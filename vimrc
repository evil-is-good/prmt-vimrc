" Отключить совместимость с vi
set nocompatible

" Настраиваем отображения скрытых символов, при включении их отображения:
" tab - два символа для отображения табуляции (первый символ и заполнитель)
" eol - символ для отображения конца строки
" precedes - индикатор продолжения строки в лево
" extends - индикатор продолжения строки в право
set listchars=tab:··,eol:😸,precedes:«,extends:»
" Делаем скрытые символы видимыми
set list

" Определяем ширину символа табуляции.
set tabstop=4
" Количество пробелов на которое изменяется ширина отступа, при использовании команд изменения отступа << и >>
set shiftwidth=4
" Опция заменяющая,при вставке, символы табуляции на количество пробелов указанных
set expandtab

" Каждая новая строка вводится с тем же отступом, что и предыдущая.
set autoindent
" Сишные отступы, например после {
set cindent

" Включить мышь для всех режимов
set mouse=a

" Переключатель приклейки при копировании
set pastetoggle=<F2>

" Показывать номера строк
set number

" Включить фолдинги
set foldenable
" Количество столбцов для фолдингов
set foldcolumn=3
set foldmethod=syntax

" Показывать набираемые команды
set showcmd

colorscheme desert "twilight 

" Искать сразу при вводе
set incsearch
" Подсвечивать всё что нашли
set hlsearch
" По нажатию на % перейти к ближай открывающей или закрывающей скобке {[()]}
set showmatch
" Игнорировать регистр
set ignorecase  
set smartcase 

" При работе с командной строкой показывать горизонтальный спимок подоходящих файлов, можно переключться стрелками
set wildmenu
" Показывать таблицей файлы
set wildmode=list:longest
" Какие файлы не показывать
" set wildignore=*.o,*~

" Не переносить строки
set nowrap

" Ленивая перерисовка экрана при выполнении макросов
set lazyredraw

"execute pathogen#infect()
syntax on
" Для определения типов файлов
filetype on
filetype plugin on
filetype indent on

" Делает возможной проверку орфографии в латех-файлах, пока что почемуто только командой из самого вима
syntax spell toplevel

" Длина истории команд
set history=1000 
" Глубина ундов
set undolevels=1000

" Сделать так, чтобы Vim понимал, какие клавиши нажимаются, если включена русская раскладка.
"set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
" Более действенный способ, раскладка меняется по <C-^> и русский остается только в инсерт моде
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
" Обеспечивает изменение цвета курсора на голубенький, когда включена альтернативная раскладка. Только для гуя
"highlight lCursor guifg=NONE guibg=Cyan

" Всегда показывать текущее положение
set ruler

" Отключаем бэкапы
set nobackup
set nowb
set noswapfile

" Автоматически сохранять файл при переключении на другой
set autowrite

"imap :!setxkbmap us:!setxkbmap us,ru
"nmap :!setxkbmap us:!setxkbmap us,ru

" Проверка двух языков; русский с буквой ё 
set spelllang=ru_yo,en_us

" Выполнять vimrc при сохранении
autocmd! bufwritepost ~/.vimrc execute "normal! :source ~/.vimrc"
autocmd! VimEnter * TagbarOpen


"set statusline=%t\ %y%m%r[%{&fileencoding}]%<[%{strftime(\"%d.%m.%y\",getftime(expand(\"%:p\")))}]%k%=%-14.(%l,%c%V%)\ %P



" Переменные !!!!!!!!!!!!!!!!!!!!!!!!!

" Долой старый лидер! Да здравствует новый лидер!
let mapleader = ","
let g:mapleader = ","



" Мапы !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" Простая навигация по окнам
nmap <S-Up> <C-w>k
nmap <S-Down> <C-w>j
nmap <S-Left> <C-w>h
nmap <S-Right> <C-w>l

" Навигация по буфферам
map <C-Left>  :bp<CR>
map <C-Right> :bn<CR>

" Скролл в окне
nmap <M-Left>  <ScrollWheelLeft>
nmap <M-Right> <ScrollWheelRight>
nmap <M-Up>    <ScrollWheelUp>
nmap <M-Down>  <ScrollWheelDown>

" Просто удобное сохранение
nmap <leader>w :w!<cr>
imap <leader>w <Esc>:w!<cr>

" Копи/паст по Ctrl+C/Ctrl+V
"vmap <C-C> "*yi
"imap <C-V> +gPi
vmap <C-c> "ay
imap <C-v> <Esc>"api
nmap <C-v> "ap
vmap <C-v> "ap
imap <C-z> <Esc>ui

" Прыгаем по поставленным меткам
nmap <C-Down> ]'
nmap <C-Up> ['

vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Nightmare mode
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>



" Команды !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" Сохранение файла с sudo
command W w !sudo tee % > /dev/null



function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        "call CmdLine("Ack \"" . l:pattern . "\" %" )
        execute "Ack \"" . l:pattern . "\" %"
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Плагины !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'gmarik/Vundle.vim'
" Периименовать открытый файл Rename new_name
Bundle 'Rename'
" Комментировать строки для всяких разных языков n мод gcc, v мод gc
Bundle 'tomtom/tcomment_vim'
" Открыть файл найдя его нечетким поиском (шустро работает) CtrlP name
Bundle 'kien/ctrlp.vim'
" Типа греба, ищит слова в файлах, можно отрыть подходяший файл (удивительно шустро работает) Ack pattern
Bundle 'mileszs/ack.vim'
" Движок сниппетов, неплохая штука, но лучше всего работает, если повесить на таб (низнаю почему), значит может мешать другим плагинам 
Bundle 'SirVer/ultisnips'
" Набор различных сниппетов
Bundle 'honza/vim-snippets'
" Нужен для следующего, требует сборки, в папке плагина make -f make_unix.mak
Bundle 'Shougo/vimproc.vim'
" Может заменять и ctrlp и ack и имеет ещё кучу возможносией но медлинноват, надо испытывать
Bundle 'Shougo/unite.vim' 
" Более мощьная статусная строка, только для графического :(
" Bundle 'bling/vim-airline'
" Мульти курсор <c-n>
Bundle 'terryma/vim-multiple-cursors'
" Менеджкр проекта
Bundle 'majutsushi/tagbar'
call vundle#end()            " required
filetype plugin indent on    " required



" Настройки плагинов !!!!!!!!!!!!!!!!!!
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-J>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "MyCoolSnippets"]

" Автоматический insert mode
let g:unite_enable_start_insert = 1
" Отображаем Unite в нижней части экрана
let g:unite_split_rule = "botright"
" Отключаем замену статус строки
let g:unite_force_overwrite_statusline = 0
" Размер окна Unite
let g:unite_winheight = 10
" Красивые стрелочки
let g:unite_candidate_icon="▷"
" Поиск по истории как в yankring/yankstack
let g:unite_source_history_yank_enable = 1

let g:multi_cursor_quit_key='<C-[>'

"autocmd FileType cpp normal :UltiSnipsAddFiletypes cpp.mycpp

let g:tagbar_width = 30
let g:tagbar_left = 1

