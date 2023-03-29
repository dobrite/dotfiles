const Configuration = {
  extends: ["@commitlint/config-conventional"],
  formatter: "commitlint-format-json",
  rules: {
    "header-max-length": [2, "always", 72],
    "body-max-line-length": [2, "always", 72],
    "footer-max-line-length": [1, "always", 100],
  },
  parserPreset: {
    parserOpts: {
      // links are ok to be long in the footer
      noteKeywords: ["\\[.+\\]:"],
    },
  },
};

module.exports = Configuration;
