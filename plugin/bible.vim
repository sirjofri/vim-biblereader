if exists("g:loaded_vimbible") || &cp
	finish
endif
let g:loaded_vimbible = 1

function! FindInBible()
	echo system("diatheke -b system -k modulelistnames")
	let module = input("Choose Module: ")
	let key = input("Enter search key: ")
	let result = system("diatheke -b ".module." -k ".key)
	normal ggVGd
	execute "normal i".result
	normal gg
	syntax match biblebook /^\w\+/
	syntax match biblebook /\d\+:\d\+:/
	highlight biblebook ctermfg=yellow cterm=NONE
endfunction

" vim:ts=3
