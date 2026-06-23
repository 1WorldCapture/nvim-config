return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "clangd",
        "pyright",
        "omnisharp",
        "rust_analyzer"
      }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = {
        "lua_ls",
        "ts_ls",
        "clangd",
        "pyright",
        "omnisharp",
        "rust_analyzer",
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      vim.lsp.enable(servers)

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local bufnr = event.buf
          local builtin = require("telescope.builtin")
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          local supports_method = function(method)
            for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
              if client:supports_method(method, bufnr) then
                return true
              end
            end
            return false
          end
          local declaration_or_definition = function()
            if supports_method("textDocument/declaration") then
              vim.lsp.buf.declaration()
            else
              builtin.lsp_definitions()
            end
          end

          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "gD", declaration_or_definition, "Goto Declaration")
          map("n", "gd", builtin.lsp_definitions, "Goto Definition")
          map("n", "gr", builtin.lsp_references, "Goto References")
          map("n", "gi", builtin.lsp_implementations, "Goto Implementation")
          map("n", "gy", builtin.lsp_type_definitions, "Goto Type Definition")
          map("n", "<leader>ds", builtin.lsp_document_symbols, "Document Symbols")
          map("n", "<leader>ws", builtin.lsp_workspace_symbols, "Workspace Symbols")
          map("n", "<leader>ci", builtin.lsp_incoming_calls, "Incoming Calls")
          map("n", "<leader>co", builtin.lsp_outgoing_calls, "Outgoing Calls")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        end,
      })
    end
  }
}
