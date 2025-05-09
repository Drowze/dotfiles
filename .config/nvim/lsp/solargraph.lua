return {
  settings = {
    solargraph = {
      diagnostics = false, -- rely on rubocop LSP for diagnostics
      formatting = false, -- rely on rubocop LSP for diagnostics
      autoformat = false, -- rely on rubocop LSP for diagnostics
      logLevel = 'warn',
    },
  },
  init_options = { formatting = false },
  single_file_support = true,
}
