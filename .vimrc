set number
:highlight LineNr ctermfg=yellow
set nowrap
set mouse=a
set clipboard=unnamedplus

" Insert mode: Sisipkan timestamp (hh:mm:ss - )
imap <A-Enter> <C-R>=strftime("- %H:%M:%S - ")<CR>

" Normal mode: sisipkan timestamp, lalu kembali ke normal mode
nmap <A-Enter> i<C-R>=strftime("- %H:%M:%S - ")<CR>

" Normal mode: Buat baris baru, tab, tab, strip, lalu timestamp
nnoremap <S-Enter> o<Tab><Tab>- <C-R>=strftime("%H:%M:%S - ")<CR>

" Insert mode: Buat baris baru, tab, tab, strip, lalu timestamp
inoremap <S-Enter> <CR><Tab><Tab>- <C-R>=strftime("%H:%M:%S - ")<CR>

inoremap <A-Space> <Esc>
vnoremap <A-Space> <Esc>
cnoremap <A-Space> <Esc>
