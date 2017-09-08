"
" cream-filetype-txt.vim
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2011 Steve Hall
"
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 2 of the License, or
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
"

"---------------------------------------------------------------------
" comments

" start fresh
setlocal comments=

" bulleted within email replies prefaced ">"
setlocal comments+=sr:\>\ \ \ \ \ \ \ +\ ,mb:\>\ \ \ \ \ \ \ \ ,eb:\>\ \ \ \ \ \ \ \
setlocal comments+=sr:\>\ \ \ \ \ -\ ,mb:\>\ \ \ \ \ \ ,eb:\>\ \ \ \ \ \
setlocal comments+=sr:\>\ \ \ *\ ,mb:\>\ \ \ \ ,eb:\>\ \ \ \
setlocal comments+=sr:\>\ o\ ,mb:\>\ \ ,eb:\>\ \
setlocal comments+=sr:\>\ @\ ,mb:\>\ \ ,eb:\>\ \

" bulleted within email replies prefaced "|"
setlocal comments+=sr:\|\ \ \ \ \ \ \ +\ ,mb:\|\ \ \ \ \ \ \ \ ,eb:\|\ \ \ \ \ \ \ \
setlocal comments+=sr:\|\ \ \ \ \ -\ ,mb:\|\ \ \ \ \ \ ,eb:\|\ \ \ \ \ \
setlocal comments+=sr:\|\ \ \ *\ ,mb:\|\ \ \ \ ,eb:\|\ \ \ \
setlocal comments+=sr:\|\ o\ ,mb:\|\ \ ,eb:\|\ \
setlocal comments+=sr:\|\ @\ ,mb:\|\ \ ,eb:\|\ \

" bullet parts
setlocal comments+=fb:@,fb:o,fb:*,fb:-,fb:+

" email, communications
setlocal comments+=n:>,n:\|,n:),:XCOMM


"---------------------------------------------------------------------
" highlighting

" don't do this if syntax highlighting is off
if exists("g:CREAM_SYNTAX")
\&& g:CREAM_SYNTAX == 1

	" bullets
	highlight! link Cream_txt_bullets Special
	silent! syntax match Cream_txt_bullets '\(^[ \t]*\)\@<=[@o\*\-+]\{1} '

	" character lines, < full width, > 5 (must precede full width def)
	"execute "silent! syntax match PreProc \"\\(^\\s*\\)\\@<=\\([-_=#\\\"~]\\)\\{5,}$\""
	highlight! link Cream_txt_charlines_half PreProc
	execute 'silent! syntax match Cream_txt_charlines_half "\(^\s*\)\@<=\([-_=#\"~]\)\{5,}$"'
	" character lines, full width
	if exists("g:CREAM_AUTOWRAP_WIDTH")
		highlight! link Cream_txt_charlines_full Statement
		execute 'silent! syntax match Cream_txt_charlines_full "\(^\s*\)\@<=\([-_=#\"~]\{1}\)\+\%' . g:CREAM_AUTOWRAP_WIDTH . 'v"'
	endif

	" email quotes and sigs (def order is critical!)
	silent! syntax match EQuote1 "^>[ ]\{0,1}>\@!.*$"
	silent! syntax match EQuote2 "^>[ ]\{0,1}>[ ]\{0,1}>\@!.*$"
	silent! syntax match EQuote3 "^>[ ]\{0,1}>[ ]\{0,1}>.*$"
	silent! syntax match Sig "^-- [\r\n]\{1,2}\_.*"

	if exists("g:CREAM_TIMESTAMP_TEXT")
		" timestamp text
		highlight! link Cream_txt_stamp WarningMsg
		execute "silent! syntax match Cream_txt_stamp \"\\<" . g:CREAM_TIMESTAMP_TEXT . "\""
		" timestamp value
		highlight! link Cream_txt_stamp_value Underlined
		execute "silent! syntax match Cream_txt_stamp_value \"\\(\\<" . g:CREAM_TIMESTAMP_TEXT . "\\)\\@<=.\\{-}[\"\'\\n\\r]\""
	endif

	if exists("g:CREAM_STAMP_FILENAME_TEXT")
		" text
		highlight! link Cream_txt_stamp WarningMsg
		execute "silent! syntax match Cream_txt_stamp \"\\<" . g:CREAM_STAMP_FILENAME_TEXT . "\""
		" value
		highlight! link Cream_txt_stamp_value Underlined
		execute "silent! syntax match Cream_txt_stamp_value \"\\(\\<" . g:CREAM_STAMP_FILENAME_TEXT . "\\)\\@<=.\\{-}[\"\'\\n\\r]\""
	endif

	" foldmark titles
	highlight! link Cream_txt_foldtitles ModeMsg
	"execute "silent! syntax match Cream_txt_foldtitles \"^.\\+{{{\\(\\d\\+\\)\\{-}$\""
	silent! syntax match Cream_txt_foldtitles "^.\+\s\+\({{{\d\+\s*$\)\@="

	" arrow bullets
	"highlight! link Cream_txt_important WarningMsg
	highlight! link Cream_txt_important User1
	silent! syntax match Cream_txt_important '\(\s*[o\*\-+@\(\d\.\)] \)\@<==>'

	"" bold headers (numbers + caps + punct + whitespace)
	"highlight! link Cream_txt_header VisualNOS
	"silent! syntax match Cream_txt_header '^\([0-9A-Z 	[:punct:]]\+\)\C$'

	" URLs
	highlight! link Cream_URL Underlined
	" web address [-._?,'/\\+&%$#=~]
	silent! syntax match Cream_URL "https\=://[[:alnum:]\.-]\+\.[[:alpha:]]\{2,4}[[:alnum:]-\._?,'/\\+&%$#=~^?@\*]*"
	silent! syntax match Cream_URL "www\.[[:alnum:]\.-]\+\.[[:alpha:]]\{2,4}[[:alnum:]-\._?,'/\\+&%$#=~^?@\*]*"
	" email
	silent! syntax match Cream_URL "https\=://[[:alnum:]\._%+-]\+@[[:alnum:]\.-]\+\.[[:alpha:]]\{2,4}[[:alnum:]-\._?,'/\\+&%$#=~^?@\*]*"

endif

