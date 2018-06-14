"=============================================================================
" File: comment.vim
" Author: Eric Wegscheid <ericwegscheid@gmail.com>
" WebPage: http://github.com/mattn/emmet-vim
" Description: Toggle commented code
"=============================================================================

fun! Comment()
	let comment_leader = ''

	if index(['sh', 'ruby', 'python', 'conf', 'ini', 'htaccess'], &filetype) >= 0
		let comment_leader = '#'

	elseif index(['c', 'cpp', 'java', 'javascript', 'php', 'less'], &filetype) >= 0
		let comment_leader = '//'

	elseif index(['vim'], &filetype) >= 0
		let comment_leader = '"'

	elseif index(['vb'], &filetype) >=0
		let comment_leader = "'"

	elseif index(['autohotkey'], &filetype) >= 0
		let comment_leader = ';'

	else
		echohl WarningMsg
		echo "Warning"
		echohl None
		echon ': filetype ' . &filetype . ' is not supported'

		return
	endif

	let line = getline('.')

	if line =~ '^' . comment_leader . '.*$'
		call setline('.', strpart(line, strlen(comment_leader) + 1))
	else
		call setline('.', comment_leader . ' ' . getline('.'))
	endif
endf

noremap <leader>c :call Comment()<CR>
