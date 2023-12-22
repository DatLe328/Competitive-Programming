syntax on
:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Compile and run cpp file
"autocmd FileType cpp nnoremap <F6> :w<CR>:!g++ % -o %< && ./%< < /home/datle/Documents/TASK.inp > /home/datle/Documents/TASK.out 2>&1<CR>

"Auto open input and output in cpp
"autocmd FileType cpp
"\ call CloseSpecifiedFiles() | vsp | wincmd l |  edit /home/datle/Documents/TASK.out | execute 'vertical resize 35' | sp | edit /home/datle/Documents/TASK.inp

nnoremap <F5> :call RunFile()<CR>

"Compile and run
function! RunFile()
    "Get file type
    let l:filetype = &filetype

	"CPP
    if l:filetype == 'cpp'
        echomsg "Running C++ file!"
		let g:input_file = expand('%:p:r') . '_input.txt'
		let g:output_file = expand('%:p:r') . '_output.txt'
		if filereadable(g:input_file)
        " Chạy file C++ và truyền địa chỉ file input và output
			execute ":w"
			execute ':!g++ % -o %< && ./%< < ' . g:input_file . ' > ' . g:output_file '2>&1'
		else
			echomsg 'File input not found: ' . g:input_file
		endif
		
		"execute ":w"
        "execute ":!g++ % -o %< && ./%< < . g:input_file > . g:output_file 2>&1"
	"Python 
	elseif l:filetype == 'python'
        echomsg "Running Python file!"
		execute ":w"
        execute ":!python3 %"
	"Javascript
	elseif l:filetype == "javascript"
		echomsg "Running Javascript file!"
		execute ":w"
        execute "!node %"
	"Can't run
	else
		echomsg "File not supported"
	endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:input_file = ''
let g:output_file = ''

"Close input and output files
function! CloseFiles()
	if filereadable(g:input_file)
		execute 'bwipeout ' . g:input_file
	endif
	if filereadable(g:output_file)
		execute 'bwipeout ' . g:output_file
	endif
	let g:input_file = ''
	let g:output_file = ''
endfunction

"Open input and output files
function! OpenFiles()
	" Auto create input and output files
	call CreateInputOutputFiles()
	let g:input_file = expand('%:p:r') . '_input.txt'
	let g:output_file = expand('%:p:r') . '_output.txt'

	" Check if ouput file exist
	if filereadable(g:output_file)
		vsp | wincmd l
        execute 'edit ' . g:output_file
		execute 'vertical resize 35' 
    else
		echo 'Auto create input file: ' . g:output_file
		vsp | wincmd l
        execute 'edit ' . g:output_file
		execute 'vertical resize 35'
    endif
    
    " Check if input file exist
    if filereadable(g:input_file)
		sp
		execute 'edit ' . g:input_file
		wincmd h
    else
        echo 'Auto create output file: ' . g:output_file
		sp
		execute 'edit ' . g:input_file
		wincmd h
    endif
endfunction

" Autocmd để gọi hàm kiểm tra và đóng file khi mở file mới
"autocmd BufRead * call CloseFiles()

" Autocmd để mở file input và output khi mở file cpp
"autocmd FileType cpp call OpenFiles()

function! CreateInputOutputFiles()
    " Kiểm tra và tạo file input nếu chưa tồn tại
    if !filereadable(g:input_file) && g:input_file != ''
        call writefile([''], g:input_file)
    endif

    " Kiểm tra và tạo file output nếu chưa tồn tại
    if !filereadable(g:output_file) && g:output_file != ''
        call writefile([''], g:output_file)
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CP()
	let l:filetype = &filetype
	if l:filetype == 'cpp'
		call CloseOtherWindows() | call OpenFiles()
	else
		echo 'Not cpp file, if you want to use this language for CP please go to /.config/nvim.init.vim'
	endif
endfunction
command! -nargs=0 CP :call CP()

function! CPe()
	call CloseFiles()
	execute ':NERDTreeToggle'
endfunction
command! -nargs=0 CPe :call CPe()

function! CloseOtherWindows()
    " Get number of windows
    let num_windows = winnr('$')
	
    if num_windows > 1
        execute 'only'
    endif
endfunction
command! -nargs=0 CloseOtherWindows :call CloseOtherWindows()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Close NerdTree if we close the last window while nerdtree is opening
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") 
      \ && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/rstacruz/vim-closer' " For brackets autocompletion


" Auto-completion  For Javascript
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed

Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {

" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
set encoding=UTF-8

call plug#end()

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

:colorscheme gruvbox 

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
