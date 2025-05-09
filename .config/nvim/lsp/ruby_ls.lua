return {
  cmd = { "bundle", "exec", "ruby-lsp" },
  init_options = {
    formatter = 'rubocop',
    enabledFeatures = {
      "codeActions",
      "diagnostics",
      "documentHighlights",
      "documentLink",
      "documentSymbols",
      "foldingRanges",
      "formatting",
      "hover",
      "inlayHint",
      "onTypeFormatting",
      "selectionRanges",
      "semanticHighlighting",
      "completion",
      "codeLens",
      "definition",
      "workspaceSymbol",
      "signatureHelp"
    }
  },
}
