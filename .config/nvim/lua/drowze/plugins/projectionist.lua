return {
  'tpope/vim-projectionist',
  event = 'VeryLazy',
  ft = { 'ruby' },
--  cmd = { 'A', 'AS', 'AV', 'AT' },
  config = function()
    vim.g.projectionist_heuristics = {
      ['app/*'] = {
        ['app/*.rb'] = { ['alternate'] = { 'spec/{}_spec.rb', 'spec/app/{}_spec.rb' } },
        ['spec/*_spec.rb'] = { ['alternate'] = { 'app/{}.rb', '{}.rb' } },
      },
      ['lib/*'] = {
        ['lib/*.rb'] = { ['alternate'] = { 'spec/{}_spec.rb', 'spec/lib/{}_spec.rb' } },
        ['spec/*_spec.rb'] = { ['alternate'] = { 'lib/{}.rb' } },
      },
    }
  end
}
