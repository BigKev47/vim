"
" Filename: cream-menu-developer.vim
" Updated:  2004-12-26 21:28:12-0400
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

if !exists("g:cream_dev")
	finish
endif

" Cream_menu_devel() {{{1
function! Cream_menu_devel()
" load the developer menu
" Notes:
" o This is now dynamic: whatever files exist in g:cream_cvs
"   are put in the menu.
" o All subdirectories of g:cream_cvs are included (but no
"   farther).
" o This is called via VimEnter autocmd so multvals functions are available.

	" drop back to $CREAM if not set manually (will cause error on
	" open on systems with permissions on these files)
	if !exists("g:cream_cvs")
		let g:cream_cvs = $CREAM
	else
		" verify has trailing slash
		let test = matchstr(g:cream_cvs, '.$')
		if test != '/' && test != '\'
			let g:cream_cvs = g:cream_cvs . '/'
		endif
	endif

	" main menu priority
	let g:cream_menu_dyn_prio = 9999
	" submenu priority
	let g:cream_menu_dyn_subprio = 1
	" main menu name
	let g:cream_menu_dyn_menustr = 'Cream\ &Developer'
	" maximum items in menu
	let g:cream_menu_dyn_maxitems = 40

	" remove existing menu
	execute "silent! aunmenu \<silent> " . g:cream_menu_dyn_menustr

	" main file set
	call Cream_menu_dyn_files(g:cream_cvs, ".cream")
	" subdirectory files
	call Cream_menu_dyn_dirs(g:cream_cvs, ".cream")

	" seperator
	call Cream_menu_dyn_sep()

	" g:cream_user files
	call Cream_menu_dyn_files(g:cream_user, ".user")

	" seperator
	call Cream_menu_dyn_sep()

	" make run INSTALL.sh entry
	if Cream_has("ms")
		let installer = 'INSTALL\.bat'
	else
		let installer = 'INSTALL\.sh'
	endif
	execute "anoremenu " . g:cream_menu_dyn_prio . "." . g:cream_menu_dyn_subprio . " " . g:cream_menu_dyn_menustr . '.run\ ' . installer . '  :call Cream_install()<CR>'

endfunction

" Cream_install() {{{1
function! Cream_install()

	" save cwd
	let mycwd = getcwd()

	let mycmdheight = &cmdheight
	set cmdheight=2
	" change current directory to that of install bat
	execute ":silent cd " . Cream_path_fullsystem(g:cream_cvs)
	if Cream_has("ms")
		execute '!' . Cream_path_fullsystem(g:cream_cvs) . '\INSTALL.bat'
	else
		" echo relative path to installer
		echo ''
		echo ' After entering root password, run this command:'
		echo ''
		echo '       sh INSTALL.sh'
		echo ''
		execute ':!su'
	endif
	let &cmdheight = mycmdheight
	" restore cwd
	execute ":silent cd " . mycwd

endfunction

" Cream_menu_dyn_dirs() {{{1
function! Cream_menu_dyn_dirs(path, submenu)
" Menu all the files found in the subdirectories of {path}.
" TODO: This is now a prototype--use it!

	let mydirs = Cream_getfilelist(a:path . "*/")
	let i = 0
	let cnt = MvNumberOfElements(mydirs, "\n")
	while i < cnt

		" find first
		let mypos = stridx(mydirs, "\n")
		let mydir = strpart(mydirs, 0, mypos)
		if mydir != ""
			" trim to remaining
			let mydirs = strpart(mydirs, mypos + 1)

			" strip path
			let mydir = fnamemodify(mydir, ":p:h:t") . '/'

			let submenu = a:submenu . '/' . mydir
			call Cream_menu_dyn_files(a:path . mydir, submenu)
		endif

		let i = i + 1
	endwhile

endfunction

" Cream_menu_dyn_files() {{{1
function! Cream_menu_dyn_files(path, submenu)
" Menus all files found in {path} into {submenu} of g:cream_menu_dyn_menustr.
" TODO: This is now a prototype--use it!

	let path = a:path

	" ensure trailing slash
	let path = Cream_path_addtrailingslash(path)

	" get root files
	let myfiles = Cream_getfilelist(path . "*")

	" menu each file
	let subdir = ""
	let ctr = 0
	let i = 0
	let cnt = MvNumberOfElements(myfiles, "\n")
	while i < cnt

		" find first
		let mypos = stridx(myfiles, "\n")
		let myfile = strpart(myfiles, 0, mypos)
		" remove double slashes
		let myfile = substitute(myfile, '//\+', '/', 'g')

		if myfile != ""
			" trim to remaining
			let myfiles = strpart(myfiles, mypos + 1)

			" skip if directory
			if isdirectory(myfile)
				let i = i + 1
				continue
			endif

			" strip path
			let myfilename = substitute(myfile, '.*[/\\:]\([^/\\:]*\)', '\1', '')

			" collect into subgroups if total count is higher then max
			if cnt >= g:cream_menu_dyn_maxitems

				" bump index to multiple of 15 so first menu has 15 items
				if ctr == 0
					let g:cream_menu_dyn_subprio = ((g:cream_menu_dyn_subprio) + g:cream_menu_dyn_maxitems - ((g:cream_menu_dyn_subprio + g:cream_menu_dyn_maxitems) % g:cream_menu_dyn_maxitems))
				endif
				" if index is divisable by 0 increment counter
				if (g:cream_menu_dyn_subprio % g:cream_menu_dyn_maxitems) == 0
					let ctr = ctr + 1
				endif
				" string is menu seperator and count
				let subdir = "." . "[" . ((ctr - 1) * g:cream_menu_dyn_maxitems) . "-" . ((ctr * g:cream_menu_dyn_maxitems) - 1) . "]"
			endif

			" convert idx to string and pad
			let index = g:cream_menu_dyn_subprio
			while strlen(index) < 3
				let index = "0" . index
			endwhile

			let cmdstr =
				\ "anoremenu \<silent>" .
				\ " " . g:cream_menu_dyn_prio . "." . index .
				\ " " . g:cream_menu_dyn_menustr . a:submenu . subdir . "." . escape(myfilename, ' .-') .
				\ " " . ":call Cream_file_open(\"" . myfile . "\")\<CR>"

			execute cmdstr
			let g:cream_menu_dyn_subprio = g:cream_menu_dyn_subprio + 1
		endif

		let i = i + 1
	endwhile

endfunction

" Cream_menu_dyn_sep() {{{1
function! Cream_menu_dyn_sep()
" Add a line seperator at the current priority index.
	execute "anoremenu \<silent> " . g:cream_menu_dyn_prio . "." . g:cream_menu_dyn_subprio . " " . g:cream_menu_dyn_menustr . ".-SEP" . g:cream_menu_dyn_subprio . "- \<NUL>"
endfunction

" 1}}}
" vim:foldmethod=marker
