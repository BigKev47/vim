"
" cream-menu-file.vim
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
" Note: Recent File menu is called at bottom.
"

function! Cream_menu_load_file()
" This is functionalized so that buffers can restore it after deleting the File menu for each refresh.

	anoremenu <silent> 10.101 &File.&New<Tab>Ctrl+N			:call Cream_file_new()<CR>
	anoremenu <silent> 10.102 &File.&Open\.\.\.<Tab>Ctrl+O	:call Cream_file_open()<CR>
	    vmenu <silent> 10.103 &File.&Open\ (selection)<Tab>Ctrl+Enter      :<C-u>call Cream_file_open_undercursor("v")<CR>
	anoremenu <silent> 10.104 &File.&Open\ (Read-Only)\.\.\.	:call Cream_file_open_readonly()<CR>
	anoremenu <silent> 10.105 &File.&Close\ File<Tab>Ctrl+F4	:call Cream_close()<CR>
	anoremenu <silent> 10.106 &File.C&lose\ All\ Files		:call Cream_close_all()<CR>

	anoremenu <silent> 10.107 &File.-SEP1-				<Nul>
	anoremenu <silent> 10.108 &File.&Save<Tab>Ctrl+S	:call Cream_save()<CR>
	anoremenu <silent> 10.109 &File.Save\ &As\.\.\.		:call Cream_saveas()<CR>
	anoremenu <silent> 10.110 &File.Sa&ve\ All\.\.\.	:call Cream_saveall()<CR>

	"if has("diff")
	"	anoremenu 10.400 &File.-SEP2-			:
	"	anoremenu 10.410 &File.Split\ &Diff\ with\.\.\.	:browse vert diffsplit<CR>
	"	anoremenu 10.420 &File.Split\ Patched\ &By\.\.\.	:browse vert diffpatch<CR>
	"endif

	" support for :hardcopy exists
	if has("printer")

		" Print
		anoremenu <silent> 10.500 &File.-SEP10500-		<Nul>
		    imenu <silent> 10.510 &File.&Print\.\.\.	<C-b>:call Cream_print("i")<CR>
		    vmenu <silent> 10.510 &File.&Print\.\.\.	:<C-u>call Cream_print("v")<CR>

		" Print setup {{{1
			" &printoptions only supported in 6.2+
			if version >= 602
				imenu <silent> 10.521 &File.Prin&t\ Setup.Paper\ Size.&Statement\ (5-1/2\ x\ 8-1/2)	<C-b>:call Cream_print_set("i", "paper:statement")<CR>
				vmenu <silent> 10.521 &File.Prin&t\ Setup.Paper\ Size.&Statement\ (5-1/2\ x\ 8-1/2)	:<C-u>call Cream_print_set("v", "paper:statement")<CR>
				imenu <silent> 10.522 &File.Prin&t\ Setup.Paper\ Size.&Letter\ (8-1/2\ x\ 11)	<C-b>:call Cream_print_set("i", "paper:letter")<CR>
				vmenu <silent> 10.522 &File.Prin&t\ Setup.Paper\ Size.&Letter\ (8-1/2\ x\ 11)	:<C-u>call Cream_print_set("v", "paper:letter")<CR>
				imenu <silent> 10.523 &File.Prin&t\ Setup.Paper\ Size.&Legal\ (11\ x\ 14)	<C-b>:call Cream_print_set("i", "paper:letter")<CR>
				vmenu <silent> 10.523 &File.Prin&t\ Setup.Paper\ Size.&Legal\ (11\ x\ 14)	:<C-u>call Cream_print_set("v", "paper:letter")<CR>
				imenu <silent> 10.524 &File.Prin&t\ Setup.Paper\ Size.&Ledger\ (17\ x\ 11)	<C-b>:call Cream_print_set("i", "paper:ledger")<CR>
				vmenu <silent> 10.524 &File.Prin&t\ Setup.Paper\ Size.&Ledger\ (17\ x\ 11)	:<C-u>call Cream_print_set("v", "paper:ledger")<CR>
				imenu <silent> 10.525 &File.Prin&t\ Setup.Paper\ Size.&A3		<C-b>:call Cream_print_set("i", "paper:A3")<CR>
				vmenu <silent> 10.525 &File.Prin&t\ Setup.Paper\ Size.&A3		:<C-u>call Cream_print_set("v", "paper:A3")<CR>
				imenu <silent> 10.526 &File.Prin&t\ Setup.Paper\ Size.&A4		<C-b>:call Cream_print_set("i", "paper:A4")<CR>
				vmenu <silent> 10.526 &File.Prin&t\ Setup.Paper\ Size.&A4		:<C-u>call Cream_print_set("v", "paper:A4")<CR>
				imenu <silent> 10.527 &File.Prin&t\ Setup.Paper\ Size.&A5		<C-b>:call Cream_print_set("i", "paper:A5")<CR>
				vmenu <silent> 10.527 &File.Prin&t\ Setup.Paper\ Size.&A5		:<C-u>call Cream_print_set("v", "paper:A5")<CR>
				imenu <silent> 10.528 &File.Prin&t\ Setup.Paper\ Size.&B4		<C-b>:call Cream_print_set("i", "paper:B4")<CR>
				vmenu <silent> 10.528 &File.Prin&t\ Setup.Paper\ Size.&B4		:<C-u>call Cream_print_set("v", "paper:B4")<CR>
				imenu <silent> 10.529 &File.Prin&t\ Setup.Paper\ Size.&B5		<C-b>:call Cream_print_set("i", "paper:B5")<CR>
				vmenu <silent> 10.529 &File.Prin&t\ Setup.Paper\ Size.&B5		:<C-u>call Cream_print_set("v", "paper:B5")<CR>

				imenu <silent> 10.541 &File.Prin&t\ Setup.Paper\ Orientation.&Portrait		<C-b>:call Cream_print_set("i", "portrait:y")<CR>
				vmenu <silent> 10.541 &File.Prin&t\ Setup.Paper\ Orientation.&Portrait		:<C-u>call Cream_print_set("v", "portrait:y")<CR>
				imenu <silent> 10.542 &File.Prin&t\ Setup.Paper\ Orientation.&Landscape		<C-b>:call Cream_print_set("i", "portrait:n")<CR>
				vmenu <silent> 10.542 &File.Prin&t\ Setup.Paper\ Orientation.&Landscape		:<C-u>call Cream_print_set("v", "portrait:n")<CR>

				imenu <silent> 10.553 &File.Prin&t\ Setup.Margins.&Top\.\.\.		<C-b>:call Cream_print_set_margin_top("i")<CR>
				vmenu <silent> 10.553 &File.Prin&t\ Setup.Margins.&Top\.\.\.		:<C-u>call Cream_print_set_margin_top("v")<CR>
				imenu <silent> 10.551 &File.Prin&t\ Setup.Margins.&Left\.\.\.		<C-b>:call Cream_print_set_margin_left("i")<CR>
				vmenu <silent> 10.551 &File.Prin&t\ Setup.Margins.&Left\.\.\.		:<C-u>call Cream_print_set_margin_left("v")<CR>
				imenu <silent> 10.552 &File.Prin&t\ Setup.Margins.&Right\.\.\.		<C-b>:call Cream_print_set_margin_right("i")<CR>
				vmenu <silent> 10.552 &File.Prin&t\ Setup.Margins.&Right\.\.\.		:<C-u>call Cream_print_set_margin_right("v")<CR>
				imenu <silent> 10.554 &File.Prin&t\ Setup.Margins.&Bottom\.\.\.		<C-b>:call Cream_print_set_margin_bottom("i")<CR>
				vmenu <silent> 10.554 &File.Prin&t\ Setup.Margins.&Bottom\.\.\.		:<C-u>call Cream_print_set_margin_bottom("v")<CR>


				imenu <silent> 10.561 &File.Prin&t\ Setup.Header.Height\.\.\.		<C-b>:call Cream_print_set_header("i")<CR>
				vmenu <silent> 10.561 &File.Prin&t\ Setup.Header.Height\.\.\.		:<C-u>call Cream_print_set_header("v")<CR>
			endif

			imenu <silent> 10.562 &File.Prin&t\ Setup.Header.Text\.\.\.			<C-b>:call Cream_print_set_headertext("i")<CR>
			vmenu <silent> 10.562 &File.Prin&t\ Setup.Header.Text\.\.\.			:<C-u>call Cream_print_set_headertext("v")<CR>

		anoremenu <silent> 10.565 &File.Prin&t\ Setup.--Sep10565--	<Nul>
			imenu <silent> 10.565 &File.Prin&t\ Setup.Syntax\ Highlighting\.\.\.	<C-b>:call Cream_print_set_syntax("i")<CR>
			vmenu <silent> 10.565 &File.Prin&t\ Setup.Syntax\ Highlighting\.\.\.	:<C-u>call Cream_print_set_syntax("v")<CR>

			imenu <silent> 10.566 &File.Prin&t\ Setup.Line\ Numbering\.\.\.		<C-b>:call Cream_print_set_number("i")<CR>
			vmenu <silent> 10.566 &File.Prin&t\ Setup.Line\ Numbering\.\.\.		:<C-u>call Cream_print_set_number("v")<CR>


			imenu <silent> 10.567 &File.Prin&t\ Setup.Wrap\ at\ Margins\.\.\.	<C-b>:call Cream_print_set_wrap("i")<CR>
			vmenu <silent> 10.567 &File.Prin&t\ Setup.Wrap\ at\ Margins\.\.\.	:<C-u>call Cream_print_set_wrap("v")<CR>

		anoremenu <silent> 10.600 &File.Prin&t\ Setup.--Sep600--		<Nul>
			imenu <silent> 10.601 &File.Prin&t\ Setup.Font\.\.\.		<C-b>:call Cream_print_set_font("i")<CR>
			vmenu <silent> 10.602 &File.Prin&t\ Setup.Font\.\.\.		:<C-u>call Cream_print_set_font("v")<CR>


			" print encoding (10.600s) {{{2
			" &printencoding only supported in Vim 6.2+
			if version >= 602
				" (swiped from file encoding menu)
				anoremenu <silent> 10.603 &File.Prin&t\ Setup.&Encoding.Unicode.Unicode\ (UTF-8)<Tab>[utf-8\ --\ 32\ bit\ UTF-8\ encoded\ Unicode\ (ISO/IEC\ 10646-1)]	:call Cream_print_set("i", "encoding", "utf-8")<CR>
				anoremenu <silent> 10.604 &File.Prin&t\ Setup.&Encoding.Unicode.-Sep10604-		<Nul>
				anoremenu <silent> 10.605 &File.Prin&t\ Setup.&Encoding.Unicode.Unicode\ (UCS-2)<Tab>[ucs-2\ --\ 16\ bit\ UCS-2\ encoded\ Unicode\ (ISO/IEC\ 10646-1)]	:call Cream_print_set("i", "encoding", "ucs-2")<CR>
				anoremenu <silent> 10.606 &File.Prin&t\ Setup.&Encoding.Unicode.Unicode\ (UCS-2le)<Tab>[ucs-2le\ --\ like\ ucs-2,\ little\ endian]	:call Cream_print_set("i", "encoding", "ucs-2le")<CR>
				anoremenu <silent> 10.607 &File.Prin&t\ Setup.&Encoding.Unicode.Unicode\ (UTF-16)<Tab>[utf-16\ --\ UCS-2\ extended\ with\ double-words\ for\ more\ characters]	:call Cream_print_set("i", "encoding", "utf-16")<CR>
				anoremenu <silent> 10.608 &File.Prin&t\ Setup.&Encoding.Unicode.Unicode\ (UTF-16le)<Tab>[utf-16le\ --\ like\ UTF-16,\ little\ endian]	:call Cream_print_set("i", "encoding", "utf-16le")<CR>
				anoremenu <silent> 10.609 &File.Prin&t\ Setup.&Encoding.Unicode.Unicode\ (UCS-4)<Tab>[ucs-4\ --\ 32\ bit\ UCS-4\ encoded\ Unicode\ (ISO/IEC\ 10646-1)]	:call Cream_print_set("i", "encoding", "ucs-4")<CR>
				anoremenu <silent> 10.610 &File.Prin&t\ Setup.&Encoding.Unicode.Unicode\ (UCS-4le)<Tab>[ucs-4le\ --\ like\ ucs-4,\ little\ endian]	:call Cream_print_set("i", "encoding", "ucs-4le")<CR>
				anoremenu <silent> 10.611 &File.Prin&t\ Setup.&Encoding.-Sep10611-		<Nul>
				anoremenu <silent> 10.612 &File.Prin&t\ Setup.&Encoding.Western\ European.Western\ (ISO-8859-1)<Tab>[latin1/ANSI\ --\ 8-bit\ characters]	:call Cream_print_set("i", "encoding", "latin1")<CR>
				anoremenu <silent> 10.613 &File.Prin&t\ Setup.&Encoding.Western\ European.Western\ (ISO-8859-15)<Tab>[iso-8859-15\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-15")<CR>
				anoremenu <silent> 10.614 &File.Prin&t\ Setup.&Encoding.Western\ European.Western\ (Windows-1252)<Tab>[8bit-cp1252\ --\ MS-Windows\ double-byte\ codepage]	:call Cream_print_set("i", "encoding", "8bit-cp1252")<CR>
				anoremenu <silent> 10.615 &File.Prin&t\ Setup.&Encoding.Western\ European.Celtic\ (ISO-8859-14)<Tab>[iso-8859-14\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-14")<CR>
				anoremenu <silent> 10.616 &File.Prin&t\ Setup.&Encoding.Western\ European.Greek\ (ISO-8859-7)<Tab>[iso-8859-7\ --\ ISO_8859\ variant]		:call Cream_print_set("i", "encoding", "iso-8859-7")<CR>
				anoremenu <silent> 10.617 &File.Prin&t\ Setup.&Encoding.Western\ European.Greek\ (Windows-1253)<Tab>[8bit-cp1253\ --\ MS-Windows\ double-byte\ codepage]	:call Cream_print_set("i", "encoding", "8bit-cp1253")<CR>
				anoremenu <silent> 10.618 &File.Prin&t\ Setup.&Encoding.Western\ European.Nordic\ (ISO-8859-10)<Tab>[iso-8859-10\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-10")<CR>
				anoremenu <silent> 10.619 &File.Prin&t\ Setup.&Encoding.Western\ European.South\ European\ (ISO-8859-3)<Tab>[iso-8859-3\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-3")<CR>
				anoremenu <silent> 10.620 &File.Prin&t\ Setup.&Encoding.Eastern\ European.Baltic\ (ISO-8859-4)<Tab>[iso-8859-4\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-4")<CR>
				anoremenu <silent> 10.621 &File.Prin&t\ Setup.&Encoding.Eastern\ European.Baltic\ (ISO-8859-13)<Tab>[iso-8859-13\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-13")<CR>
				anoremenu <silent> 10.622 &File.Prin&t\ Setup.&Encoding.Western\ European.Baltic\ (Windows-1257)<Tab>[8bit-cp1257\ --\ MS-Windows\ double-byte\ codepage]	:call Cream_print_set("i", "encoding", "8bit-cp1257")<CR>
				anoremenu <silent> 10.623 &File.Prin&t\ Setup.&Encoding.Western\ European.Central\ European\ (Windows-1250)<Tab>[8bit-cp1250\ --\ MS-Windows\ double-byte\ codepage]	:call Cream_print_set("i", "encoding", "8bit-cp1250")<CR>
				anoremenu <silent> 10.624 &File.Prin&t\ Setup.&Encoding.Eastern\ European.Cyrillic\ (ISO-8859-5)<Tab>[iso-8859-5\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-5")<CR>
				anoremenu <silent> 10.625 &File.Prin&t\ Setup.&Encoding.Eastern\ European.Cyrillic\ (KO18-R)<Tab>[koi8-r\ --\ Russian]	:call Cream_print_set("i", "encoding", "koi8-r")<CR>
				anoremenu <silent> 10.626 &File.Prin&t\ Setup.&Encoding.Western\ European.Cyrillic\ (Windows-1251)<Tab>[8bit-cp1251\ --\ MS-Windows\ double-byte\ codepage]	:call Cream_print_set("i", "encoding", "8bit-cp1251")<CR>
				anoremenu <silent> 10.627 &File.Prin&t\ Setup.&Encoding.Eastern\ European.Cyrillic/Ukrainian\ (KO18-U)<Tab>[koi8-u\ --\ Ukrainian]	:call Cream_print_set("i", "encoding", "koi8-u")<CR>
				anoremenu <silent> 10.628 &File.Prin&t\ Setup.&Encoding.Eastern\ European.Romanian\ (ISO-8859-16)<Tab>[iso-8859-16\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-16")<CR>
				anoremenu <silent> 10.629 &File.Prin&t\ Setup.&Encoding.East\ Asian.Simplified\ Chinese\ (ISO-2022-CN)<Tab>[chinese\ --\ simplified\ Chinese:\ on\ Unix\ "euc-cn",\ on\ MS-Windows\ cp936]	:call Cream_print_set("i", "encoding", "chinese")<CR>
				anoremenu <silent> 10.630 &File.Prin&t\ Setup.&Encoding.East\ Asian.Chinese\ Traditional\ (Big5)<Tab>[big5\ --\ traditional\ Chinese]	:call Cream_print_set("i", "encoding", "big5")<CR>
				anoremenu <silent> 10.631 &File.Prin&t\ Setup.&Encoding.East\ Asian.Chinese\ Traditional\ (EUC-TW)<Tab>[taiwan\ --\ on\ Unix\ "euc-tw",\ on\ MS-Windows\ cp950]	:call Cream_print_set("i", "encoding", "taiwan")<CR>
				anoremenu <silent> 10.632 &File.Prin&t\ Setup.&Encoding.East\ Asian.Japanese<Tab>[japan\ --\ on\ Unix\ "euc-jp",\ on\ MS-Windows\ cp932]	:call Cream_print_set("i", "encoding", "japan")<CR>
				anoremenu <silent> 10.633 &File.Prin&t\ Setup.&Encoding.East\ Asian.Korean<Tab>[korea\ --\ on\ Unix\ "euc-kr",\ on\ MS-Windows\ cp949]	:call Cream_print_set("i", "encoding", "korea")<CR>
				anoremenu <silent> 10.634 &File.Prin&t\ Setup.&Encoding.SE\ and\ SW\ Asian.Turkish\ (ISO-8859-9)<Tab>[iso-8859-6\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-9")<CR>
				anoremenu <silent> 10.635 &File.Prin&t\ Setup.&Encoding.Western\ European.Turkish\ (Windows-1254)<Tab>[8bit-cp1254\ --\ MS-Windows\ double-byte\ codepage]	:call Cream_print_set("i", "encoding", "8bit-cp1254")<CR>
				anoremenu <silent> 10.636 &File.Prin&t\ Setup.&Encoding.Western\ European.Vietnamese\ (Windows-1258)<Tab>[8bit-cp1258\ --\ MS-Windows\ double-byte\ codepage]	:call Cream_print_set("i", "encoding", "8bit-cp1258")<CR>
				anoremenu <silent> 10.637 &File.Prin&t\ Setup.&Encoding.Middle\ Eastern.Arabic\ (ISO-8859-6)<Tab>[iso-8859-6\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-6")<CR>
				anoremenu <silent> 10.638 &File.Prin&t\ Setup.&Encoding.Western\ European.Arabic\ (Windows-1256)<Tab>[8bit-cp1256\ --\ MS-Windows\ double-byte\ codepage]	:call Cream_print_set("i", "encoding", "8bit-cp1256")<CR>
				anoremenu <silent> 10.639 &File.Prin&t\ Setup.&Encoding.Western\ European.Hebrew\ (Windows-1255)<Tab>[8bit-cp1255\ --\ MS-Windows\ double-byte\ codepage]	:call Cream_print_set("i", "encoding", "8bit-cp1255")<CR>
				anoremenu <silent> 10.640 &File.Prin&t\ Setup.&Encoding.Middle\ Eastern.Hebrew\ Visual\ (ISO-8859-8)<Tab>[iso-8859-8\ --\ ISO_8859\ variant]	:call Cream_print_set("i", "encoding", "iso-8859-8")<CR>
			endif
			" 2}}}

			imenu <silent> 10.650 &File.Prin&t\ Setup.Obey\ Formfeeds\.\.\.		<C-b>:call Cream_print_set_formfeed("i")<CR>
			vmenu <silent> 10.651 &File.Prin&t\ Setup.Obey\ Formfeeds\.\.\.		:<C-u>call Cream_print_set_formfeed("v")<CR>

		anoremenu <silent> 10.660 &File.Prin&t\ Setup.--Sep10660--	<Nul>
			imenu <silent> 10.661 &File.Prin&t\ Setup.Collate\.\.\.				<C-b>:call Cream_print_set_collate("i")<CR>
			vmenu <silent> 10.662 &File.Prin&t\ Setup.Collate\.\.\.				:<C-u>call Cream_print_set_collate("v")<CR>

			imenu <silent> 10.670 &File.Prin&t\ Setup.Duplex\.\.\.				<C-b>:call Cream_print_set_duplex("i")<CR>
			vmenu <silent> 10.671 &File.Prin&t\ Setup.Duplex\.\.\.				:<C-u>call Cream_print_set_duplex("v")<CR>

			imenu <silent> 10.680 &File.Prin&t\ Setup.Job\ Split\ Copies\.\.\.	<C-b>:call Cream_print_set_jobsplit("i")<CR>
			vmenu <silent> 10.681 &File.Prin&t\ Setup.Job\ Split\ Copies\.\.\.	:<C-u>call Cream_print_set_jobsplit("v")<CR>

		anoremenu <silent> 10.690 &File.Prin&t\ Setup.--Sep10690--		<Nul>
			" we don't need this functionality (READ :help 'printdevice)
			"imenu <silent> 10.691 &File.Prin&t\ Setup.Device\.\.\.			<C-b>:call Cream_print_set_device("i")<CR>
			"vmenu <silent> 10.692 &File.Prin&t\ Setup.Device\.\.\.			:<C-u>call Cream_print_set_device("v")<CR>

			imenu <silent> 10.693 &File.Prin&t\ Setup.Printer\ Expression\.\.\.		<C-b>:call Cream_print_set_expr("i")<CR>
			vmenu <silent> 10.694 &File.Prin&t\ Setup.Printer\ Expression\.\.\.		:<C-u>call Cream_print_set_expr("v")<CR>


			" 1}}}


	elseif has("unix")
		anoremenu <silent> 10.500 &File.-SEP10500-		<Nul>
		anoremenu <silent> 10.510 &File.&Print\.\.\.	:w !lpr<CR>
		  vunmenu <silent> &File.&Print\.\.\.
		    vmenu <silent> &File.&Print\.\.\.			:w !lpr<CR>
	elseif has("vms")
		anoremenu <silent> 10.500 &File.-SEP10500-		<Nul>
		anoremenu <silent> 10.510 &File.&Print\.\.\.	:call VMSPrint(":")<CR>
		  vunmenu <silent> &File.&Print\.\.\.
		    vmenu <silent> &File.&Print\.\.\.			<Esc>:call VMSPrint(":'<,'>")<CR>

		if !exists("*VMSPrint")
			function VMSPrint(range)
				let mod_save = &mode
				let ttt = tempname()
				execute a:range . "w! " . ttt
				let &mode = mod_save
				execute "!print/delete " . ttt
			endfunction
		endif
	endif

	anoremenu <silent> 10.800 &File.-SEP4-				<Nul>
	anoremenu <silent> 10.801 &File.E&xit<Tab>Alt+F4	:call Cream_exit()<CR>
	anoremenu <silent> 10.821 &File.Save\ All\ and\ &Exit   :call Cream_save_exit()<CR>


endfunction
call Cream_menu_load_file()

"----------------------------------------------------------------------
" Recent File menu

function! Cream_load_menu_mru()
	if filereadable($CREAM . "cream-menu-mru.vim") > 0
		execute "source " . $CREAM . "cream-menu-mru.vim"
	endif
endfunction
call Cream_load_menu_mru()

" vim:foldmethod=marker
