return {
  "neovim/nvim-lspconfig",
  config= function()
    local lspconfig = require("lspconfig");

    -- common capabilities
    local capabilities = nil

    -- list of lsp 
    local servers = {
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = false;
            }
          }
        }
      },

    }

    -- setup servers
    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)

      lspconfig[name].setup(config)
    end

    -- blacklist client for semantic tokens
    local disable_semantic_tokens = {
      lua = true,
    }

    -- fun call when file open 
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

        local settings = servers[client.name]
        if type(settings) ~= "table" then
          settings = {}
        end

        local Map = require("core.mappings")

        Map.OnLspAttach(bufnr)

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        local filetype = vim.bo[bufnr].filetype
        if disable_semantic_tokens[filetype] then
          client.server_capabilities.semanticTokensProvider = nil
        end

        -- Override server capabilities
        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            if v == vim.NIL then
              ---@diagnostic disable-next-line: cast-local-type
              v = nil
            end

            client.server_capabilities[k] = v
          end
        end
      end,
    })

    -- formatting
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        vim.lsp.buf.format()
      end,
    })
  end,
}
