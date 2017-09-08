" Menu Translations:	Korean (Windows)
" Translated By:	Hanjo Kim <lordmiss@gmail.com>
" Last Change:		Wed Oct 25 10:04:52 KST 2006

" translations for vimcream (http://cream.sourceforge.net)

" Quit when menu translations have already been done.
if exists("did_menu_trans")
  finish
endif
let did_menu_trans = 1

scriptencoding cp949

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &File				ÆÄÀÏ(&F)
menutrans &New<Tab>Ctrl+N		»õ\ ÆÄÀÏ(&N)<Tab>Ctrl+N
menutrans &Open\.\.\.			¿­±â(&O)\.\.\.
menutrans &Open\ (selection)<Tab>Ctrl+Enter	¼±ÅÃÇÑ\ ÆÄÀÏ\ ¿­±â<Tab>Ctrl+Enter
menutrans &Open\ (Read-Only)\.\.\.	ÀĞ±â\ Àü¿ëÀ¸·Î\ ¿­±â\.\.\.
menutrans &Close\ File			´İ±â
menutrans C&lose\ All\ Files		¸ğµÎ\ ´İ±â

menutrans &Save<Tab>Ctrl+S		ÀúÀå(&S)<Tab>Ctrl+S
menutrans Save\ &As\.\.\.		»õ\ ÀÌ¸§À¸·Î ÀúÀå(&A)\.\.\.
menutrans Sa&ve\ All\.\.\.		¸ğµÎ\ ÀúÀå(&v)\.\.\.
menutrans &Print\.\.\.			ÀÎ¼â(&P)\.\.\.
menutrans Prin&t\ Setup			ÀÎ¼â\ ¼³Á¤
menutrans Save\ All\ and\ &Exit		¸ğµÎ\ ÀúÀåÇÏ°í\ ³¡³»±â

menutrans E&xit<Tab>Ctrl+F4		³¡³»±â(&X)<Tab>Ctrl+F4

menutrans &Recent\ Files,\ Options	ÃÖ±ÙÆÄÀÏ,\ ¿É¼Ç
menutrans Set\ Menu\ Size		¸Ş´º\ Å©±â\ ¼³Á¤
menutrans Remove\ Invalid		Àß¸øµÈ\ Ç×¸ñ\ Áö¿ì±â
menutrans Clear\ List			¸ñ·Ï\ ºñ¿ì±â

" Print Setup
menutrans Paper\ Size			Á¾ÀÌ\ Å©±â
menutrans Paper\ Orientation		Á¾ÀÌ\ ¹æÇâ
menutrans Margins			¿©¹é
menutrans Header			¸Ó¸®±Û
menutrans Syntax\ Highlighting\.\.\.	±¸¹®\ °­Á¶
menutrans Line\ Numbering\.\.\.		ÁÙ¹øÈ£\.\.\.
menutrans Wrap\ at\ Margins\.\.\.	¿©¹é¿¡¼­\ µé¿©¾²±â\.\.\.
menutrans &Encoding			ÀÎÄÚµù(&E)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Edit menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Edit				ÆíÁı(&E)
menutrans &Undo<Tab>Ctrl+Z		µÇµ¹¸®±â(&U)<Tab>Ctrl+Z
menutrans &Redo<Tab>Ctrl+Y		´Ù½ÃÇÏ±â(&R)<Tab>Ctrl+Y

menutrans Cu&t<Tab>Ctrl+X		Àß¶ó³»±â(&T)<Tab>Ctrl+X
menutrans &Copy<Tab>Ctrl+C		º¹»ç(&C)<Tab>Ctrl+C
menutrans &Paste<Tab>Ctrl+V		ºÙ¿©³Ö±â(&P)<Tab>Ctrl+V

menutrans &Select\ All<Tab>Ctrl+A	¸ğµÎ\ ¼±ÅÃ(&S)<Tab>Ctrl+A
menutrans &Go\ To\.\.\.<Tab>Ctrl+G	ÀÌµ¿(&G)\.\.\.<Tab>Ctrl+G

menutrans &Find\.\.\.<Tab>Ctrl+F	Ã£±â(&F)\.\.\.<Tab>Ctrl+F
menutrans &Replace\.\.\.<Tab>Ctrl+H	¹Ù²Ù±â(&R)\.\.\.<Tab>Ctrl+H
menutrans &Find<Tab>/			Ã£±â(&F)<Tab>/
menutrans Find\ and\ Rep&lace<Tab>:%s	Ã£¾Æ\ ¹Ù²Ù±â(&l)<Tab>:%s
menutrans Multi-file\ Replace\.\.\.	¿©·¯\ ÆÄÀÏ¿¡¼­\ ¹Ù²Ù±â\.\.\.

menutrans Fi&nd\ Under\ Cursor		Ä¿¼­\ À§Ä¡¿¡¼­\ Ã£±â
menutrans &Find\ Under\ Cursor<Tab>F3	Ã£±â<Tab>F3
menutrans &Find\ Under\ Cursor\ (&Reverse)<Tab>Shift+F3		¿ª¹æÇâÀ¸·Î\ Ã£±â<Tab>Shift+F3
menutrans &Find\ Under\ Cursor\ (&Case-sensitive)<Tab>Alt+F3	´ë¼Ò¹®ÀÚ\ ±¸º°ÇÏ¿©\ Ã£±â<Tab>Alt+F3
menutrans &Find\ Under\ Cursor\ (Cas&e-sensitive,\ Reverse)<Tab>Alt+Shift+F3	´ë¼Ò¹®ÀÚ\ ±¸º°ÇÏ¿©\ ¿ª¹æÇâÀ¸·Î Ã£±â<Tab>Alt+Shift+F3

menutrans Count\ &Word\.\.\.		´Ü¾î\ ¼ö\ ¼¼±â(&W)\.\.\.
menutrans Cou&nt\ Total\ Words\.\.\.	ÀüÃ¼\ ´Ü¾î\ ¼ö\ ¼¼±â(&n)\.\.\.
menutrans Column\ Select<Tab>Alt+Shift+(motion)		ÄÃ·³\ ¼±ÅÃ<Tab>Alt+Shift+(¿òÁ÷ÀÓ)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Insert			»ğÀÔ(&I)
menutrans Character\ Line\.\.\.<Tab>Shift+F4	¹®ÀÚ\ Çà\.\.\.<Tab>Shift+F4
menutrans Character\ Line\ (length\ of\ line\ above)\.\.\.<Tab>Shift+F4\ (x2)	¹®ÀÚ\ Çà\ (À­\ ÇàÀÇ\ ±æÀÌ·Î)\.\.\.<Tab>Shift+F4\ (x2)
menutrans Date/Time\.\.\.<Tab>F11			³¯Â¥/½Ã°£\.\.\.<Tab>F11
menutrans Date/Time\ (Last\ Used)<Tab>F11\ (2x)	³¯Â¥/½Ã°£\ (Áö³­¹ø)<Tab>F11\ (2x)
menutrans Character\ by\ Value<Tab>Alt+,	¹®ÀÚ¸¦\ °ªÀ¸·Î<Tab>Alt+,
menutrans List\ Characters\ Available\.\.\.<Tab>Alt+,\ (x2)	 ÀÔ·Â\ °¡´ÉÇÑ\ ¹®ÀÚ\.\.\.<Tab>Alt+,\ (x2)
menutrans List\ Character\ Values\ Under\ Cursor<Tab>Alt+\.	Ä¿¼­\ À§Ä¡ÀÇ\ ¹®ÀÚ°ª<Tab>Alt+\.
"menutrans Character\ by\ Dialog\.\.\.		´ëÈ­Ã¢À¸·Î\ ¹®ÀÚ\ »ğÀÔ\.\.\.
menutrans Character\ by\ Digraph<Tab>Ctrl+K	ÀÌÁßÀÚ<Tab>Ctrl+K
menutrans List\ Digraphs\ Available\.\.\.<Tab>Ctrl+K\ (x2)	ÀÌÁßÀÚ\ ¸ñ·Ï\.\.\.<Tab>Ctrl+K\ (x2)
menutrans Text\ Filler\.\.\.	±Û\ Ã¤¿ì±â
"menutrans ASCII\ Table			¾Æ½ºÅ°\ Ç¥
"menutrans ASCII\ Table,\ List		¾Æ½ºÅ°\ Ç¥,\ ¸®½ºÆ®
menutrans Line\ Numbers\.\.\.\ (selection)	ÁÙ¹øÈ£(¼±ÅÃ)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Format menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans Fo&rmat			Æ÷¸Ë(&r)

menutrans &Quick\ Wrap\ (selection\ or\ current\ paragraph)<Tab>Ctrl+Q		ÀÚµ¿\ ÁÙ¹Ù²Ş<Tab>Ctrl+Q
menutrans Quick\ &Un-Wrap\ (selection\ or\ current\ paragraph)<Tab>Alt+Q,\ Q	É¾ÀÚµ¿\ ÁÙ¹Ù²Ş\ ÇØÁ¦<Tab>Alt+Q,\ Q

menutrans Capitalize,\ Title\ Case<Tab>F5	´ë¼Ò¹®ÀÚÀüÈ¯,\ Ã¹\ ±ÛÀÚ¸¸\ ´ë¹®ÀÚ·Î(&T)<Tab>F5
menutrans Capitalize,\ UPPERCASE<Tab>Shift+F5	´ë¼Ò¹®ÀÚÀüÈ¯,\ ¸ğµÎ\ ´ë¹®ÀÚ·Î(&U)<Tab>Shift+F5
menutrans Capitalize,\ lowercase<Tab>Alt+F5	´ë¼Ò¹®ÀÚÀüÈ¯,\ ¸ğµÎ\ ¼Ò¹®ÀÚ·Î(&l)<Tab>Alt+F5
menutrans Capitalize,\ rEVERSE<Tab>Ctrl+F5	´ë¼Ò¹®ÀÚÀüÈ¯,\ Ã¹\ ±ÛÀÚ¸¸\ ¼Ò¹®ÀÚ·Î(&I)<Tab>Ctrl+F5

menutrans Justify,\ Left			Á¤·Ä,\ ¿ŞÂÊ(&L)
menutrans Justify,\ Center			Á¤·Ä,\ °¡¿îµ¥(&C)
menutrans Justify,\ Right			Á¤·Ä,\ ¿À¸¥ÂÊ(&R)
menutrans Justify,\ Full			Á¤·Ä,\ ¹èºĞ(&F)

menutrans &Remove\ Trailing\ Whitespace É¾ÁÙ\ ³¡ÀÇ\ °ø¹é\ Áö¿ì±â(&R)
menutrans Remove\ &Leading\ Whitespace  É¾ÁÙ\ Ã³À½ÀÇ\ °ø¹é\ Áö¿ì±â(&L)
menutrans &Collapse\ All\ Empty\ Lines\ to\ One		É¾ºó\ ÁÙ\ ¿©·¯\ °³¸¦\ ÇÑ\ ÁÙ·Î(&C)
menutrans &Delete\ All\ Empty\ Lines	É¾¸ğµç\ ºó\ ÁÙ\ »èÁ¦(&D)
menutrans &Join\ Lines\ (selection)	ÁÙ\ ÇÕÄ¡±â(&J)

menutrans Con&vert\ Tabs\ To\ Spaces	ÅÇÀ»\ °ø¹éÀ¸·Î

menutrans &File\ Format\.\.\.		ÆÄÀÏ\ Æ÷¸Ë(&F)\.\.\.

menutrans File\ &Encoding		ÆÄÀÏ\ ÀÎÄÚµù(&E)
menutrans Asian				¾Æ½Ã¾Æ¾î
menutrans Unicode			À¯´ÏÄÚµå
menutrans Western\ European		¼­À¯·´¾î
menutrans Eastern\ European		µ¿À¯·´¾î
menutrans East\ Asian			µ¿¾Æ½Ã¾Æ¾î
menutrans Middle\ Eastern		Áß¾Ó¾Æ½Ã¾Æ¾î
menutrans SE\ and\ SW\ Asian		³²µ¿/³²¼­¾Æ½Ã¾Æ¾î

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Settings			¼³Á¤(&S)
menutrans &Show/Hide\ Invisibles\ (toggle)<Tab>F4	º¸ÀÌ±â/°¨Ãß±â(&S)\ (toggle)<Tab>F4
menutrans Line\ &Numbers\ (toggle)	ÁÙ¹øÈ£(&N)\ (toggle)

menutrans &Word\ Wrap<Tab>Ctrl+W	ÁÙ¹Ù²Ş<Tab>Ctrl+W
menutrans A&uto\ Wrap<Tab>Ctrl+E	ÀÚµ¿\ ÁÙ¹Ù²Ş<Tab>Ctrl+E
menutrans &Set\ Wrap\ Width\.\.\.		ÁÙ¹Ù²Ş\ ³ĞÀÌ\ ¼³Á¤(&S)\.\.\.
menutrans &Highlight\ Wrap\ Width\ (toggle)	ÁÙ¹Ù²Ş\ ³ĞÀÌ\ º¸ÀÌ±â(&H)

menutrans &Tabstop\ Width\.\.\. 		ÅÇ\ ³ĞÀÌ\.\.\.
menutrans Tab\ &Expansion\ (toggle)<Tab>Ctrl+T	ÅÇ\ È®Àå(&E)<Tab>Ctrl+T
menutrans &Auto-indent\ (toggle)		ÀÚµ¿\ µé¿©¾²±â(&A)

menutrans Syntax\ Highlighting\ (toggle)	¹®¹ı\ °­Á¶
menutrans Highlight\ Find\ (toggle)		°Ë»ö\ °á°ú\ °­Á¶
menutrans Highlight\ Current\ Line\ (toggle)	ÇöÀç\ ÁÙ\ °­Á¶
menutrans &Filetype			ÆÄÀÏ\ Á¾·ù

menutrans &Color\ Themes		»ö\ ½ºÅ´(&C)
menutrans Selection			¼±ÅÃ

menutrans P&references			¼³Á¤(&r)
menutrans Font\.\.\.			±Û²Ã\.\.\.
menutrans Toolbar\ (toggle)		Åø¹Ù
menutrans Last\ File\ Restore\ Off	Áö³­\ ÆÄÀÏ\ º¹±¸\ ¾ÈÇÔ
menutrans Last\ File\ Restore\ On	Áö³­\ ÆÄÀÏ\ º¹±¸\ ÇÔ

menutrans &Middle-Mouse\ Disabled	¸¶¿ì½º\ °¡¿îµ¥\ ¹öÆ°\ »ç¿ë¾ÈÇÔ
menutrans &Middle-Mouse\ Pastes		¸¶¿ì½º\ °¡¿îµ¥\ ¹öÆ°\ ºÙ¿©³Ö±â

menutrans Bracket\ Flashing\ Off	°ıÈ£\ ±ôºıÀÓ\ ²ô±â
menutrans Bracket\ Flashing\ On		°ıÈ£\ ±ôºıÀÓ\ ÄÑ±â
menutrans Info\ Pop\ Options\.\.\.	ÆË\ ¿É¼Ç\ Á¤º¸\.\.\.

menutrans &Expert\ Mode\.\.\.		Àü¹®°¡\ ¸ğµå(&E)\.\.\.
menutrans &Behavior			¿òÁ÷ÀÓ(&B)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tools menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Tools			µµ±¸(&T)

menutrans &Spell\ Check			¸ÂÃã¹ü\ °Ë»ç
menutrans Next\ Spelling\ Error<Tab>F7			´ÙÀ½\ ¸ÂÃã¹ı\ ¿¡·¯<Tab>F7
menutrans Previous\ Spelling\ Error<Tab>Shift+F7	ÀÌÀü\ ¸ÂÃã¹ı\ ¿¡·¯<Tab>Shift+F7
menutrans Show\ Spelling\ Errors\ (toggle)<Tab>Alt+F7	¸ÂÃã¹ı\ ¿¡·¯\ º¸ÀÌ±â<Tab>Alt+F7
menutrans Add\ Word\ (under\ cursor)\ to\ Dictionary<Tab>Ctrl+F7	¼±ÅÃ\ ´Ü¾î\ »çÀü¿¡\ ³Ö±â<Tab>Ctrl+F7
menutrans Language\.\.\.		¾ğ¾î\.\.\.
menutrans Options\.\.\.			¿É¼Ç\.\.\.

menutrans &Bookmarks			ºÏ¸¶Å©(&B)
menutrans Bookmark\ Next<Tab>F2		´ÙÀ½\ ºÏ¸¶Å©<Tab>F2
menutrans Bookmark\ Previous<Tab>Shift+F2	ÉÏÀÌÀü\ ºÏ¸¶Å©<Tab>Shift+F2	
menutrans Bookmark\ Set\ (toggle)<Tab>Alt+F2	ÉèºÏ¸¶Å©\ ¸ğÀ½<Tab>Alt+F2
menutrans Delete\ All\ Bookmarks<Tab>Alt+Shift+F2	É¾¸ğµç\ ºÏ¸¶Å©\ »èÁ¦<Tab>Alt+Shift+F2

menutrans Block\ Comment\ (selection)<Tab>F6		¼±ÅÃ¿µ¿ª\ ÄÚ¸àÆ®·Î<Tab>F6
menutrans Block\ Un-Comment\ (selection)<Tab>Shift+F6	É¾¼±ÅÃ¿µ¿ª\ ÄÚ¸àÆ®\ Ç®±â<Tab>Shift+F6

menutrans Macro\ Play<Tab>F8				¸ÅÅ©·Î\ ½ÇÇà<Tab>F8
menutrans Macro\ Record\ (toggle)<Tab>Shift+F8		¸ÅÅ©·Î\ ±â·Ï<Tab>Shift+F8

menutrans &Diff\ Mode			ºñ±³\ ¸ğµå(&D)

menutrans &Folding			Á¢±â(&F)
menutrans &Fold\ Open/Close<Tab>F9	Á¢±â\ ¿­±â/´İ±â<Tab>F9
menutrans &Fold\ Open/Close<Tab>Shift+F9	Á¢±â\ ¿­±â/´İ±â<Tab>Shift+F9
menutrans &Set\ Fold\ (Selection)<Tab>F9	Á¢±â\ ¼³Á¤
menutrans &Open\ All\ Folds<Tab>Ctrl+F9		¸ğµç\ Á¢±â\ ¿­±â<Tab>Ctrl+F9
menutrans &Close\ All\ Folds<Tab>Ctrl+Shift+F9	¸ğµç\ Á¢±â\ ´İ±â<Tab>Ctrl+Shift+F9
menutrans &Delete\ Fold\ at\ Cursor<Tab>Alt+F9	É¾Ä¿¼­\ À§Ä¡¿¡¼­\ Á¢±â\ »èÁ¦<Tab>Alt+F9
menutrans D&elete\ All\ Folds<Tab>Alt+Shift+F9	É¾¸ğµç\ Á¢±â\ »èÁ¦<Tab>Alt+Shift+F9

menutrans &Completion			ÀÚµ¿¿Ï¼º(&C)

menutrans &Tag\ Navigation		ÅÇ\ ÀÌµ¿
menutrans &Jump\ to\ Tag\ (under\ cursor)<Tab>Alt+Down	ÅÂ±×·Î\ ÀÌµ¿<Tab>Alt+Down
menutrans &Close\ and\ Jump\ Back<Tab>Alt+Up		´İ°í\ µÚ·Î\ ÀÌµ¿<Tab>Alt+Up
menutrans &Previous\ Tag<Tab>Alt+Left			ÀÌÀü\ ÅÂ±×<Tab>Alt+Left
menutrans &Next\ Tag<Tab>Alt+Right			´ÙÀ½\ ÅÂ±×<Tab>Alt+Right
menutrans &Tag\ Listing\.\.\.<Tab>Ctrl+Alt+Down		ÅÂ±×\ ¸®½ºÆ®\.\.\.<Tab>Ctrl+Alt+Down

menutrans Add-ons\ E&xplore\ (Map/Unmap)	Ãß°¡±â´É\ Å½»ö(&x)

" Add-ons
menutrans &Add-ons	±âÅ¸
menutrans Color\ Invert			»ö\ ¹İÀü
menutrans Convert			º¯È¯
menutrans Cream\ Config\ Info	Å©¸²\ ¼³Á¤\ Á¤º¸
menutrans Cream\ Devel	 Å©¸²\ °³¹ß
menutrans Fold\ Vim\ Functions	Vim\ ÇÔ¼ö\ Á¢±â
menutrans Ctags\ Generate	Ctags\ »ı¼º
menutrans Daily\ Read	¸ÅÀÏ\ ÀĞ±â
menutrans De-binary	¹ÙÀÌ³Ê¸®\ ÇØÁ¦
menutrans &Email\ Prettyfier	ÀÌ¸ŞÀÏ\ ²Ù¹Ì±â
menutrans Sort				Á¤·Ä
menutrans Encrypt			¾ÏÈ£È­
menutrans Highlight\ Control\ Characters	Á¦¾î¹®ÀÚ\ ÇÏÀÌ¶óÀÌÆ®
menutrans Highlight\ Multibyte		¸ÖÆ¼¹ÙÀÌÆ®\ ÇÏÀÌ¶óÀÌÆ®
menutrans Stamp\ Time			½Ã°£\ Ç¥½Ã

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Window				Ã¢(&W)
menutrans Maximize\ (&Single)			ÃÖ´ëÈ­(&S)
menutrans Minimize\ (Hi&de)			ÃÖ¼ÒÈ­(&d)
menutrans Tile\ &Vertical			¼¼·Î·Î\ Á¤·Ä
menutrans Tile\ Hori&zontal			°¡·Î·Î\ Á¤·Ä
menutrans Sizes\ E&qual				°°Àº\ Å©±â·Î(&q)
menutrans Height\ Max\ &=			ÃÖ´ë³ôÀÌ(&=)
menutrans Height\ Min\ &-			ÃÖ¼Ò³ôÀÌ(&-)
menutrans &Width\ Max				ÃÖ´ë³ĞÀÌ(&W)
menutrans Widt&h\ Min				ÃÖ¼Ò³ĞÀÌ(&h)
menutrans Split\ New\ Pane\ Vertical		»õ\ Ã¢À»\ ¼¼·Î·Î\ ³ª´®
menutrans Split\ New\ Pane\ Horizontal		»õ\ Ã¢À»\ °¡·Î·Î\ ³ª´®
menutrans Split\ Existing\ Vertically		ÇöÀç\ Ã¢À»\ ¼¼·Î·Î\ ³ª´®
menutrans Split\ Existing\ Horizontally		ÇöÀç\ Ã¢À»\ °¡·Î·Î\ ³ª´®
menutrans Start\ New\ Cream\ Ins&tance		Å©¸²\ »õ·Î\ ¿­±â(&t)

menutrans File\ Tr&ee				ÆÄÀÏ\ Æ®¸®
menutrans Open\ File\ E&xplorer	ÆÄÀÏ\ Å½»ö±â(&x)
menutrans Open\ File\ in\ Default\ &Application	±âº»\ ÇÁ·Î±×·¥À¸·Î\ ÆÄÀÏ\ ¿­±â
menutrans &Calendar\ (toggle)<Tab>Ctrl+F11	´Ş·Â<Tab>Ctrl+F11

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Help menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Help			µµ¿ò¸»(&H)

menutrans Keyboard\ Shortcuts<Tab>F1	´ÜÃàÅ°<Tab>F1
menutrans Features		Æ¯Â¡
menutrans FAQ			ÀÚÁÖ\ ¹¯´Â\ Áú¹®
menutrans License		¶óÀÌ¼¾½º
menutrans Contributors	µµ¿ÍÁØ\ ºĞµé
menutrans &Vim\ Help\ (expert)	VIM\ µµ¿ò¸»\ (Àü¹®°¡¿ë)
menutrans &Overview		°³¿ä(&O)
menutrans &User\ Manual		»ç¿ëÀÚ\ ¸Å´º¾ó(&U)
menutrans &GUI			»ç¿ëÀÚ\ ÀÎÅÍÆäÀÌ½º(&G)
menutrans &How-to\ links	HOWTO\ ¸µÅ©\.\.\.(&H)
menutrans &Credits		ÀúÀÛ±Ç(&C)
menutrans Co&pying		º¹»ç(&P)
menutrans &Version\.\.\.	¹öÀü(&V)\.\.\.
menutrans &About\.\.\.		Vim¿¡\ ´ëÇØ(&A)
menutrans &List\ Help\ Topics\.\.\.<Tab>Alt+F1	µµ¿ò¸»\ Ç×¸ñ\ ¸®½ºÆ®<Tab>Alt+F1
menutrans &Go\ to\ Help\ Topic\.\.\.<Tab>Ctrl+F1	µµ¿ò¸»\ Ç×¸ñÀ¸·Î\ ÀÌµ¿\.\.\.<Tab>Ctrl+F1

menutrans &About\ Cream\.\.\.	Cream¿¡\ ´ëÇØ\.\.\.

" Popup menu
menutrans Select\ &All		¸ğµÎ\ ¼±ÅÃ(&A)
menutrans Cu&t			ÀÚ¸£±â(&t)
menutrans &Copy			º¹»ç(&C)
menutrans &Paste		ºÙ¿©³Ö±â(&P)
menutrans &Delete		»èÁ¦(&D)


" Toolbar #FIXME: not work?
menutrans New\ File		»õ\ ÆÄÀÏ
menutrans Open			¿­±â
menutrans Save			ÀúÀå
menutrans Save\ As		´Ù¸¥\ ÀÌ¸§À¸·Î\ ÀúÀå
menutrans Close			´İ±â
menutrans Exit\ Vim		Vim\ Á¾·á
menutrans Print			ÀÎ¼â
menutrans Undo			½ÇÇàÃë¼Ò
menutrans Redo			´Ù½Ã½ÇÇà
menutrans Cut\ (to\ Clipboard)	Å¬¸³º¸µå·Î\ ÀÚ¸£±â
menutrans Copy\ (to\ Clipboard)	Å¬¸³º¸µå·Î\ º¹»ç
menutrans Paste\ (from\ Clipboard)	Å¬¸³º¸µå¿¡¼­\ ºÙ¿©³Ö±â


" The GUI toolbar
if has("toolbar")
  if exists("*Do_toolbar_tmenu")
    delfun Do_toolbar_tmenu
  endif
  fun Do_toolbar_tmenu()
    tmenu ToolBar.new		»õÆÄÀÏ
    tmenu ToolBar.Open		¿­±â
    tmenu ToolBar.Save		ÀúÀå
    tmenu ToolBar.SaveAll	¸ğµÎÀúÀå
    tmenu ToolBar.Print		ÀÎ¼â
    tmenu ToolBar.Undo		½ÇÇàÃë¼Ò
    tmenu ToolBar.Redo		´Ù½Ã½ÇÇà
    tmenu ToolBar.Cut		Àß¶ó³»±â
    tmenu ToolBar.Copy		º¹»ç
    tmenu ToolBar.Paste		ºÙ¿©³Ö±â
    tmenu ToolBar.Find		Ã£±â...
    tmenu ToolBar.FindNext	´ÙÀ½Ã£±â
    tmenu ToolBar.FindPrev	ÀÌÀüÃ£±â
    tmenu ToolBar.Replace	¹Ù²Ù±â...
    tmenu ToolBar.LoadSesn	¼¼¼ÇºÒ·¯¿À±â
    tmenu ToolBar.SaveSesn	¼¼¼ÇÀúÀå
    tmenu ToolBar.RunScript	½ºÅ©¸³Æ®½ÇÇà
    tmenu ToolBar.Make		Make
    tmenu ToolBar.Shell		½©
    tmenu ToolBar.RunCtags	ctags½ÇÇà
    tmenu ToolBar.TagJump	ÅÂ±×ÀÌµ¿
    tmenu ToolBar.Help		µµ¿ò¸»
    tmenu ToolBar.FindHelp	µµ¿ò¸»Ã£±â
  endfun
endif



