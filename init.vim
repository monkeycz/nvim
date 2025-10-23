" NeoVim config file: ~/.config/nvim/init.vim
"

" -----------------------------------------------------------------------------
"  VIM-Plug Config
" -----------------------------------------------------------------------------

" Install vim-plugin[https://github.com/junegunn/vim-plug]
" and run `:PlugInstall`, `:PlugUpdate`, `:PlugUpgrade`
call plug#begin('~/.vim/plugged')

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'kkharji/sqlite.lua'

" Plug 'NLKNguyen/papercolor-theme'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

Plug 'lewis6991/gitsigns.nvim'
" Plug 'tpope/vim-fugitive'
Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v3.x' }
" Plug 'nvim-tree/nvim-tree.lua'
" Plug 'preservim/nerdtree'
Plug 'akinsho/toggleterm.nvim', { 'tag' : '*' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
" Plug 'romgrk/barbar.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" Plug 'kizza/actionmenu.nvim'
Plug 'monkeycz/actionmenu.nvim'
Plug 's1n7ax/nvim-window-picker'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
" run `:TSInstall vim vimdoc lua c rust python javascript toml markdown markdown_inline` `:TSUpdate`
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" run `:CocInstall coc-lists coc-tsserver coc-json coc-rust-analyzer coc-pyright coc-clangd coc-lua coc-git` `:CocUpdate`
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
Plug 'AckslD/nvim-neoclip.lua'
Plug 'tpope/vim-obsession'
Plug 'stevearc/aerial.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-mini/mini.bufremove'
" Plug 'nvim-mini/mini.animate'
Plug 'mhartington/formatter.nvim'
Plug 'folke/which-key.nvim'

call plug#end()

" -----------------------------------------------------------------------------
"  VIM Config
" -----------------------------------------------------------------------------

set number
set mouse=a
set nowrap
set ignorecase
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set clipboard=unnamedplus
set nobackup
set nowritebackup
set updatetime=300
set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=3
nnoremap <F2> :set invpaste paste?<CR>
set showmode
set whichwrap+=<,>,[,],h,l
set foldmethod=indent
set foldlevel=99

nnoremap <silent><F4> :nohlsearch<CR>:pclose<CR>

lua << EOF

vim.keymap.set("x", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("x", "<", "<gv", { noremap = true, silent = true })

EOF

" -----------------------------------------------------------------------------
" Web Devicons Config
" -----------------------------------------------------------------------------

lua << EOF

require('nvim-web-devicons').setup {}

EOF

" -----------------------------------------------------------------------------
" gitsigns Config
" -----------------------------------------------------------------------------

lua << EOF

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk)
  end
}

vim.keymap.set('n', 'g>', '<cmd>Gitsigns next_hunk<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'g<', '<cmd>Gitsigns prev_hunk<cr>', { noremap = true, silent = true })

EOF

" -----------------------------------------------------------------------------
" Neogit Config
" -----------------------------------------------------------------------------

lua << EOF

require('neogit').setup {}

EOF

" -----------------------------------------------------------------------------
" Diffview Config
" -----------------------------------------------------------------------------

lua << EOF

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "DiffviewFiles", "DiffviewFileHistory" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>DiffviewClose<CR>", { buffer = true, silent = true })
  end,
})

EOF

" -----------------------------------------------------------------------------
" PaperColor Config
" -----------------------------------------------------------------------------

" let g:PaperColor_Theme_Options = {
"     \ 'theme': {
"     \     'default.dark': {
"     \       'allow_bold': 1,
"     \       'transparent_background': 0
"     \     }
"     \   }
"     \ }

" -----------------------------------------------------------------------------
" Catppuccin Config
" -----------------------------------------------------------------------------

lua << EOF

require("catppuccin").setup {
    transparent_background = false,
}

EOF

" -----------------------------------------------------------------------------
" Theme Config
" -----------------------------------------------------------------------------

" set background=dark

set notermguicolors
if has("termguicolors")
    " fix bug for vim
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " enable true color
    set termguicolors
endif

" colorscheme PaperColor
colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

" -----------------------------------------------------------------------------
" NERDTree Config
" -----------------------------------------------------------------------------

" " autocmd vimenter * NERDTree
" let g:NERDTreeWinSize = 25
" let NERDTreeShowBookmarks = 1
" autocmd vimenter * if !argc() | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" let g:NERDTreeDirArrowExpandable = '+'
" let g:NERDTreeDirArrowCollapsible = '-'
" let NERDTreeIgnore = ['\.pyc$']
" let g:NERDTreeShowLineNumbers = 0
" let g:NERDTreeHidden = 0
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1

" nnoremap <silent><c-n> :NERDTreeToggle<CR>

" -----------------------------------------------------------------------------
" NvimTree Config
" -----------------------------------------------------------------------------

" lua << EOF
"
" vim.g.loaded_netrw = 1
" vim.g.loaded_netrwPlugin = 1
"
" require("nvim-tree").setup {
"     view = {
"         width = 30,
"         side = "left",
"     },
"     filters = {
"         -- dotfiles = false,
"         custom = {
"             "^.git$",
"             "^.DS_Store$",
"             -- "^.env$",
"             "^node_modules$",
"             "^thumbs.db$",
"             "^.ipynb_checkpoints$",
"         },
"     },
"     update_focused_file = {
"         enable = true,
"         update_cwd = true,
"         ignore_list = {},
"     },
" }
"
" vim.api.nvim_create_autocmd({ "VimEnter" }, {
"     callback = function(data)
"         if vim.fn.argc(-1) == 0 then
"             vim.cmd("NvimTreeOpen")
"         end
"     end
" })
"
" vim.api.nvim_create_autocmd("BufEnter", {
"     callback = function()
"         local wins = vim.api.nvim_tabpage_list_wins(0)
"         if #wins == 1 then
"             local buf = vim.api.nvim_win_get_buf(wins[1])
"             local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
"
"             if buf_name:match("NvimTree_1") then
"                 vim.cmd("qa")
"             end
"         end
"     end,
" })
"
" EOF
"
" nnoremap <silent><c-n> :NvimTreeToggle<CR>

" -----------------------------------------------------------------------------
" NvimTree Config
" -----------------------------------------------------------------------------

lua << EOF

require('neo-tree').setup {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = {
        "terminal",
        "trouble",
        "qf",
        "edgy",
        "nofile",
        "neo-tree",
        "target_hidden_message",
        ".gitignore_hidden_message",
        ".DS_Store_hidden_message",
    },
    window = {
        width = 30,
    },
    filesystem = {
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
        filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_ignored = true,
            hide_hidden = true,
            hide_by_name = {
                "node_modules",
                ".git",
            },
            never_show = {
                ".DS_Store",
                "thumbs.db",
            },
        },
    },
    default_component_configs = {
        git_status = {
            symbols = {
                added     = "+",
                modified  = "~",
                deleted   = "-",
                renamed   = "→",
                untracked = "?",
                ignored   = "",
                unstaged  = "!",
                staged    = "✔",
                -- conflict  = "✖",
            },
        },
    },
}

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function(data)
        if vim.fn.argc(-1) == 0 then
            vim.cmd("Neotree focus")
        end
    end
})

local hidden_buffers = {
    "target_hidden_message",
    ".gitignore_hidden_message",
    ".DS_Store_hidden_message",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = hidden_buffers,
    callback = function()
        vim.schedule(function()
            vim.cmd("bd!")
        end)
    end,
})

vim.keymap.set("n", "<c-n>", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true })

EOF

" -----------------------------------------------------------------------------
" ToggleTerm Config
" -----------------------------------------------------------------------------

lua require("toggleterm").setup {}

autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

" -----------------------------------------------------------------------------
" Airline Config
" -----------------------------------------------------------------------------

"let g:airline_theme = 'desertink'
"let g:airline_theme = 'atomic'
"let g:airline_theme = 'papercolor'
"let g:airline_theme = 'bubblegum'
let g:airline_theme = 'catppuccin'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1

" -----------------------------------------------------------------------------
" Tmuxline Config
" -----------------------------------------------------------------------------

let g:tmuxline_preset = 'full'
let g:tmuxline_theme = 'jellybeans'

" -----------------------------------------------------------------------------
" Barbar Config
" -----------------------------------------------------------------------------

" lua << EOF
"
" require('barbar').setup {
"     icons = {
"         buffer_index = true,
"         filetype = {
"             enabled = false,
"         },
"         -- button = 'x',
"         pinned = { button = '', filename = true },
"         -- gitsigns = {
"         --     added = { enabled = true, icon = '+' },
"         --     changed = { enabled = true, icon = '~' },
"         --     deleted = { enabled = true, icon = '-' },
"         -- },
"     },
"     sidebar_filetypes = {
"         NvimTree = { text = "File Explorer", align = "center" },
"         ['neo-tree'] = { text = "File Explorer", align = "center" },
"     },
"     no_name_title = "No Name"
" }
"
" vim.keymap.set('n', '<leader>,', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>.', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
"
" vim.keymap.set('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>0', '<Cmd>BufferLast<CR>', { noremap = true, silent = true })
"
" vim.keymap.set('n', '<leader>q', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
" vim.keymap.set('n', '<leader>Q', '<Cmd>BufferCloseAllButCurrent<CR>', { noremap = true, silent = true })
"
" EOF

" -----------------------------------------------------------------------------
" bufferline Config
" -----------------------------------------------------------------------------

lua << EOF

require("bufferline").setup {
    options = {
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
		},
	},
}

vim.keymap.set('n', '<leader>,', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>.', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>0', '<Cmd>BufferLineGoToBuffer 0<CR>', { noremap = true, silent = true })

local function smart_close_buffer()
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local modified = vim.bo[bufnr].modified

    local other_bufs = vim.tbl_filter(function(b)
        return vim.bo[b].buflisted and b ~= bufnr
    end, vim.api.nvim_list_bufs())

    if bufname == "" and not modified and #other_bufs == 0 then
        print("Already in an empty buffer")
        return
    end

    local bufs = vim.fn.getbufinfo({buflisted = 1})

    if #bufs <= 1 then
        vim.cmd('enew')
        vim.bo.buftype = ''
        vim.bo.bufhidden = 'wipe'
    end

    require('mini.bufremove').delete(bufnr, false)
end

vim.keymap.set('n', '<leader>q', smart_close_buffer, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>Q', '<Cmd>BufferLineCloseOthers<CR>', { noremap = true, silent = true })

EOF

" -----------------------------------------------------------------------------
" ActionMenu Config
" -----------------------------------------------------------------------------

let s:code_actions = []

func! ActionMenuCodeActionsCallback(index, item) abort
  if a:index >= 0
    let l:selected_code_action = s:code_actions[a:index]
    let l:response = CocAction('doCodeAction', l:selected_code_action)
  endif
endfunc

func! ActionMenuCodeActions() abort
  if coc#float#has_float()
    call coc#float#close_all()
  endif

  let s:code_actions = CocAction('codeActions')
  let l:menu_items = map(copy(s:code_actions), { index, item -> item['title'] })
  call actionmenu#open(l:menu_items, 'ActionMenuCodeActionsCallback')
endfunc

func! ActionMenuItemCallback(index, item)
  if a:index >= 0
    execute a:item['user_data']
  endif
endfunc

func! ActionMenuCodeActionMenu()
  let l:items = [
    \ { 'word': 'Hover', 'user_data': 'call CocActionAsync("doHover")', 'shortcut': '1' },
    \ { 'word': 'Definition', 'user_data': 'call CocAction("jumpDefinition")', 'shortcut': '2' },
    \ { 'word': 'Type Definition', 'user_data': 'call CocAction("jumpTypeDefinition")', 'shortcut': '3' },
    \ { 'word': 'References', 'user_data': 'call CocAction("jumpReferences")', 'shortcut': '4' },
    \ { 'word': 'Code Actions', 'user_data': 'call ActionMenuCodeActions()', 'shortcut': '5' },
    \ { 'word': 'Quickfix', 'user_data': 'call CocAction("doQuickfix")', 'shortcut': '6' },
    \ { 'word': 'Rename', 'user_data': 'call CocActionAsync("rename")', 'shortcut': '7' },
    \ { 'separator': v:true },
    \ { 'word': 'OutLine', 'user_data': 'AerialToggle!', 'shortcut': '8' },
    \ { 'separator': v:true },
    \ { 'word': 'Format Code', 'user_data': 'Format', 'shortcut': '9' },
    \ ]

  call actionmenu#open(
    \ l:items,
    \ { index, item -> ActionMenuItemCallback(index, item) }
    \ )
endfunc

nnoremap <silent><leader>; :call ActionMenuCodeActionMenu()<CR>
inoremap <silent><leader>; <ESC>:call ActionMenuCodeActionMenu()<CR>

lua << EOF

local neogit = require('neogit')

function GitViewToggle()
  local tab = vim.api.nvim_get_current_tabpage()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
    local ok, buf = pcall(vim.api.nvim_win_get_buf, win)
    if ok then
        local name = vim.api.nvim_buf_get_name(buf)
        -- vim.api.nvim_echo({{vim.inspect(name)}}, true, {})
        if name:match("NeogitStatus") then
          -- vim.api.nvim_win_close(win, true)
          neogit.close()
          return
        elseif name:match("DiffviewFilePanel") or name:match("DiffviewFileHistoryPanel") then
          vim.cmd("DiffviewClose")
          return
        end
    end
  end
  neogit.open({ kind = "tab" })  -- "tab" / "replace" / "split"
end

EOF

func! ActionMenuGitMenu()
  let l:items = [
    \ { 'word': 'Toggle Git View', 'user_data': 'lua GitViewToggle()', 'shortcut': '1' },
    \ { 'word': 'Open Git Diff', 'user_data': 'DiffviewOpen', 'shortcut': '2' },
    \ { 'word': 'Open Git History', 'user_data': 'DiffviewFileHistory', 'shortcut': '3' },
    \ { 'separator': v:true },
    \ { 'word': 'Goto Next Diff', 'user_data': 'Gitsigns next_hunk', 'shortcut': '4' },
    \ { 'word': 'Goto Prev Diff', 'user_data': 'Gitsigns prev_hunk', 'shortcut': '5' },
    \ ]

  call actionmenu#open(
    \ l:items,
    \ { index, item -> ActionMenuItemCallback(index, item) }
    \ )
endfunc

nnoremap <silent><leader>g :call ActionMenuGitMenu()<CR>
inoremap <silent><leader>g <ESC>:call ActionMenuGitMenu()<CR>

func! ActionMenuShortcutMenu()
  let l:items = [
    \ { 'word': 'New Window', 'user_data': 'call feedkeys(":vs\<CR>")', 'shortcut': '1' },
    \ { 'word': 'Close Window', 'user_data': 'call feedkeys(":close\<CR>")', 'shortcut': '2' },
    \ { 'separator': v:true },
    \ { 'word': 'New File', 'user_data': 'call feedkeys(":new\<CR>")', 'shortcut': '3' },
    \ { 'separator': v:true },
    \ { 'word': 'Toggle Terminal', 'user_data': 'call feedkeys(":ToggleTerm\<CR>")', 'shortcut': '4' },
    \ { 'word': 'Toggle File Explorer', 'user_data': 'call feedkeys(":Neotree toggle\<CR>")', 'shortcut': '5' },
    \ { 'separator': v:true },
    \ { 'word': 'Files List', 'user_data': 'call feedkeys(":CocList files\<CR>")', 'shortcut': '6' },
    \ { 'word': 'Buffers List', 'user_data': 'call feedkeys(":CocList buffers\<CR>")', 'shortcut': '7' },
    \ { 'word': 'Windows List', 'user_data': 'call feedkeys(":CocList windows\<CR>")', 'shortcut': '8' },
    \ { 'separator': v:true },
    \ { 'word': 'Hide Highlight', 'user_data': 'call feedkeys(":nohlsearch\<CR>:pclose\<CR>")', 'shortcut': '9' },
    \ ]

  call actionmenu#open(
    \ l:items,
    \ { index, item -> ActionMenuItemCallback(index, item) }
    \ )
endfunc

nnoremap <silent><leader>' :call ActionMenuShortcutMenu()<CR>
inoremap <silent><leader>' <ESC>:call ActionMenuShortcutMenu()<CR>

" -----------------------------------------------------------------------------
" Window Picker Config
" -----------------------------------------------------------------------------

lua << EOF

local picker = require("window-picker")
picker.setup {
    autoselect_one = true,
    include_current = false,
    show_prompt = false,
    filter_rules = {
        bo = {
            -- filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
            filetype = { "notify", "quickfix" },
            buftype = { "terminal" },
        },
    },
}

vim.keymap.set("n", "<leader>w", function()
    local picked_window_id = picker.pick_window({
        hint = 'floating-big-letter',
        include_current_win = true,
    }) or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

local function swap_windows()
    local window = picker.pick_window({
        hint = 'floating-big-letter',
        include_current_win = false,
    })
    local target_buffer = vim.fn.winbufnr(window)
    vim.api.nvim_win_set_buf(window, 0)
    vim.api.nvim_win_set_buf(0, target_buffer)
end

vim.keymap.set("n", "<leader>W", swap_windows, { desc = "Swap windows" })

EOF

" -----------------------------------------------------------------------------
" Treesitter Config
" -----------------------------------------------------------------------------

lua << EOF

require('nvim-treesitter.configs').setup {
    ensure_installed = { "vim", "vimdoc", "lua", "c", "rust", "python", "javascript", "toml", "markdown", "markdown_inline" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            node_decremental = "grm",
        },
    },
}

EOF

" -----------------------------------------------------------------------------
" CoC Config
" -----------------------------------------------------------------------------

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <c-/> coc#refresh()

nmap <silent>g[ <Plug>(coc-diagnostic-prev)
nmap <silent>g] <Plug>(coc-diagnostic-next)

nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nnoremap <silent>K :call ShowDocumentation()<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

" nmap <silent><leader>rn <Plug>(coc-rename)

" xmap <silent><leader>f  <Plug>(coc-format-selected)
" nmap <silent><leader>f  <Plug>(coc-format-selected)

" nmap <silent><C-s> <Plug>(coc-range-select)
" xmap <silent><C-s> <Plug>(coc-range-select)

" command! -nargs=1 Format :call CocActionAsync('format')
" command! -nargs=? Fold 	 :call CocAction('fold', <f-args>)
" command! -nargs=0 OR     :call CocActionAsync('runCommand', 'editor.action.organizeImport')

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" -----------------------------------------------------------------------------
" Telescope Config
" -----------------------------------------------------------------------------

lua << EOF

require('telescope').setup {
  defaults = {
    layout_config = {
      width = 0.8,
      height = 0.8,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fu', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope git_status<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope git_commits<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope git_branches<cr>', { noremap = true, silent = true })

EOF

" -----------------------------------------------------------------------------
" NeoClip Config
" -----------------------------------------------------------------------------

lua << EOF

require('neoclip').setup {
    history = 1000,
    enable_persistent_history = true,
    default_register = { '"', '+', '*' },
    content_spec_column = true,
    filter = nil,
    preview = true,
}

vim.keymap.set("n", "<leader>fr", "<cmd>Telescope neoclip<CR>", { noremap = true, silent = true })

EOF

" -----------------------------------------------------------------------------
" Aerial Config
" -----------------------------------------------------------------------------

lua << EOF

require("aerial").setup {
    layout = {
        max_width = { 40, 0.2 },
        width = 30,
        min_width = 10,
        resize_to_content = false,
    },
}

EOF

" -----------------------------------------------------------------------------
" Comment Config
" -----------------------------------------------------------------------------

lua << EOF

require('Comment').setup {}

-- Ctrl + /
vim.keymap.set('n', '<c-_>', function()
    require('Comment.api').toggle.linewise.current()
end, { noremap = true, silent = true })

-- Ctrl + /
vim.keymap.set('v', '<c-_>', function()
    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'nx', false)
    require('Comment.api').toggle.linewise(vim.fn.visualmode())
end, { noremap = true, silent = true })

EOF

" -----------------------------------------------------------------------------
" MiniAnimate Config
" -----------------------------------------------------------------------------

" lua << EOF
"
" require('mini.animate').setup {
"     scroll = {
"         enable = false,
"     },
"     cursor = {
"         enable = false,
"     },
"     resize = {
"         enabel = false,
"     },
"     open = {
"         enable = false,
"     },
"     close = {
"         enable = false,
"     },
" }
"
" EOF

" -----------------------------------------------------------------------------
" Formatter Config
" -----------------------------------------------------------------------------

lua << EOF

require("formatter").setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua,
    },

    python = {
      require("formatter.filetypes.python").black,
      -- require("formatter.filetypes.python").autopep8,
    },

    rust = {
      require("formatter.filetypes.rust").rustfmt,
    },

    c = {
      require("formatter.filetypes.c").clangformat,
    },

    javascript = {
      require("formatter.filetypes.javascript").prettier,
    },
    json = {
      require("formatter.filetypes.json").prettier,
    },

    toml = {
      require("formatter.filetypes.toml").taplo,
    },

    vim = {
      function()
        return {
          exe = "vim",
          args = { "-E", "-s", "-", "+normal! gg=G" },
          stdin = true,
        }
      end,
    },

    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
})

-- auto format code when save file
-- vim.api.nvim_exec([[
--   augroup FormatAutogroup
--     autocmd!
--     autocmd BufWritePost * silent! FormatWrite
--   augroup END
-- ]], true)

-- vim.api.nvim_set_keymap("n", "<leader>m", ":Format<CR>", { noremap = true, silent = true })

EOF

" -----------------------------------------------------------------------------
" Formatter Config
" -----------------------------------------------------------------------------

lua << EOF

require("which-key").setup {}

vim.keymap.set('n', '<leader>?', function()
    require("which-key").show({ global = false })
end, { noremap = true, silent = true })

EOF

