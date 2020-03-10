const fs = require("fs")
const recursive = require("recursive-readdir-synchronous")
const metadataParser = require("markdown-yaml-metadata-parser")
const json2md = require("json2md")

const rootPath = "src"
const outputFile = `${rootPath}/generated/sitemap.md`
const tags = []
const output = []

const files = recursive(rootPath, ["!*.md"])
files.forEach(file => {
  const data = fs.readFileSync(file, "utf8")
  const result = metadataParser(data)
  if (result.metadata.tags) {
    const fileObj = { "name": result.metadata.name, "path": file }
    result.metadata.tags.forEach(tag => {
      const tagFound = tags.find(obj => obj.name === tag)
      if (!tagFound) {
        tags.push({
          name: tag,
          files: [fileObj]
        })
      } else {
        const fileFound = tagFound.files.find(obj => obj.name === fileObj.name && obj.path === fileObj.path)
        if (!fileFound) {
          tagFound.files.push(fileObj)
        }
      }
    })
  }
})

fs.writeFileSync(outputFile, "")

output.push({ h1: "Sitemap" })
tags.forEach(tag => {
  output.push({ h2: tag.name })
  tag.files.forEach(file => {
    output.push(
      { ul: [
        { link: { title: file.name, source: file.path.replace(rootPath, "..") } }
      ] }
    )
  })
})

fs.appendFileSync(outputFile, json2md(output), "utf8")
