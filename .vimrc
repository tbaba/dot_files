set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vividchalk'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rvm'
Plugin 'tpope/vim-haml'
Plugin 'skwp/vim-rspec'
Plugin 'vim-coffee-script'
Plugin 'Shougo/neocomplcache'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler'
Plugin 'h1mesuke/unite-outline'
Plugin 'vim-ruby/vim-ruby'
Plugin 'othree/html5.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'scrooloose/nerdtree'

" 文字コードの設定
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" 検索文字のハイライト
set hlsearch
" 検索時、大文字小文字無視
set ignorecase
" 検索時、大文字から始めたら大文字小文字を無視しない
set smartcase
" ファイル形式の検出
filetype on
" ファイル形式別のインデントを有効にする
" ファイル形式別のプラグインを有効にする
filetype plugin indent on

" エラーベルを鳴らさない
set noerrorbells

" バックアップファイルを作らない
set nobackup

" バッファを切り替えてもundoの効果を失わないようにする
set hidden
" 行数を表示する
set number
" ステータスバーを下から2行目に表示
set laststatus=2
" カーソル位置を表示する
set ruler
" カーソルのある行に下線を引く
" set cursorline

" 自動インデントを有効にする
set autoindent

" シンタックスハイライトを有効化する
syntax on

" vividchalk as colorscheme
colorscheme vividchalk

"" Ruby, Ruby on Rails, Sinatraなどの開発用オプション
" 通常、tabはスペース4つ分
au BufNewFile,BufRead * set tabstop=4 shiftwidth=4
" erb/html/yml/rbの場合はスペース2つ分
au BufNewFile,BufRead *.html.erb set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.rhtml set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.html set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.yml set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.haml set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.js set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.js.coffee set tabstop=2 shiftwidth=2 expandtab
" RailsはUTF-8で書く　
au User Rails* set fenc=utf-8
let ruby_space_errors=1
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1
let g:rails_level=4
let g:rails_syntax=1
let g:rails_default_database='sqlite3'

"バッファタブにパスを省略してファイル名のみ表示する(buftabs.vim)
let g:buftabs_only_basename=1
"バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1

"neocomplcache周りの設定
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_min_syntax_length=3

" map, nmap
" 保存とか
nmap <Space>w :up<CR>
nmap <Space>q :q<CR>
nmap <Space>z <C-z>

" Space + hl で:nohl
nmap <Space>hl :nohl<CR>

" ノーマルモードでもエンターキーで改行を挿入
noremap <CR> o<ESC>

" バッファの移動を矢印キーで
map <LEFT> <ESC>:bp<CR>
map <RIGHT> <ESC>:bn<CR>
map <UP> <ESC>:ls<CR>
map <Space>d <ESC>:bd<CR>

" :と数字でバッファ移動
map <ESC>:1 <ESC>:b1

" CTRL-Spaceでomni補完
imap <C-Space> <C-x><C-o>

"CTRL-kでクリップボードから貼り付け
imap <C-k> <ESC>"+gpa

"edit routes & schema

" Edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb
command! Rapp :e config/application.rb
command! Rinitializer :e config/initializers/

function! MagicComment()
  return "# coding: utf-8\<CR>"
endfunction

inoreabbrev <buffer> #### <C-R>=MagicComment()<CR>

" Space + . でvimrcを開く
nnoremap <Space>. :<C-u>edit ~/.vimrc<Enter>

" ;と:を入れ替える
noremap ; :

noremap <Shift>: ;



" Vimテクニックバイブルのお試し系

" Insertのときにstatuslineの色を変える
au InsertEnter * hi StatusLine guifg=Black guibg=Yellow gui=none ctermfg=Black ctermbg=Yellow cterm=none
au InsertLeave * hi StatusLine guifg=White guibg=DarkGray gui=none ctermfg=White ctermbg=DarkGray cterm=none

set listchars=eol:$,tab:>\

autocmd FileType ruby map <F9> :w<CR>:!ruby -c %<CR>


function! Scouter(file, ...)
	let pat = '^\s*$\|^\s*"'
	let lines = readfile(a:file)
	if !a:0 || !a:1
		let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
	endif
	return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
			\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)


function! s:SetupSpeCuke()
	command! RunTestFile exe '!sc ' . expand('%:p')
	command! RunTestCase exe '!sc --line ' . line('.') . ' ' . expand('%:p')

	nnoremap -tf :RunTestFile<CR>
	nnoremap -tc :RunTestCase<CR>
endfunction

au BufRead,BufNewFile *_spec.rb,*.feature call s:SetupSpeCuke()
