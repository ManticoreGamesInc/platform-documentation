const fs = require("fs");
const path = require("path");

exports.settings = {
    bullet: "*",
    listItemIndent: "1",
    rule: "-",
    ruleRepetition: "3",
    ruleSpaces: false,
    emphasis: "*",
    incrementListMarker: true
};

const personalDictionaryPath = path.join(__dirname, ".dictionary");
const personalDictionary = fs.existsSync(personalDictionaryPath)
    ? {
          personal: fs.readFileSync(personalDictionaryPath, "utf8")
      }
    : {};

exports.plugins = [
    require("remark-frontmatter"),
    [
        require("remark-retext"),
        require("unified")().use({
            plugins: [
                require("retext-english"),
                require("retext-syntax-urls"),
                require("retext-spell"),
                {
                    ignoreLiteral: true,
                    dictionary: require("dictionary-en-us"),
                    ...personalDictionary
                },
                [require("retext-sentence-spacing"), { preferred: 1 }],
                require("retext-repeated-words"),
                require("retext-usage"),
                require("retext-indefinite-article"),
                require("retext-redundant-acronyms"),
                [
                    require("retext-contractions"),
                    { straight: true, allowLiteral: true }
                ],
                require("retext-diacritics"),
                [
                  require("retext-quotes"),
                  {
                    preferred: "straight"
                  }
                ],
            ]
        })
    ],
    require("remark-preset-lint-markdown-style-guide"),
    ["remark-lint-maximum-line-length", 999],
    ["remark-lint-unordered-list-marker-style", "consistent"],
    ["remark-lint-ordered-list-marker-style", "consistent"],
    ["remark-lint-ordered-list-marker-value", "ordered"],
    ["remark-lint-no-file-name-irregular-characters", false],
    ["remark-lint-list-item-spacing", { checkBlanks: true }],
    ["remark-lint-list-item-indent", "space"],
    ["remark-lint-list-item-content-indent", false]
];
