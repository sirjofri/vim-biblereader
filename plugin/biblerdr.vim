
if exists("g:loaded_biblerdr") || &cp
	finish
endif
let g:loaded_biblerdr = 1

function! s:LoadVerse(query)
	" load and return search results
	let result = system("diatheke -b ".a:query[0]." -k ".a:query[1])
	return result
endfunction

function! s:AskKey()
	" set up modulelist
	let modulelist = split(system("diatheke -b system -k modulelistnames"), "\n")
	let moduleindex = 0
	while moduleindex < len(modulelist)
		let modulelist[moduleindex] = (moduleindex+1)."\t".modulelist[moduleindex]
		let moduleindex += 1
	endwhile
	
	" get module name from user
	let modulelist = ["Choose Module:"] + modulelist
	let index = 0
	while index < 1
		let index = inputlist(modulelist)
	endwhile

	" get search key and return query
	let module = split(modulelist[index], "\t")[1]
	let key = input("Enter search key or text: ")
	let query = [module, key]
	return query
endfunction

function! s:GetVerses(vertical)
	" Print out list of modules
	let query = s:AskKey()
	let result = s:LoadVerse(query)

	" open new buffer
	if a:vertical
		vnew
	else
		new
	endif

	" extract info for statusline
	let printkey = escape(query[1], ' \')
	let printmodule = escape(query[0], ' ')

	" set statusline
	execute 'setlocal statusline='.printkey.'\ \('.printmodule.'\)'
	" set buffertype
	setlocal buftype=nofile
	" paste content
	execute "normal i".result
	" jump to first position
	normal gg

	" highlight verses
	syntax match biblebook /^\w\+/
	syntax match biblebook /\d\+:\d\+:/
	highlight biblebook ctermfg=yellow cterm=NONE
endfunction

function! PasteVerse()
	let query = s:AskKey()
	let result = s:LoadVerse(query)

	echo "\nOK, I found:"
	echo result
	let question = str2nr(input("Paste this? (0/1) "))
	if question == 1
		execute "normal i".result
	endif
endfunction

function! FindInBible()
	call s:GetVerses(0)
endfunction

function! VFindInBible()
	call s:GetVerses(1)
endfunction

" folding stolen from tpopes pathogen.vim script
" http://github.com/tpope/vim-pathogen
"
" Thank you!
"
" vim:ts=3:foldmethod=expr:foldexpr=getline(v\:lnum)=~'^\"\ Section\:'?'>1'\:getline(v\:lnum)=~#'^fu'?'a1'\:getline(v\:lnum)=~#'^endf'?'s1'\:'=':
