function s:CheckColorScheme()
  let g:base16colorspace=256

  let s:config_file = expand('~/.base16')

  if filereadable(s:config_file)
    let s:config = readfile(s:config_file, '', 2)

    if s:config[1] =~# '^dark\|light$'
      execute 'set background=' . s:config[1]
    else
      echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
    endif

    if filereadable(expand('~/.vim/plugged/base16-vim/colors/base16-' . s:config[0] . '.vim'))
      execute 'color base16-' . s:config[0]
    else
      echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
    endif
  else " default
    set background=dark
    color base16-ocean
  endif

  execute 'highlight Comment ' . pinnacle#italicize('Comment')

  " Allow for overrides:
  " - `statusline.vim` will re-set User1, User2 etc.
  " - `after/plugin/loupe.vim` will override Search.
  doautocmd ColorScheme
endfunction

if v:progname !=# 'vi'
  if has('autocmd')
    augroup Autocolor
      autocmd!
      autocmd FocusGained * call s:CheckColorScheme()
    augroup END
  endif

  call s:CheckColorScheme()
endif
