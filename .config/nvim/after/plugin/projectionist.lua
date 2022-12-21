vim.g.projectionist_heuristics = {
  ['app/*'] = {
    ['app/*.rb'] = { ['alternate'] = { 'spec/{}_spec.rb' } },
    ['spec/*_spec.rb'] = { ['alternate'] = { 'app/{}.rb' } },
  },
  ['lib/*'] = {
    ['lib/*.rb'] = { ['alternate'] = { 'spec/{}_spec.rb' } },
    ['spec/*_spec.rb'] = { ['alternate'] = { 'lib/{}.rb' } },
  },
}
