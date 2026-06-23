return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
      })

      vim.keymap.set("n", "<leader>t", function()
        if vim.bo.filetype == "NvimTree" then
          vim.cmd("wincmd p")      -- 回到上一个窗口（通常就是代码窗口）
        else
          vim.cmd("NvimTreeFocus") -- 回到文件树（没开会自动打开）
        end
      end, { desc = "Toggle focus: NvimTree <-> last window" })

      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
    end
}
