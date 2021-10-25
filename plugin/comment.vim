"=============================================================================
" File: comment.vim
" Author: Eric Wegscheid <ericwegscheid@gmail.com>
" WebPage: http://github.com/ericwegcsheid/comment-vim
" Description: Toggle commented code
"=============================================================================


" TODO: modify function as needed to get what it necessary for comment_selection function
fun! s:get_visual_selection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)

  if len(lines) == 0
    return ''
  endif

  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]

  return join(lines, '\n')
endf

" TODO: add function to only comment only selected characters, i.e. html or css
fun! s:comment_selection(selection)
  echo 'asdfasdf'
endf

" TODO: update to use with range so that this function is only called once
" fun! Comment() range
fun! Comment()
  " let selection = GetSelection()
  " echo selection

  let comment_leader = ''

  if index(['sh', 'zsh', 'ruby', 'python', 'conf', 'ini', 'htaccess', 'gitconfig', 'yaml'], &filetype) >= 0
    let comment_leader = '#'

  elseif index(['c', 'cpp', 'java', 'javascript', 'typescript', 'php', 'less', 'scss', 'groovy'], &filetype) >= 0
    let comment_leader = '//'

  elseif index(['vim'], &filetype) >= 0
    let comment_leader = '"'

  elseif index(['vb'], &filetype) >= 0
    let comment_leader = "'"

  elseif index(['autohotkey'], &filetype) >= 0
    let comment_leader = ';'

  elseif index(['html'], &filetype) >= 0
    execute ":normal O<!--\<CR>-->\<ESC>"
    return

  else
    " TODO warn only once for multiple lines
    echohl WarningMsg
    echo "Warning"
    echohl None
    echon ': filetype ' . &filetype . ' is not supported, using default: #'
    let comment_leader = '#'
  endif

  let line = getline('.')

  if line =~ '^\s*' . comment_leader . '.*$'
    " call setline('.', strpart(line, strlen(comment_leader) + 1))
    call setline('.', substitute(line, comment_leader . ' ', '', ''))
  else
    " call setline('.', comment_leader . ' ' . getline('.'))
    execute ':normal I' . comment_leader . ' '
    execute ':normal ^'
  endif
endf

noremap <leader>c :call Comment()<CR>

