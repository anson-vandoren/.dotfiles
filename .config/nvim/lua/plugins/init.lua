return {
  -- main color theme
  {
    "wincent/base16-nvim",
    lazy = false, -- load at start
    priority = 1000, -- load first
    config = function()
      vim.cmd([[colorscheme gruvbox-dark-hard]])
      vim.o.background = 'dark'

      -- Make comments more prominent
      -- local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
      -- vim.api.nvim_set_hl(0, 'Comment', bools)
      --
      -- Make it clearly visible which argument we're at.
      local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
      vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg })
    end
  },

  -- TODO highlighting and browser
  "folke/todo-comments.nvim",

  -- Sidebar for issues and symbols, etc
  {
    "folke/trouble.nvim",
    opts = {},
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)"
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
     },
    },
  },

  -- Misc QoL stuff
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    --@type snacks.Config
    opts = {
      gitbrowse = { enabled = true },
      indent = {
        only_scope = true,
        animate = {
          enabled = false,
        },
      },
      bufdelete = { enabled = true },
      picker = { enabled = true },
      terminal = { win = { style = 'terminal' } },
    },
  },

  -- icons used elsewhere
  { "nvim-tree/nvim-web-devicons", opts = {} },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- bottom bar
  {
    'itchyny/lightline.vim',
    lazy = false, -- load at the start since it's UI
    config = function()
      -- no need to also show mode in the cmd line since there's a bar
      vim.o.showmode = false
      vim.g.lightline = {
        active = {
	  left = {
	    { 'mode', 'paste' },
	    { 'readonly', 'filename', 'modified' },
	  },
	  right = {
	    { 'lineinfo' },
	    { 'percent' },
	    { 'fileencoding', 'filetype' },
	  },
        },
	component_function = {
	  filename = 'LightlineFilename',
	},
      }
      function LightlineFilenameInLua(opts)
	if vim.fn.expand('%:t') == '' then
	  return '[No Name]'
	else
	  return vim.fn.getreg('%')
	end
      end
      vim.api.nvim_exec(
        [[
	function! g:LightlineFilename()
	  return v:lua.LightlineFilenameInLua()
	endfunction
	]],
	true
      )
    end
  },


  -- easier navigation
  'easymotion/vim-easymotion',

  -- better % nav
  {
    'andymass/vim-matchup',
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },

  -- fzf support for ^p
  {
    'junegunn/fzf.vim',
    dependencies = {
      { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
    },
    config = function()
      -- doesn't need to be that big
      vim.g.fzf_layout = { down = '~20%' }
      -- prefer files closer to the current file
      -- using https://github.com/jonhoo/proximity-sort
      function list_cmd()
        local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:._S')
	if base == '.' then
	  -- if there is no current file, can't proximity-sort
	  return 'fd --hidden --type file --follow'
        else
	  return vim.fn.printf('fd --hidden --type file --follow | proximity-sort %s', vim.fn.shellescape(vim.fn.expand('%')))
	end
      end
      vim.api.nvim_create_user_command(
        'Files',
	function(arg)
	  vim.fn['fzf#vim#files'](arg.qargs, { source = list_cmd(), options = '--scheme=path --tiebreak=index' }, arg.bang)
	end,
	{ bang = true, nargs = '?', complete = 'dir' }
      )
    end
  },

  -- automatically go to project root when opening a file
  {
    'notjedi/nvim-rooter.lua',
    config = function()
      require('nvim-rooter').setup({
        fallback_to_parent = true,
      })
    end
  },

  -- change surrounding containers
  'tpope/vim-surround',

  -- add closing tags for HTML
  'alvan/vim-closetag',

  -- add closing brace, etc. when opening
  'jiangmiao/auto-pairs',

  -- show git diff in the sign column
  'airblade/vim-gitgutter',

  -- show git blame all the time
  {
    'APZelos/blamer.nvim',
    config = function()
      vim.g.blamer_enabled = true
    end
  },

  -- see what keys are bound to what commands
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- setup language servers
      local lspconfig = require('lspconfig')

      -- Rust
      lspconfig.rust_analyzer.setup {
        -- server-specific settings
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            imports = {
              group = {
                enable = true,
              },
            },
            completion = {
              postfix = {
                enable = false,
              },
            },
          },
        },
      }

      -- Global mappings
      -- See ':help vim.diagnostic.*' for documentation on any of the below
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

      -- use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c->
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings
          -- See `:help vim.lsp.*` for documentation
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)

          local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
					-- *and* there's some way to make it only apply to the current line.
					-- if client.server_capabilities.inlayHintProvider then
					--     vim.lsp.inlay_hint(ev.buf, true)
					-- end

					-- None of this semantics tokens business.
					-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
					client.server_capabilities.semanticTokensProvider = nil
        end,
      })
    end
  },
  -- LSP-based code-completion
  {
    'hrsh7th/nvim-cmp',
    -- load cmp on InsertEnter
    event = 'InsertEnter',
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          -- required by nvim-cmp
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          -- Accept currently selected item
          -- Set `select` to `false` to only confirm explicitly selected items
          ['<CR>'] = cmp.mapping.confirm({ select = true })
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'path' },
        }),
        experimental = {
          ghost_text = true
        },
      })

      -- Enable completing paths in :
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' },
        })
      })
    end
  },
  -- inline function signatures
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      -- get signatures (and _only_ signatures) when in argument lists.
      require 'lsp_signature'.setup({
        doc_lines = 0,
        handler_opts = {
          border = 'none',
        },
      })
    end
  },
  -- language support
  -- toml
  'cespare/vim-toml',
  -- yaml
  {
    'cuducos/yaml.nvim',
    ft = { 'yaml' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  -- rust
  {
    'rust-lang/rust.vim',
    ft = { 'rust' },
    config = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_emit_files = 1
      vim.g.rustfmt_fail_silently = 0
      vim.g.rust_clip_command = 'xclip -sel clip'
    end
  },
  -- markdown
  {
    'plasticboy/vim-markdown',
    ft = { 'markdown' },
    dependencies = {
      'godlygeek/tabular',
    },
    config = function()
      -- don't fold
      vim.g.vim_markdown_folding_disabled = 1
      -- support front-matter
      vim.g.vim_markdown_frontmatter = 1
      -- 'o' on a list item should insert at same level
      vim.g.markdown_new_list_item_indent = 0
      -- don't add bullest when wrapping
      vim.g.vim_markdown_auto_insert_bullets = 0
    end
  },
}
