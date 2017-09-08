"
" cream-encrypt-gpg.vim
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

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Encrypt, GPG', 
	\ 'Encrypt, GnuPG', 
	\ 'Encrypt a selection with GnuPG.', 
	\ 'Encrypt.GnuPG', 
	\ 'call Cream_encrypt_gpg()', 
	\ '<C-u>call Cream_encrypt_gpg("v")'
	\ )
endif

function! Cream_encrypt_gpg(...)
" Encrypt with GNU GPG
" o Arguments:
"   "silent" quiets operation
"   "v" implies a visual mode selection
"   (nothing) implies to do the entire file

	" verify gpg is on the system
	if !executable("gpg")
		call confirm(
			\ "GPG program not found, quitting.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" find arguments
	if a:0 > 0
		let i = 0
		while i < a:0
			let i = i + 1
			execute "let myarg = a:" . i
			if     myarg == "v"
				let dofile = 0
			elseif myarg == "silent"
				let silent = 1
			endif
		endwhile
	endif

	" handle not-founds
	if !exists("dofile")
		let dofile = 1
	endif

	" get current cursor position
	let line = line('.')
	if line < 1
		let line = 1
	endif

	" select
	if dofile == 0
		" reselect previous selection
		normal gv
	else
		if !exists("silent")
			let n = confirm(
				\ "Encrypt/Unencrypt entire file?\n" .
				\ "\n", "&Ok\n&Cancel", 1, "Info")
			if n != 1
				" quit
				return
			endif
		endif
		" remember position
		let mypos_orig = Cream_pos()
		" select all
		call Cream_select_all(1)
	endif

	" OPTION 1: using temp files {{{1
	" cut selection into register
	normal "xx
	" write register to tmpfile
	let tmpfile = Cream_path_fullsystem(tempname())

	" decrypt
	if @x =~ '^\s*-\+BEGIN PGP '

		" write register to file
		call Cream_str_tofile(@x, tmpfile.".gpg")

		if Cream_has("ms")
			let q = '"'
		else
			let q = ''
		endif

		" TAKE 1
		" command
		" TODO: on GNU/Linux, this fails due to TTY problems
		let cmd = "!gpg --output " . q.tmpfile.q . " --decrypt " . q.tmpfile.".gpg".q
		let @+ = cmd
		silent execute cmd
		" read in encrypted file (at point of cut)
		silent execute "silent! " . line-1 . "read " . tmpfile
		let bufnr = bufnr("$")
		" close buffer
		silent execute "silent! bwipeout! " . bufnr

		"""" TAKE 2
		"""redir @y
		"""execute "!gpg --decrypt " . q.tmpfile.".gpg".q
		"""redir END
		"""put y

		"""" TAKE 3
		"""" command
		"""" TODO: on GNU/Linux, this fails due to TTY problems
		"""let cmd = "!gpg --decrypt " . q.tmpfile.".gpg".q
		"""execute cmd
		"""" read in encrypted file (at point of cut)
		"""silent execute "silent! " . line-1 . "read " . tmpfile

		"" clean up temp files
		"call delete(tmpfile)
		"call delete(tmpfile . ".gpg")

	" encrypt
	else
		" write register to file
		call Cream_str_tofile(@x, tmpfile)

		" command
		"silent execute 'silent! !gpg --armor --output "' . tmpfile . '.gpg" --encrypt "' . tmpfile . '"'
		if Cream_has("ms")
			let q = '"'
		else
			let q = ''
		endif
		" TODO: on GNU/Linux, this fails due to TTY problems and
		"       requesting recipient if "--default-recipient-self"
		"       option isn't used.
		silent execute "silent! !gpg -q --armor --default-recipient-self --output " . q.tmpfile.".gpg".q . " --encrypt " . q.tmpfile.q

		" read in encrypted file (at point of cut)
		silent execute "silent! " . line-1 . "read " . escape(tmpfile, ' \') . ".gpg"
		let bufnr = bufnr("$")
		" close buffer
		silent execute "silent! bwipeout! " . bufnr

		" clean up temp files
		call delete(tmpfile)
		call delete(tmpfile . ".gpg")

	endif

	" OPTION 2: no temp files, only streams {{{1
	"""" copy selection into register
	"""normal "xy
	"""" re-select for paste over
	"""normal gv
	"""
	"""" decrypt
	"""if @x =~ '^\s*-\+BEGIN PGP '
	"""
	"""    " command
	"""    execute '!echo ' . @x . '> !gpg --output "' . tmpfile . '" --decrypt "' . tmpfile . '.gpg"'
	"""
	"""" encrypt
	"""else
	"""
	"""    " command
	"""    call system('echo "' . @x . '" | gpg --armor --encrypt')
	"""
	"""endif

	" 1}}}

endfunction
" vim:foldmethod=marker
