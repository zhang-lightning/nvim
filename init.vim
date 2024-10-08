" 设备默认配置
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
        let has_machine_specific_file = 0
        silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim
set nospell
set encoding=utf-8      " 使用utf-8编码
set t_Co=256    " 256色显示启用
filetype indent on      " 自动甄别文件类型，载入对应缩进规则
set textwidth=90        " 设置行宽
set wrap        " 自动换行显示
set linebreak   " 防止单词内换行
set wrapmargin=3        " 换行显示部分与右端空出的字符数
set scrolloff=5  " 垂直滚动光标距离底部或顶部是距离（行）
set laststatus=2        " 显示状态栏
set showmatch   " 匹配对应的括号
set ignorecase " 搜索时忽略大小写
set incsearch   " 每输入一个字符，自动跳到第一个匹配的结果
set visualbell  " 出错时发出视觉提示
set history=600 " 记录的历史操作次数
set wildmenu
set wildmode=longest:list,full  " 底部指令操作补全
set lazyredraw  " 加速运行
silent !mkdir -p ~/.config/nvim/tmp/undo/
silent !mkdir -p ~/.config/nvim/tmp/backup/
set backup
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('presitent_undo')
        set undofile
        set undodir=~/.config/nvim/tmp/undo,.
endif
set nu
set relativenumber
set updatetime=100

" 键位修改
let mapleader=" "
noremap ; :
noremap W <ESC>w

" Markdown设置
" Snippets
source /home/zeshen/.config/nvim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell

" GCC编译功能
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'python'
                set splitbelow
                :sp
                :term python3 %
        elseif &filetype == 'markdown'
                exec "MarkdownPreview"
        endif
endfunc

" *********插件管理*********
call plug#begin('~/.config/nvim/plugged')
"外观
Plug 'bling/vim-bufferline'
Plug 'bpietravalle/vim-bolt'
Plug 'theniceboy/vim-deus'
"状态栏
Plug 'theniceboy/eleline.vim'
"高亮
Plug 'RRethy/vim-hexokinase',{'do':'make hexokinase'}
Plug 'RRethy/vim-illuminate'
"文件管理
Plug 'junegunn/fzf.vim'
Plug 'kevinhwang91/rnvimr',{'do':'make sync'}
Plug 'airblade/vim-rooter'
Plug 'pechorin/any-jump.vim'
"标签列表
Plug 'liuchengxu/vista.vim'
"DEBUGGER
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}
"自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Snippets
Plug 'theniceboy/vim-snippets'
"格式化代码
Plug 'Chiel92/vim-autoformat'
"Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }
" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'
"R语言插件
Plug 'jalvesaq/Nvim-R'
" 视觉增强
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'
Plug 'mg979/vim-xtabline'
Plug 'wincent/terminus'
call plug#end()
set re=0

"×××××××××插件设置

" ===
" === eleline.vim
" ===
let g:airline_powerline_fonts = 0

" ===
" === coc
" ===
silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = [
  \ 'coc-actions',
  \ 'coc-clangd',
  \ 'coc-diagnostic',
  \ 'coc-explorer',
  \ 'coc-flutter',
  \ 'coc-gitignore',
  \ 'coc-lists',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-sourcekit',
  \ 'coc-stylelint',
  \ 'coc-syntax']

" tab键自动补全
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
                        \ 'mkit': {},
                        \ 'katex': {},
                        \ 'uml': {},
                        \ 'maid': {},
                        \ 'disable_sync_scroll': 0,
                        \ 'sync_scroll_type': 'middle',
                        \ 'hide_yaml_meta': 1
                        \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" ===
" === AutoFormat
" ===
nnoremap \f :Autoformat<CR>
let g:formatdef_custom_js = '"js-beautify -t"'
let g:formatters_javascript = ['custom_js']
au BufWrite *.js :Auoformat

" === vim-markdown-toc
" ===
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

set clipboard+=unnamedplus
