"
" cream-behavior -- load Cream, Vim or Vi behaviors
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
" * These functions control the toggling of Cream/Vim/Vi behavior
"

" don't try to overwrite on re-load
if exists("g:cream_behave")
	finish
endif
let g:cream_behave = 1

function! Cream_behave_cream()
" (re)initialize default Cream behavior

	" don't repeat to improve speed
	if exists("g:CREAM_BEHAVE")
		if g:CREAM_BEHAVE == "cream"
			return
		endif
	endif

	" do this before re-init, so viminfo is good
	let g:CREAM_BEHAVE = "cream"

	" recall current buffer
	let g:CREAM_LAST_BUFFER = bufname("%")
	" get screen position and size
	if has("gui_running")
		call Cream_screen_get()
	endif
	" write the current setup to viminfo so it's remembered
	wviminfo!

	" TODO: why couldn't we just 
	"
	"    :source $VIMRUNTIME/cream/creamrc | doautoall VimEnter
	"
	" ?

	" reload Cream
	call Cream()

	call Cream_filetype_reinit()

	" initialize current buffers
	doautocmd VimEnter *
	doautocmd BufEnter *

endfunction

function! Cream_behave_creamlite()
" use Cream behavior sans keystroke mappings

	" warning
	if !exists("g:cream_behave_warn")
	\|| g:cream_behave_warn == 1
		let n = confirm(
			\ "Note:\n" .
			\ "\n" .
			\ "Using Vim style key mappings, all other Cream customizations \n" .
			\ "in effect. (Use g:cream_behave_warn=0 in cream-conf to avoid \n" .
			\ "future warnings.)\n" .
			\ "\n" .
			\ "\n", "&Ok\n&Cancel", 2, "Info")
		if n != 1
			let g:CREAM_BEHAVE = "cream"
			return
		else
		endif
	endif

	" restart Cream if coming from vim or vi
	if exists("g:CREAM_BEHAVE")
		if  g:CREAM_BEHAVE == "vim"
		\|| g:CREAM_BEHAVE == "vi"
			call Cream_behave_cream()
		endif
	endif

	let g:CREAM_BEHAVE = "creamlite"

	" don't use Shift to select
	"set keymodel&

	" mappings, clear
	imapclear
	vmapclear
	"nmapclear
	"omapclear

	" now put back Ctrl+B remap so menu items work
	inoremap <C-b>  <C-o>

	" let them eat cake!
	set noinsertmode

endfunction

function! Cream_behave_vim()
" delete customizations and re-initialize default Vim behavior

	" warning
	if !exists("g:cream_behave_warn")
	\|| g:cream_behave_warn != 1
		let n = confirm(
			\ "WARNING!\n" .
			\ "\n" .
			\ "Use of the Vim behavior option will change editing to strict \n" .
			\ "Vim style, including menus, key mappings, toolbars and statusline. \n" .
			\ "This will cancel all Cream customizations until restarting Vim. \n" .
			\ "\n" .
			\ "This option is provided here for illustrative and educational purposes \n" .
			\ "and shouldn't normally be used unless you are attempting to learn Vim \n" .
			\ "or are already an experienced Vim user. \n" .
			\ "\n" .
			\ "Continue?\n" .
			\ "\n", "&Yes\n&Cancel", 2, "Warning")
		if n != 1
			return
		endif
	endif
	let g:cream_behave_warn = 1

	let g:CREAM_BEHAVE = "vim"

	" autocommands, clear
	call Cream_augroup_delete_all()

	" menus, clear
	unmenu! *
	unmenu *

	" mappings, clear
	imapclear
	vmapclear
	nmapclear
	omapclear

	" highlighting, clear
	highlight clear

	" menus, load default
	source $VIMRUNTIME/menu.vim

	" plugins, load default
	runtime plugin/*.vim

	" filetype, re-initialize
	call Cream_filetype_reinit()

	" settings, clear
	set all&

	" Vim default behavior
	set nocompatible

endfunction

function! Cream_behave_vi()
" drop all the way back to Vi behavior (bleck!)

	" warning
	if !exists("g:cream_behave_warn")
	\|| g:cream_behave_warn != 1
		let n = confirm(
			\ "WARNING!\n" .
			\ "\n" .
			\ "Use of this option will change your current editing behavior to \n" .
			\ "strict *Vi* style, including menus, key mappings, toolbars and statusline. \n" .
			\ "This will cancel all Cream customizations until restarting Vim. \n" .
			\ "\n" .
			\ "This option is provided here for illustrative and educational purposes \n" .
			\ "and shouldn't normally be used unless you are attempting to learn Vi \n" .
			\ "or are already an experienced Vi user and are unable to kick your habit. ;)\n" .
			\ "(And then what on earth are you doing with Cream's 400Kb+ of configuration?!)\n" .
			\ "\n" .
			\ "Continue?\n" .
			\ "\n", "&Yes\n&Cancel", 2, "Warning")
		if n != 1
			return
		endif
	endif
	let g:cream_behave_warn = 1

	call Cream_behave_vim()

	" do this *after* above call
	let g:CREAM_BEHAVE = "vi"

	" be really Vi compatible
	set compatible

endfunction


"----------------------------------------------------------------------
" functions

function! Cream_filetype_reinit()
" re-initialize finicky filetype stuff

	" filetype reinit
	if exists("g:did_load_filetypes")
	    unlet g:did_load_filetypes
	endif
	runtime filetype.vim

endfunction

function! Cream_augroup_delete_all()
" delete all existing augroups

	redir @x
	silent! augroup
	redir END
	let mygroups = @x
	let mygroups = substitute(mygroups, "\\s\\+", "\\n", "g")
	" Hack: eliminate initial \n
	if strpart(mygroups, 0, 1) == "\n"
		let mygroups = strpart(mygroups, 1)
	endif

	let i = 0
	while i < MvNumberOfElements(mygroups, "\n")
		" make group current
		execute "silent! augroup " . MvElementAt(mygroups, "\n", i)
		" delete group's autocmds
		execute "silent! autocmd! " . MvElementAt(mygroups, "\n", i)
		" delete group
		"execute "silent! augroup! " . MvElementAt(mygroups, "\n", i)
		let i = i + 1
	endwhile

	" now make default group active
	silent augroup end
	" clean out default group's autocommands
	silent autocmd!

endfunction

function! Cream_behave_init()
" initialize behavior on startup

	if exists("g:CREAM_BEHAVE")
		if     g:CREAM_BEHAVE == "vim"
			call Cream_behave_vim()
		elseif g:CREAM_BEHAVE == "vi"
			call Cream_behave_vi()
		elseif g:CREAM_BEHAVE == "creamlite"
			call Cream_behave_creamlite()
		endif
	endif

endfunction

