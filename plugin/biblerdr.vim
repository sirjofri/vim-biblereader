
if exists("g:loaded_biblerdr") || &cp
	finish
endif
let g:loaded_biblerdr = 1

function! s:GetVerses(vertical)
	" Print out list of modules
	let modulelist = split(system("diatheke -b system -k modulelistnames"), "\n")
	let index = 0
	while index < len(modulelist)
		echo "".index."\t".modulelist[index]
		let index = index + 1
	endwhile

	let module = modulelist[str2nr(input("Choose Module: "))]
	let key = input("Enter search key or text: ")
	let result = system("diatheke -b ".module." -k ".key)

	if a:vertical
		vnew
	else
		new
	endif

	let printkey = escape(key, ' \')
	let printmodule = escape(module, ' ')

	execute 'setlocal statusline='.printkey.'\ \('.printmodule.'\)'
	setlocal buftype=nofile
	execute "normal i".result
	normal gg

	syntax match biblebook /^\w\+/
	syntax match biblebook /\d\+:\d\+:/
	highlight biblebook ctermfg=yellow cterm=NONE
endfunction

function! FindInBible()
	call s:GetVerses(0)
endfunction

function! VFindInBible()
	call s:GetVerses(1)
endfunction

" vim:ts=3
