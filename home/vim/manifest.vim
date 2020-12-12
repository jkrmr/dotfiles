" ---------------- Plugins --------------------------
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'liuchengxu/space-vim-dark'

Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-zsh'
Plug 'Shougo/neco-vim'
Plug 'wellle/tmux-complete.vim'

Plug 'SirVer/ultisnips'               " snippets engine, integrates with YCM
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'    " cp
Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'          " lightweight, configurable status line
Plug 'jiangmiao/auto-pairs'
Plug 'jmromer/yankee.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kien/rainbow_parentheses.vim'   " delimiter highlighting
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-hugefile'
Plug 'ntpeters/vim-better-whitespace' " detect and highlight bad whitespace
Plug 'pbrisbin/vim-mkdir'             " create subdirectories as needed
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tomtom/tcomment_vim'            " gcc / gc[ai][pim]
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'                  " git commit filetype settings, et al
Plug 'tpope/vim-rsi'                  " readline bindings in insert mode
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'             " surround text block with delimiters
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'              " enhancements to netrw
Plug 'vim-scripts/YankRing.vim'       " maintain yank/del history

" Text objects
Plug 'kana/vim-textobj-entire' " Adds ae/ie
Plug 'kana/vim-textobj-indent' " Adds i
Plug 'kana/vim-textobj-user'   " custom text objects
Plug 'kana/vim-textobj-line'   " Adds l

" Ruby
Plug 'ck3g/vim-change-hash-syntax', { 'for': ['ruby'] }
Plug 'ecomba/vim-ruby-refactoring', { 'for': ['ruby'] }
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': ['ruby'] }
Plug 'noprompt/vim-yardoc', { 'for': ['ruby'] }
Plug 't9md/vim-ruby-xmpfilter', { 'for': ['ruby'] }
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise', { 'for': ['ruby'] }
Plug 'tpope/vim-projectionist' | Plug 'tpope/vim-rake'
Plug 'tpope/vim-rails', { 'for': ['ruby']  }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }

" JS
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript'], 'do': 'npm install -g tern' }
Plug 'elzr/vim-json', { 'for': ['json'] }
Plug 'wizicer/vim-jison', { 'for': ['json'] }

" Python
Plug 'cjrh/vim-conda', { 'for': ['python'] }
Plug 'jeetsukumaran/vim-pythonsense', { 'for': ['python'] }
Plug 'plytophogy/vim-virtualenv', { 'for': ['python'] }
Plug 'python-mode/python-mode', { 'branch': 'develop', 'for': ['python'] }
Plug 'tweekmonster/django-plus.vim', { 'for': ['python'] }
Plug 'vim-scripts/indentpython.vim', { 'for': ['python'] }
Plug 'zchee/deoplete-jedi', { 'for': ['python'] }

" Elixir
Plug 'elixir-editors/vim-elixir', { 'for': ['elixir'] }
Plug 'mhinz/vim-mix-format', { 'for': ['elixir'] }
Plug 'c-brenn/phoenix.vim' | Plug 'tpope/vim-projectionist'
