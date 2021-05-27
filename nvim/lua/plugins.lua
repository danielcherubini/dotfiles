-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'dracula/vim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use 'itchyny/lightline.vim'
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
  use { 'lukas-reineke/indent-blankline.nvim', branch="lua" }
  use 'tpope/vim-commentary'
  use 'kdheepak/lazygit.nvim'
  use 'jiangmiao/auto-pairs'
end)

