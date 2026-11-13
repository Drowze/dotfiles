vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250

-- Built-in fuzzy completion (e.g. buffer names, vim commands, etc)
vim.opt.wildoptions:append { 'fuzzy' }

-- vimdiff: ignore whitespaces, better line-match
-- see neovim/neovim#14537 for more about line-match
vim.opt.diffopt:append { 'iwhiteall', 'linematch:50' }

-- hide current mode
vim.opt.showmode = false

-- decent wrapping/scrolling
vim.opt.linebreak = true
vim.opt.scrolloff = 4

-- buffer management
vim.opt.equalalways = false
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ruler/line no
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = '80'

-- tabs/indentation
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- folds
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false -- do not fold by default

-- invisible characters
vim.opt.list = true
vim.opt.listchars = {
  tab = '▸ ',
  eol = '↲',
  trail= '·'
}

vim.opt.mouse = 'n'

-- we use undotree and have a ~permanent~ history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- disable netrw
vim.g['loaded_netrwPlugin'] = 1

-- opens netrw previews (`p`) vertically
vim.g['netrw_preview'] = 1

-- when a vertical preview window is opened, the directory listing
-- will use only 30% of the columns available; the rest of the window
-- is used for the preview window
vim.g['netrw_winsize'] = 30

local api = vim.api

api.nvim_create_user_command(
  'RestartSession',
  ':mksession! /tmp/nvim-session.vim | restart +qa source /tmp/nvim-session.vim',
  { desc = 'Restart neovim and restore current session' }
)

api.nvim_create_user_command(
  'Messages',
  ":vnew | put =execute('messages') | setlocal buftype=nofile bufhidden=wipe noswapfile",
  { desc = 'Open a new tab with the output of :messages' }
)
api.nvim_create_user_command('Keymaps', "Telescope keymaps", {})

local function resolve_jinja_filetype(_, _, ext)
  local inner_filetype = vim.filetype.match({ filename = "dummy." .. ext }) or ext
  return "jinja." .. inner_filetype
end

vim.filetype.add({
  extension = {
    avsc = 'json',
    gemfile = 'ruby',
    jbuilder = 'ruby',
    mdx = 'markdown',
    pryrc = 'ruby',
    simplecov = 'ruby',
    tigrc = 'tig',
    jsonl = 'json.jsonl', -- custom filetype as the lsp (jsonls) doesn't support jsonl (see microsoft/vscode-json-languageservice#285)
  },
  filename = {
    Dangerfile = 'ruby',
    Appraisals = 'ruby',
  },
  pattern = {
    -- GitHub Actions workflows: custom filetype so we can use a separate LSP
    [".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghactions",
    -- Jinja templates: custom filetypes so we can derive the sub-language from it and inject into the Treesitter query
    [".*%.jinja%.([%w_]+)"] = resolve_jinja_filetype,
    [".*%.([%w_]+)%.j2"] = resolve_jinja_filetype,
    [".*%.([%w_]+)%.jinja2?"] = resolve_jinja_filetype,
    -- Jinja templates: handle YAML files with `## template: jinja` at the top (common on cloud-init files)
    [".*%.ya?ml"] = {
      function(_, bufnr)
        local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
        if first_line:match("^##%s*template:%s*jinja") then
          return "jinja.yaml"
        end
      end,
    },
  }
})

vim.treesitter.language.register("tmux", "tig") -- .tigrc has a similar syntax to tmux.conf
vim.treesitter.language.register("bash", "env") -- bash parser for dotenv files

-- Jinja templates: derive the sub-language from the filetype (e.g. `jinja.yaml` -> `yaml`) and inject it into the Treesitter query
-- This is used at our custom TS query at `after/queries/jinja/injections.scm`
vim.treesitter.query.add_directive("inject-jinja-sublang!", function(_, _, bufnr, _, metadata)
  local sub_filetype = vim.bo[bufnr].filetype:match("^jinja%.(.+)$")
  if sub_filetype then
    metadata["injection.language"] = vim.treesitter.language.get_lang(sub_filetype) or sub_filetype
  end
end, { force = true})
