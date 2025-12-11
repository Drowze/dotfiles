return {
  cmd = require('drowze.utils').mise_cmd('ruby-lsp'),
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile.lock', '.git' },
  -- Reference: https://shopify.github.io/ruby-lsp/editors.html#all-initialization-options
  init_options = {
    formatter = 'auto',
    enabledFeatures = {
      'codeActions',
      'codeLens',
      'completion',
      'definition',
      'diagnostics',
      'documentHighlights',
      'documentLink',
      'documentSymbols',
      'foldingRanges',
      'formatting',
      'hover',
      'inlayHint',
      'onTypeFormatting',
      'selectionRanges',
      -- 'semanticHighlighting', # leave highligthing to treesitter
      'signatureHelp',
      'typeHierarchy',
      'workspaceSymbol',
    }
  },
}
