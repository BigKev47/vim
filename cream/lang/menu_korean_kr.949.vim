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
menutrans &File				파일(&F)
menutrans &New<Tab>Ctrl+N		새\ 파일(&N)<Tab>Ctrl+N
menutrans &Open\.\.\.			열기(&O)\.\.\.
menutrans &Open\ (selection)<Tab>Ctrl+Enter	선택한\ 파일\ 열기<Tab>Ctrl+Enter
menutrans &Open\ (Read-Only)\.\.\.	읽기\ 전용으로\ 열기\.\.\.
menutrans &Close\ File			닫기
menutrans C&lose\ All\ Files		모두\ 닫기

menutrans &Save<Tab>Ctrl+S		저장(&S)<Tab>Ctrl+S
menutrans Save\ &As\.\.\.		새\ 이름으로 저장(&A)\.\.\.
menutrans Sa&ve\ All\.\.\.		모두\ 저장(&v)\.\.\.
menutrans &Print\.\.\.			인쇄(&P)\.\.\.
menutrans Prin&t\ Setup			인쇄\ 설정
menutrans Save\ All\ and\ &Exit		모두\ 저장하고\ 끝내기

menutrans E&xit<Tab>Ctrl+F4		끝내기(&X)<Tab>Ctrl+F4

menutrans &Recent\ Files,\ Options	최근파일,\ 옵션
menutrans Set\ Menu\ Size		메뉴\ 크기\ 설정
menutrans Remove\ Invalid		잘못된\ 항목\ 지우기
menutrans Clear\ List			목록\ 비우기

" Print Setup
menutrans Paper\ Size			종이\ 크기
menutrans Paper\ Orientation		종이\ 방향
menutrans Margins			여백
menutrans Header			머리글
menutrans Syntax\ Highlighting\.\.\.	구문\ 강조
menutrans Line\ Numbering\.\.\.		줄번호\.\.\.
menutrans Wrap\ at\ Margins\.\.\.	여백에서\ 들여쓰기\.\.\.
menutrans &Encoding			인코딩(&E)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Edit menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Edit				편집(&E)
menutrans &Undo<Tab>Ctrl+Z		되돌리기(&U)<Tab>Ctrl+Z
menutrans &Redo<Tab>Ctrl+Y		다시하기(&R)<Tab>Ctrl+Y

menutrans Cu&t<Tab>Ctrl+X		잘라내기(&T)<Tab>Ctrl+X
menutrans &Copy<Tab>Ctrl+C		복사(&C)<Tab>Ctrl+C
menutrans &Paste<Tab>Ctrl+V		붙여넣기(&P)<Tab>Ctrl+V

menutrans &Select\ All<Tab>Ctrl+A	모두\ 선택(&S)<Tab>Ctrl+A
menutrans &Go\ To\.\.\.<Tab>Ctrl+G	이동(&G)\.\.\.<Tab>Ctrl+G

menutrans &Find\.\.\.<Tab>Ctrl+F	찾기(&F)\.\.\.<Tab>Ctrl+F
menutrans &Replace\.\.\.<Tab>Ctrl+H	바꾸기(&R)\.\.\.<Tab>Ctrl+H
menutrans &Find<Tab>/			찾기(&F)<Tab>/
menutrans Find\ and\ Rep&lace<Tab>:%s	찾아\ 바꾸기(&l)<Tab>:%s
menutrans Multi-file\ Replace\.\.\.	여러\ 파일에서\ 바꾸기\.\.\.

menutrans Fi&nd\ Under\ Cursor		커서\ 위치에서\ 찾기
menutrans &Find\ Under\ Cursor<Tab>F3	찾기<Tab>F3
menutrans &Find\ Under\ Cursor\ (&Reverse)<Tab>Shift+F3		역방향으로\ 찾기<Tab>Shift+F3
menutrans &Find\ Under\ Cursor\ (&Case-sensitive)<Tab>Alt+F3	대소문자\ 구별하여\ 찾기<Tab>Alt+F3
menutrans &Find\ Under\ Cursor\ (Cas&e-sensitive,\ Reverse)<Tab>Alt+Shift+F3	대소문자\ 구별하여\ 역방향으로 찾기<Tab>Alt+Shift+F3

menutrans Count\ &Word\.\.\.		단어\ 수\ 세기(&W)\.\.\.
menutrans Cou&nt\ Total\ Words\.\.\.	전체\ 단어\ 수\ 세기(&n)\.\.\.
menutrans Column\ Select<Tab>Alt+Shift+(motion)		컬럼\ 선택<Tab>Alt+Shift+(움직임)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Insert			삽입(&I)
menutrans Character\ Line\.\.\.<Tab>Shift+F4	문자\ 행\.\.\.<Tab>Shift+F4
menutrans Character\ Line\ (length\ of\ line\ above)\.\.\.<Tab>Shift+F4\ (x2)	문자\ 행\ (윗\ 행의\ 길이로)\.\.\.<Tab>Shift+F4\ (x2)
menutrans Date/Time\.\.\.<Tab>F11			날짜/시간\.\.\.<Tab>F11
menutrans Date/Time\ (Last\ Used)<Tab>F11\ (2x)	날짜/시간\ (지난번)<Tab>F11\ (2x)
menutrans Character\ by\ Value<Tab>Alt+,	문자를\ 값으로<Tab>Alt+,
menutrans List\ Characters\ Available\.\.\.<Tab>Alt+,\ (x2)	 입력\ 가능한\ 문자\.\.\.<Tab>Alt+,\ (x2)
menutrans List\ Character\ Values\ Under\ Cursor<Tab>Alt+\.	커서\ 위치의\ 문자값<Tab>Alt+\.
"menutrans Character\ by\ Dialog\.\.\.		대화창으로\ 문자\ 삽입\.\.\.
menutrans Character\ by\ Digraph<Tab>Ctrl+K	이중자<Tab>Ctrl+K
menutrans List\ Digraphs\ Available\.\.\.<Tab>Ctrl+K\ (x2)	이중자\ 목록\.\.\.<Tab>Ctrl+K\ (x2)
menutrans Text\ Filler\.\.\.	글\ 채우기
"menutrans ASCII\ Table			아스키\ 표
"menutrans ASCII\ Table,\ List		아스키\ 표,\ 리스트
menutrans Line\ Numbers\.\.\.\ (selection)	줄번호(선택)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Format menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans Fo&rmat			포맷(&r)

menutrans &Quick\ Wrap\ (selection\ or\ current\ paragraph)<Tab>Ctrl+Q		자동\ 줄바꿈<Tab>Ctrl+Q
menutrans Quick\ &Un-Wrap\ (selection\ or\ current\ paragraph)<Tab>Alt+Q,\ Q	�씬湄�\ 줄바꿈\ 해제<Tab>Alt+Q,\ Q

menutrans Capitalize,\ Title\ Case<Tab>F5	대소문자전환,\ 첫\ 글자만\ 대문자로(&T)<Tab>F5
menutrans Capitalize,\ UPPERCASE<Tab>Shift+F5	대소문자전환,\ 모두\ 대문자로(&U)<Tab>Shift+F5
menutrans Capitalize,\ lowercase<Tab>Alt+F5	대소문자전환,\ 모두\ 소문자로(&l)<Tab>Alt+F5
menutrans Capitalize,\ rEVERSE<Tab>Ctrl+F5	대소문자전환,\ 첫\ 글자만\ 소문자로(&I)<Tab>Ctrl+F5

menutrans Justify,\ Left			정렬,\ 왼쪽(&L)
menutrans Justify,\ Center			정렬,\ 가운데(&C)
menutrans Justify,\ Right			정렬,\ 오른쪽(&R)
menutrans Justify,\ Full			정렬,\ 배분(&F)

menutrans &Remove\ Trailing\ Whitespace �씰�\ 끝의\ 공백\ 지우기(&R)
menutrans Remove\ &Leading\ Whitespace  �씰�\ 처음의\ 공백\ 지우기(&L)
menutrans &Collapse\ All\ Empty\ Lines\ to\ One		�씌�\ 줄\ 여러\ 개를\ 한\ 줄로(&C)
menutrans &Delete\ All\ Empty\ Lines	�씀醍�\ 빈\ 줄\ 삭제(&D)
menutrans &Join\ Lines\ (selection)	줄\ 합치기(&J)

menutrans Con&vert\ Tabs\ To\ Spaces	탭을\ 공백으로

menutrans &File\ Format\.\.\.		파일\ 포맷(&F)\.\.\.

menutrans File\ &Encoding		파일\ 인코딩(&E)
menutrans Asian				아시아어
menutrans Unicode			유니코드
menutrans Western\ European		서유럽어
menutrans Eastern\ European		동유럽어
menutrans East\ Asian			동아시아어
menutrans Middle\ Eastern		중앙아시아어
menutrans SE\ and\ SW\ Asian		남동/남서아시아어

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Settings			설정(&S)
menutrans &Show/Hide\ Invisibles\ (toggle)<Tab>F4	보이기/감추기(&S)\ (toggle)<Tab>F4
menutrans Line\ &Numbers\ (toggle)	줄번호(&N)\ (toggle)

menutrans &Word\ Wrap<Tab>Ctrl+W	줄바꿈<Tab>Ctrl+W
menutrans A&uto\ Wrap<Tab>Ctrl+E	자동\ 줄바꿈<Tab>Ctrl+E
menutrans &Set\ Wrap\ Width\.\.\.		줄바꿈\ 넓이\ 설정(&S)\.\.\.
menutrans &Highlight\ Wrap\ Width\ (toggle)	줄바꿈\ 넓이\ 보이기(&H)

menutrans &Tabstop\ Width\.\.\. 		탭\ 넓이\.\.\.
menutrans Tab\ &Expansion\ (toggle)<Tab>Ctrl+T	탭\ 확장(&E)<Tab>Ctrl+T
menutrans &Auto-indent\ (toggle)		자동\ 들여쓰기(&A)

menutrans Syntax\ Highlighting\ (toggle)	문법\ 강조
menutrans Highlight\ Find\ (toggle)		검색\ 결과\ 강조
menutrans Highlight\ Current\ Line\ (toggle)	현재\ 줄\ 강조
menutrans &Filetype			파일\ 종류

menutrans &Color\ Themes		색\ 스킴(&C)
menutrans Selection			선택

menutrans P&references			설정(&r)
menutrans Font\.\.\.			글꼴\.\.\.
menutrans Toolbar\ (toggle)		툴바
menutrans Last\ File\ Restore\ Off	지난\ 파일\ 복구\ 안함
menutrans Last\ File\ Restore\ On	지난\ 파일\ 복구\ 함

menutrans &Middle-Mouse\ Disabled	마우스\ 가운데\ 버튼\ 사용안함
menutrans &Middle-Mouse\ Pastes		마우스\ 가운데\ 버튼\ 붙여넣기

menutrans Bracket\ Flashing\ Off	괄호\ 깜빡임\ 끄기
menutrans Bracket\ Flashing\ On		괄호\ 깜빡임\ 켜기
menutrans Info\ Pop\ Options\.\.\.	팝\ 옵션\ 정보\.\.\.

menutrans &Expert\ Mode\.\.\.		전문가\ 모드(&E)\.\.\.
menutrans &Behavior			움직임(&B)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tools menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Tools			도구(&T)

menutrans &Spell\ Check			맞춤범\ 검사
menutrans Next\ Spelling\ Error<Tab>F7			다음\ 맞춤법\ 에러<Tab>F7
menutrans Previous\ Spelling\ Error<Tab>Shift+F7	이전\ 맞춤법\ 에러<Tab>Shift+F7
menutrans Show\ Spelling\ Errors\ (toggle)<Tab>Alt+F7	맞춤법\ 에러\ 보이기<Tab>Alt+F7
menutrans Add\ Word\ (under\ cursor)\ to\ Dictionary<Tab>Ctrl+F7	선택\ 단어\ 사전에\ 넣기<Tab>Ctrl+F7
menutrans Language\.\.\.		언어\.\.\.
menutrans Options\.\.\.			옵션\.\.\.

menutrans &Bookmarks			북마크(&B)
menutrans Bookmark\ Next<Tab>F2		다음\ 북마크<Tab>F2
menutrans Bookmark\ Previous<Tab>Shift+F2	�舅缺�\ 북마크<Tab>Shift+F2	
menutrans Bookmark\ Set\ (toggle)<Tab>Alt+F2	�翁玖뗘�\ 모음<Tab>Alt+F2
menutrans Delete\ All\ Bookmarks<Tab>Alt+Shift+F2	�씀醍�\ 북마크\ 삭제<Tab>Alt+Shift+F2

menutrans Block\ Comment\ (selection)<Tab>F6		선택영역\ 코멘트로<Tab>F6
menutrans Block\ Un-Comment\ (selection)<Tab>Shift+F6	�씔궈첼동�\ 코멘트\ 풀기<Tab>Shift+F6

menutrans Macro\ Play<Tab>F8				매크로\ 실행<Tab>F8
menutrans Macro\ Record\ (toggle)<Tab>Shift+F8		매크로\ 기록<Tab>Shift+F8

menutrans &Diff\ Mode			비교\ 모드(&D)

menutrans &Folding			접기(&F)
menutrans &Fold\ Open/Close<Tab>F9	접기\ 열기/닫기<Tab>F9
menutrans &Fold\ Open/Close<Tab>Shift+F9	접기\ 열기/닫기<Tab>Shift+F9
menutrans &Set\ Fold\ (Selection)<Tab>F9	접기\ 설정
menutrans &Open\ All\ Folds<Tab>Ctrl+F9		모든\ 접기\ 열기<Tab>Ctrl+F9
menutrans &Close\ All\ Folds<Tab>Ctrl+Shift+F9	모든\ 접기\ 닫기<Tab>Ctrl+Shift+F9
menutrans &Delete\ Fold\ at\ Cursor<Tab>Alt+F9	�씻옘�\ 위치에서\ 접기\ 삭제<Tab>Alt+F9
menutrans D&elete\ All\ Folds<Tab>Alt+Shift+F9	�씀醍�\ 접기\ 삭제<Tab>Alt+Shift+F9

menutrans &Completion			자동완성(&C)

menutrans &Tag\ Navigation		탭\ 이동
menutrans &Jump\ to\ Tag\ (under\ cursor)<Tab>Alt+Down	태그로\ 이동<Tab>Alt+Down
menutrans &Close\ and\ Jump\ Back<Tab>Alt+Up		닫고\ 뒤로\ 이동<Tab>Alt+Up
menutrans &Previous\ Tag<Tab>Alt+Left			이전\ 태그<Tab>Alt+Left
menutrans &Next\ Tag<Tab>Alt+Right			다음\ 태그<Tab>Alt+Right
menutrans &Tag\ Listing\.\.\.<Tab>Ctrl+Alt+Down		태그\ 리스트\.\.\.<Tab>Ctrl+Alt+Down

menutrans Add-ons\ E&xplore\ (Map/Unmap)	추가기능\ 탐색(&x)

" Add-ons
menutrans &Add-ons	기타
menutrans Color\ Invert			색\ 반전
menutrans Convert			변환
menutrans Cream\ Config\ Info	크림\ 설정\ 정보
menutrans Cream\ Devel	 크림\ 개발
menutrans Fold\ Vim\ Functions	Vim\ 함수\ 접기
menutrans Ctags\ Generate	Ctags\ 생성
menutrans Daily\ Read	매일\ 읽기
menutrans De-binary	바이너리\ 해제
menutrans &Email\ Prettyfier	이메일\ 꾸미기
menutrans Sort				정렬
menutrans Encrypt			암호화
menutrans Highlight\ Control\ Characters	제어문자\ 하이라이트
menutrans Highlight\ Multibyte		멀티바이트\ 하이라이트
menutrans Stamp\ Time			시간\ 표시

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Window				창(&W)
menutrans Maximize\ (&Single)			최대화(&S)
menutrans Minimize\ (Hi&de)			최소화(&d)
menutrans Tile\ &Vertical			세로로\ 정렬
menutrans Tile\ Hori&zontal			가로로\ 정렬
menutrans Sizes\ E&qual				같은\ 크기로(&q)
menutrans Height\ Max\ &=			최대높이(&=)
menutrans Height\ Min\ &-			최소높이(&-)
menutrans &Width\ Max				최대넓이(&W)
menutrans Widt&h\ Min				최소넓이(&h)
menutrans Split\ New\ Pane\ Vertical		새\ 창을\ 세로로\ 나눔
menutrans Split\ New\ Pane\ Horizontal		새\ 창을\ 가로로\ 나눔
menutrans Split\ Existing\ Vertically		현재\ 창을\ 세로로\ 나눔
menutrans Split\ Existing\ Horizontally		현재\ 창을\ 가로로\ 나눔
menutrans Start\ New\ Cream\ Ins&tance		크림\ 새로\ 열기(&t)

menutrans File\ Tr&ee				파일\ 트리
menutrans Open\ File\ E&xplorer	파일\ 탐색기(&x)
menutrans Open\ File\ in\ Default\ &Application	기본\ 프로그램으로\ 파일\ 열기
menutrans &Calendar\ (toggle)<Tab>Ctrl+F11	달력<Tab>Ctrl+F11

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Help menu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
menutrans &Help			도움말(&H)

menutrans Keyboard\ Shortcuts<Tab>F1	단축키<Tab>F1
menutrans Features		특징
menutrans FAQ			자주\ 묻는\ 질문
menutrans License		라이센스
menutrans Contributors	도와준\ 분들
menutrans &Vim\ Help\ (expert)	VIM\ 도움말\ (전문가용)
menutrans &Overview		개요(&O)
menutrans &User\ Manual		사용자\ 매뉴얼(&U)
menutrans &GUI			사용자\ 인터페이스(&G)
menutrans &How-to\ links	HOWTO\ 링크\.\.\.(&H)
menutrans &Credits		저작권(&C)
menutrans Co&pying		복사(&P)
menutrans &Version\.\.\.	버전(&V)\.\.\.
menutrans &About\.\.\.		Vim에\ 대해(&A)
menutrans &List\ Help\ Topics\.\.\.<Tab>Alt+F1	도움말\ 항목\ 리스트<Tab>Alt+F1
menutrans &Go\ to\ Help\ Topic\.\.\.<Tab>Ctrl+F1	도움말\ 항목으로\ 이동\.\.\.<Tab>Ctrl+F1

menutrans &About\ Cream\.\.\.	Cream에\ 대해\.\.\.

" Popup menu
menutrans Select\ &All		모두\ 선택(&A)
menutrans Cu&t			자르기(&t)
menutrans &Copy			복사(&C)
menutrans &Paste		붙여넣기(&P)
menutrans &Delete		삭제(&D)


" Toolbar #FIXME: not work?
menutrans New\ File		새\ 파일
menutrans Open			열기
menutrans Save			저장
menutrans Save\ As		다른\ 이름으로\ 저장
menutrans Close			닫기
menutrans Exit\ Vim		Vim\ 종료
menutrans Print			인쇄
menutrans Undo			실행취소
menutrans Redo			다시실행
menutrans Cut\ (to\ Clipboard)	클립보드로\ 자르기
menutrans Copy\ (to\ Clipboard)	클립보드로\ 복사
menutrans Paste\ (from\ Clipboard)	클립보드에서\ 붙여넣기


" The GUI toolbar
if has("toolbar")
  if exists("*Do_toolbar_tmenu")
    delfun Do_toolbar_tmenu
  endif
  fun Do_toolbar_tmenu()
    tmenu ToolBar.new		새파일
    tmenu ToolBar.Open		열기
    tmenu ToolBar.Save		저장
    tmenu ToolBar.SaveAll	모두저장
    tmenu ToolBar.Print		인쇄
    tmenu ToolBar.Undo		실행취소
    tmenu ToolBar.Redo		다시실행
    tmenu ToolBar.Cut		잘라내기
    tmenu ToolBar.Copy		복사
    tmenu ToolBar.Paste		붙여넣기
    tmenu ToolBar.Find		찾기...
    tmenu ToolBar.FindNext	다음찾기
    tmenu ToolBar.FindPrev	이전찾기
    tmenu ToolBar.Replace	바꾸기...
    tmenu ToolBar.LoadSesn	세션불러오기
    tmenu ToolBar.SaveSesn	세션저장
    tmenu ToolBar.RunScript	스크립트실행
    tmenu ToolBar.Make		Make
    tmenu ToolBar.Shell		쉘
    tmenu ToolBar.RunCtags	ctags실행
    tmenu ToolBar.TagJump	태그이동
    tmenu ToolBar.Help		도움말
    tmenu ToolBar.FindHelp	도움말찾기
  endfun
endif



