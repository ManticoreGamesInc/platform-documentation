const fs = require("fs")
const recursive = require("recursive-readdir-synchronous")
const metadataParser = require("markdown-yaml-metadata-parser")
const json2md = require("json2md")

const rootPath = "src"
const outputFile = `${rootPath}/generated/sitemap.md`
const categories = []
const output = []

const files = recursive(rootPath, ["!*.md"])
files.forEach(file => {
  const data = fs.readFileSync(file, "utf8")
  const result = metadataParser(data)
  if (result.metadata.categories) {
    const fileObj = { "name": result.metadata.name, "path": file }
    result.metadata.categories.forEach(cat => {
      const catFound = categories.find(obj => obj.name === cat)
      if (!catFound) {
        categories.push({
          name: cat,
          files: [fileObj]
        })
      } else {
        const fileFound = catFound.files.find(obj => obj.name === fileObj.name && obj.path === fileObj.path)
        if (!fileFound) {
          catFound.files.push(fileObj)
        }
      }
    })
  }
})

fs.writeFileSync(outputFile, "")

output.push({ h1: "Sitemap" })
categories.forEach(cat => {
  output.push({ h2: cat.name })
  cat.files.forEach(file => {
    output.push(
      { ul: [
        { link: { title: file.name, source: file.path.replace(rootPath, "") } }
      ] }
    )
  })
})

fs.appendFileSync(outputFile, json2md(output), "utf8")
