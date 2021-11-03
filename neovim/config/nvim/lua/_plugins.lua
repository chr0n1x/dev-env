-- Auto install plugin manager

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrapped = fn.system(
    {
      'git', 'clone',
      '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    }
  )
end

return require('packer').startup(
  function()
    use 'airblade/vim-gitgutter'
    use 'gregsexton/MatchTag'
    use 'jamestthompson3/nvim-remote-containers'
    use 'kien/ctrlp.vim'
    use 'pseewald/vim-anyfold'
    use 'shaunsingh/nord.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'scrooloose/nerdtree'
    use 'wbthomason/packer.nvim'
    use 'Yggdroot/indentLine'

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {'kyazdani42/nvim-web-devicons', after = 'packer.nvim'}
    use {
        'hoob3rt/lualine.nvim',
        after = 'nvim-web-devicons',
        event = 'VimEnter',
        config = function() require "plugins/lualine" end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        config = function() require "plugins/treesitter" end,
        run = ':TSUpdate'
    }
    use {'neovim/nvim-lspconfig', event = 'BufRead'}
    use {
        'kabouzeid/nvim-lspinstall',
        config = function() require "plugins.lspinstall" end,
        after = 'nvim-lspconfig'
    }

    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        event = 'InsertEnter',
        config = function() require "plugins.coq" end
    }
    use {'ms-jpq/coq.artifacts', after = 'coq_nvim', branch = 'artifacts'}

    if packer_bootstrapped then
      require('packer').sync()
    end
  end
)
