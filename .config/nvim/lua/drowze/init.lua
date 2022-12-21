require('drowze.remap')
require('drowze.set')

local function set_custom_filetype(pattern, filetype)
  vim.api.nvim_create_autocmd(
    { 'BufNewFile', 'BufRead' },
    {
      pattern = pattern,
      callback = function()
        vim.api.nvim_set_option_value('filetype', filetype, { scope = 'local' })
      end
    }
  )
end

set_custom_filetype('*.jbuilder', 'ruby')
