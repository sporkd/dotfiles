" -------------------------------------------------------------------------------------------
"  PLUGINS
" -------------------------------------------------------------------------------------------

" Call vim-plug
call plug#begin()

" -------------------------------------------------------------------------------------------
" SYNTAX & HIGHTLIGHTING
" -------------------------------------------------------------------------------------------

" HTML
Plug 'othree/html5.vim',            {'for': ['html', 'vue', 'jsx', 'javascript.jsx', 'eelixir']} " HTML5 syntax & completion
Plug 'valloric/MatchTagAlways',     {'for': ['html', 'vue', 'jsx', 'javascript.jsx']} " Highlights matching tag

" Javascript & Json
Plug 'othree/yajs.vim',             {'for': ['javascript', 'jsx', 'vue', 'javascript.jsx']} " Javascript syntax
Plug 'othree/jspc.vim',             {'for': ['javascript', 'jsx', 'vue', 'javascript.jsx']} " Javascript parameter completion
Plug 'moll/vim-node',               {'for': ['javascript', 'jsx', 'vue', 'javascript.jsx']} " Node tools
Plug 'elzr/vim-json',               {'for': 'json'}                                         " JSON highlighting
Plug 'posva/vim-vue',               {'for': 'vue'}                                          " Vue.js syntax highlighting

" Yaml
Plug 'stephpy/vim-yaml',            {'for': 'yaml'} " Yaml syntax highlighting

" CSS & Styling
Plug 'hail2u/vim-css3-syntax',      {'for': ['css', 'vue']} " CSS and SCSS syntax & highlighting
Plug 'cakebaker/scss-syntax.vim',   {'for': ['scss', 'vue']} " SCSS syntax
Plug 'wavded/vim-stylus',           { 'for': ['stylus', 'vue']} " Stylus syntax & highlighting
Plug 'ap/vim-css-color',            {'for':['css', 'scss', 'styl', 'vue',]} " Show colors on CSS files

" Elixir
Plug 'elixir-lang/vim-elixir',      {'for': 'elixir'} " Elixir language highlighting
Plug 'slashmili/alchemist.vim',     {'for': 'elixir'} " Elixir Integration

" Go
Plug 'fatih/vim-go',                {'do': ':GoInstallBinaries', 'for': 'go'} " Golang utilities

" Crystal
Plug 'rhysd/vim-crystal',           {'for': 'crystal'} " Crystal language highlighting

" Ruby
Plug 'vim-ruby/vim-ruby',           {'for': 'ruby'} " Ruby language syntax & highlighting
Plug 'tpope/vim-rails',             {'for': 'ruby'} " Rails syntax and helpers

" Tools
Plug 'tmux-plugins/vim-tmux',       {'for': 'tmux'} " Tmux file highlighting
" Plug 'dag/vim-fish',                {'for': 'fish'} " Fish shell highlighting

" -------------------------------------------------------------------------------------------
" UTILITIES
" -------------------------------------------------------------------------------------------

" Delimiters
Plug 'itmammoth/doorboy.vim'        " Auto close brackets, quotations, etc.
Plug 'tpope/vim-surround'           " Easily change surroundings (parenthesis, brackets, etc)
Plug 'tpope/vim-endwise'            " Add 'end' automatically for ruby, elixir and others

" Comments
Plug 'tpope/vim-commentary'         " Easily comment/uncomment words, lines or group of lines

" File manipulation
Plug 'mattn/emmet-vim',             {'for': ['html', 'vue', 'css', 'scss', 'javascript', 'jsx', 'eelixir']} " Easy workflow for html & CSS

" Format/Indentation
Plug 'sbdchd/neoformat'             " Format code
Plug 'junegunn/vim-easy-align'      " Easy alignement
Plug 'Yggdroot/indentLine'          " Show a line to display indentation level
Plug 'AndrewRadev/splitjoin.vim',   {'on': ['SplitjoinJoin', 'SplitjoinSplit']} " Transition between multiline and single-line code

" Git
Plug 'lambdalisue/gina.vim'         " Control GIT repos from nvim session
Plug 'airblade/vim-gitgutter'       " Show GIT changes status in the gutter
Plug 'jreybert/vimagit'             " Easier GIT workflow

" Nerdtree
Plug 'scrooloose/nerdtree'          " Directory & files tree
Plug 'Xuyuanp/nerdtree-git-plugin'  " Nerdtree plugin to show GIT flags

" Skim fuzzy finder
Plug 'lotabout/skim',               {'dir': '~/.skim', 'do': './install --bin', 'on': ['SK']} " FZF option in Rust lang

" Denite
Plug 'Shougo/denite.nvim'           " Multiple helpful functions: open files, search, change folder, etc.
Plug 'Shougo/neomru.vim'            " Most recent used files source for denite/unite

" Testing
Plug 'janko-m/vim-test'             " Run tests from inside Neovim

" Other tools
Plug 'bogado/file-line'                 " Open a file on arbitrary line: filename:line
Plug 'AndrewRadev/switch.vim'           " Quickly switch between patterns
Plug 'christoomey/vim-tmux-navigator'   " Navigate between Tmux and Vim splits
Plug 'mtth/scratch.vim'                 " Create scratch buffer for quick notes and todo lists
Plug 'ludovicchabant/vim-gutentags'     " ctags all the way!!!
Plug 'majutsushi/tagbar'                " Inmemory ctags window visualizer
Plug 'terryma/vim-multiple-cursors'     " Multiple cursors like Sublime Text's
Plug 'justinmk/vim-sneak'               " Jump to location specifies by 2 character
Plug 'hauleth/sad.vim'                  " Quick change and replace!
Plug 'matze/vim-move'                   " Easily move blocks of code, no cuting and pasting!!!
Plug 'EinfachToll/DidYouMean'           " Ask for confirmation to open file if similar names exist
Plug 'airblade/vim-rooter'              " Chage working directory to project root
Plug 'tpope/vim-eunuch'                 " UNIX file shell command helpers
Plug 'rizzatti/dash.vim',           {'on': ['Dash', 'DashKeywords', '<Plug>DashSearch']} " Easy documentation with Dash.app (OSX)

" -------------------------------------------------------------------------------------------
" COMPLETION
" -------------------------------------------------------------------------------------------

" Deoplete
Plug 'Shougo/deoplete.nvim',        { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'Shougo/context_filetype.vim'  " Filetype context
Plug 'Shougo/neoinclude.vim'        " Include completion framework

" Snippets
Plug 'Shougo/neosnippet.vim'        " Snippets support
Plug 'Shougo/neosnippet-snippets'   " Snippets repository
Plug 'Shougo/echodoc.vim'           " Show functions signatures in the command line

" Deoplete filetype sources
Plug 'wellle/tmux-complete.vim'     " Adjacent tmux panes completion
Plug 'Shougo/neco-vim',             {'for': 'vim'} " Vim script completion
Plug 'awetzel/elixir.nvim',         {'do': 'yes \| ./install.sh' } " Elixir completion
Plug 'fishbullet/deoplete-ruby',    {'for': 'ruby'} " Ruby completion
" Plug 'ponko2/deoplete-fish',        {'for': 'fish'} " Fish shell completion
Plug 'carlitux/deoplete-ternjs',    {'for': ['javascript', 'vue', 'jsx']} " Javascript completion
Plug 'zchee/deoplete-go',           {'do': 'make', 'for': 'go'} " Golang completion

" -------------------------------------------------------------------------------------------
" LINTERS
" -------------------------------------------------------------------------------------------

" Main lintting framework
Plug 'w0rp/ale'

" -------------------------------------------------------------------------------------------
" THEMES & UI
" -------------------------------------------------------------------------------------------

" Status line
Plug 'jacoborus/tender.vim'       " Tender theme
Plug 'rakr/vim-one'               " Vim One theme
Plug 'reedes/vim-colors-pencil'   " Pencil theme
Plug 'vim-airline/vim-airline'    " Airline plugin

call plug#end()
