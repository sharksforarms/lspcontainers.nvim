local supported_languages = {
  bashls = "lspcontainers/bash-language-server:1.17.0",
  dockerls = "lspcontainers/docker-langserver:0.4.1",
  gopls = "lspcontainers/gopls:0.6.11",
  pyright = "lspcontainers/pyright:1.1.137",
  sumneko_lua = "lspcontainers/lua-language-server:1.20.5",
  tsserver = "lspcontainers/typescript-language-server:0.5.1",
  yamlls = "lspcontainers/yaml-language-server:0.18.0"
}

local function command(server, user_opts)
  local opts = user_opts or {}

  local workdir = opts.root_dir or vim.fn.getcwd()
  local volume = workdir..":"..workdir

  local additional_languages = opts.additional_languages or {}
  local image = additional_languages[server]
                or supported_languages[server]
                or nil

  if not image then
    error(string.format("lspcontainers: language not supported `%s`", server))
    return 1
  end

  return {
      "docker",
      "container",
      "run",
      "--interactive",
      "--rm",
      "--volume",
      volume,
      image
    }
end

return {
  command = command
}
