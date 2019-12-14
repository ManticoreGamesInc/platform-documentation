const fs = require("fs");
const path = require("path");

exports.settings = {
    bullet: "consistent",
    listItemIndent: "1",
    rule: "-",
    ruleRepetition: "3",
    ruleSpaces: false,
    emphasis: "*",
    paddedTable: false
};

const personalDictionaryPath = path.join(__dirname, ".vscode/spellright.dict");
const personalDictionary = fs.existsSync(personalDictionaryPath)
    ? {
          personal: fs.readFileSync(personalDictionaryPath, "utf8")
      }
    : {};

exports.plugins = [
    require("remark-preset-lint-markdown-style-guide"),
    ["remark-lint-maximum-line-length", 999],
    ["remark-lint-unordered-list-marker-style", "consistent"],
    ["remark-lint-ordered-list-marker-style", "consistent"],
    ["remark-lint-ordered-list-marker-value", "ordered"],
    ["remark-lint-no-file-name-irregular-characters", false],
    ["remark-lint-list-item-spacing", { checkBlanks: true }],
    ["remark-lint-list-item-indent", "space"],
    ["remark-lint-list-item-content-indent", false],
    ["remark-lint-code-block-style", "fenced"],
    ["remark-lint-table-cell-padding", 'compact'],
    require("remark-frontmatter"),
    ["remark-frontmatter", {type: 'custom', marker: '!'}]
];
