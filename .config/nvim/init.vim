" Hello and welcome!

let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'

    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'kien/ctrlp.vim'

    " Python
    Plug 'nvie/vim-flake8'
    Plug 'vim-scripts/Pydiction'
    Plug 'vim-scripts/indentpython.vim'
    Plug 'scrooloose/syntastic'
    Plug 'psf/black'
    Plug 'vim-python/python-syntax'
    Plug 'davidhalter/jedi-vim'   " jedi for python
    " Plug 'Valloric/YouCompleteMe'
    " Plug 'klen/rope-vim'

    " code folding
    Plug 'tmhedberg/SimpylFold'
    Plug 'altercation/vim-colors-solarized'
    Plug 'jnurmine/Zenburn'

    " Plug '/usr/local/opt/fzf'
    " Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    " Plug 'junegunn/limelight.vim'
    " Plug 'PotatoesMaster/i3-vim-syntax'
    " Plug 'jreybert/vimagit'
    Plug 'vimwiki/vimwiki', {'as': 'vimwiki', 'branch': 'dev' }
    Plug 'bling/vim-airline'
    Plug 'jalvesaq/Nvim-R'
    Plug 'vim-pandoc/vim-rmarkdown'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'vifm/vifm.vim'
    Plug 'kovetskiy/sxhkd-vim'
    " Plug 'chazy/dirsettings'
    Plug 'roxma/nvim-yarp'  " dependency of ncm2
    Plug 'ncm2/ncm2'  " awesome autocomplete plugin
    Plug 'HansPinckaers/ncm2-jedi'  " fast python completion
    Plug 'ncm2/ncm2-bufword'  " buffer keyword completion
    Plug 'ncm2/ncm2-path'  " filepath completion
    Plug 'frazrepo/vim-rainbow'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'mileszs/ack.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'rafaqz/citation.vim'
    " Plug 'jalvesaq/zotcite'
    Plug 'ryanoasis/vim-devicons'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

    if has('nvim')
      Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
    else
      Plug 'Shougo/denite.nvim'
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
    endif

call plug#end()

" path to python
    let g:python3_host_prog = '/usr/bin/python3'
    let g:python_host_prog = '/usr/bin/python2'


" Some basics:
    "nnoremap c "_c
    set bg=light
    set go=a
    set mouse=a
    set nohlsearch
    set incsearch
    set clipboard+=unnamedplus
    set updatetime=300
    set nocompatible
    filetype plugin on
    syntax on
    set encoding=utf-8
    set autoindent
    set tabstop
    set expandtab
    set softtabstop=4
    set shiftwidth=4
    filetype indent on
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    set number relativenumber
    autocmd CursorHold * update
    set nofoldenable
    set noswapfile

" Enable autocompletion:
    set wildmode=longest,list,full

" Folding options
    set foldmethod=syntax
    " Hitting spacebar will open and close fold if on a fold, else move forward as usual
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
    vnoremap <Space> zf

" Disables automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" vim rainbow settings
    let g:rainbow_active = 1

" ncm2 settings
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=menuone,noselect,noinsert
    set shortmess+=c
    let ncm2#popup_delay = 5
    let ncm2#complete_length = [[1,1]]
    let g:ncm2#matcher = 'substrfuzzy'
    let g:R_assign = 0

" highlight python and self function
    autocmd BufEnter * syntax match Type /\v\.[a-zA-Z0-9_]+\ze(\[|\s|$|,|\]|\)|\.|:)/hs=s+1
    autocmd BufEnter * syntax match pythonFunction /\v[[:alnum:]_]+\ze(\s?\()/
    hi def link pythonFunction Function
    autocmd BufEnter * syn match Self "\(\W\|^\)\@<=self\(\.\)\@="
    highlight self ctermfg=239
    let g:python_highlight_all = 1

" run Black with F9
    nnoremap <F9> :Black<CR>

" coc settings
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" Close preview window when completion is done.
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    nmap <leader> rn <Plug>(coc-rename)

" Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction


" silver searcher settings
    let g:ackprg = 'ag --nogroup --nocolor --column'

" jedi settings
    let g:jedi#auto_initialization = 1
    let g:jedi#completions_enabled = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#smart_auto_mappings = 0
    let g:jedi#popup_on_dot = 1
    let g:jedi#completions_command = ""
    let g:jedi#show_call_signatures = "1"
    let g:jedi#show_call_signatures_delay = 0
    let g:jedi#use_tabs_not_buffers = 0
    let g:jedi#show_call_signatures_modes = 'ni'  " ni = also in normal mode
    let g:jedi#enable_speed_debugging=0

" Goyo plugin makes text more readable when writing prose:
    map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
    map <leader>o :setlocal spell! spelllang=en_us<CR>
    hi clear SpellBad
    hi clear SpellLocal
    hi clear SpellCap
    hi clear SpellRare
    hi SpellBad ctermfg=red
    hi SpellLocal ctermfg=green
    hi SpellCap ctermfg=yellow
    hi SpellRare ctermfg=green

" Splits open at the bottom and right.
    set splitbelow splitright

" Shortcut split opening
    nnoremap <leader>h :split<Space>
    nnoremap <leader>v :vsplit<Space>

" NerdCommenter settings
    let g:NERDSpaceDelims = 1
    let g:NERDToggleCheckAllLines = 1
    let g:NERDCommentEmptyLines = 1

" NERDTree
    " Close if only NERDTree is open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    nmap <C-f> :NERDTreeToggle<CR>
    let g:NERDTreeShowHidden=1
    let g:NERDTreeGitStatusWithFlags = 1
    let g:WebDevIconsUnicodeDecorateFolderNodes = 1
    let g:NERDTreeGitStatusNodeColorization = 1
    let g:NERDTreeIgnore = ['^node_modules$']
    let g:NERDTreeColorMapCustom = {
    \ "Staged"    : "#0ee375",
    \ "Modified"  : "#d9bf91",
    \ "Renamed"   : "#51C9FC",
    \ "Untracked" : "#FCE77C",
    \ "Unmerged"  : "#FC51E6",
    \ "Dirty"     : "#FFBD61",
    \ "Clean"     : "#87939A",
    \ "Ignored"   : "#808080"
    \ }


" Shortcutting split navigation:
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

" Check file in shellcheck:
    map <leader>s :!clear && shellcheck %<CR>

" Open my bibliography file in split
    map <leader>b :vsp<space>$BIB<CR>
    " map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
    nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
    map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
    map <leader>p :!opout <c-r>%<CR><CR>


" Vimwiki settings
    let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mkd': 'markdown', '.mdown': 'markdown'}
    let g:vimwiki_list = [
            \ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md',
    \  'auto_diary_index': 1, 'auto_generate_links': 1,
            \  'toc_header_level' : 1, 'markdown_toc' : 1,
    \  'auto_generate_tags': 1, 'auto_tags': 1, 'auto_toc': 1,
    \  'list_margin': 0,
    \ }]
    let g:vimwiki_markdown_link_ext = 1
    let g:vimwiki_tags_header = 'Tags'
    let g:vimwiki_links_header = 'Links'
    let g:rmd_fenced_languages = ['r', 'python']
    let g:markdown_fenced_languages = ['r', 'python']

    autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
    autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
    autocmd BufRead,BufNewFile *.tex set filetype=tex

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
    autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
    autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Automatically deletes all trailing whitespace on save.
    autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
    autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Update binds when sxhkdrc is updated.
    autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Run xrdb whenever Xdefaults or Xresources are updated.
    autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Alias write and quit to Q
    nnoremap Q :wq<CR>

" Navigating with guides
    inoremap ;g <++>
    inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
    vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
    map <leader><leader> <Esc>/<++><Enter>"_c4l

" Save file as sudo on files that require root permission
    cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" markdown
    autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
    autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
    autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>F*hi
    autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>F~hi
    autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
    autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>F=hi
    autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
    autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
    autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
    autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
    autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
    autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
    autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
    autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
    autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO

" markdown preview
    " set to 1, nvim will open the preview window after entering the markdown buffer
    " default: 0
    let g:mkdp_auto_start = 0

    " set to 1, the nvim will auto close current preview window when change
    " from markdown buffer to another buffer
    " default: 1
    let g:mkdp_auto_close = 1

    " set to 1, the vim will refresh markdown when save the buffer or
    " leave from insert mode, default 0 is auto refresh markdown as you edit or
    " move the cursor
    " default: 0
    let g:mkdp_refresh_slow = 0

    " set to 1, the MarkdownPreview command can be use for all files,
    " by default it can be use in markdown file
    " default: 0
    let g:mkdp_command_for_global = 0

    " preview page title
    " ${name} will be replace with the file name
    let g:mkdp_page_title = '「${name}」'

" LaTeX
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
    autocmd VimLeave *.tex !texclear %

" citations
    let g:citation_vim_bibtex_file="repos/life/dox/acad.bib"
    let g:citation_vim_mode="bibtex"
    let g:citation_vim_cache_path='~/.config/nvim/cache'
    let g:citation_vim_description_format = "{} ┃ {} ┃ {} ┃ {} ┃ {}"
    let g:citation_vim_description_fields = ["key","author","publication","journal","doi"]

" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"

try

call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight

let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction
