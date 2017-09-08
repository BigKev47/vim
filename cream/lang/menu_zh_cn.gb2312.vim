" Menu Translations:	Simplified Chinese (UNIX)
" Translated By:	Ralgh Young <glyoung@users.sourceforge.net>
" Last Change:		Thir Dec 2 11:26:52 CST 2004

" translations for vimcream (http://cream.sourceforge.net)

" Quit when menu translations have already been done.
if exists("did_menu_trans")
  finish
endif
let did_menu_trans = 1

scriptencoding gb2312

" File menu
menutrans &File				文件(&F)
menutrans &New<Tab>Ctrl+N		新建(&N)<Tab>Ctrl+N
menutrans &Open\.\.\.			打开(&O)\.\.\.
menutrans &Open\ (selection)<Tab>Ctrl+Enter	打开光标下文件<Tab>Ctrl+Enter
menutrans &Close			关闭(&C)
menutrans C&lose\ All			全部关闭(&l)

menutrans &Save<Tab>Ctrl+S		保存(&S)<Tab>Ctrl+S
menutrans Save\ &As\.\.\.		另存为(&A)\.\.\.
menutrans Sa&ve\ All\.\.\.		全部保存(&v)\.\.\.
menutrans &Print\.\.\.			打印(&P)\.\.\.
menutrans Prin&t\ Setup			打印设置

menutrans E&xit<Tab>Ctrl+F4		退出(&X)<Tab>Ctrl+F4

menutrans &Recent\ Files,\ Options	最近打开的文件,\ 设置
menutrans Set\ Menu\ Size		设置历史记录数
menutrans Remove\ Invalid		删除无效项
menutrans Clear\ List			清除列表

" Print Setup
menutrans Paper\ Size			纸张大小
menutrans Paper\ Orientation		页面方向
menutrans Margins			边空
menutrans Header			标题
menutrans Syntax\ Highlighting\.\.\.	语法高亮
menutrans Line\ Numbering\.\.\.		行号\.\.\.
menutrans Wrap\ at\ Margins\.\.\.	自动换行\.\.\.
menutrans &Encoding			编码(&E)

" Edit menu
menutrans &Edit				编辑(&E)
menutrans &Undo<Tab>Ctrl+Z		恢复(&U)<Tab>Ctrl+Z
menutrans &Redo<Tab>Ctrl+Y		重做(&R)<Tab>Ctrl+Y

menutrans Cu&t<Tab>Ctrl+X		剪切(&T)<Tab>Ctrl+X
menutrans &Copy<Tab>Ctrl+C		复制(&C)<Tab>Ctrl+C
menutrans &Paste<Tab>Ctrl+V		粘帖(&P)<Tab>Ctrl+V

menutrans &Select\ All<Tab>Ctrl+A	全选(&S)<Tab>Ctrl+A
menutrans &Go\ To\.\.\.<Tab>Ctrl+G	跳到指定行(&G)\.\.\.<Tab>Ctrl+G

menutrans &Find\.\.\.<Tab>Ctrl+F	查找(&F)\.\.\.<Tab>Ctrl+F
menutrans &Replace\.\.\.<Tab>Ctrl+H	替换(&R)\.\.\.<Tab>Ctrl+H
menutrans &Find<Tab>/			查找(&F)<Tab>/
menutrans Find\ and\ Rep&lace<Tab>:%s	查找并替换(&l)<Tab>:%s
menutrans Multi-file\ Replace\.\.\.	多文件查找/替换\.\.\.

menutrans Fi&nd\ Under\ Cursor		查找光标下标识符
menutrans &Find\ Under\ Cursor<Tab>F3	查找<Tab>F3
menutrans &Find\ Under\ Cursor\ (&Reverse)<Tab>Shift+F3		反向查找<Tab>Shift+F3
menutrans &Find\ Under\ Cursor\ (&Case-sensitive)<Tab>Alt+F3	大小写敏感<Tab>Alt+F3
menutrans &Find\ Under\ Cursor\ (Cas&e-sensitive,\ Reverse)<Tab>Alt+Shift+F3	大小写敏感,反向查找<Tab>Alt+Shift+F3

menutrans Count\ &Word\.\.\.		统计字数(&W)\.\.\.
menutrans Cou&nt\ Total\ Words\.\.\.	统计全部字数(&n)\.\.\.
menutrans Column\ Select<Tab>Alt+Shift+(motion)		列选择<Tab>Alt+Shift+(光标)

" Insert menu
menutrans &Insert			插入(&I)
menutrans Character\ Line\.\.\.<Tab>Shift+F4	整行用字符填充\.\.\.<Tab>Shift+F4
menutrans Character\ Line\ (length\ of\ line\ above)\.\.\.<Tab>Shift+F4\ (x2)	整行用字符填充,与前一行同宽\.\.\.<Tab>Shift+F4\ (x2)
menutrans Date/Time			日期/时间

"menutrans Character\ by\ Decimal\ Value<Tab>Alt+,	特殊字符<Tab>Alt+,
"menutrans I&nsert.Character\ by\ Dialog\.\.\.		选择特殊字符\.\.\.
"menutrans Digraph<Tab>Ctrl+K
"menutrans Digraphs,\ List
"menutrans ASCII\ Table
"menutrans ASCII\ Table,\ List
menutrans Line\ Numbers\ (selection)	行号(选中部分)



" Format menu
menutrans Fo&rmat			格式(&r)

menutrans &Quick\ Wrap\ (selection\ or\ current\ paragraph)<Tab>Ctrl+Q		段落重排<Tab>Ctrl+Q
menutrans Quick\ &Un-Wrap\ (selection\ or\ current\ paragraph)<Tab>Alt+Q,\ Q	删除换行(当前段)<Tab>Alt+Q,\ Q

menutrans Capitalize,\ Title\ Case<Tab>F5	首字母大写(&T)<Tab>F5
menutrans Capitalize,\ UPPERCASE<Tab>Shift+F5	全部大写(&U)<Tab>Shift+F5
menutrans Capitalize,\ lowercase<Tab>Alt+F5	全部小写(&l)<Tab>Alt+F5
menutrans Capitalize,\ rEVERSE<Tab>Ctrl+F5	大小写反转(&I)<Tab>Ctrl+F5

menutrans Justify,\ Left			左对齐(&L)
menutrans Justify,\ Center			中间对齐(&C)
menutrans Justify,\ Right			右对齐(&R)
menutrans Justify,\ Full			左右均对齐(&F)

menutrans &Remove\ Trailing\ Whitespace 删除行尾空格(&R)
menutrans Remove\ &Leading\ Whitespace  删除行首空格(&L)
menutrans &Collapse\ All\ Empty\ Lines\ to\ One		删除多余空行(&C)
menutrans &Delete\ All\ Empty\ Lines	删除所有空行(&D)
menutrans &Join\ Lines\ (selection)	合并选中行(&J)

menutrans Con&vert\ Tabs\ To\ Spaces	将Tab转化为空格

menutrans &File\ Format\.\.\.		文件格式(&F)\.\.\.

menutrans File\ &Encoding		文件编码(&E)
menutrans Western\ European		西欧
menutrans Eastern\ European		东欧
menutrans East\ Asian			东亚
menutrans Middle\ Eastern		中东
menutrans SE\ and\ SW\ Asian		东南亚/西亚
menutrans Simplified\ Chinese\ (ISO-2022-CN)<Tab>[chinese\ --\ simplified\ Chinese:\ on\ Unix\ "euc-cn",\ on\ MS-Windows\ cp936]	简体中文(ISO-2022-CN)<Tab>[Unix:\ "euc-cn",\ Windows:\ cp936]
menutrans Chinese\ Traditional\ (Big5)<Tab>[big5\ --\ traditional\ Chinese]		繁体中文(大五码)<Tab>[Big5]
menutrans Chinese\ Traditional\ (EUC-TW)<Tab>[taiwan\ --\ on\ Unix\ "euc-tw",\ on\ MS-Windows\ cp950]			繁体中文(EUC-TW)<Tab>[Unix:\ "euc-tw",\ Windows:\ cp950]

" Settings menu
menutrans &Settings			设置(&S)
menutrans &Show/Hide\ Invisibles<Tab>F4	显示/隐藏不可见字符(&S)<Tab>F4
menutrans Line\ &Numbers\ (toggle)	显示/隐藏行号(&N) 

menutrans &Word\ Wrap\ (toggle)<Tab>Ctrl+W	折行显示<Tab>Ctrl+W
menutrans A&uto\ Wrap\ (toggle)<Tab>Ctrl+E	自动换行<Tab>Ctrl+E
menutrans &Set\ Wrap\ Width\.\.\.		设置自动换行位置(&S)\.\.\.
menutrans &Highlight\ Wrap\ Width\ (toggle)	高亮显示自动换行位置(&H)

menutrans &Tabstop\ Width\.\.\. 		&Tab宽度\.\.\.
menutrans Tab\ &Expansion\ (toggle)<Tab>Ctrl+T	Tab自动扩展为空格(&E)<Tab>Ctrl+T
menutrans &Auto-indent\ (toggle)		自动缩进(&A)

menutrans Syntax\ Highlighting\ (toggle)	语法高亮显示
menutrans Highlight\ Find\ (toggle)		高亮显示查找结果
menutrans Highlight\ Current\ Line\ (toggle)	高亮显示当前行
menutrans &Filetype			语言类型

menutrans &Color\ Themes		色彩主题(&C)
menutrans Selection			选中文字

menutrans P&references			偏好(&r)
menutrans Font\.\.\.			字体\.\.\.
menutrans Toolbar\ (toggle)		显示/隐藏工具条
"menutrans Last\ File\ Restore\ Off
"menutrans Last\ File\ Restore\ On

menutrans &Middle-Mouse\ Disabled	鼠标中键:\ 已禁用
menutrans &Middle-Mouse\ Pastes		鼠标中键:\ 粘贴

menutrans Bracket\ Flashing\ Off	括号匹配闪烁:\ 关闭
menutrans Bracket\ Flashing\ On		括号匹配闪烁:\ 打开
menutrans Info\ Pop\ Options\.\.\.	自动完成提示设置\.\.\.

menutrans &Expert\ Mode\.\.\.		专家模式(&E)\.\.\.
menutrans &Behavior			行为模式(&B)

" Tools menu
menutrans &Tools			工具(&T)

menutrans &Spell\ Check			拼写检查
menutrans Next\ Spelling\ Error<Tab>F7			下一个错误<Tab>F7
menutrans Previous\ Spelling\ Error<Tab>Shift+F7	上一个错误<Tab>Shift+F7
menutrans Show\ Spelling\ Errors\ (toggle)<Tab>Alt+F7	显示全部拼写错误<Tab>Alt+F7
menutrans Add\ Word\ (under\ cursor)\ to\ Dictionary<Tab>Ctrl+F7	将当前单词加入词典<Tab>Ctrl+F7
menutrans Language\.\.\.		语言\.\.\.
menutrans Options\.\.\.			选项\.\.\.

menutrans &Bookmarks			书签(&B)
menutrans Bookmark\ Next<Tab>F2		下一个书签<Tab>F2
menutrans Bookmark\ Previous<Tab>Shift+F2	上一个书签<Tab>Shift+F2	
menutrans Bookmark\ Set\ (toggle)<Tab>Alt+F2	设置书签<Tab>Alt+F2
menutrans Delete\ All\ Bookmarks<Tab>Alt+Shift+F2	删除所有书签<Tab>Alt+Shift+F2

menutrans Block\ Comment\ (selection)<Tab>F6		添加注释<Tab>F6
menutrans Block\ Un-Comment\ (selection)<Tab>Shift+F6	删除注释<Tab>Shift+F6

menutrans Macro\ Play<Tab>F8				回放宏<Tab>F8
menutrans Macro\ Record\ (toggle)<Tab>Shift+F8		开始/停止录制宏<Tab>Shift+F8

menutrans &Diff\ Mode			文件比较模式(&D)

menutrans &Folding			代码折叠(&F)
menutrans &Fold\ Open/Close<Tab>F9	折叠/打开<Tab>F9
menutrans &Fold\ Open/Close<Tab>Shift+F9	折叠/打开<Tab>Shift+F9
"menutrans &Set\ Fold\ (Selection)<Tab>F9
menutrans &Open\ All\ Folds<Tab>Ctrl+F9		打开所有折叠<Tab>Ctrl+F9
menutrans &Close\ All\ Folds<Tab>Ctrl+Shift+F9	关闭所有折叠<Tab>Ctrl+Shift+F9
menutrans &Delete\ Fold\ at\ Cursor<Tab>Alt+F9	删除光标处折叠<Tab>Alt+F9
menutrans D&elete\ All\ Folds<Tab>Alt+Shift+F9	删除所有折叠<Tab>Alt+Shift+F9

menutrans &Completion			自动完成(&C)

menutrans &Tag\ Navigation		&Tag导航
menutrans &Jump\ to\ Tag\ (under\ cursor)<Tab>Alt+Down	跳转到此标记<Tab>Alt+Down
menutrans &Close\ and\ Jump\ Back<Tab>Alt+Up		关闭并回到前一位置<Tab>Alt+Up
menutrans &Previous\ Tag<Tab>Alt+Left			前一标记<Tab>Alt+Left
menutrans &Next\ Tag<Tab>Alt+Right			后一标记<Tab>Alt+Right
menutrans &Tag\ Listing\.\.\.<Tab>Ctrl+Alt+Down	列出所有标记\.\.\.<Tab>Ctrl+Alt+Down

menutrans Add-ons\ E&xplore\ (Map/Unmap)	插件管理/快捷键映射(&x)

" Add-ons
menutrans Color\ Invert			反转HTML颜色值
menutrans Convert			转换
menutrans Sort				排序
menutrans Encrypt			加密
menutrans Highlight\ Control\ Characters	高亮显示控制字符
menutrans Highlight\ Multibyte		高亮显示多字节字符
menutrans Stamp\ Time			插入时间戳


" Window menu
menutrans &Window			窗口(&W)
menutrans Maximize\ (&Single)			最大化(&S)
menutrans Minimize\ (Hi&de)			最小化/隐藏(&d)
menutrans Tile\ &Vertical			垂直平铺
menutrans Tile\ Hori&zontal			水平平铺
menutrans Sizes\ E&qual				相同大小(&q)
menutrans Height\ Max\ &=			最大高度(&=)
menutrans Height\ Min\ &-			最小高度(&-)
menutrans &Width\ Max				最大宽度(&W)
menutrans Widt&h\ Min				最小宽度(&h)
menutrans Split\ New\ Pane\ Vertical		纵向分割新窗口
menutrans Split\ New\ Pane\ Horizontal		横向分割新窗口	
menutrans Split\ Existing\ Vertically		纵向分割当前窗口
menutrans Split\ Existing\ Horizontally		横向分割当前窗口
menutrans Start\ New\ Vim\ Ins&tance		开启新实例(&t)

menutrans File\ Tr&ee				目录树(&e)
menutrans File\ E&xplorer\ (obsolete)		文件浏览器(&x)
menutrans &Calendar\ (toggle)<Tab>Ctrl+F11	显示/隐藏日历<Tab>Ctrl+F11

" Help menu
menutrans &Help			帮助(&H)

menutrans &Vim\ Help		VIM帮助
menutrans &Overview<Tab>F1	总览(&O)<Tab>F1
menutrans &User\ Manual		用户手册(&U)
menutrans &GUI			图形界面(&G)
menutrans &How-to\ links	HOWTO文档\.\.\.(&H)
menutrans &Credits		作者(&C)
menutrans Co&pying		版权(&P)
menutrans &Version\.\.\.	版本(&V)\.\.\.
menutrans &About\.\.\.		关于\ Vim(&A)

menutrans &About\ Cream\.\.\.	关于\ Cream\.\.\.

" Popup menu
menutrans Select\ &All		全选(&A)
menutrans Cu&t			剪切(&t)
menutrans &Copy			拷贝(&C)
menutrans &Paste		粘贴(&P)
menutrans &Delete		删除(&D)


" Toolbar #FIXME: not work?
menutrans New\ File		新建文件
menutrans Open			打开
menutrans Save			保存
menutrans Save\ As		另存为
menutrans Close			关闭
menutrans Exit\ Vim		退出Vim
menutrans Print			打印
menutrans Undo			恢复
menutrans Redo			重做
menutrans Cut\ (to\ Clipboard)	剪切到剪贴板
menutrans Copy\ (to\ Clipboard)	拷贝到剪贴板
menutrans Paste\ (from\ Clipboard)	从剪贴板粘贴


" The GUI toolbar
if has("toolbar")
  if exists("*Do_toolbar_tmenu")
    delfun Do_toolbar_tmenu
  endif
  fun Do_toolbar_tmenu()
    tmenu ToolBar.new		新建文件
    tmenu ToolBar.Open		打开文件
    tmenu ToolBar.Save		保存当前文件
    tmenu ToolBar.SaveAll	保存全部文件
    tmenu ToolBar.Print		打印
    tmenu ToolBar.Undo		撤销上次修改
    tmenu ToolBar.Redo		重做上次撤销的动作
    tmenu ToolBar.Cut		剪切至剪贴板
    tmenu ToolBar.Copy		复制到剪贴板
    tmenu ToolBar.Paste		由剪贴板粘帖
    tmenu ToolBar.Find		查找...
    tmenu ToolBar.FindNext	查找下一个
    tmenu ToolBar.FindPrev	查找上一个
    tmenu ToolBar.Replace	替换...
    tmenu ToolBar.LoadSesn	加载会话
    tmenu ToolBar.SaveSesn	保存当前的会话
    tmenu ToolBar.RunScript	运行Vim脚本
    tmenu ToolBar.Make		执行 Make
    tmenu ToolBar.Shell		打开一个命令窗口
    tmenu ToolBar.RunCtags	执行 ctags
    tmenu ToolBar.TagJump	跳到当前光标位置的标签
    tmenu ToolBar.Help		Vim 帮助
    tmenu ToolBar.FindHelp	查找 Vim 帮助
  endfun
endif



