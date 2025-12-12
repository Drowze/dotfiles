return {
  cmd = require('drowze.utils').mise_cmd({'rubocop', '--lsp'}),
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
  single_file_support = true,
}
