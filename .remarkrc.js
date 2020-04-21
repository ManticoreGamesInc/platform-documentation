const fs = require("fs")
const path = require("path")

exports.settings = {
    listItemIndent: "1",
    rule: "-",
    ruleRepetition: "3",
    ruleSpaces: false,
    emphasis: "*",
    tableCellPadding: false
}

const personalDictionaryPath = path.join(__dirname, ".vscode/spellright.dict")
const personalDictionary = fs.existsSync(personalDictionaryPath)
    ? {
        personal: fs.readFileSync(personalDictionaryPath, "utf8")
    }
    : {}

exports.plugins = [
    "preset-lint-markdown-style-guide",
    ["lint-maximum-line-length", 999],
    ["lint-emphasis-marker", "consistent"],
    ["lint-ordered-list-marker-value", "ordered"],
    ["lint-unordered-list-marker-style", "consistent"],
    ["lint-no-file-name-irregular-characters", false],
    ["lint-list-item-spacing", { checkBlanks: true }],
    ["lint-list-item-indent", "space"],
    ["lint-list-item-content-indent", false],
    ["lint-code-block-style", false],
    ["lint-table-cell-padding", false],
    ["lint-table-pipe-alignment", false],
    ["lint-no-duplicate-headings", false],
    ["frontmatter", { type: "custom", marker: "-" }]
]
