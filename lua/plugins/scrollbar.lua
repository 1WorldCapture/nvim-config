-- Decorated scrollbar: shows current position plus diagnostics, git hunks
-- and search matches along the right edge. Always on for normal buffers.
return {
  "petertriho/nvim-scrollbar",
  lazy = false,
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "kevinhwang91/nvim-hlslens",
  },
  config = function()
    -- hlslens feeds search match data to the scrollbar search handler.
    require("hlslens").setup()

    require("scrollbar").setup({
      set_highlights = true,
      handle = {
        text = " ",
        blend = 30,
        color = nil,
        color_nr = nil,
        highlight = "CursorColumn",
      },
      -- Don't render on non-code surfaces.
      excluded_buftypes = { "terminal", "nofile", "prompt" },
      excluded_filetypes = {
        "cmp_menu",
        "cmp_docs",
        "help",
        "lazy",
        "lazyterm",
        "mason",
        "noice",
        "NvimTree",
        "TelescopePrompt",
      },
    })

    -- Diagnostic and cursor marks are built in; git + search need handlers.
    require("scrollbar.handlers.gitsigns").setup()
    require("scrollbar.handlers.search").setup()
  end,
}
