-- Code overview / minimap. mini.map never auto-opens, so the map window
-- stays hidden until toggled with <leader>mm.
return {
  "nvim-mini/mini.map",
  version = false,
  config = function()
    local map = require("mini.map")

    map.setup({
      -- Surface diagnostics, search hits and git changes on the minimap.
      integrations = {
        map.gen_integration.diagnostic({
          error = "DiagnosticFloatingError",
          warn = "DiagnosticFloatingWarn",
          info = "DiagnosticFloatingInfo",
          hint = "DiagnosticFloatingHint",
        }),
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns(),
      },
      symbols = {
        -- Dot (braille) encoding reads closer to the VS Code minimap.
        encode = map.gen_encode_symbols.dot("3x2"),
      },
      window = {
        side = "right",
        width = 12,
        winblend = 25,
      },
    })

    vim.keymap.set("n", "<leader>mm", map.toggle, { desc = "Toggle minimap" })
    vim.keymap.set("n", "<leader>mf", map.toggle_focus, { desc = "Focus minimap" })
    vim.keymap.set("n", "<leader>ms", map.toggle_side, { desc = "Toggle minimap side" })
  end,
}
