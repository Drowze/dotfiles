local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

local function harpoon_map(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = 'Harpoon: ' .. desc })
end

harpoon_map('n', '<leader>a', mark.add_file, 'harpoon file')
harpoon_map('n', '<C-e>', ui.toggle_quick_menu, 'navigation map')
harpoon_map('n', '<C-h>', function() ui.nav_file(1) end, 'navigate to 1')
harpoon_map('n', '<C-t>', function() ui.nav_file(2) end, 'navigate to 2')
harpoon_map('n', '<C-n>', function() ui.nav_file(3) end, 'navigate to 3')
harpoon_map('n', '<C-s>', function() ui.nav_file(4) end, 'navigate to 4')
