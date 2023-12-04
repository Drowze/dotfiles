return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    local function harpoon_map(mode, key, action, desc)
      vim.keymap.set(mode, key, action, { desc = 'Harpoon: ' .. desc })
    end
    harpoon_map('n', '<leader>a', function() harpoon:list():append() end, 'harpoon file')
    harpoon_map('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, 'navigation map')
    harpoon_map('n', '<C-h>', function() harpoon:list():select(1) end, 'navigate to 1')
    harpoon_map('n', '<C-t>', function() harpoon:list():select(2) end, 'navigate to 2')
    harpoon_map('n', '<C-n>', function() harpoon:list():select(3) end, 'navigate to 3')
    harpoon_map('n', '<C-s>', function() harpoon:list():select(4) end, 'navigate to 4')
  end
}
