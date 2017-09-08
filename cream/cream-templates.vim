"
" Filename: cream-templates.vim
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

"
" Description: This is a template expander. While typing, a brief word
" ("keyword") can be expanded into a larger body of standard text
" ("template"). (Inspired by imaps.vim, by Srinath Avadhanula.)
"

" cursor placement marker
let s:findchar = "{+}"

"" mapping (expands valid keyword to template)
"inoremap <silent> <Esc><Space> <C-r>=Cream_template_expand()<CR>

" Cream_template_expand() {{{1
function! Cream_template_expand()
" test the word before the cursor and expand it if it matches

	" test the word before the cursor
	normal h
	let word = expand('<cword>')
	normal l

	let rhs = ''
	if exists('g:cream_template_' . &filetype . '_' . word)
	" first find out whether this word is a mapping in the current file-type.
		execute 'let rhs = g:cream_template_' . &filetype . '_' . word
	elseif exists('g:cream_template__' . word)
	" also check for general purpose mappings.
		execute 'let rhs = g:cream_template__' . word
	end

	" if this is a mapping
	if rhs != ''

		" erase the map's letters with equal number of backspaces
		let bkspc = "\<BS>" . substitute(word, ".", "\<BS>", 'ge')

		" is the cursor placement marker found?
		if stridx(rhs, s:findchar) != -1
			let i = strlen(s:findchar)
		else
			let i = 0
		endif
		if rhs =~ s:findchar
			if i > 0
				let movement = "\<C-\>\<C-n>?" . s:findchar . "\<CR>" . i . "s"
			else
				let movement = "\<C-\>\<C-n>?" . s:findchar . "\<CR>"
			endif
		else
			let movement = ""
		end

		return bkspc . rhs . movement

	endif

	return ''

endfunction

" Cream_template_assign() {{{1
function! Cream_template_assign(ftype, mapping, template)
" set (initialize) template mappings to be available
" arguments:
" {ftype}       Filetype mapping is applicable in. Can be empty to
"               match all files.
" {mapping}     Word to complete template on.
" {template}    String to insert on completion.
"

	" create variable
	" Note: Final template is stored here as a double-quoted string.
	" ALL ESCAPING MUST BE APPROPRIATE AS FOR A DOUBLE-QUOTED STRING,
	" NOT A LITERAL ONE!
	execute "let g:cream_template_" . a:ftype . "_" . a:mapping . " = \"" . a:template . "\""

	" register with both filetype*s* array AND particular filetype array
	" * "g:cream_template"           arrays all filetypes with templates available
	" * "g:cream_template . a:ftype" arrays each filetype's templates
	" initialize filetype's global ("g:cream_template_html")
	if !exists("g:cream_template_" . a:ftype)
		" verify filetype is registered (so we don't have to search
		" through all variables later)
		" initialize
		if !exists("g:cream_template")
			let g:cream_template = a:ftype . "\n"
		else
			" only add if not already in array
			if match(g:cream_template, a:ftype . "\\n") == -1
				execute "let g:cream_template = g:cream_template . \"" . a:ftype . "\" . \"\\n\""
			endif
		endif
		" initialize container
		execute "let g:cream_template_" . a:ftype . " = ''"
	endif

	" append current to global registration for that filetype
	execute "let g:cream_template_" . a:ftype . " = g:cream_template_" . a:ftype . " . \"" . a:mapping . "\" . \"\\n\""

endfunction

" Cream_template_listing() {{{1
function! Cream_template_listing()
" diaplay all registered templates

	" compose display string
	let mystr = ""

	" get variable for each filetype registered
	let x = MvNumberOfElements(g:cream_template, "\n")
	let i = 0
	while i < x
		" form: "g:cream_template_html"
		let myvar = MvElementAt(g:cream_template, "\n", i)
		"let myarray = g:cream_template_{myvar}
		let y = MvNumberOfElements(g:cream_template_{myvar}, "\n")
		let j = 0
		while j < y
			" form: "g:cream_template_html_table"
			let myword = MvElementAt(g:cream_template_{myvar}, "\n", j)
			let mytemplate = g:cream_template_{myvar}_{myword}

			" compose string
			" header
			if j == 0
				let mystr = mystr . "\n"
				let mywidth = winwidth(0) - 1
				let k = 0
				while k < mywidth
					let mystr = mystr . "_"
					let k = k + 1
				endwhile
				let mystr = mystr . "\n"
				" empty is applicable to all filetypes
				if myvar == ""
					let mystr = mystr . "General Templates (available in all files)" . "\n\n"
				else
					let mystr = mystr . toupper(myvar) . " Templates (available in " . myvar . " files only)\n\n"
				endif
				let mystr = mystr . "WORD        TEMPLATE                                     \n"
				let mystr = mystr . "---------   -------------------------------------------- \n"
			endif

			" remove *initial* newline or return
			let mytemplate = substitute(mytemplate, '^[\n\r]', '', 'g')
			" remove dec 001-007 chars
			let mytemplate = substitute(mytemplate, '[-]', '', 'g')
			" remove dec 008 (<BS>)
			let mytemplate = substitute(mytemplate, '[]', '', 'g')
			" remove "<BS>"
			let mytemplate = substitute(mytemplate, '\<BS>', '', 'g')
			"" remove dec 009 (<TAB>)
			"let mytemplate = substitute(mytemplate, '[	]', '', 'g')
			" remove dec 011-012 chars
			let mytemplate = substitute(mytemplate, '[-]', '', 'g')
			" remove dec 014-031 chars
			let mytemplate = substitute(mytemplate, '[-]', '', 'g')
			"" trim off remaining returns and replace with ellipses ("...")
			"let mytemplate = substitute(mytemplate, "\n.*$", "...", "")
			" remove s:findchar
			let mytemplate = substitute(mytemplate, s:findchar, '', 'g')

			" space off templates from left margin
			let myspacer = "            "
			" preceed entries containing return second lines with a spacer
			if match(mytemplate, "\n") != -1
				let mytemplate = substitute(mytemplate, "\n", "\n" . myspacer, "g")
			endif

			" space single/first string
			let myspacerlen = strlen(myspacer)
			let myspacer = ""
			" insert character &textwidth number of times
			let k = 0
			while k < myspacerlen - strlen(myword)
				let myspacer = myspacer . " "
				let k = k + 1
			endwhile

			" cat
			let mystr = mystr . myword . myspacer . mytemplate . "\n"

			let j = j + 1
		endwhile
		let i = i + 1
	endwhile

	" set margin, right
	let k = 0
	let myright = ""
	while k < 1
		let myright = myright . " "
		let k = k + 1
	endwhile
	let mystr = substitute(mystr, "\n", '\n' . myright, 'g')
	" set margin, left
	let mywidth = winwidth(0) - 1
	let mystr = substitute(mystr, "\\v([^\n]{," . mywidth . "})[^\n]*", '\1', 'g')

	" now add pre-header explanation, so it can wrap/return without concerns
	let mystr =
		\ "\n" .
		\ "    The listing below indicates words that can be expanded\n" .
		\ "    into the adjacent template. The templates are grouped \n" .
		\ "    by the file type in which each is available.\n" .
		\ "\n" .
		\ "    Simply press Shift+Space(x2) with the cursor at the end\n" .
		\ "    of the word. (Note that the word must be separated\n" .
		\ "    by a space or return from the following word.)\n" .
		\ "\n" .
		\ "    Press the Space Bar to continue... (Esc to quit)\n" .
		\ mystr

	echo mystr

endfunction
" 1}}}

" Templates
" General {{{1

" date: "20 November 2002" (See F11 for stamps)
call Cream_template_assign("", "date", "\<C-r>=strftime('%d %B %Y')\<CR>")
" datestamp: "2002-12-04T11:16:27EST" (Same as F11x4)
call Cream_template_assign("", "datestamp", "\\<C-r>=strftime('%Y-%m-%dT%H:%M:%S%Z')\<CR>")

" URLs
call Cream_template_assign("", "url", "http://www.")
call Cream_template_assign("", "urlcream", "http://cream.sourceforge.net")
call Cream_template_assign("", "urlvim", "http://www.vim.org")
call Cream_template_assign("", "urlgpl", "http://www.gnu.org/licenses/gpl.html")
call Cream_template_assign("", "urlpi", "http://3.141592653589793238462643383279502884197169399375105820974944592.com/")

" ASCII chars 32-126 (Note "!" and " " are swapped for readibility)
call Cream_template_assign("", "ascii", "! \\\"#$%&'()*+,-./0123456789:;\<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\\\]^_`abcdefghijklmnopqrstuvwxyz{\|}~")

" a "ruler" -- nice for counting the length of words
call Cream_template_assign("", "ruler", "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890\n" .
	\ "       10^       20^       30^       40^       50^       60^       70^       80^       90^      100^\n")

" some important numbers
call Cream_template_assign("", "e", "2.7182818284590452353602874713526624977573")
call Cream_template_assign("", "pi", "3.1415926535897932384626433832795028841972")
" pi to 1,000 places
call Cream_template_assign("", "PI",
	\ "3.\n" .
	\ "1415926535 8979323846 2643383279 5028841971 6939937510\n" .
	\ "5820974944 5923078164 0628620899 8628034825 3421170679\n" .
	\ "8214808651 3282306647 0938446095 5058223172 5359408128\n" .
	\ "4811174502 8410270193 8521105559 6446229489 5493038196\n" .
	\ "4428810975 6659334461 2847564823 3786783165 2712019091\n" .
	\ "4564856692 3460348610 4543266482 1339360726 0249141273\n" .
	\ "7245870066 0631558817 4881520920 9628292540 9171536436\n" .
	\ "7892590360 0113305305 4882046652 1384146951 9415116094\n" .
	\ "3305727036 5759591953 0921861173 8193261179 3105118548\n" .
	\ "0744623799 6274956735 1885752724 8912279381 8301194912\n" .
	\ "9833673362 4406566430 8602139494 6395224737 1907021798\n" .
	\ "6094370277 0539217176 2931767523 8467481846 7669405132\n" .
	\ "0005681271 4526356082 7785771342 7577896091 7363717872\n" .
	\ "1468440901 2249534301 4654958537 1050792279 6892589235\n" .
	\ "4201995611 2129021960 8640344181 5981362977 4771309960\n" .
	\ "5187072113 4999999837 2978049951 0597317328 1609631859\n" .
	\ "5024459455 3469083026 4252230825 3344685035 2619311881\n" .
	\ "7101000313 7838752886 5875332083 8142061717 7669147303\n" .
	\ "5982534904 2875546873 1159562863 8823537875 9375195778\n" .
	\ "1857780532 1712268066 1300192787 6611195909 2164201989\n" .
	\ "  For more: http://www.piday.org/\n")

" standard abbreviations
call Cream_template_assign("", "i18n", "internationalization")
call Cream_template_assign("", "l10n", "localization")

" HTML {{{1

call Cream_template_assign("html", "html", 
	\ '<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\<CR>' .
	\ '<html>\<CR>' .
	\ '<head>\<CR>' .
	\ '\<TAB><title></title>\<CR>' .
	\ '<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\<CR>' .
	\ '<meta name=\"robots\" content=\"noindex, nofollow\">\<CR>' .
	\ '<link href=\"main.css\" rel=\"stylesheet\" type=\"text/css\">\<CR>' .
	\ '<link href=\"favicon.ico\" rel=\"Shortcut Icon\">\<CR>' .
	\ '\<BS></head>\<CR>' .
	\ '<body>\<CR>' .
	\ '' . s:findchar . '\<CR>' .
	\ '</body>\<CR>' .
	\ '</html>\<CR>')
call Cream_template_assign("html", "table",
	\ '<table cellpadding=\"4\" cellspacing=\"0\" border=\"0\">\<CR>' .
	\ '<tr>\<CR>' .
	\ '\<TAB><td>' . s:findchar . '</td>\<CR>' .
	\ '\<BS></tr>\<CR>' .
	\ '</table>\<CR>')
call Cream_template_assign("html", "tr",
	\ '<tr>\<CR>' .
	\ '\<TAB><td>' . s:findchar . '</td>\<CR>' .
	\ '\<BS></tr>\<CR>')
call Cream_template_assign("html", "td", '<td>' . s:findchar . '</td>\<CR>')
call Cream_template_assign("html", "p",  '<p>' . s:findchar . '</p>\<CR>')
call Cream_template_assign("html", "a",  '<a href=\"' . s:findchar . '\"></a>')
call Cream_template_assign("html", "mail", '<a href=\"mailto:' . s:findchar . '\"></a>')
call Cream_template_assign("html", "b",  '<b>' . s:findchar . '</b>')
call Cream_template_assign("html", "i",  '<i>' . s:findchar . '</i>')
call Cream_template_assign("html", "u",  '<u>' . s:findchar . '</u>')
call Cream_template_assign("html", "ol", '<ol>\<CR><li>' . s:findchar . '</li>\<CR></ol>\<CR>')
call Cream_template_assign("html", "ul", '<ul>\<CR><li>' . s:findchar . '</li>\<CR></ul>\<CR>')
call Cream_template_assign("html", "li", '<li>' . s:findchar . '</li>\<CR>')
call Cream_template_assign("html", "h1", '<h1>' . s:findchar . '</h1>\<CR>')
call Cream_template_assign("html", "h2", '<h2>' . s:findchar . '</h2>\<CR>')
call Cream_template_assign("html", "h3", '<h3>' . s:findchar . '</h3>\<CR>')
call Cream_template_assign("html", "h4", '<h4>' . s:findchar . '</h4>\<CR>')
call Cream_template_assign("html", "h5", '<h5>' . s:findchar . '</h5>\<CR>')
call Cream_template_assign("html", "h6", '<h6>' . s:findchar . '</h6>\<CR>')

" HTML character equivilences {{{1
"
" Are these really helpful? A list would be better.

call Cream_template_assign("html", "_", "\&nbsp;\n\<Left>" . s:findchar)

" HTML greek characters {{{1
"
" Cream: single letters are more valuable otherwise
"let s:imaps_html_a = "\&alpha;"
"let s:imaps_html_b = "\&beta;"
"let s:imaps_html_c = "\&chi;"
"let s:imaps_html_d = "\&delta;"
"let s:imaps_html_e = "\&epsilon;"
"let s:imaps_html_f = "\&phi;"
"let s:imaps_html_g = "\&gamma;"
"let s:imaps_html_h = "\&eta;"
"let s:imaps_html_k = "\&kappa;"
"let s:imaps_html_l = "\&lambda;"
"let s:imaps_html_m = "\&mu;"
"let s:imaps_html_n = "\&nu;"
"let s:imaps_html_p = "\&pi;"
"let s:imaps_html_q = "\&theta;"
"let s:imaps_html_r = "\&rho;"
"let s:imaps_html_s = "\&sigma;"
"let s:imaps_html_t = "\&tau;"
"let s:imaps_html_u = "\&upsilon;"
"let s:imaps_html_v = "\&varsigma;"
"let s:imaps_html_w = "\&omega;"
"let s:imaps_html_x = "\&xi;"
"let s:imaps_html_y = "\&psi;"
"let s:imaps_html_z = "\&zeta;"
"let s:imaps_html_A = "\&Alpha;"
"let s:imaps_html_B = "\&Beta;"
"let s:imaps_html_C = "\&Chi;"
"let s:imaps_html_D = "\&Delta;"
"let s:imaps_html_E = "\&Epsilon;"
"let s:imaps_html_F = "\&Phi;"
"let s:imaps_html_G = "\&Gamma;"
"let s:imaps_html_H = "\&Eta;"
"let s:imaps_html_K = "\&Kappa;"
"let s:imaps_html_L = "\&Lambda;"
"let s:imaps_html_M = "\&Mu;"
"let s:imaps_html_N = "\&Nu;"
"let s:imaps_html_P = "\&Pi;"
"let s:imaps_html_Q = "\&Theta;"
"let s:imaps_html_R = "\&Rho;"
"let s:imaps_html_S = "\&Sigma;"
"let s:imaps_html_T = "\&Tau;"
"let s:imaps_html_U = "\&Upsilon;"
"let s:imaps_html_V = "\&Varsigma;"
"let s:imaps_html_W = "\&Omega;"
"let s:imaps_html_X = "\&Xi;"
"let s:imaps_html_Y = "\&Psi;"
"let s:imaps_html_Z = "\&Zeta;"

" Vim {{{1

call Cream_template_assign("vim", "function",
	\ "function! \" . s:findchar . \"()\n" .
	\ "\n" .
	\ "endfunction\n")

call Cream_template_assign("vim", "while",
	\ "let i = 0\n" .
	\ "while i \< \" . s:findchar . \"\n" .
	\ "\n" .
	\ "\<TAB>let i = i + 1\n" .
	\ "\<BS>endwhile\n")

call Cream_template_assign("vim", "debug",
	\ '\"*** DEBUG:\<CR>\<BS>\<CR>' .
	\ '\<BS>let n = confirm(\<CR>' .
	\ '\<TAB>\\ \"DEBUG:\\n\" .\<CR>' .
	\ '\\ \"  ' . s:findchar . 'myvar  = \\\"\" . myvar . \"\\\"\\n\" .\<CR>' .
	\ '\\ \"\\n\", \"&Ok\\n&Cancel\", 1, \"Info\")\<CR>' .
	\ 'if n != 1\<CR>' .
	\ 'return\<CR>' .
	\ '\<BS>endif\<CR>' .
	\ '\"***\<CR>\<BS>')

call Cream_template_assign("vim", "confirm",
	\ "call confirm(\\n" .
	\ "\<TAB>\\\\ \\\"\" . s:findchar . \"\\\\n\\\" .\\n" .
	\ "\\\\ \\\"\\\\n\\\", \\\"&Ok\\\", 1, \\\"Info\\\")\n\<BS>")

" VB (Basic) {{{1

call Cream_template_assign("basic", "debug",
	\ "\'*** DEBUG:\\n" .
	\ "\Msg (\\\"Progress to here!\\\" & Chr(13) & _\\n" .
	\ "\\<TAB>\\\"  \" . s:findchar . \"myvar  = \\\" & myvar & Chr(13) & _\\n" .
	\ "Chr(13))\\n" .
	\ "\'***\\n" .
	\ "")

" Lisp {{{1

call Cream_template_assign("lisp", "debug",
	\ '\<CR>(princ \"DEBUG:  \"' . s:findchar . 'myvar : \") (princ myvar) (princ \"\\n\")\<CR>\<CR>')


"1}}}
" vim:foldmethod=marker
