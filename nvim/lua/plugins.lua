-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Package managment
	use 'wbthomason/packer.nvim'

	-- Theme
	use 'dracula/vim'
	use 'itchyny/lightline.vim'
	use 'lukas-reineke/indent-blankline.nvim'

	-- General
	use 'tpope/vim-commentary'
	use 'jiangmiao/auto-pairs'

	-- File Managment
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'}
		}
	}

	-- Git stuff
	use 'kdheepak/lazygit.nvim'
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		}
	}

	-- Tree Sitter and LSP
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'nvim-treesitter/playground'
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use 'hrsh7th/nvim-compe'
	use {
		'hrsh7th/vim-vsnip',
		requires = {
			{ 'hrsh7th/vim-vsnip-integ' },
			{ 'rafamadriz/friendly-snippets' }
		}
	}
	use {
		'SirVer/ultisnips',
		requires = {
			{ 'honza/vim-snippets' }
		}
	}
	use 'ray-x/lsp_signature.nvim'

	-- Linting
	use 'sbdchd/neoformat'


	-- Trouble
	use {
	  "folke/trouble.nvim",
	  requires = {
		"kyazdani42/nvim-web-devicons",
		'runiq/telescope-trouble.nvim'
	  }
	}
end)

