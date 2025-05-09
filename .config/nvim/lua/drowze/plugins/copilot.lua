return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VeryLazy",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
        }
      },
      -- logger = {
      --   file = vim.fn.stdpath("log") .. "/copilot-lua.log",
      --   file_log_level = vim.log.levels.INFO,
      --   -- print_log_level = vim.log.levels.INFO,
      --   trace_lsp = "verbose", -- "off" | "messages" | "verbose"
      --   trace_lsp_progress = true,
      --   log_lsp_messages = true,
      -- }
    }
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
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

