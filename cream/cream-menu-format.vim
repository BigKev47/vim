"
" cream-menu-format.vim
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


	imenu <silent> 50.100 Fo&rmat.&Quick\ Wrap\ (selection\ or\ current\ paragraph)<Tab>Ctrl+Q	      <C-b>:call Cream_quickwrap("i")<CR>
	vmenu <silent> 50.101 Fo&rmat.&Quick\ Wrap\ (selection\ or\ current\ paragraph)<Tab>Ctrl+Q	      :<C-u>call Cream_quickwrap("v")<CR>
	imenu <silent> 50.102 Fo&rmat.Quick\ &Un-Wrap\ (selection\ or\ current\ paragraph)<Tab>Alt+Q,\ Q  <C-b>:call Cream_quickunwrap("i")<CR>
	vmenu <silent> 50.103 Fo&rmat.Quick\ &Un-Wrap\ (selection\ or\ current\ paragraph)<Tab>Alt+Q,\ Q  :<C-u>call Cream_quickunwrap("v")<CR>

anoremenu <silent> 50.200 Fo&rmat.-Sep200-                            <Nul>
	imenu <silent> 50.201 Fo&rmat.Capitalize,\ Title\ Case<Tab>F5     <C-b>:call Cream_case_title("i")<CR>
	vmenu <silent> 50.202 Fo&rmat.Capitalize,\ Title\ Case<Tab>F5     :<C-u>call Cream_case_title("v")<CR>
	imenu <silent> 50.203 Fo&rmat.Capitalize,\ UPPERCASE<Tab>Shift+F5 <C-b>:call Cream_case_upper("i")<CR>
	vmenu <silent> 50.204 Fo&rmat.Capitalize,\ UPPERCASE<Tab>Shift+F5 :<C-u>call Cream_case_upper("v")<CR>
	imenu <silent> 50.205 Fo&rmat.Capitalize,\ lowercase<Tab>Alt+F5   <C-b>:call Cream_case_lower("i")<CR>
	vmenu <silent> 50.206 Fo&rmat.Capitalize,\ lowercase<Tab>Alt+F5   :<C-u>call Cream_case_lower("v")<CR>
	"imenu <silent> 50.207 Fo&rmat.Capitalize,\ rEVERSE<Tab>Ctrl+F5    <C-b>:call Cream_case_reverse("i")<CR>
	"vmenu <silent> 50.208 Fo&rmat.Capitalize,\ rEVERSE<Tab>Ctrl+F5    :<C-u>call Cream_case_reverse("v")<CR>

anoremenu <silent> 50.300 Fo&rmat.-Sep300-           <Nul>
	imenu <silent> 50.301 Fo&rmat.Justify,\ Left     <C-b>:call Cream_quickwrap_set("i", "left")<CR>
	vmenu <silent> 50.302 Fo&rmat.Justify,\ Left     :<C-u>call Cream_quickwrap_set("v", "left")<CR>
	imenu <silent> 50.303 Fo&rmat.Justify,\ Center   <C-b>:call Cream_quickwrap_set("i", "center")<CR>
	vmenu <silent> 50.304 Fo&rmat.Justify,\ Center   :<C-u>call Cream_quickwrap_set("v", "center")<CR>
	imenu <silent> 50.305 Fo&rmat.Justify,\ Right    <C-b>:call Cream_quickwrap_set("i", "full")<CR>
	vmenu <silent> 50.306 Fo&rmat.Justify,\ Right    :<C-u>call Cream_quickwrap_set("v", "right")<CR>
	imenu <silent> 50.307 Fo&rmat.Justify,\ Full     <C-b>:call Cream_quickwrap_set("i", "full")<CR>
	vmenu <silent> 50.308 Fo&rmat.Justify,\ Full     :<C-u>call Cream_quickwrap_set("v", "full")<CR>


" utilities
anoremenu <silent> 50.600 Fo&rmat.-Sep600-								<Nul>
	imenu <silent> 50.601 Fo&rmat.Remove\ &Leading\ Whitespace			<C-b>:call Cream_whitespace_trim_leading("i")<CR>
	vmenu <silent> 50.602 Fo&rmat.Remove\ &Leading\ Whitespace			:<C-u>call Cream_whitespace_trim_leading("v")<CR>
	imenu <silent> 50.603 Fo&rmat.&Remove\ Trailing\ Whitespace			<C-b>:call Cream_whitespace_trim_trailing("i")<CR>
	vmenu <silent> 50.604 Fo&rmat.&Remove\ Trailing\ Whitespace			:<C-u>call Cream_whitespace_trim_trailing("v")<CR>
anoremenu <silent> 50.605 Fo&rmat.&Collapse\ All\ Empty\ Lines\ to\ One	:call Cream_emptyline_collapse()<CR>
anoremenu <silent> 50.606 Fo&rmat.&Delete\ All\ Empty\ Lines			:call Cream_emptyline_delete()<CR>
	vmenu <silent> 50.607 Fo&rmat.&Join\ Lines\ (selection)				:<C-u>call Cream_joinlines("v")<CR>
anoremenu <silent> 50.608 Fo&rmat.Con&vert\ Tabs\ To\ Spaces			:call Cream_retab()<CR>

anoremenu <silent> 50.650 Fo&rmat.-Sep50650-							<Nul>
anoremenu <silent> 50.651 Fo&rmat.&File\ Format\.\.\.					:call Cream_fileformat()<CR>

anoremenu <silent> 50.700 Fo&rmat.-Sep50700-			<Nul>


" Vim encodings
"
"    iso-8859-n ISO_8859 variant (n = 2 to 15)
"
"    latin1     8-bit characters (ISO 8859-1)
"    ansi       same as latin1 (obsolete, for backward compatibility)
"
"    cp{number} MS-Windows: any installed double-byte codepage (ex: "8bit-cp1252")
"    cp{number} MS-Windows: any installed single-byte codepage
"    2byte-{name} Unix: any double-byte encoding (Vim specific name)
"    8bit-{name} any 8-bit encoding (Vim specific name)
"
"    big5       traditional Chinese (on Windows alias for cp950)
"    cp950      traditional Chinese (on Unix alias for big5)
"
"    chinese     same as "prc"
"    prc        simplified Chinese: on Unix "euc-cn", on MS-Windows cp936
"    cp936      simplified Chinese (Windows only)
"
"    japan      Japanese: on Unix "euc-jp", on MS-Windows cp932
"    cp932      Japanese (Windows only)
"    euc-jp     Japanese (Unix only)
"
"    korea      Korean: on Unix "euc-kr", on MS-Windows cp949
"    euc-kr     Korean (Unix only)
"    cp949      Korean (Unix and Windows)
"
"    taiwan     traditional Chinese: on Unix "euc-tw", on MS-Windows cp950
"    euc-tw     traditional Chinese (Unix only)
"
"    koi8-r     Russian
"
"    koi8-u     Ukrainian
"
"    ucs-2      16 bit UCS-2 encoded Unicode (ISO/IEC 10646-1)
"    unicode    same as ucs-2
"    ucs2be     same as ucs-2 (big endian)
"    ucs-2be    same as ucs-2 (big endian)
"
"    ucs-2le    like ucs-2, little endian
"
"    utf-16     ucs-2 extended with double-words for more characters
"
"    utf-16le   like utf-16, little endian
"
"    ucs-4      32 bit UCS-4 encoded Unicode (ISO/IEC 10646-1)
"    ucs-4be    same as ucs-4 (big endian)
"
"    ucs-4le    like ucs-4, little endian
"
"    utf-8      32 bit UTF-8 encoded Unicode (ISO/IEC 10646-1)
"    utf8       same as utf-8
"
"    .....................................................................
"    Not available below (not multi-platform)
"
"    euc-cn     simplified Chinese (Unix only)
"
"    sjis       Japanese (Unix only)
"

" General

"
" Note: This list is re-used at print encoding.
"


"   Unicode (UTF-8) --------------------------------------------------
anoremenu <silent> 50.701 Fo&rmat.File\ &Encoding.Unicode.Unicode\ (UTF-8)<Tab>[utf-8\ --\ 32-bit\ Unicode\ (ISO/IEC\ 10646-1)]	:call Cream_fileencoding_set("utf-8")<CR>

anoremenu <silent> 50.702 Fo&rmat.File\ &Encoding.Unicode.-Sep50702-		<Nul>

"   unicode (UCS-2)
anoremenu <silent> 50.703 Fo&rmat.File\ &Encoding.Unicode.Unicode\ (UCS-2)<Tab>[ucs-2\ --\ 16-bit\ Unicode\ (ISO/IEC\ 10646-1)]	:call Cream_fileencoding_set("ucs-2")<CR>
"   unicode (UCS-2le)
anoremenu <silent> 50.704 Fo&rmat.File\ &Encoding.Unicode.Unicode\ (UCS-2le)<Tab>[ucs-2le\ --\ UCS-2,\ little\ endian]	:call Cream_fileencoding_set("ucs-2le")<CR>
"   unicode (UCS-16)
anoremenu <silent> 50.705 Fo&rmat.File\ &Encoding.Unicode.Unicode\ (UTF-16)<Tab>[utf-16\ --\ UCS-2\ extended]	:call Cream_fileencoding_set("utf-16")<CR>
"   unicode (UCS-16le)
anoremenu <silent> 50.706 Fo&rmat.File\ &Encoding.Unicode.Unicode\ (UTF-16le)<Tab>[utf-16le\ --\ UTF-16,\ little\ endian]	:call Cream_fileencoding_set("utf-16le")<CR>
"   unicode (UCS-4)
anoremenu <silent> 50.707 Fo&rmat.File\ &Encoding.Unicode.Unicode\ (UCS-4)<Tab>[ucs-4\ --\ 32\ bit\ Unicode\ (ISO/IEC\ 10646-1)]	:call Cream_fileencoding_set("ucs-4")<CR>
"   unicode (UCS-4le)
anoremenu <silent> 50.708 Fo&rmat.File\ &Encoding.Unicode.Unicode\ (UCS-4le)<Tab>[ucs-4le\ --\ UCS-4,\ little\ endian]	:call Cream_fileencoding_set("ucs-4le")<CR>
"   Unicode (UTF-7)

anoremenu <silent> 50.710 Fo&rmat.File\ &Encoding.-Sep50710-		<Nul>


" Western European ---------------------------------------------------
"   Western (ISO-8859-1)
anoremenu <silent> 50.711 Fo&rmat.File\ &Encoding.Western\ European.Western\ (ISO-8859-1)<Tab>[latin1\ (8-bit\ ANSI)]	:call Cream_fileencoding_set("latin1")<CR>
"   Western (ISO-8859-15)
anoremenu <silent> 50.712 Fo&rmat.File\ &Encoding.Western\ European.Western\ (ISO-8859-15)		:call Cream_fileencoding_set("iso-8859-15")<CR>
"   Western (IBM-850)
"   Western (MacRoman)
"   Western (Windows-1252)
anoremenu <silent> 50.715 Fo&rmat.File\ &Encoding.Western\ European.Western\ (Windows-1252)<Tab>[8bit-cp1252]	:call Cream_fileencoding_set("8bit-cp1252")<CR>
"   Celtic (ISO-8859-14)
anoremenu <silent> 50.716 Fo&rmat.File\ &Encoding.Western\ European.Celtic\ (ISO-8859-14)		:call Cream_fileencoding_set("iso-8859-14")<CR>
"   Greek (ISO-8859-7)
anoremenu <silent> 50.717 Fo&rmat.File\ &Encoding.Western\ European.Greek\ (ISO-8859-7)		:call Cream_fileencoding_set("iso-8859-7")<CR>
"   Greek (MacGreek)
"   Greek (Windows-1253)
anoremenu <silent> 50.719 Fo&rmat.File\ &Encoding.Western\ European.Greek\ (Windows-1253)<Tab>[8bit-cp1253]	:call Cream_fileencoding_set("8bit-cp1253")<CR>
"   Icelandic (MacIcelandic)
"   Nordic (ISO-8859-10)
anoremenu <silent> 50.721 Fo&rmat.File\ &Encoding.Western\ European.Nordic\ (ISO-8859-10)	:call Cream_fileencoding_set("iso-8859-10")<CR>
"   Polish (ISO-8859-2)
anoremenu <silent> 50.722 Fo&rmat.File\ &Encoding.Western\ European.Polish\ (ISO-8859-2)	:call Cream_fileencoding_set("iso-8859-2")<CR>
"   South European (ISO-8859-3)
anoremenu <silent> 50.723 Fo&rmat.File\ &Encoding.Western\ European.South\ European\ (ISO-8859-3)	:call Cream_fileencoding_set("iso-8859-3")<CR>

" East European ------------------------------------------------------
"   Baltic (ISO-8859-4)
anoremenu <silent> 50.724 Fo&rmat.File\ &Encoding.Eastern\ European.Baltic\ (ISO-8859-4)	:call Cream_fileencoding_set("iso-8859-4")<CR>
"   Baltic (ISO-8859-13)
anoremenu <silent> 50.725 Fo&rmat.File\ &Encoding.Eastern\ European.Baltic\ (ISO-8859-13)		:call Cream_fileencoding_set("iso-8859-13")<CR>
"   Baltic (Windows-1257)
anoremenu <silent> 50.726 Fo&rmat.File\ &Encoding.Eastern\ European.Baltic\ (Windows-1257)<Tab>[8bit-cp1257]	:call Cream_fileencoding_set("8bit-cp1257")<CR>
"   Central European (IBM-852)
"   Central European (MacCE)
"   Central European (Windows 1250)
anoremenu <silent> 50.728 Fo&rmat.File\ &Encoding.Eastern\ European.Central\ European\ (Windows-1250)<Tab>[8bit-cp1250]	:call Cream_fileencoding_set("8bit-cp1250")<CR>
"   Croatian (MacCroatian)
"   Cyrillic (IBM-855)
"   Cyrillic (ISO-8859-5)
anoremenu <silent> 50.731 Fo&rmat.File\ &Encoding.Eastern\ European.Cyrillic\ (ISO-8859-5)		:call Cream_fileencoding_set("iso-8859-5")<CR>
"   Cyrillic (ISO-IR-111)
"   Cyrillic (KO18-R)
anoremenu <silent> 50.733 Fo&rmat.File\ &Encoding.Eastern\ European.Cyrillic/Russian\ (KO18-R)<Tab>[koi8-r]	:call Cream_fileencoding_set("koi8-r")<CR>
"   Cyrillic (MacCyrillic)
"   Cyrillic (Windows-1251)
anoremenu <silent> 50.735 Fo&rmat.File\ &Encoding.Eastern\ European.Cyrillic\ (Windows-1251)<Tab>[8bit-cp1251]	:call Cream_fileencoding_set("8bit-cp1251")<CR>
"   Cyrillic/Russian (CP-866)
"   Cyrillic/Ukrainian (KO18-U)
anoremenu <silent> 50.737 Fo&rmat.File\ &Encoding.Eastern\ European.Cyrillic/Ukrainian\ (KO18-U)<Tab>[koi8-u]	:call Cream_fileencoding_set("koi8-u")<CR>
"   Cyrillic/Ukrainian (MacUkrainian)
"   Romanian (ISO-8859-16)
anoremenu <silent> 50.739 Fo&rmat.File\ &Encoding.Eastern\ European.Romanian\ (ISO-8859-16)		:call Cream_fileencoding_set("iso-8859-16")<CR>
"   Romanian (MacRomanian)
"   Armenian (ARMSCII-8)
"   Georgian (GEOSTD8)
"   Thai (TIS-620)
"   Turkish (IBM-857)
"   Turkish (ISO-8859-9)
anoremenu <silent> 50.740 Fo&rmat.File\ &Encoding.Eastern\ European.Turkish\ (ISO-8859-9)		:call Cream_fileencoding_set("iso-8859-9")<CR>
"   Turkish (MacTurkish)
"   Turkish (Windows-1254)
anoremenu <silent> 50.741 Fo&rmat.File\ &Encoding.Eastern\ European.Turkish\ (Windows-1254)<Tab>[8bit-cp1254]	:call Cream_fileencoding_set("8bit-cp1254")<CR>

" Asian --------------------------------------------------------------
"   Simplified Chinese (ISO-2022-CN)
anoremenu <silent> 50.745 Fo&rmat.File\ &Encoding.Asian.Simplified\ Chinese\ (ISO-2022-CN)<Tab>[chinese\ (simplified\ Chinese:\ Unix\ "euc-cn",\ MS-Windows\ "cp936")]	:call Cream_fileencoding_set("chinese")<CR>
"   Chinese Simplified (GB2312)
"   Chinese Simplified (GBK)
"   Chinese Simplified (GB18030)
"   Chinese Simplified (HZ)
"   Chinese Traditional (Big5)
anoremenu <silent> 50.746 Fo&rmat.File\ &Encoding.Asian.Chinese\ Traditional\ (Big5)<Tab>[big5\ (traditional\ Chinese)]	:call Cream_fileencoding_set("big5")<CR>
"   Chinese Traditional (Big5-HKSCS)
"   Chinese Traditional (EUC-TW)
anoremenu <silent> 50.747 Fo&rmat.File\ &Encoding.Asian.Chinese\ Traditional\ (EUC-TW)<Tab>[taiwan\ (Unix\ "euc-tw",\ MS-Windows\ "cp950")]	:call Cream_fileencoding_set("taiwan")<CR>

anoremenu <silent> 50.748 Fo&rmat.File\ &Encoding.Asian.Korean<Tab>[korea\ (Unix\ "euc-kr",\ MS-Windows\ "cp949")]	:call Cream_fileencoding_set("korea")<CR>
"   Korean (EUC-KR)
"   Korean (UHC)
"   Korean (JOHAB)
"   Korean (ISO-2022-KR)

anoremenu <silent> 50.749 Fo&rmat.File\ &Encoding.Asian.Japanese<Tab>[japan\ (Unix\ "euc-jp",\ MS-Windows\ "cp932")]	:call Cream_fileencoding_set("japan")<CR>
"   Japanese (EUC-JP)
"   Japanese (ISO-2022-JP)
"   Japanese (Shift_JIS)

" Thai (ISO-8859-11)
anoremenu <silent> 50.750 Fo&rmat.File\ &Encoding.Asian.Thai\ (ISO-8859-11)		:call Cream_fileencoding_set("iso-8859-11")<CR>


"   Vietnamese (TCVN)
"   Vietnamese (VISCII)
"   Vietnamese (VPS)
"   Vietnamese (Windows-1258)
anoremenu <silent> 50.751 Fo&rmat.File\ &Encoding.Asian.Vietnamese\ (Windows-1258)<Tab>[8bit-cp1258]	:call Cream_fileencoding_set("8bit-cp1258")<CR>
"   Hindi (MacDevanagari)
"   Gujarati (MacGujarati)
"   Gurmukhi (MacGurmukhi)

" Middle Eastern -----------------------------------------------------
"   Arabic (ISO-8859-6)
anoremenu <silent> 50.775 Fo&rmat.File\ &Encoding.Middle\ Eastern.Arabic\ (ISO-8859-6)			:call Cream_fileencoding_set("iso-8859-6")<CR>
"   Arabic (Windows-1256)
anoremenu <silent> 50.776 Fo&rmat.File\ &Encoding.Middle\ Eastern.Arabic\ (Windows-1256)<Tab>[8bit-cp1256]	:call Cream_fileencoding_set("8bit-cp1256")<CR>
"   Arabic (IBM-864)
"   Arabic (MacArabic)
"   Farsi (MacFarsi)
"   Hebrew (ISO-8859-8-I)
"   Hebrew (Windows-1255)
anoremenu <silent> 50.782 Fo&rmat.File\ &Encoding.Middle\ Eastern.Hebrew\ (Windows-1255)<Tab>[8bit-cp1255]	:call Cream_fileencoding_set("8bit-cp1255")<CR>
"   Hebrew Visual (ISO-8859-8)
anoremenu <silent> 50.783 Fo&rmat.File\ &Encoding.Middle\ Eastern.Hebrew\ Visual\ (ISO-8859-8)		:call Cream_fileencoding_set("iso-8859-8")<CR>
"   Hebrew (IBM-862)
"   Hebrew (MacHebrew)


" Character Encoding listing (Mozilla 1.2) {{{1
"
" Western European
"   Western (ISO-8859-1)
"   Western (ISO-8859-15)
"   Western (IBM-850)
"   Western (MacRoman)
"   Western (Windows-1252)
"   Celtic (ISO-8859-14)
"   Greek (ISO-8859-7)
"   Greek (MacGreek)
"   Greek (Windows-1253)
"   Icelandic (MacIcelandic)
"   Nordic (ISO-8859-10)
"   South European (ISO-8859-3)
"
" East European
"   Baltic (ISO-8859-4)
"   Baltic (ISO-8859-13)
"   Baltic (Windows-1257)
"   Central European (IBM-852)
"   Central European (MacCE)
"   Central European (Windows 1250)
"   Croatian (MacCroatian)
"   Cyrillic (IBM-855)
"   Cyrillic (ISO-8859-5)
"   Cyrillic (ISO-IR-111)
"   Cyrillic (KO18-R)
"   Cyrillic (MacCyrillic)
"   Cyrillic (Windows-1251)
"   Cyrillic/Russian (CP-866)
"   Cyrillic/Ukrainian (KO18-U)
"   Cyrillic/Ukrainian (MacUkrainian)
"   Romanian (ISO-8859-16)
"   Romanian (MacRomanian)
"
" East Asian
"   Chinese Simplified (GB2312)
"   Chinese Simplified (GBK)
"   Chinese Simplified (GB18030)
"   Chinese Simplified (HZ)
"   Chinese Traditional (Big5)
"   Chinese Traditional (Big5-HKSCS)
"   Chinese Traditional (EUC-TW)
"   Japanese (EUC-JP)
"   Japanese (ISO-2022-JP)
"   Japanese (Shift_JIS)
"   Korean (EUC-KR)
"   Korean (UHC)
"   Korean (JOHAB)
"   Korean (ISO-2022-KR)
"
" SE & SW Asian
"   Armenian (ARMSCII-8)
"   Georgian (GEOSTD8)
"   Thai (TIS-620)
"   Turkish (IBM-857)
"   Turkish (ISO-8859-9)
"   Turkish (MacTurkish)
"   Turkish (Windows-1254)
"   Vietnamese (TCVN)
"   Vietnamese (VISCII)
"   Vietnamese (VPS)
"   Vietnamese (Windows-1258)
"   Hindi (MacDevanagari)
"   Gujarati (MacGujarati)
"   Gurmukhi (MacGurmukhi)
"
" Middle Eastern
"   Arabic (ISO-8859-6)
"   Arabic (Windows-1256)
"   Arabic (IBM-864)
"   Arabic (MacArabic)
"   Farsi (MacFarsi)
"   Hebrew (ISO-8859-8-I)
"   Hebrew (Windows-1255)
"   Hebrew Visual (ISO-8859-8)
"   Hebrew (IBM-862)
"   Hebrew (MacHebrew)
"
" 1}}}
" vim:foldmethod=marker
