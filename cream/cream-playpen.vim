"
" Filename: cream-playpen.vim
" 
" Description: Experiments, things in flux or unresolved.
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

" ShortenPath() {{{1
function! ShortenPath(mode)
    if a:mode != "v"
        return
    endif
    " reselect
    normal gv
    " yank
    normal "xy
    " convert to 8.3
    let @x = fnamemodify(@x, ":p:8")
    " paste back over
    normal gv
    normal "xp
endfunction
"vmap <silent> <F12> :<C-u>call ShortenPath("v")<CR>


" C:\Program Files\cowsaregreat.butnottoeat


" remote read/write
" FTP spell check retrieval {{{1
function! Cream_get_ftp_listing(file)
" Return a string of FTP files delineated by newlines. 
"
" TODO:
" o Depending on platform, Netrw will deliver listings in different
"   formats. Need to investigate and handle.
"

	" hide Netrw menu
	let g:netrw_menu = 0

	" open list in new buffer
	call Cream_file_new()
	execute "edit " . a:file

	" process into list
	set modifiable
	" remove comments
	silent! %substitute/^".*$//geI
	" remove dot files
	silent! %substitute/^\..*$//geI
	" remove last "yanked" line
	silent! %substitute/^\d\+ lines yanked$//geI
	" remove empty lines
	silent! %substitute/\n\s*\n*$//ge
	silent! %substitute/^\n\+//ge
	" yank processed buffer
	silent! normal gg
	silent! normal V
	silent! normal G
	silent! normal "xy
	" close buffer
	bwipeout!
	return @x

endfunction
function! Cream_spell_dictlangs()

	let @x = Cream_get_ftp_listing('ftp://ftp.vim.org/pub/vim/runtime/spell/')

	" put into new file
	call Cream_file_new()
	silent! normal "xP

	" convert to list of languages
	" remove READMEs
	silent! %substitute/^README.*$//geI
	" remove suggestion files
	silent! %substitute/^.\+\.sug$//geI

	"" remove .spl extensions
	"%substitute/\.spl$//geI
	" remove everything but language
	silent! %substitute/^\(..\).\+$/\1/geI

	" remove empty lines
	silent! %substitute/\n\s*\n*$//ge
	silent! %substitute/^\n\+//ge

	" unique
	call Uniq(1, line('$'))

	" remove empty lines
	silent! %substitute/\n\s*\n*$//ge
	silent! %substitute/^\n\+//ge

endfunction
"imap <silent> <F12> <C-b>:call Cream_spell_dictlangs()<CR>

" Cream remote read/write {{{1
" NOTES {{{2
" We have never had success getting Netrw to work, thus this attempt.
" Netrw also attempts too much, it confuses basic up/down
" functionality with mappings, buffers, browsing, etc.
"
" Goals:
"
" o Parse standard URI:
"
"     ftp://anonymous:vim7user@ftp.vim.org/pub/vim/README
"
"   for:
"
"   * protocol (ftp, http)
"   * username
"   * password
"   * hostname
"   * path
"   * filename
"
"   Need a "hard" and "soft" version, the first which assumes a
"   properly formed URI, and the second to remove offending
"   accommodations like surrounding quotes, brackets, line endings and
"   embedded whitespace.
"
" o Be able to store URI components in 
"   * global vars (encoded username and passwords only)
"   * session vars
"   * prompt user for temporary use if none found
"
" o API
"   * Read remote file
"   * Get listing of remote path
"
"
" References:
"
" o http://en.wikipedia.org/wiki/Uniform_Resource_Identifier
" o http://www.gbiv.com/protocols/uri/rfc/rfc3986.html
" o http://www.zvon.org/tmRFC/RFC2396/Output/chapter12.html

" Cream_remote_parse_URI() {{{2
function! Cream_remote_parse_URI(uri)
" Return a dictionary of URI components:
"
"   ftp://anonymous:vim7user@ftp.vim.org:port/pub/vim/README#02
"   ¯¯¯   ¯¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ ¯¯
"   1     2         3        4           5   6        7      8
"
"   1. protocol:    dict["prot"] (required)
"   2. username:    dict["user"]
"   3. password:    dict["pass"]
"   4. hostname:    dict["host"] (required)
"   5. port:        dict["port"]
"   6. path:        dict["path"]
"   7. filename:    dict["file"]
"   8. anchor:      dict["anch"]
"
" Notes:
"
" o valid field chars: [[:alnum:]-\._~]
"
" Tests:
"
" call Cream_remote_parse_URI("ftp://ftp.vim.org")
" call Cream_remote_parse_URI("ftp://ftp.vim.org/pub/vim/README")
" call Cream_remote_parse_URI("ftp://anonymous:vim7user@ftp.vim.org:port/pub/vim/README")
" call Cream_remote_parse_URI("ftp://127.0.0.1")
"

	let uri = a:uri

	let prot = matchstr(uri, '^[^:/?#]\+\ze:')
	" temp var to hold user, pass, host, port
	let uphp = matchstr(uri, '^'.prot.'://'.'\zs[^/?#]\+')
	let user = matchstr(uphp, '^.*\ze:.*@')
	let pass = matchstr(uphp, '^.*:\zs.*\ze@')
	let port = matchstr(uphp, '^'.user.':\='.pass.'@\=.*:\zs.*$')
	let host = matchstr(uphp, '^'.user.':\='.pass.'@\=\zs[^:]\+\ze:\='.port.'$')

	" find path begin (watch for paths matching host!)
	let path = matchstr(uri, host.':\='.port.'\zs/.*$')
	let anch = matchstr(path, '#\zs[^:/?#]*$')
	let file = matchstr(path, '/\zs[^:/?#]*\ze#\='.anch.'$')
	" now trim off file and anchor
	let path = matchstr(path, '.*\ze'.file.'#\='.anch.'$')

	" validation
	if   host == ""
		call confirm(
			\ "Improperly formed URI: host.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif
	if   prot == ""
		call confirm(
			\ "Improperly formed URI: protocol.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif
	if   file == "" && anch != ""
		call confirm(
			\ "Improperly formed URI: anchor with no file.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif
	if   user == "" && pass != ""
		call confirm(
			\ "Improperly formed URI: password with no username.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" put into list
	let dict = {
		\ "prot": prot,
		\ "user": user,
		\ "pass": pass,
		\ "host": host,
		\ "port": port,
		\ "path": path,
		\ "file": file,
		\ "anch": anch
		\ }

	""*** DEBUG:
	"let n = confirm(
	"    \ "DEBUG:" . Cream_str_pad(" ", 150) .
	"    \ "\n" .
	"    \ "  prot  = \"" . dict["prot"] . "\"\n" .
	"    \ "  user  = \"" . dict["user"] . "\"\n" .
	"    \ "  pass  = \"" . dict["pass"] . "\"\n" .
	"    \ "  host  = \"" . dict["host"] . "\"\n" .
	"    \ "  port  = \"" . dict["port"] . "\"\n" .
	"    \ "  path  = \"" . dict["path"] . "\"\n" .
	"    \ "  file  = \"" . dict["file"] . "\"\n" .
	"    \ "  anch  = \"" . dict["anch"] . "\"\n" .
	"    \ "\n", "&Ok\n&Cancel", 1, "Info")
	"if n != 1
	"    return
	"endif
	""***

	return dict
	
endfunction

" Cream_remote_parse_URI_test() {{{2
function! Cream_remote_parse_URI_test()

	let dict = Cream_remote_parse_URI("ftp://anonymous:vim7user@ftp.vim.org:port/pub/vim/README#cow")

	""*** DEBUG:
	"let n = confirm(
	"    \ "DEBUG:" . Cream_str_pad(" ", 150) .
	"    \ "\n" .
	"    \ "  prot  = \"" . dict.prot . "\"\n" .
	"    \ "  user  = \"" . dict.user . "\"\n" .
	"    \ "  pass  = \"" . dict.pass . "\"\n" .
	"    \ "  host  = \"" . dict.host . "\"\n" .
	"    \ "  port  = \"" . dict.port . "\"\n" .
	"    \ "  path  = \"" . dict.path . "\"\n" .
	"    \ "  file  = \"" . dict.file . "\"\n" .
	"    \ "  anch  = \"" . dict.anch . "\"\n" .
	"    \ "\n", "&Ok\n&Cancel", 1, "Info")
	"if n != 1
	"    return
	"endif
	""***

endfunction

" Cream_remote_ftp_down() {{{2
function! Cream_remote_ftp_down()
" Download an explicitly named file.

	let user = "anonymous"
	let verbose = "-d stdout"
	let host = "ftp.vim.com"
	let getfile = "/pub/vim/runtime/spell"
	let dir = g:cream_user
	let progressmeter = "-v"
	let noprgressmeter = "-V"

	" set directory to download into
	execute "cd " . dir
	" do it (prompts for password)
	execute "!ncftpget " . progressmeter . " -u " . user . " " . verbose . " " . host . " . " . "'" . getfile . "'"

endfunction

" 2}}}
" Color_NavajoNight() {{{2
function! Color_NavajoNight()
" Change the current color scheme via accessing a remote script.
	enew
	execute 'Nread http://cream.cvs.sourceforge.net/*checkout*/cream/cream/cream-colors-zenburn.vim'
	execute "saveas " . tempname()
	source %
endfunction
" map <silent> <F12>      :call Color_NavajoNight()<CR>
"imap <silent> <F12> <C-b>:call Color_NavajoNight()<CR>
"vmap <silent> <F12> :<C-u>call Color_NavajoNight()<CR>
" 1}}}
" In progress...
" password encrypting {{{1
function! Cream_encrypt_input()

	let pw = inputsecret("Enter string to encrypt: ")
	if pw != ""
		let pw = String2Hex(pw)
		call Inputdialog("", pw)
	endif

endfunction
"imap <silent> <F12><F12> <C-b>:call Cream_encrypt_input()<CR>


" 1}}}
" TODO: move to add-ons
" Draw directory structure or genealogy tree {{{1
function! Cream_DrawTree()

	let @x = "\n"
	let @x = @x . "NAME\n"
	let @x = @x . " +-NAME\n"
	let @x = @x . " |  +-NAME\n"
	let @x = @x . " |  |  +-NAME\n"
	let @x = @x . " |  |  |  +-NAME\n"
	let @x = @x . " |  |  |  |  +-NAME\n"
	let @x = @x . " |  |  |  |\n"
	let @x = @x . " |  |  |  +-NAME\n"
	let @x = @x . " |  |  |\n"
	let @x = @x . " |  |  +-NAME\n"
	let @x = @x . " |  |\n"
	let @x = @x . " |  +-NAME\n"
	let @x = @x . " |\n"
	let @x = @x . " +-NAME\n"
	let @x = @x . "\n"

	put x

endfunction

" 1}}}
" non-Cream reliant functions
" Tabpage naming (non-Cream environment) {{{1
"function! TabpageName(mode)
"    if     a:mode == 1
"        return fnamemodify(expand("%"), ":p:h")
"    elseif a:mode == 2
"        let name = fnamemodify(expand("%"), ":p:t")
"        if name == ""
"            return "(Untitled)"
"        endif
"        return name
"    endif
"endfunction
"function! TabpageState()
"    if &modified != 0
"        return '*'
"    else
"        return ''
"    endif
"endfunction
"set guitablabel=%{TabpageName(2)}%{TabpageState()}

" Cream_copy_char_above() {{{1
function! Cream_copy_char_above()
	" position correction
	if getline('.') == ""
		let col = 0
	else
		let col = col('.')
	endif

	let str = getline(line('.') - 1)
	let chr = matchstr(str, '.', col)
	execute "normal a" . chr
endfunction
"imap <silent> <F12> <C-b>:call Cream_copy_char_above()<CR>

" :Buffers {{{1
function! Buffers()
" same output as :buffers except omits help, directories, and
" new unmodified buffers

	redir @x
	silent! buffers
	redir END
	let @x = @x . "\n"

	let buf = 1
	let str = ""
	while buf <= bufnr('$')
		if  bufexists(buf)
		\&& getbufvar(buf, "&buftype") != "help"
		\&& !isdirectory(bufname(buf))
		\&&	s:IsNewUnMod(buf) != 1
			let pos1    = match(@x, '\n\s\+' . buf . '[ u]')
			"let pos1str = matchstr(@x, '\n\s\+' . buf . '[ u]')
			let pos2    = match(@x, '\n', pos1 + 1)
			"let pos2str = matchstr(@x, '\n', pos1 + 1)
			let str = str . strpart(@x, pos1, pos2 - pos1)
		endif
		let buf = buf + 1
	endwhile

	echo ":Buffers" . str

endfunction

function! s:IsNewUnMod(buf)
	if  bufname(a:buf) == ""
	\&& getbufvar(a:buf, "&modified") == 0
	\&& bufexists(a:buf) == 1
		return 1
	endif
endfunction

command! Buffers call Buffers()

" Associate Mime Type With Windows Registry {{{1
"
" From: Ben Peterson, Dan Sharp on vim-dev@vim.org list
" Date: 2003-01-14, 11:00am
" RE: Associating extensions to Vim (was RE: Win32 improvement: ...)
"
" Description:
"
" associate/unassociated vim with the extension of the current file
" 	:associate %:e
" 	:noassociate %:e

function! s:Associate(ext, remove)
" Arguments:
"   ext      extension to associate
"   remove   1 to associate, 0 to remove
"
	if a:remove
		silent exec '!assoc ' . a:ext . '='
	else
		silent exec '!assoc ' . a:ext . '=OpenInVim'
		execute "silent !ftype OpenInVim=" . $VIMRUNTIME . "\\gvim.exe" . "\"$*\""
	endif
endfunction

command! Associate call s:Associate('.' . expand("%:e"), 0)
command! DeAssociate call s:Associate('.' . expand("%:e"), 1)

command! -nargs=1 AssociateArg call s:Associate('.' . <args>, 0)
command! -nargs=1 DeAssociateArg call s:Associate('.' . <args>, 1)

" Variably Toggleable Invisibles {{{1

"function! MyInvisibles(which)
"
"    if a:which == 1
"        set nolist
"        return
"    else
"        set list
"    endif
"
"    " reset
"    set listchars=
"    execute "set listchars+=precedes:" . nr2char(95)
"    execute "set listchars+=extends:" . nr2char(95)
"
"    if a:which >= 2
"        execute "set listchars+=tab:" . nr2char(187) . '\ '
"    else
"        execute 'set listchars+=tab:\ \ '
"    endif
"    if a:which >= 3
"        execute "set listchars+=eol:" . nr2char(182)
"    endif
"    if a:which >= 4
"        execute "set listchars+=trail:" . nr2char(183)
"    endif
"
"endfunction
"imap <silent> <F4>             <C-b>:call MyInvisibles(1)<CR>
"imap <silent> <F4><F4>         <C-b>:call MyInvisibles(2)<CR>
"imap <silent> <F4><F4><F4>     <C-b>:call MyInvisibles(3)<CR>
"imap <silent> <F4><F4><F4><F4> <C-b>:call MyInvisibles(4)<CR>

" highlighting attribute removals {{{1
function! Highlight_remove_attr(attr)
" remove attribute from current color scheme
" see ":help attr-list" for terms accepted

	if  a:attr != "bold"
	\&& a:attr != "underline"
	\&& a:attr != "reverse"
	\&& a:attr != "inverse"
	\&& a:attr != "italic"
	\&& a:attr != "standout"
		echo "Invalid argument to Highlight_remove_attr()."
		return -1
	endif

	" get current highlight configuration
	redir @x
	silent! highlight
	redir END
	" open temp buffer
	new
	" paste in
	put x

	" convert to vim syntax (from Mkcolorscheme.vim,
	"   http://vim.sourceforge.net/scripts/script.php?script_id=85)
	" delete empty and links lines
	silent! g/^$\| links /d
	" remove the xxx's
	silent! %s/ xxx / /
	" add highlight commands
	silent! %s/^/highlight /
	" protect spaces in some font names
	silent! %s/font=\(.*\)/font='\1'/

	" substitute attribute with "NONE"
	execute 'silent! %s/' . a:attr . '\([\w,]*\)/NONE\1/geI'
	" yank entire buffer
	normal ggVG
	" copy
	normal "xy
	" run
	execute @x

	" remove temp buffer
	bwipeout!

endfunction

" 1}}}
" Cream functionalities (non-default)
" Cream_fileformat_unix() {{{1

function! Cream_fileformat_unix()
" Ensure buffers are always unix format, even on windows.

	" get buffer number
	let mybufnr = bufnr("%")
	" only if buffer is unnamed and doesn't exist
	if  bufname(mybufnr) == ""
	\&& bufexists(mybufnr) == 1

		" remember unmodified state
		if getbufvar(mybufnr, "&modified") == 0
			let mod = 1
		endif

		set ff=unix

		" recover unmodifed state
		if exists("mod")
			set nomodified
		endif
	endif

endfunction
"" Uncomment to activate
"set encoding=utf8
"call Cream_listchars_init()
"autocmd VimEnter,BufEnter * call Cream_fileformat_unix()

" 1}}}
" Examples
" Justify selection bug {{{1

"set insertmode
"imap <F12> <C-b>:call JustifyRight()<CR>
"function! JustifyRight()

"    " remember
"    let mytextwidth = &textwidth
"    let myexpandtab = &expandtab
"    " sets
"    set textwidth=70
"    set expandtab

"    " select inner paragraph
"    normal vip

"    " get range (marks "'<" and "'>" are scoped pre-function call,
"    " can't use!)
"    let myfirstline = line(".")
"    normal o
"    let mylastline = line(".")
"    normal o

"    " put first range value first (necessary?)
"    if mylastline < myfirstline
"        let tmp = myfirstline
"        let myfirstline = mylastline
"        let mylastline = tmp
"    endif

"    " right justify
"    execute "silent! " . myfirstline . "," . mylastline . "right"

"    "*** BROKEN:
"    "startinsert
"    "normal i
"    execute "normal \<Esc>"
"    "***

"    " restore
"    let &textwidth = mytextwidth
"    let &expandtab = myexpandtab

"endfunction


" Why <C-l><Esc> is evil. {{{1

"function! MyFunction()
"
"    "-------- Test area ----------
"    "23456789012345678901234567890
"    "23456789012345678901234567890
"    "23456789012345678901234567890
"    "23456789012345678901234567890
"    "-------- Test area ----------
"
"    " insert "Cow"
"    normal iCow
"    " back up
"    normal hh
"    " scroll screen up one line
"    execute "normal \<C-e>"
"    " move cursor back down one
"    normal gj
"endfunction

" incorrect:
"nmap <F12>           :call MyFunction()<CR>
"imap <F12>      <C-l>:call MyFunction()<CR><Esc>

" correct:
"nmap <F12>           :call MyFunction()<CR>
"imap <F12> <C-b>:call MyFunction()<CR>


" 1}}}
" Tests
" Hooks {{{1
function! Cream_hook_open(fname)

	" tests
	let match = 0
	
	" TEST 1: extension is "COW"
	if fnamemodify(a:fname, ':e') =~ "COW"
		let match = 1
	endif
	
	" TEST 2: last four chars of filename is "_NEW"
	" strip extension
	let str = fnamemodify(a:fname, ':r')
	" test last four chars
	if strpart(str, strlen(str) - 4) == "_NEW"
		let match = 1
	endif

	" OTHER TESTS

	" no match
	if match == 0
		" quit and continue normal open
		return 0
	endif

	" match
	let n = confirm(
		\ "Restriction match. Open read-only?\n" .
		\ "\n", "Read-only\n&Cancel", 1, "Info")
	if n == 1
		call Cream_file_open_readonly(a:fname)
	endif
	" return -1 to stop normal open process
	return -1

endfunction

" Remaining key maps {{{1
" functional {{{2

" Minus/Equals
imap <silent> <C-->       <C-b>:call TestCow("C--")<CR>
imap <silent> <C-_>       <C-b>:call TestCow("C-_")<CR>
imap <silent> <M-->       <C-b>:call TestCow("M--")<CR>
" Comma/Period
imap <silent> <M-<>       <C-b>:call TestCow("M-\<")<CR>
imap <silent> <M->>       <C-b>:call TestCow("M->")<CR>


" non-functional {{{2
" These mappings aren't advisable due to keyboard and OS
" standardization issues.

"" Brackets
"imap <silent> <C-[>       <C-b>:call TestCow()<CR>
"imap <silent> <C-S-]>     <C-b>:call TestCow()<CR>
"imap <silent> <C-S-[>     <C-b>:call TestCow()<CR>
"imap <silent> <C-}>       <C-b>:call TestCow()<CR>
"imap <silent> <C-{>       <C-b>:call TestCow()<CR>

"" Parenthesis
"imap <silent> <C-S-0>     <C-b>:call TestCow()<CR>
"imap <silent> <C-)>       <C-b>:call TestCow()<CR>
"imap <silent> <C-S-9>     <C-b>:call TestCow()<CR>
"imap <silent> <M-S-9>     <C-b>:call TestCow()<CR>
"imap <silent> <M-S-(>     <C-b>:call TestCow()<CR>
"imap <silent> <C-M-(>     <C-b>:call TestCow()<CR>
"imap <silent> <C-M-9>     <C-b>:call TestCow()<CR>
"imap <silent> <C-(>       <C-b>:call TestCow()<CR>

"" Minus/Equals
"imap <silent> <C-=>       <C-b>:call TestCow()<CR>
"imap <silent> <C-+>       <C-b>:call TestCow()<CR>
"imap <silent> <C-S-=>     <C-b>:call TestCow()<CR>

"" Backslash/Bar
"imap <silent> <C-Bar>  <C-b>:call TestCow()<CR>
"imap <silent> <C-S-\>     <C-b>:call TestCow()<CR>
"imap <silent> <C-\|>      <C-b>:call TestCow()<CR>
"imap <silent> <C-|>     <C-b>:call TestCow()<CR>
"imap <silent> |     <C-b>:call TestCow()<CR>
"imap <silent> <C-M-\>     <C-b>:call TestCow()<CR>

"" Enter
"inoremap <silent> <C-m>    <C-b>:call TestCow("C-m")<CR>
"imap <silent> <S-Return>   <C-b>:call TestCow("S-Return")<CR>
"imap <silent> <M-Return>   <C-b>:call TestCow("M-Return")<CR>
"imap <silent> <M-S-Return> <C-b>:call TestCow("M-S-Return")<CR>
"imap <silent> <C-M-Return> <C-b>:call TestCow("C-M-Return")<CR>
"imap <silent> <M-Enter>    <C-b>:call TestCow("M-Enter")<CR>
"imap <silent> <M-S-Enter>  <C-b>:call TestCow("M-S-Enter")<CR>
"imap <silent> <C-M-Enter>  <C-b>:call TestCow("C-M-Enter")<CR>
"imap <silent> <M-CR>       <C-b>:call TestCow("M-CR")<CR>
"imap <silent> <M-S-CR>     <C-b>:call TestCow("M-S-CR")<CR>
"imap <silent> <C-M-CR>     <C-b>:call TestCow("C-M-CR")<CR>

"" Space
"imap <silent> <C-M-Space>  <C-b>:call TestCow()<CR>
"imap <silent> <M-S-Space>  <C-b>:call TestCow()<CR>

"" Letters
"imap <silent> <C-j>       <C-b>:call TestCow("C-j")<CR>

"imap <silent> <C-i>       <C-b>:echo "C-i"<CR>
"imap <silent> <Tab>       <C-r>=Tab()<CR>
"function! Tab()
"    return nr2char(9)
"endfunction

" 2}}}

" What exactly is in [[:punct:]] {{{1

function! Cream_whatis(collection)
" see :help /collection
" use "call Cream_whatis('[[:punct:]]')" or the like

	let mycollection = ""
	let i = 0
	while i < 256
		if match(nr2char(i), a:collection) == 0
			let mycollection = mycollection . i . ":  " . nr2char(i) . "\t"
		endif
		if i % 10 == 0
			let mycollection = mycollection . "\n"
		endif
		let i = i + 1
	endwhile

	echo mycollection

endfunction

" Find the <SID> of a specific script {{{1

"function! GetSID(script_name)
"" retrieve vim <SID> for a specific script
"" Source: http://groups.yahoo.com/group/vim/message/34855
"" Author: Sylvain Viart <viart.sylvain (at) videotron.ca>
"" Date:   2002-12-01
"    let old_reg_r = @r
"    redir @r
"    silent scriptnames
"    redir END

"    let regex = substitute(a:script_name, '[/\\]', '.', 'g')
"    let regex = "\\s\\+[0-9]\\+:\\s*[^\n]*" . regex
"    let l = matchstr(@r, regex)
"    let sid = matchstr(l, '[0-9]\+')

"    let @r = old_reg_r
"    return sid
"endfunction


"" in the sourced script
"function! <SID>GetVar(varname)
"    execute "let v = s:" . a:varname
"    return v
"endfunction

"" and then when you want a variable:
"let sid = GetSID('golbal/var.vim')
"" call the script function with the specified argument
"execute "let v = \<SNR>" . sid . "_Getvar(" . varname . ")"


" Progress bar from 1-100% {{{1
function! BarTest()
	let i = 0
	while i < 101
		call ProgressBar(i, "    Loading files... ", "=", 0)
		sleep 5m
		let i = i + 1
	endwhile
endfunction


" 1}}}
" vim:foldmethod=marker
