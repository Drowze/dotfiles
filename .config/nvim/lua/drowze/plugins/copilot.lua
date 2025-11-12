-- always run copilot with latest node (even if the project uses an older version)
local copilot_node_command
if vim.fn.executable("mise") == 1 then
  copilot_node_command = { "mise", "exec", "node@latest", "--", "node" }
else
  copilot_node_command = "node"
end

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      copilot_node_command = copilot_node_command,
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
