return {
  'tpope/vim-projectionist',
  event = 'VeryLazy',
  ft = { 'ruby', 'javascript' },
--  cmd = { 'A', 'AS', 'AV', 'AT' },
  config = function()
    vim.g.projectionist_heuristics = vim.json.decode([[
    {
      "Gemfile|gemfiles/*": {
        "Gemfile": {"alternate": ["Gemfile.lock"] },

        "app/*.rb": {"alternate": ["spec/{}_spec.rb","spec/app/{}_spec.rb"] },
        "lib/*.rb": { "alternate": ["spec/{}_spec.rb", "spec/lib/{}_spec.rb", "spec/app/lib/{}_spec.rb"] },
        "spec/*_spec.rb": {"alternate": ["app/{}.rb","lib/{}.rb","{}.rb"] },

        "spec/requests/*_spec.rb": {"alternate": ["app/controllers/{}_controller.rb"] },
        "app/controllers/*_controller.rb": {"alternate": ["spec/controllers/{}_controller_spec.rb","spec/requests/{}_spec.rb"] },

        "spec/factories/*.rb": {"alternate":["app/models/{singular}.rb"] }
      },

      "src/*.js": {
        "__tests__/*.test.js": { "alternate": ["src/{}.js"] },
        "src/*.js": {"alternate": ["src/{}.test.js", "__tests__/{}.test.js" ] }
      }
    }
    ]])
  end
}
