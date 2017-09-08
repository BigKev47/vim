"=
" cream-ctags.vim
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2011 Steve Hall
" 
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 3 of the License, or
" (at your option) any later version.
" [ http://www.gnu.org/licenses/gpl.html ]
" 
" This program is distributed in the hope that it will be useful, but
" WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
" General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
" 02111-1307, USA.
"
" Description:
" Generates ctags for path (also for Cream project files)

" register as a Cream add-on
if exists("$CREAM")

	call Cream_addon_register(
	\ 'Ctags Generate', 
	\ 'Generate a tags file for a single directory', 
	\ "Generates ctags for all files within a single provided directory. Requires working accessible installation of ctags.", 
	\ 'Ctags Generate', 
	\ 'call Cream_ctags_generate()',
	\ '<Nil>'
	\ )

	" don't list unless Cream developer
	if exists("g:cream_dev")
		call Cream_addon_register(
		\ 'Ctags Generate Cream', 
		\ 'Generate ctags file for Cream', 
		\ "Generates ctags for all relevant Cream files, in all subdirectories. Requires working installation of ctags on the path and (currently) Windows.", 
		\ 'Cream Devel.Ctags Generate Cream', 
		\ 'call Cream_ctags_generate_cream()',
		\ '<Nil>'
		\ )
	endif

endif

function! Cream_ctags_generate_cream()

	let ctagsexe = s:Cream_ctags_executable()
	if ctagsexe == ""
		call confirm(
			\ "No ctags utility found on path. Quitting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	let n = confirm(
		\ "Silence shell output?\n" .
		\ "\n", "&Ok\n&No", 1, "Info")
	if n == 1
		let mysilent = "silent "
	else
		let mysilent = ""
	endif

	if exists("g:cream_cvs")
		let creamfix = g:cream_cvs
	else
		call confirm(
			\ "Unable to find g:cream_cvs. Quitting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif
	if has("win32") && !has("win32unix")
		" root
		execute mysilent . '!' . ctagsexe . ' -f "' . creamfix . '/tags" "'              . creamfix . '/*.vim"'
		execute mysilent . '!' . ctagsexe . ' -f "' . creamfix . '/tags" --append=yes "' . creamfix . '/addons/*.vim"'	
		" addons
		execute mysilent . '!' . ctagsexe . ' -f "' . creamfix . '/addons/tags" "'              . creamfix . '/*.vim"'
		execute mysilent . '!' . ctagsexe . ' -f "' . creamfix . '/addons/tags" --append=yes "' . creamfix . '/addons/*.vim"'
	else
		" root
		execute mysilent . '!' . ctagsexe . ' -f ' . creamfix . '/tags '              . creamfix . '/*.vim'
		execute mysilent . '!' . ctagsexe . ' -f ' . creamfix . '/tags --append=yes ' . creamfix . '/addons/*.vim'
		" addons
		execute mysilent . '!' . ctagsexe . ' -f ' . creamfix . '/addons/tags '              . creamfix . '/*.vim'
		execute mysilent . '!' . ctagsexe . ' -f ' . creamfix . '/addons/tags --append=yes ' . creamfix . '/addons/*.vim'
	endif

endfunction

function! Cream_ctags_generate(...)
" generate ctags for the current file's directory, unless argument passed.

	let ctagsexe = s:Cream_ctags_executable()
	if ctagsexe == ""
		call confirm(
			\ "No ctags utility found on path. Quitting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	if !exists("g:cream_ctags_path")
		" Tim Cera patched this to a single wildcard
		"let mypath = expand("%:p:h") . '/*.*'
		let mypath = expand("%:p:h") . '/*'
	elseif a:0 == 1
		let mypath = a:1
	else
		let mypath = g:cream_ctags_path
	endif

	" maintain dialog until Ok or Cancel
	let valid = 0
	while valid != 1

		let n = 0
		let msg = "Path/Filename(s) on which to generate ctags:\n"
		let msg = msg . "(wildcards accepted)\n"
		let msg = msg . "\n"
		let msg = msg . "    " . mypath . "  \n"
		let msg = msg . "\n"
		let n = confirm(msg, "&Enter Path/Filename\n&Browse\n&Ok\n&Cancel", 1, "Info")
		if     n == 1
			let mypath = inputdialog("Please enter the path/filename to ctag", mypath)
			if mypath == ""
				return
			endif
		elseif n == 2
			let mypath = Cream_browse_path()
		elseif n == 3
			" Validate: is single file or directory
			if filewritable(mypath) != 0
				let valid = 1
			endif
			" Validate: has wildcards (e.g., "*.*", "*.ext")
			if filewritable(fnamemodify(mypath, ":h")) != 0
				let g:cream_ctags_path = mypath
				break
			endif
			if valid != 1
				call confirm(
				\ "Please enter a valid path/filename.\n" .
				\ "\n", "&Ok", 1, "Info")
			endif
		else
			return
		endif
		
	endwhile

	" figure out where to put the tags file
	let mytagspath = g:cream_ctags_path
	" if uses tail has wildcards, use head
	let tmp = fnamemodify(mytagspath, ":t")
	if  match(tmp, "\*") > -1
	\|| match(tmp, "?") > -1
	\|| match(tmp, "#") > -1
		let mytagspath = fnamemodify(mytagspath, ":h")
	endif

	" windows paths (only) should be quoted
	if Cream_has("ms")
		let q = '"'
	else
		let q = ''
	endif
	" Example:  :!ctags -f [path]/tags [path]/*
	let tmp = ':!' . ctagsexe . ' -f ' . q . mytagspath . '/tags' . q . ' ' . q . g:cream_ctags_path . q

	" don't silence, too many things to go wrong
	execute tmp

endfunction

function! s:Cream_ctags_executable()
" returns a string of the name of the ctags executable (Gentoo and
" others sometimes name it "exuberant-ctags") or 0 if nothing found

	let ctags = ""

	if executable("exuberant-ctags")
		let ctags = "exuberant-ctags"
	endif

	if executable("ctags")
		let ctags = "ctags"
	endif
	
	return ctags

endfunction

