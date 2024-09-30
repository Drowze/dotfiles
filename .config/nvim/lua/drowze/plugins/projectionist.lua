return {
  'tpope/vim-projectionist',
  event = 'VeryLazy',
  ft = { 'ruby', 'javascript' },
--  cmd = { 'A', 'AS', 'AV', 'AT' },
  config = function()
    vim.g.projectionist_heuristics = {
      -- ruby projects:
      ['Gemfile'] = {
        ['Gemfile'] = { ['alternate'] = { 'Gemfile.lock' } },
        ['app/*.rb'] = { ['alternate'] = { 'spec/{}_spec.rb', 'spec/app/{}_spec.rb' } },
        ['lib/*.rb'] = { ['alternate'] = { 'spec/{}_spec.rb', 'spec/lib/{}_spec.rb', 'spec/app/lib/{}_spec.rb' } },
        ['spec/*_spec.rb'] = { ['alternate'] = { 'app/{}.rb', 'lib/{}.rb', '{}.rb' } },

        ['spec/factories/*.rb'] = { ['alternate'] = { 'app/models/{singular}.rb' } },
      },
      -- javascript projects:
      ['src/*.js'] = {
        ['__tests__/*.test.js'] = { ['alternate'] = { 'src/{}.js' } },
        ['src/*.js'] = { ['alternate'] = { 'src/{}.test.js', '__tests__/{}.test.js' } },
      },
    }
  end
}
