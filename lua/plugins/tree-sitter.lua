return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  -- install parsers once during :Lazy build (or :Lazy sync), not on every startup
  build = function()
    require'nvim-treesitter'.setup { install_dir = vim.fn.stdpath('data') .. '/site' }
    require'nvim-treesitter'.install {
      'rust', 'javascript', 'typescript', 'c', 'cpp', 'c_sharp',
      'swift', 'zsh', 'bash', 'java', 'lua',
    }
  end,
  config = function()
    require'nvim-treesitter'.setup { install_dir = vim.fn.stdpath('data') .. '/site' }
  end,
}
