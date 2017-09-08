" Menu Translations:	Simplified Chinese (Windows)
" Translated By:	Ralgh Young <glyoung@users.sourceforge.net>
" Last Change:		Thir Dec 2 11:26:52 CST 2004

" translations for vimcream (http://cream.sourceforge.net)

" Quit when menu translations have already been done.
if exists("did_menu_trans")
  finish
endif
let did_menu_trans = 1

scriptencoding cp936

" File menu
menutrans &File				ÎÄ¼þ(&F)
menutrans &New<Tab>Ctrl+N		ÐÂ½¨(&N)<Tab>Ctrl+N
menutrans &Open\.\.\.			´ò¿ª(&O)\.\.\.
menutrans &Open\ (selection)<Tab>Ctrl+Enter	´ò¿ª¹â±êÏÂÎÄ¼þ<Tab>Ctrl+Enter
menutrans &Close			¹Ø±Õ(&C)
menutrans C&lose\ All			È«²¿¹Ø±Õ(&l)

menutrans &Save<Tab>Ctrl+S		±£´æ(&S)<Tab>Ctrl+S
menutrans Save\ &As\.\.\.		Áí´æÎª(&A)\.\.\.
menutrans Sa&ve\ All\.\.\.		È«²¿±£´æ(&v)\.\.\.
menutrans &Print\.\.\.			´òÓ¡(&P)\.\.\.
menutrans Prin&t\ Setup			´òÓ¡ÉèÖÃ

menutrans E&xit<Tab>Ctrl+F4		ÍË³ö(&X)<Tab>Ctrl+F4

menutrans &Recent\ Files,\ Options	×î½ü´ò¿ªµÄÎÄ¼þ,\ ÉèÖÃ
menutrans Set\ Menu\ Size		ÉèÖÃÀúÊ·¼ÇÂ¼Êý
menutrans Remove\ Invalid		É¾³ýÎÞÐ§Ïî
menutrans Clear\ List			Çå³ýÁÐ±í

" Print Setup
menutrans Paper\ Size			Ö½ÕÅ´óÐ¡
menutrans Paper\ Orientation		Ò³Ãæ·½Ïò
menutrans Margins			±ß¿Õ
menutrans Header			±êÌâ
menutrans Syntax\ Highlighting\.\.\.	Óï·¨¸ßÁÁ
menutrans Line\ Numbering\.\.\.		ÐÐºÅ\.\.\.
menutrans Wrap\ at\ Margins\.\.\.	×Ô¶¯»»ÐÐ\.\.\.
menutrans &Encoding			±àÂë(&E)

" Edit menu
menutrans &Edit				±à¼­(&E)
menutrans &Undo<Tab>Ctrl+Z		»Ö¸´(&U)<Tab>Ctrl+Z
menutrans &Redo<Tab>Ctrl+Y		ÖØ×ö(&R)<Tab>Ctrl+Y

menutrans Cu&t<Tab>Ctrl+X		¼ôÇÐ(&T)<Tab>Ctrl+X
menutrans &Copy<Tab>Ctrl+C		¸´ÖÆ(&C)<Tab>Ctrl+C
menutrans &Paste<Tab>Ctrl+V		Õ³Ìû(&P)<Tab>Ctrl+V

menutrans &Select\ All<Tab>Ctrl+A	È«Ñ¡(&S)<Tab>Ctrl+A
menutrans &Go\ To\.\.\.<Tab>Ctrl+G	Ìøµ½Ö¸¶¨ÐÐ(&G)\.\.\.<Tab>Ctrl+G

menutrans &Find\.\.\.<Tab>Ctrl+F	²éÕÒ(&F)\.\.\.<Tab>Ctrl+F
menutrans &Replace\.\.\.<Tab>Ctrl+H	Ìæ»»(&R)\.\.\.<Tab>Ctrl+H
menutrans &Find<Tab>/			²éÕÒ(&F)<Tab>/
menutrans Find\ and\ Rep&lace<Tab>:%s	²éÕÒ²¢Ìæ»»(&l)<Tab>:%s
menutrans Multi-file\ Replace\.\.\.	¶àÎÄ¼þ²éÕÒ/Ìæ»»\.\.\.

menutrans Fi&nd\ Under\ Cursor		²éÕÒ¹â±êÏÂ±êÊ¶·û
menutrans &Find\ Under\ Cursor<Tab>F3	²éÕÒ<Tab>F3
menutrans &Find\ Under\ Cursor\ (&Reverse)<Tab>Shift+F3		·´Ïò²éÕÒ<Tab>Shift+F3
menutrans &Find\ Under\ Cursor\ (&Case-sensitive)<Tab>Alt+F3	´óÐ¡Ð´Ãô¸Ð<Tab>Alt+F3
menutrans &Find\ Under\ Cursor\ (Cas&e-sensitive,\ Reverse)<Tab>Alt+Shift+F3	´óÐ¡Ð´Ãô¸Ð,·´Ïò²éÕÒ<Tab>Alt+Shift+F3

menutrans Count\ &Word\.\.\.		Í³¼Æ×ÖÊý(&W)\.\.\.
menutrans Cou&nt\ Total\ Words\.\.\.	Í³¼ÆÈ«²¿×ÖÊý(&n)\.\.\.
menutrans Column\ Select<Tab>Alt+Shift+(motion)		ÁÐÑ¡Ôñ<Tab>Alt+Shift+(¹â±ê)

" Insert menu
menutrans &Insert			²åÈë(&I)
menutrans Character\ Line\.\.\.<Tab>Shift+F4	ÕûÐÐÓÃ×Ö·ûÌî³ä\.\.\.<Tab>Shift+F4
menutrans Character\ Line\ (length\ of\ line\ above)\.\.\.<Tab>Shift+F4\ (x2)	ÕûÐÐÓÃ×Ö·ûÌî³ä,ÓëÇ°Ò»ÐÐÍ¬¿í\.\.\.<Tab>Shift+F4\ (x2)
menutrans Date/Time			ÈÕÆÚ/Ê±¼ä

"menutrans Character\ by\ Decimal\ Value<Tab>Alt+,	ÌØÊâ×Ö·û<Tab>Alt+,
"menutrans I&nsert.Character\ by\ Dialog\.\.\.		Ñ¡ÔñÌØÊâ×Ö·û\.\.\.
"menutrans Digraph<Tab>Ctrl+K
"menutrans Digraphs,\ List
"menutrans ASCII\ Table
"menutrans ASCII\ Table,\ List
menutrans Line\ Numbers\ (selection)	ÐÐºÅ(Ñ¡ÖÐ²¿·Ö)



" Format menu
menutrans Fo&rmat			¸ñÊ½(&r)

menutrans &Quick\ Wrap\ (selection\ or\ current\ paragraph)<Tab>Ctrl+Q		¶ÎÂäÖØÅÅ<Tab>Ctrl+Q
menutrans Quick\ &Un-Wrap\ (selection\ or\ current\ paragraph)<Tab>Alt+Q,\ Q	É¾³ý»»ÐÐ(µ±Ç°¶Î)<Tab>Alt+Q,\ Q

menutrans Capitalize,\ Title\ Case<Tab>F5	Ê××ÖÄ¸´óÐ´(&T)<Tab>F5
menutrans Capitalize,\ UPPERCASE<Tab>Shift+F5	È«²¿´óÐ´(&U)<Tab>Shift+F5
menutrans Capitalize,\ lowercase<Tab>Alt+F5	È«²¿Ð¡Ð´(&l)<Tab>Alt+F5
menutrans Capitalize,\ rEVERSE<Tab>Ctrl+F5	´óÐ¡Ð´·´×ª(&I)<Tab>Ctrl+F5

menutrans Justify,\ Left			×ó¶ÔÆë(&L)
menutrans Justify,\ Center			ÖÐ¼ä¶ÔÆë(&C)
menutrans Justify,\ Right			ÓÒ¶ÔÆë(&R)
menutrans Justify,\ Full			×óÓÒ¾ù¶ÔÆë(&F)

menutrans &Remove\ Trailing\ Whitespace É¾³ýÐÐÎ²¿Õ¸ñ(&R)
menutrans Remove\ &Leading\ Whitespace  É¾³ýÐÐÊ×¿Õ¸ñ(&L)
menutrans &Collapse\ All\ Empty\ Lines\ to\ One		É¾³ý¶àÓà¿ÕÐÐ(&C)
menutrans &Delete\ All\ Empty\ Lines	É¾³ýËùÓÐ¿ÕÐÐ(&D)
menutrans &Join\ Lines\ (selection)	ºÏ²¢Ñ¡ÖÐÐÐ(&J)

menutrans Con&vert\ Tabs\ To\ Spaces	½«Tab×ª»¯Îª¿Õ¸ñ

menutrans &File\ Format\.\.\.		ÎÄ¼þ¸ñÊ½(&F)\.\.\.

menutrans File\ &Encoding		ÎÄ¼þ±àÂë(&E)
menutrans Western\ European		Î÷Å·
menutrans Eastern\ European		¶«Å·
menutrans East\ Asian			¶«ÑÇ
menutrans Middle\ Eastern		ÖÐ¶«
menutrans SE\ and\ SW\ Asian		¶«ÄÏÑÇ/Î÷ÑÇ
menutrans Simplified\ Chinese\ (ISO-2022-CN)<Tab>[chinese\ --\ simplified\ Chinese:\ on\ Unix\ "euc-cn",\ on\ MS-Windows\ cp936]	¼òÌåÖÐÎÄ(ISO-2022-CN)<Tab>[Unix:\ "euc-cn",\ Windows:\ cp936]
menutrans Chinese\ Traditional\ (Big5)<Tab>[big5\ --\ traditional\ Chinese]		·±ÌåÖÐÎÄ(´óÎåÂë)<Tab>[Big5]
menutrans Chinese\ Traditional\ (EUC-TW)<Tab>[taiwan\ --\ on\ Unix\ "euc-tw",\ on\ MS-Windows\ cp950]			·±ÌåÖÐÎÄ(EUC-TW)<Tab>[Unix:\ "euc-tw",\ Windows:\ cp950]

" Settings menu
menutrans &Settings			ÉèÖÃ(&S)
menutrans &Show/Hide\ Invisibles<Tab>F4	ÏÔÊ¾/Òþ²Ø²»¿É¼û×Ö·û(&S)<Tab>F4
menutrans Line\ &Numbers\ (toggle)	ÏÔÊ¾/Òþ²ØÐÐºÅ(&N) 

menutrans &Word\ Wrap\ (toggle)<Tab>Ctrl+W	ÕÛÐÐÏÔÊ¾<Tab>Ctrl+W
menutrans A&uto\ Wrap\ (toggle)<Tab>Ctrl+E	×Ô¶¯»»ÐÐ<Tab>Ctrl+E
menutrans &Set\ Wrap\ Width\.\.\.		ÉèÖÃ×Ô¶¯»»ÐÐÎ»ÖÃ(&S)\.\.\.
menutrans &Highlight\ Wrap\ Width\ (toggle)	¸ßÁÁÏÔÊ¾×Ô¶¯»»ÐÐÎ»ÖÃ(&H)

menutrans &Tabstop\ Width\.\.\. 		&Tab¿í¶È\.\.\.
menutrans Tab\ &Expansion\ (toggle)<Tab>Ctrl+T	Tab×Ô¶¯À©Õ¹Îª¿Õ¸ñ(&E)<Tab>Ctrl+T
menutrans &Auto-indent\ (toggle)		×Ô¶¯Ëõ½ø(&A)

menutrans Syntax\ Highlighting\ (toggle)	Óï·¨¸ßÁÁÏÔÊ¾
menutrans Highlight\ Find\ (toggle)		¸ßÁÁÏÔÊ¾²éÕÒ½á¹û
menutrans Highlight\ Current\ Line\ (toggle)	¸ßÁÁÏÔÊ¾µ±Ç°ÐÐ
menutrans &Filetype			ÓïÑÔÀàÐÍ

menutrans &Color\ Themes		É«²ÊÖ÷Ìâ(&C)
menutrans Selection			Ñ¡ÖÐÎÄ×Ö

menutrans P&references			Æ«ºÃ(&r)
menutrans Font\.\.\.			×ÖÌå\.\.\.
menutrans Toolbar\ (toggle)		ÏÔÊ¾/Òþ²Ø¹¤¾ßÌõ
"menutrans Last\ File\ Restore\ Off
"menutrans Last\ File\ Restore\ On

menutrans &Middle-Mouse\ Disabled	Êó±êÖÐ¼ü:\ ÒÑ½ûÓÃ
menutrans &Middle-Mouse\ Pastes		Êó±êÖÐ¼ü:\ Õ³Ìù

menutrans Bracket\ Flashing\ Off	À¨ºÅÆ¥ÅäÉÁË¸:\ ¹Ø±Õ
menutrans Bracket\ Flashing\ On		À¨ºÅÆ¥ÅäÉÁË¸:\ ´ò¿ª
menutrans Info\ Pop\ Options\.\.\.	×Ô¶¯Íê³ÉÌáÊ¾ÉèÖÃ\.\.\.

menutrans &Expert\ Mode\.\.\.		×¨¼ÒÄ£Ê½(&E)\.\.\.
menutrans &Behavior			ÐÐÎªÄ£Ê½(&B)

" Tools menu
menutrans &Tools			¹¤¾ß(&T)

menutrans &Spell\ Check			Æ´Ð´¼ì²é
menutrans Next\ Spelling\ Error<Tab>F7			ÏÂÒ»¸ö´íÎó<Tab>F7
menutrans Previous\ Spelling\ Error<Tab>Shift+F7	ÉÏÒ»¸ö´íÎó<Tab>Shift+F7
menutrans Show\ Spelling\ Errors\ (toggle)<Tab>Alt+F7	ÏÔÊ¾È«²¿Æ´Ð´´íÎó<Tab>Alt+F7
menutrans Add\ Word\ (under\ cursor)\ to\ Dictionary<Tab>Ctrl+F7	½«µ±Ç°µ¥´Ê¼ÓÈë´Êµä<Tab>Ctrl+F7
menutrans Language\.\.\.		ÓïÑÔ\.\.\.
menutrans Options\.\.\.			Ñ¡Ïî\.\.\.

menutrans &Bookmarks			ÊéÇ©(&B)
menutrans Bookmark\ Next<Tab>F2		ÏÂÒ»¸öÊéÇ©<Tab>F2
menutrans Bookmark\ Previous<Tab>Shift+F2	ÉÏÒ»¸öÊéÇ©<Tab>Shift+F2	
menutrans Bookmark\ Set\ (toggle)<Tab>Alt+F2	ÉèÖÃÊéÇ©<Tab>Alt+F2
menutrans Delete\ All\ Bookmarks<Tab>Alt+Shift+F2	É¾³ýËùÓÐÊéÇ©<Tab>Alt+Shift+F2

menutrans Block\ Comment\ (selection)<Tab>F6		Ìí¼Ó×¢ÊÍ<Tab>F6
menutrans Block\ Un-Comment\ (selection)<Tab>Shift+F6	É¾³ý×¢ÊÍ<Tab>Shift+F6

menutrans Macro\ Play<Tab>F8				»Ø·Åºê<Tab>F8
menutrans Macro\ Record\ (toggle)<Tab>Shift+F8		¿ªÊ¼/Í£Ö¹Â¼ÖÆºê<Tab>Shift+F8

menutrans &Diff\ Mode			ÎÄ¼þ±È½ÏÄ£Ê½(&D)

menutrans &Folding			´úÂëÕÛµþ(&F)
menutrans &Fold\ Open/Close<Tab>F9	ÕÛµþ/´ò¿ª<Tab>F9
menutrans &Fold\ Open/Close<Tab>Shift+F9	ÕÛµþ/´ò¿ª<Tab>Shift+F9
"menutrans &Set\ Fold\ (Selection)<Tab>F9
menutrans &Open\ All\ Folds<Tab>Ctrl+F9		´ò¿ªËùÓÐÕÛµþ<Tab>Ctrl+F9
menutrans &Close\ All\ Folds<Tab>Ctrl+Shift+F9	¹Ø±ÕËùÓÐÕÛµþ<Tab>Ctrl+Shift+F9
menutrans &Delete\ Fold\ at\ Cursor<Tab>Alt+F9	É¾³ý¹â±ê´¦ÕÛµþ<Tab>Alt+F9
menutrans D&elete\ All\ Folds<Tab>Alt+Shift+F9	É¾³ýËùÓÐÕÛµþ<Tab>Alt+Shift+F9

menutrans &Completion			×Ô¶¯Íê³É(&C)

menutrans &Tag\ Navigation		&Tagµ¼º½
menutrans &Jump\ to\ Tag\ (under\ cursor)<Tab>Alt+Down	Ìø×ªµ½´Ë±ê¼Ç<Tab>Alt+Down
menutrans &Close\ and\ Jump\ Back<Tab>Alt+Up		¹Ø±Õ²¢»Øµ½Ç°Ò»Î»ÖÃ<Tab>Alt+Up
menutrans &Previous\ Tag<Tab>Alt+Left			Ç°Ò»±ê¼Ç<Tab>Alt+Left
menutrans &Next\ Tag<Tab>Alt+Right			ºóÒ»±ê¼Ç<Tab>Alt+Right
menutrans &Tag\ Listing\.\.\.<Tab>Ctrl+Alt+Down	ÁÐ³öËùÓÐ±ê¼Ç\.\.\.<Tab>Ctrl+Alt+Down

menutrans Add-ons\ E&xplore\ (Map/Unmap)	²å¼þ¹ÜÀí/¿ì½Ý¼üÓ³Éä(&x)

" Add-ons
menutrans Color\ Invert			·´×ªHTMLÑÕÉ«Öµ
menutrans Convert			×ª»»
menutrans Sort				ÅÅÐò
menutrans Encrypt			¼ÓÃÜ
menutrans Highlight\ Control\ Characters	¸ßÁÁÏÔÊ¾¿ØÖÆ×Ö·û
menutrans Highlight\ Multibyte		¸ßÁÁÏÔÊ¾¶à×Ö½Ú×Ö·û
menutrans Stamp\ Time			²åÈëÊ±¼ä´Á


" Window menu
menutrans &Window				´°¿Ú(&W)
menutrans Maximize\ (&Single)			×î´ó»¯(&S)
menutrans Minimize\ (Hi&de)			×îÐ¡»¯/Òþ²Ø(&d)
menutrans Tile\ &Vertical			´¹Ö±Æ½ÆÌ
menutrans Tile\ Hori&zontal			Ë®Æ½Æ½ÆÌ
menutrans Sizes\ E&qual				ÏàÍ¬´óÐ¡(&q)
menutrans Height\ Max\ &=			×î´ó¸ß¶È(&=)
menutrans Height\ Min\ &-			×îÐ¡¸ß¶È(&-)
menutrans &Width\ Max				×î´ó¿í¶È(&W)
menutrans Widt&h\ Min				×îÐ¡¿í¶È(&h)
menutrans Split\ New\ Pane\ Vertical		×ÝÏò·Ö¸îÐÂ´°¿Ú
menutrans Split\ New\ Pane\ Horizontal		ºáÏò·Ö¸îÐÂ´°¿Ú	
menutrans Split\ Existing\ Vertically		×ÝÏò·Ö¸îµ±Ç°´°¿Ú
menutrans Split\ Existing\ Horizontally		ºáÏò·Ö¸îµ±Ç°´°¿Ú
menutrans Start\ New\ Vim\ Ins&tance		¿ªÆôÐÂÊµÀý(&t)

menutrans File\ Tr&ee				Ä¿Â¼Ê÷(&e)
menutrans File\ E&xplorer\ (obsolete)		ÎÄ¼þä¯ÀÀÆ÷(&x)
menutrans &Calendar\ (toggle)<Tab>Ctrl+F11	ÏÔÊ¾/Òþ²ØÈÕÀú<Tab>Ctrl+F11

" Help menu
menutrans &Help			°ïÖú(&H)

menutrans &Vim\ Help		VIM°ïÖú
menutrans &Overview<Tab>F1	×ÜÀÀ(&O)<Tab>F1
menutrans &User\ Manual		ÓÃ»§ÊÖ²á(&U)
menutrans &GUI			Í¼ÐÎ½çÃæ(&G)
menutrans &How-to\ links	HOWTOÎÄµµ\.\.\.(&H)
menutrans &Credits		×÷Õß(&C)
menutrans Co&pying		°æÈ¨(&P)
menutrans &Version\.\.\.	°æ±¾(&V)\.\.\.
menutrans &About\.\.\.		¹ØÓÚ\ Vim(&A)

menutrans &About\ Cream\.\.\.	¹ØÓÚ\ Cream\.\.\.

" Popup menu
menutrans Select\ &All		È«Ñ¡(&A)
menutrans Cu&t			¼ôÇÐ(&t)
menutrans &Copy			¿½±´(&C)
menutrans &Paste		Õ³Ìù(&P)
menutrans &Delete		É¾³ý(&D)


" Toolbar #FIXME: not work?
menutrans New\ File		ÐÂ½¨ÎÄ¼þ
menutrans Open			´ò¿ª
menutrans Save			±£´æ
menutrans Save\ As		Áí´æÎª
menutrans Close			¹Ø±Õ
menutrans Exit\ Vim		ÍË³öVim
menutrans Print			´òÓ¡
menutrans Undo			»Ö¸´
menutrans Redo			ÖØ×ö
menutrans Cut\ (to\ Clipboard)	¼ôÇÐµ½¼ôÌù°å
menutrans Copy\ (to\ Clipboard)	¿½±´µ½¼ôÌù°å
menutrans Paste\ (from\ Clipboard)	´Ó¼ôÌù°åÕ³Ìù


" The GUI toolbar
if has("toolbar")
  if exists("*Do_toolbar_tmenu")
    delfun Do_toolbar_tmenu
  endif
  fun Do_toolbar_tmenu()
    tmenu ToolBar.new		ÐÂ½¨ÎÄ¼þ
    tmenu ToolBar.Open		´ò¿ªÎÄ¼þ
    tmenu ToolBar.Save		±£´æµ±Ç°ÎÄ¼þ
    tmenu ToolBar.SaveAll	±£´æÈ«²¿ÎÄ¼þ
    tmenu ToolBar.Print		´òÓ¡
    tmenu ToolBar.Undo		³·ÏúÉÏ´ÎÐÞ¸Ä
    tmenu ToolBar.Redo		ÖØ×öÉÏ´Î³·ÏúµÄ¶¯×÷
    tmenu ToolBar.Cut		¼ôÇÐÖÁ¼ôÌù°å
    tmenu ToolBar.Copy		¸´ÖÆµ½¼ôÌù°å
    tmenu ToolBar.Paste		ÓÉ¼ôÌù°åÕ³Ìû
    tmenu ToolBar.Find		²éÕÒ...
    tmenu ToolBar.FindNext	²éÕÒÏÂÒ»¸ö
    tmenu ToolBar.FindPrev	²éÕÒÉÏÒ»¸ö
    tmenu ToolBar.Replace	Ìæ»»...
    tmenu ToolBar.LoadSesn	¼ÓÔØ»á»°
    tmenu ToolBar.SaveSesn	±£´æµ±Ç°µÄ»á»°
    tmenu ToolBar.RunScript	ÔËÐÐVim½Å±¾
    tmenu ToolBar.Make		Ö´ÐÐ Make
    tmenu ToolBar.Shell		´ò¿ªÒ»¸öÃüÁî´°¿Ú
    tmenu ToolBar.RunCtags	Ö´ÐÐ ctags
    tmenu ToolBar.TagJump	Ìøµ½µ±Ç°¹â±êÎ»ÖÃµÄ±êÇ©
    tmenu ToolBar.Help		Vim °ïÖú
    tmenu ToolBar.FindHelp	²éÕÒ Vim °ïÖú
  endfun
endif


" vim:fileencoding=cp936:encoding=cp936
