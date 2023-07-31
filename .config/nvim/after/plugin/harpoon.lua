local mark
local ui
local function lazy_mark()
  if not mark then
    mark = require'harpoon.mark'
  end
  return mark
end
local function lazy_ui()
  if not ui then
    ui = require'harpoon.ui'
  end
  return ui
end

local function harpoon_map(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = 'Harpoon: ' .. desc })
end

harpoon_map('n', '<leader>a', function() lazy_mark().add_file() end, 'harpoon file')
harpoon_map('n', '<C-e>', function() lazy_ui().toggle_quick_menu() end, 'navigation map')
harpoon_map('n', '<C-h>', function() lazy_ui().nav_file(1) end, 'navigate to 1')
harpoon_map('n', '<C-t>', function() lazy_ui().nav_file(2) end, 'navigate to 2')
harpoon_map('n', '<C-n>', function() lazy_ui().nav_file(3) end, 'navigate to 3')
harpoon_map('n', '<C-s>', function() lazy_ui().nav_file(4) end, 'navigate to 4')
