return {
  'tpope/vim-projectionist',
  event = 'VeryLazy',
  ft = { 'ruby', 'javascript' },
--  cmd = { 'A', 'AS', 'AV', 'AT' },
  config = function()
    vim.g.projectionist_heuristics = vim.json.decode([[
    {
      "Gemfile|gemfiles/*": {
        "Gemfile": {
          "alternate": ["Gemfile.lock"]
        },
        "app/controllers/*_controller.rb": {
          "alternate": [
            "spec/controllers/{}_controller_spec.rb",
            "spec/requests/{}_spec.rb",
            "spec/requests/{}_request_spec.rb"
          ]
        },
        "app/*.rb": {
          "alternate": ["spec/{}_spec.rb"]
        },
        "lib/*.rb": {
          "alternate": [
            "spec/{}_spec.rb",
            "spec/lib/{}_spec.rb"
          ]
        },

        "spec/requests/*_request_spec.rb": {
          "alternate": ["app/controllers/{}_controller.rb"]
        },
        "spec/requests/*_spec.rb": {
          "alternate": ["app/controllers/{}_controller.rb"]
        },
        "spec/*_spec.rb": {
          "alternate": [
            "app/{}.rb",
            "lib/{}.rb",
            "{}.rb"
          ]
        },
        "spec/factories/*.rb": {
          "alternate":["app/models/{singular}.rb"]
        }
      },

      "src/*.js": {
        "__tests__/*.test.js": {
          "alternate": ["src/{}.js"]
        },
        "src/*.js": {
          "alternate": [
            "src/{}.test.js",
            "__tests__/{}.test.js"
          ]
        }
      }
    }
    ]])
  end
}
