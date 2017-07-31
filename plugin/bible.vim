if exists("g:loaded_vimbible") || &cp
	finish
endif
let g:loaded_vimbible = 1

function! FindInBible()
	" Print out list of modules
	let modulelist = split(system("diatheke -b system -k modulelistnames"), "\n")
	let index = 0
	while index < len(modulelist)
		echo "\n".index."\t".modulelist[index]
		let index = index + 1
	endwhile

	let module = modulelist[str2nr(input("Choose Module: "))]
	let key = input("Enter search key or text: ")
	let result = system("diatheke -b ".module." -k ".key)
	normal ggVGd
	execute "normal i".result
	normal gg
	syntax match biblebook /^\w\+/
	syntax match biblebook /\d\+:\d\+:/
	highlight biblebook ctermfg=yellow cterm=NONE
endfunction

" vim:ts=3
