local did_bootstrap = false

local function run_async_cmds(cmds, opts)
  local pending = vim.tbl_count(cmds)
  local on_finish = opts.on_finish
  local on_error = opts.on_error

  for _, cmd_info in ipairs(cmds) do
    local co = coroutine.create(function()
      local current_co = coroutine.running()
      vim.system(cmd_info.cmd, { text = true }, function(result) coroutine.resume(current_co, result) end)

      local result = coroutine.yield()

      vim.schedule(function()
        if result.code == 0 then
          cmd_info.cb(vim.trim(result.stdout))
        else
          on_error(cmd_info.cmd, result.stderr)
        end
      end)

      pending = pending - 1
      if pending == 0 then vim.schedule(on_finish) end
    end)
    coroutine.resume(co)
  end
end

return {
  cmd = require('drowze.utils').mise_cmd({ "actions-languageserver", "--stdio" }, { tool = "npm:@actions/languageserver" }),
  filetypes = { "yaml.ghactions" },
  root_markers = { ".git" },
  init_options = { sessionToken = nil, repos = { {} } },
  on_init = function(client)
    if did_bootstrap then return end

    did_bootstrap = true
    run_async_cmds(
      {
        {
          cmd = { "git",  "rev-parse", "--show-toplevel" },
          cb = function(git_root)
            if git_root then
              client.config.init_options.repos[1].workspaceUri = "file://" .. git_root
            end
          end
        },
        {
          cmd = { "git", "remote", "get-url", "origin" },
          cb = function(remote_url)
            -- SSH format:
            -- - git@github.com:owner/repo.git
            -- - git@github-foobar:owner/repo.git
            local owner, repo = remote_url:match("git@github[%w%.-]+:([^/]+)/([^/%.]+)")

            -- HTTPS format: https://github.com/owner/repo.git
            if not owner or not repo then
              owner, repo = remote_url:match("github%.com/([^/]+)/([^/%.]+)")
            end

            if repo and owner then
              client.config.init_options.repos[1].name = repo
              client.config.init_options.repos[1].owner = owner
            end
          end
        },
        {
          cmd = { "gh", "auth", "token" },
          cb = function(token)
            if token then
              client.config.init_options.sessionToken = token
            end
          end,
        },
        {
          cmd = { "gh", "repo", "view", "--json", "id,isInOrganization", "--template", "{{.id}}\t{{.isInOrganization}}" },
          cb = function(repo_info)
            local repo_id, repo_organization_owned = repo_info:match("^(.+)\t(.+)$")
            if repo_id and repo_organization_owned then
              client.config.init_options.repos[1].id = repo_id
              client.config.init_options.repos[1].organizationOwned = repo_organization_owned == "true"
            end
          end
        }
      },
      {
        on_finish = function()
          vim.notify("applying actionsls config")
          vim.cmd("lsp restart " .. client.name)
        end,
        on_error = function(cmd, stderr)
          vim.notify(string.format("ERROR LOADING LSP: actionsls\n%s\n%s", table.concat(cmd, " "), stderr or ""), vim.log.levels.ERROR)
        end,
      }
    )
  end,
}
