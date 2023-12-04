return {
  'Mofiqul/dracula.nvim',
  lazy = false,
  priority = 9999,
  config = function(_, opts)
    require('dracula').setup(opts)
    vim.cmd.colorscheme('dracula')
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'white' })
  end,
  opts = function()
    -- <custom functions for better vimdiff> (see: https://github.com/Mofiqul/dracula.nvim/issues/75)
    -- remove after dracula.nvim has better vimdiff support
    local function hexToRgb(c)
      c = string.lower(c)
      return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
    end

    local function blend(foreground, background, alpha)
      alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
      local bg = hexToRgb(background)
      local fg = hexToRgb(foreground)

      local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
      end

      return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
    end

    local function darken(hex, amount)
      local default_bg = "#000000"

      return blend(hex, default_bg, amount)
    end

    local colors = require('dracula.palette')
    -- </custom functions for better vimdiff>

    return {
      transparent_bg = true,
      show_end_of_buffer = true,
      italic_comment = true,
    -- <custom functions for better vimdiff>
      overrides = {
        DiffAdd = { bg = darken(colors.bright_green, 0.30) },
        DiffDelete = { fg = colors.bright_red },
        DiffChange = { bg = darken(colors.comment, 0.15) },
        DiffText = { bg = darken(colors.comment, 0.90) },
        illuminatedWord = { bg = darken(colors.comment, 0.65) },
        illuminatedCurWord = { bg = darken(colors.comment, 0.65) },
        IlluminatedWordText = { bg = darken(colors.comment, 0.65) },
        IlluminatedWordRead = { bg = darken(colors.comment, 0.65) },
        IlluminatedWordWrite = { bg = darken(colors.comment, 0.65) },
      },
    -- </custom functions for better vimdiff>
    }
  end
}
