return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter'.setup {
      install_dir = vim.fn.stdpath('data') .. '/site'
    }
    require'nvim-treesitter'.install { 
      'rust', 'javascript', 'typescript', 'c', 'cpp', 'c_sharp', 'typescript', 'swift', 'zsh', 'bash', 'java', 'lua'
    }
  end
}
