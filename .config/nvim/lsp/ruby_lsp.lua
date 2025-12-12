return {
  cmd = require('drowze.utils').mise_cmd({'ruby-lsp', '--debug'}),
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile.lock', '.git' },
  -- Reference: https://shopify.github.io/ruby-lsp/editors.html#all-initialization-options
  init_options = {
    formatter = 'auto',
    linters = { 'rubocop_internal' },
    experimentalFeaturesEnabled = false,
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
    },
    featuresConfiguration = {
      inlayHint = {
        implicitHashValue = true,
        implicitRescue = true,
      },
    },
    -- indexing = {
    --   excludedPatterns = { 'path/to/excluded/file.rb' },
    --   includedPatterns = { 'path/to/included/file.rb' },
    --   excludedGems = { 'gem1', 'gem2', 'etc.' },
    --   excludedMagicComments = { 'compiled:true' },
    -- },
  },
}
