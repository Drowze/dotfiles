return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    requires = { "copilotlsp-nvim/copilot-lsp" },
    opts = {
      copilot_node_command = require('drowze.utils').mise_cmd('node', { tool = 'node@25' }),
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
        }
      },
      filetypes = {
        ["yaml.ghactions"] = true,
        ["markdown"] = true,
      },
      -- logger = {
      --   file = vim.fn.stdpath("log") .. "/copilot-lua.log",
      --   file_log_level = vim.log.levels.INFO,
      --   -- print_log_level = vim.log.levels.INFO,
      --   trace_lsp = "verbose", -- "off" | "messages" | "verbose"
      --   trace_lsp_progress = true,
      --   log_lsp_messages = true,
      -- }
    },
  },
  {
    "copilotlsp-nvim/copilot-lsp",
    lazy = true,
    init = function() vim.g.copilot_nes_debounce = 500 end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = 'main',
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    config = true,
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatClose',
      'CopilotChatToggle',
      'CopilotChatStop',
      'CopilotChatReset',
      'CopilotChatSave',
      'CopilotChatLoad',
      'CopilotChatDebugInfo',
      'CopilotChatExplain',
      'CopilotChatReview',
      'CopilotChatFix',
      'CopilotChatOptimize',
      'CopilotChatDocs',
      'CopilotChatTests',
      'CopilotChatFixDiagnostic',
      'CopilotChatCommit',
      'CopilotChatCommitStaged'
    }
  },
}
