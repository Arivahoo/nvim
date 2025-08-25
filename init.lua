vim.g.mapleader = " "

require("config.lazy")
require("lazy").setup("plugins")

vim.opt.clipboard = "unnamedplus"
vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 2
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.cmd("set guifont=PapyrusMono:h12:w0")

vim.keymap.set("n", "<Leader>a", ":w<CR>" , {desc = 'saves current file'})
vim.keymap.set("n", "<Leader>s", ":so<CR>" , { silent = true, desc = 'SO"s the file'})
vim.keymap.set("n", "<Leader>z", ":cd ~/appdata/local/nvim <bar> :e init.lua", {silent = true, desc = 'config hotkey'})
vim.keymap.set("n", "<Leader>t", ":NvimTreeOpen", opts)

require("oil").setup()

require('cord').setup {
				text = {
								editing = function(opts)
								return string.format('Editing %s', opts.filename)
								end,
								workspace = 'In {filename}',
								viewing = 'Viewing',
								file_browser = 'Browsing files',
								plugin_manager = 'Managing Plugins in Lazy',
								lsp = 'Configuring LSP',
								docs = 'reading',
								vcs = 'Committing Changes',
								notes = 'Taking notes',
								debug = 'Debugging',
								test = 'Testing',
								diagnostics = 'Fixing Problems',
								games = 'Playing',
								terminal = 'In terminal',
								dashboard = 'In dashboard',
				},
}

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {

  }
}

local telescope = require('telescope')
telescope.setup {
  -- opts...
}
telescope.load_extension('hoogle')

require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

require('lint').linters_by_ft = {
  haskell = {'hlint'},
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- An example for configuring `clangd` LSP to use nvim-cmp as a completion engine
require('lspconfig').clangd.setup {
  capabilities = capabilities,
  ...  -- other lspconfig configs
}

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })


vim.keymap.set('n', '<space>a', '<Plug>HaskellHoverAction')
