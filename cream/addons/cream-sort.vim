"
" cream-sort.vim -- Various sorting methods and algorithms
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
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
" General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
" 02111-1307, USA.

" register as a Cream add-on {{{1
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Sort Selected Lines', 
	\ 'Sort the lines currently selected', 
	\ 'Sort the lines currently selected.', 
	\ 'Sort.Selected Lines', 
	\ '<Nil>', 
	\ 'BISort2'
	\ )

	call Cream_addon_register(
	\ 'Sort Selected Lines, Inverse', 
	\ 'Reverse sort the lines currently selected', 
	\ 'Reverse sort the lines currently selected.', 
	\ 'Sort.Selected Lines, Inverse', 
	\ '<Nil>', 
	\ "BISort2Reverse"
	\ )

	call Cream_addon_register(
	\ 'Invert Lines of Selection',
	\ 'Invert the lines of the current selection', 
	\ 'Invert the lines of the current selection.', 
	\ 'Invert Selected Lines', 
	\ '<Nil>',
	\ "Invert"
	\ )

	call Cream_addon_register(
	\ 'Uniq',
	\ 'Eliminate duplicate, sorted lines', 
	\ 'Eliminate duplicate lines of an alphabetically sorted selection, simliar to the Unix utility uniq.', 
	\ 'Uniq Selected Lines', 
	\ '<Nil>',
	\ '<C-u>call Cream_uniq("v")'
	\ )

endif


"*********************************************************************
"  BISort and related moved to library where we can access them
"  at startup.
"*********************************************************************

" File Sort (external sort) {{{1
"---------------------------------------------------------------------
" Version: 1.5
" Date:    2002 October 23
" Source:  http://vim.sourceforge.net/scripts/script.php?script_id=310
" Author:  Steve Hall  [ digitect@mindspring.com ]
"
" Description:
" Sort a file alphabetically by lines using external operating system
" (Linux or Windows) commands which redirect the current file into
" a sorted temporary file.
"
" Installation:
" Simply copy this file and paste it into your vimrc. Or you can drop
" the entire file into your plugins directory.
"
" Useage:
" Use :call Cream_sortfile() to sort the current file alphabetically
" by line. User is prompted to choose the column of the sort (default
" is 1).
"
" Notes:
" * The function uses the operating system's sort command (Windows or
"   Linux) for speed since our original use was for 7mb dictionary
"   wordlists(!).
"
" * Sorting is actually done in a temp file to preserve the original.
"
" * Please notice three other sort libraries included within the
"   script below the advertised first one. They were "research" during
"   the project and may serve certain users better than ours! 
"
" ChangeLog:
"
" 2003-02-15 -- Version 1.5
" * Unnamed buffer now saved as temporary file.
" 
" 2002-10-23 -- Version 1.4
" * Temp file overwrite option added.
"
" 2002-09-10 -- Version 1.3
" * Quote path/filenames on Windows to handle spaces
"
" 2002-09-07 -- Version 1.2
" * Added requirement that file be named (external redirection methods
"   require it)
" * Added prompt to save modified file before proceeding
"
" 2002-07-18 -- Version 1.1
" * Added temp file verification.
" * Changed Linux "--key" to "-k" to work with some Linuxes.
" * Eliminated Linux "-o=[FILENAME]" option to simple redirection to
"   work with some Linuxes.
"
" 2002-06-07 -- Version 1.0
" * Initial Release

" list as an add-on if Cream project in use
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Sort File', 
	\ 'Sort the current file by column', 
	\ 'Sort the current file alphabetically by line. User is prompted to choose the column of the sort (default is 1).', 
	\ 'Sort.File (external sort)', 
	\ 'call Cream_sortfile()'
	\ )
endif

function! Cream_sortfile()
" sort a file's lines by column number
" * option: sort selection by alternate column number (default 1)
" * multi-platform: Windows 95-XP and Linux

	" require file to be named (can't sort an un-named file due to the
	" external redirections that this module uses)
	if expand("%") == ""
		"let n = confirm("File must be named before proceeding...", "&Ok\n&Cancel", 1, "Info")
		"if n != 1
		"    call confirm("Canceled. Sort not performed.", "&Ok", 1, "Info")
		"    return
		"endif
		"if has("browse")
		"    browse confirm write
		"else
		"    confirm write
		"endif
		"" if still unnamed, quit
		"if expand("%") == ""
		"    call confirm(
		"        \ "Can not continue, document unnamed. Quitting...\n" .
		"        \ "\n", "&Ok", 1, "Info")
		"    return
		"endif
		let myfile = tempname()
		call confirm(
			\ "Saving as temp file " . myfile . " ...\n" .
			\ "\n", "&Ok", 1, "Info")
		execute "saveas " . myfile
	endif

	" prompt to save modified first
	if &modified == 1
		let n = confirm("Do you wish to save changes first?", "&Ok\n&No\n&Cancel", 1, "Info")
		if n == 1
			write
		elseif n == 2
			" carry on
		else
			call confirm("Canceled. Sort not performed.", "&Ok", 1, "Info")
			return
		endif
	endif

	" current file
	let myfile = fnamemodify(expand("%"), ":p")
	" escape backslashes (for Windows)
	let myfile = escape(myfile, "\\")
	" temp file (append extension .tmp)
	let myfiletmp = myfile . ".tmp"

	" verify temp file doesn't already exist
	if filewritable(myfiletmp) == 1
		let n = confirm("Filename \"" . myfiletmp . "\" already exists. Overwrite and continue?", "&Ok\n&Cancel", 2, "Warning")
		if n != 1
			return
		endif
	elseif filewritable(myfiletmp) == 2
		call confirm("Unable to continue. A directory with the name \"" . myfiletmp . "\" already exists.", "&Ok", 1, "Warning")
		return
	endif

	" get column to sort on
	let mycol = inputdialog("Please enter column number to sort on (default 1)", "1")
	if mycol == ""
		return
	endif

	" validate
	" convert to number
	let mycol = mycol + 0
	" make sure not empty
	if mycol == 0
		let mycol = "1"
	endif

	" sort (by platform command)
	if has("win32")

		" fix back slashes if any (I use :set shellslash)
		let myfile = substitute(myfile,'/','\\','g')
		let myfiletmp = substitute(myfiletmp,'/','\\','g')

		" Windows
		"----------------------------------------------------------------------
		" SORT /?
		"
		" Sorts input and writes results to the screen, a file, or another device
		" 
		" SORT [/R] [/+n] [[drive1:][path1]filename1] [> [drive2:][path2]filename2]
		" [command |] SORT [/R] [/+n] [> [drive2:][path2]filename2]
		" 
		"   /R                         Reverses the sort order; that is, sorts Z to A,
		"                              then 9 to 0.
		"   /+n                        Sorts the file according to characters in
		"                              column n.
		"   [drive1:][path1]filename1  Specifies file(s) to be sorted
		"   [drive2:][path2]filename2  Specifies a file where the sorted input is to be
		"                              stored.
		"   command                    Specifies a command whose output is to be sorted.

		" command (extra quotes handle file/pathnames with spaces)
		execute ":silent !SORT /+" . mycol . " " . "\"" . myfile . "\"" . " > " . "\"" . myfiletmp . "\""

	elseif has("unix")

		" Linux | Cygwin
		"----------------------------------------------------------------------
		" sort --help
		"
		" Usage: sort [OPTION]... [FILE]...
		" Write sorted concatenation of all FILE(s) to standard output.
		" 
		" Ordering options:
		" 
		" Mandatory arguments to long options are mandatory for short options too.
		"   -b, --ignore-leading-blanks ignore leading blanks
		"   -d, --dictionary-order      consider only blanks and alphanumeric characters
		"   -f, --ignore-case           fold lower case to upper case characters
		"   -g, --general-numeric-sort  compare according to general numerical value
		"   -i, --ignore-nonprinting    consider only printable characters
		"   -M, --month-sort            compare (unknown) < `JAN' < ... < `DEC'
		"   -n, --numeric-sort          compare according to string numerical value
		"   -r, --reverse               reverse the result of comparisons
		" 
		" Other options:
		" 
		"   -c, --check               check whether input is sorted; do not sort
		"   -k, --key=POS1[,POS2]     start a key at POS1, end it at POS 2 (origin 1)
		"   -m, --merge               merge already sorted files; do not sort
		"   -o, --output=FILE         write result to FILE instead of standard output
		"   -s, --stable              stabilize sort by disabling last-resort comparison
		"   -S, --buffer-size=SIZE    use SIZE for main memory buffer
		"   -t, --field-separator=SEP use SEP instead of non- to whitespace transition
		"   -T, --temporary-directory=DIR  use DIR for temporaries, not $TMPDIR or /tmp
		"                               multiple options specify multiple directories
		"   -u, --unique              with -c: check for strict ordering
		"                               otherwise: output only the first of an equal run
		"   -z, --zero-terminated     end lines with 0 byte, not newline
		"       --help     display this help and exit
		"       --version  output version information and exit
		" 
		" POS is F[.C][OPTS], where F is the field number and C the character position
		" in the field.  OPTS is one or more single-letter ordering options, which
		" override global ordering options for that key.  If no key is given, use the
		" entire line as the key.
		" 
		" SIZE may be followed by the following multiplicative suffixes:
		" % 1% of memory, b 1, K 1024 (default), and so on for M, G, T, P, E, Z, Y.
		" 
		" With no FILE, or when FILE is -, read standard input.
		" 
		" *** WARNING ***
		" The locale specified by the environment affects sort order.
		" Set LC_ALL=C to get the traditional sort order that uses
		" native byte values.
		" 
		" Report bugs to <bug-textutils@gnu.org>.

		" command
		" * original: 
		"     execute ":!sort --key=" . mycol . " -fid -o=" . myfiletmp . " " . myfile
		" * some systems cannot use the "--key=" option, use "-k"
		" * some systems cannot use the "-o=" option, use redirection
		execute ":!sort -k " . mycol . " -fid " . myfile . " > " . myfiletmp

	else
		call confirm("Sorry! This platform untested. \n\nPlease contact us at\n      http://cream.sourceforge.net ", "&Ok", 1, "Info")
		return
	endif

	" edit temp file
	execute ":edit " . myfiletmp

	" warn we're in temp file
	call confirm("Now in temp file:\n  " . myfiletmp . "\n\nPreserved original file:\n  " . myfile . "\n\n", "&Ok", 1, "Warning")

endfunction
" 1}}}
" Various other (unused) sort functions
" Line Sort {{{1

"" list as an add-on if Cream project in use
"if exists("$CREAM")
"    call Cream_addon_register(
"    \ 'Sort Selection', 
"    \ 'Sort the current selection', 
"    \ 'Sort the current selection.', 
"    \ 'Sort.Selection', 
"    \ '<Nil>', 
"    \ 'Sort'
"    \ )

"    call Cream_addon_register(
"    \ 'Sort Selection, Inverse', 
"    \ 'Reverse sort the current selection', 
"    \ 'Reverse sort the current selection.', 
"    \ 'Sort.Selection, Inverse', 
"    \ '<Nil>', 
"    \ 'SortReverse'
"    \ )
"endif

" * Extended version found in :help eval-examples
" * See also in explorer.vim
" * Extremely slow (>10 min.) for large files (dictionaries)
"
" Author: Robert Webb <RobertW at beam.com.au>
"

" Function for use with Sort(), to compare two strings.
func! <SID>Strcmp(str1, str2)
	if (a:str1 < a:str2)
		return -1
	elseif (a:str1 > a:str2)
		return 1
	else
		return 0
	endif
endfunction
" Function for use with Sort(), to compare two strings.
func! <SID>Stricmp(str1, str2)
	let st1=substitute(a:str1,'^.*$', '\L&', "")
	let st2=substitute(a:str1,'^.*$', '\L&', "")
	if (st1 < st2)
		return -1
	elseif (st1 > st2)
		return 1
	else
		return 0
	endif
endfunction

" Sort lines.  SortR() is called recursively.
func! <SID>SortR(start, end, cmp)
	if (a:start >= a:end)
		return
	endif
	let partition = a:start - 1
	let middle = partition
	let partStr = getline((a:start + a:end) / 2)
	let i = a:start
	while (i <= a:end)
		let str = getline(i)
		exec "let result = " . a:cmp . "(str, partStr)"
		if (result <= 0)
			" Need to put it before the partition.  Swap lines i and partition.
			let partition = partition + 1
			if (result == 0)
				let middle = partition
			endif
			if (i != partition)
				let str2 = getline(partition)
				call setline(i, str2)
				call setline(partition, str)
			endif
		endif
		let i = i + 1
	endwhile

	" Now we have a pointer to the "middle" element, as far as partitioning
	" goes, which could be anywhere before the partition.  Make sure it is at
	" the end of the partition.
	if (middle != partition)
		let str = getline(middle)
		let str2 = getline(partition)
		call setline(middle, str2)
		call setline(partition, str)
	endif
	call <SID>SortR(a:start, partition - 1, a:cmp)
	call <SID>SortR(partition + 1, a:end, a:cmp)
endfunc

" To Sort a range of lines, pass the range to Sort() along with the name of a
" function that will compare two lines.
func! <SID>Sort(cmp) range
	call <SID>SortR(a:firstline, a:lastline, a:cmp)
endfunc

" :Sort takes a range of lines and sorts them.
command! -nargs=0 -range Sort <line1>,<line2>call <SID>Sort('<SID>Strcmp')
command! -nargs=0 -range ISort <line1>,<line2>call <SID>Sort('<SID>Stricmp')

"+++ Cream:
command! -nargs=0 -range SortReverse <line1>,<line2>call <SID>Sort('<SID>StrcmpR')
func! <SID>StrcmpR(str2, str1)
	if (a:str1 < a:str2)
		return -1
	elseif (a:str1 > a:str2)
		return 1
	else
		return 0
	endif
endfunction
"+++

" Line Sort (BISort) {{{1
" Source: Piet Delport, vim@vim.org list, 2003-05-01

"" list as an add-on if Cream project in use
"if exists("$CREAM")
"    call Cream_addon_register(
"    \ 'Sort Selection', 
"    \ 'Sort the current selection', 
"    \ 'Sort the current selection.', 
"    \ 'Sort.Selection (BISort)', 
"    \ '<Nil>', 
"    \ 'call Cream_BISort_call("v")'
"    \ )
"
"    call Cream_addon_register(
"    \ 'Sort Selection, Inverse', 
"    \ 'Reverse sort the current selection', 
"    \ 'Reverse sort the current selection.', 
"    \ 'Sort.Selection, Inverse (BISort)', 
"    \ '<Nil>', 
"    \ 'call Cream_BISort_call_reverse("v")'
"    \ )
"endif

function! Cream_BISort_call(mode)
" calls BISort2, establishing the range
	if a:mode != "v"
		return
	endif
	normal gv
	call BISort(line("'<"), line("'>"), '<SID>Strcmp')
endfunction
function! Cream_BISort_call_reverse(mode)
" calls BISort2, establishing the range
	if a:mode != "v"
		return
	endif
	normal gv
	call BISort(line("'>"), line("'<"), '<SID>StrcmpR')
endfunction

function! BISort(start, end, cmp)
	let compare_ival_mid = 'let diff = '.a:cmp.'(i_val, getline(mid))'
	let i = a:start + 1
	while i <= a:end
		" find insertion point via binary search
		let i_val = getline(i)
		let lo = a:start
		let hi = i
		while lo < hi
			let mid = (lo + hi) / 2
			exec compare_ival_mid
			if diff < 0
				let hi = mid
			else
				let lo = mid + 1
				if diff == 0 | break | endif
			endif
		endwhile
		" do insert
		if lo < i
			exec i.'d_'
			call append(lo - 1, i_val)
		endif
		let i = i + 1
	endwhile
endfunction

" Line length sorting {{{1
"
" See: genutils.vim by Hari Krishna Dara <hari_vim at yahoo.com>
"        http://vim.sourceforge.net/scripts/script.php?script_id=197
"


" Perl file sorting {{{1
" by Colin Keith, on the vim@vim.org mailing list 03 Jun 2002
" * Uses Perl
function! VimPerlSort(...) range
	if !has('perl')
		echoerr "Perl not installed, unable to continue"
		return
	endif

	let s:col = 1
	let s:order  = 0

	" Calculate sort method
	if exists('a:1') && a:1 > 0 && a:1 < 5
		let s:order = a:1

		" And if we want any column other than the first
		if exists('a:2')
		  let s:col = a:2
		endif
	endif

	" alphabetical
	if s:order == 1
		let s:sort = 'my $x = substr($a, '. s:col. ', 1)||""; '.
				   \ 'my $y = substr($b, '. s:col. ', 1)||""; '.
				   \ 'return $x cmp $y;'
	" reverse alphabetical
	elseif s:order == 2
		let s:sort = 'my $x = substr($a, '. s:col. ', 1)||""; '.
				   \ 'my $y = substr($b, '. s:col. ', 1)||""; '.
				   \ 'return $y cmp $x;'
	" numerical
	elseif s:order == 3
		let s:sort = 'my $x = substr($a, '. s:col. ', 1)||0; '.
				   \ 'my $y = substr($b, '. s:col. ', 1)||0; '.
				   \ 'return $x <=> $y;'
	" reverse numerical
	elseif s:order == 4
		let s:sort = 'my $x = substr($a, '. s:col. ', 1)||0; '.
				   \ 'my $y = substr($b, '. s:col. ', 1)||0; '.
				   \ 'return $y <=> $x;'
	else
		let s:sort = '$a cmp $b'
	endif

	" Load into memory
	execute ':perl @data = sort { '. s:sort . ' } '.
		\ '$curbuf->Get('. a:firstline. '..'. a:lastline. ')'
	execute ':perl $curbuf->Set('. a:firstline. ', @data)'

	" just to make sure the memory is released:
	:perl @data=()

endfunction
" 1}}}
" vim:foldmethod=marker
