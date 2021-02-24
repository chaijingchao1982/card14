;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.386
		.model	flat, stdcall
		option	casemap :none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Include 文件定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include			windows.inc
include			gdi32.inc
includelib		gdi32.lib
include			user32.inc
includelib		user32.lib
include			kernel32.inc
includelib		kernel32.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Equ 等值定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;*****************************
width_bmp		equ	71
height_bmp		equ	96
;*****************************;资源
ICO_MAIN			equ	1000h		;图标
IDB_1				equ	1
IDB_2				equ	2
IDB_3				equ	3
IDB_4				equ	4
DLG_HELP			equ	1
DLG_ME			equ	2

;*****************************菜单
IDM_MAIN			equ	100
IDM_HELP			equ	101 
IDM_ME			equ	102 
IDM_EXIT			equ	103
IDM_NEW			equ	104
;*****************************
WM_NEWGAME			equ	WM_USER+200h
WM_computer_fish	equ	WM_USER+300h
;WM_cjc				equ	WM_USER+400h
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 数据段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.data?
;***************************************程序所用的全局变量
hWinMain			dd		?						;主窗口句柄
hdlg_help		dd		?						;help窗口句柄
hdlg_me			dd		?
hMenu				dd		?						;菜单句柄
hInstance		dd		?						;本程序的实例子句柄
hDc_map			dd		?						;地图位图句柄
hDc_back			dd		?						;牌的背面的位图句柄
hDc_kong			dd		?						;没有牌时空位的位图句柄
dwNowBack		dd		?						;储存位图句柄的中间变量
hDc_me			dd		?
hitpoint			POINT <>						;鼠标按下时的坐标
who_fish			dd		?						;控制游戏流程的轮换变量
random_count	dd		?
TimerID			dd		?
;***************************************这里是电脑智能钓鱼子程序中所用到的一些变量
fish_way_hand	db		?
fish_way_hand1	db		?
fish_way_fishes	dd	?
;***************************************
lp_puke_head	dd		?						;未发出去的牌的头指针
lp_puke_weiba	dd		?						;未发出去的牌的尾指针
my_will_fish	dd		?						;我手中出去的牌的张数
;***************************************玩家手中三张牌的坐标
my_hand1_x		dd		?
my_hand1_y		dd		?
my_hand2_x		dd		?
my_hand2_y		dd		?
my_hand3_x		dd		?
my_hand3_y		dd		?

;***************************************
add_points		db		?						;补充的分
can_huanpai		db		?						;对手能否换牌
;***************************************字符串
sz_printf		db		128d  dup	(?)	;显示时所用的字符串	

;***************************************实验用变量
;sz_printf_shiyan	db	128d  dup	(?)
;can_fish			dd		?
;***************************************随机变量存放处
;wash_random		db		60d	dup	(?)	;本来应该是52d的，但是我怕溢出，所以多分它几个字节，呵呵，操那

;***************************************玩家和对手手中的三张牌
my_hand			db		3d		dup	(?)	;我手中的牌
no1				dd		?						;用来隔离数据

my_hand_num		db		3d		dup	(?)	;我手中的牌的大小
no2				dd		?						;用来隔离数据

my_aogo			db		4d		dup	(?)	;我上把钓鱼的组合
no3				dd		?						;用来隔离数据

your_hand		db		3d		dup	(?)	;对手手中的牌
no4				dd		?						;用来隔离数据

your_aogo		db		4d		dup	(?)	;对手上把钓鱼的组合
no6				dd		?						;用来隔离数据

your_hand_num	db		3d		dup	(?)	;对手手中的牌的大小
no5				dd		?						;用来隔离数据


;***************************************玩家和对手本局的总得分
no7				db		?,?,?,?
my_points		db		?
your_points		db		?
;***************************************
puke				db		54d	dup	(?)	;所有的扑克变量
puke_wash		db		54d	dup	(?)	;洗牌专用的空间

fishes			db		8d		dup	(?)	;鱼池
fish_num			db		8d		dup	(?)	;鱼池中鱼的牌面值
who_will			db		3d		dup	(?)	;我手中上去的牌的指示变量，看看三张牌谁上去了
;***************************************
your_max_point	db		?
no					db		?,?
;***************************************

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.const
;****************************************游戏中所用是字符串
sz_num			db		'目前得分',0
szClassName		db		'MyClass',0
szCaptionMain	db		'~~~14点钓鱼~~~1.0单机版~~~',0
;****************************************实验用的字符串

;****************************************paint中所用到的字符串
sz_my				db		'玩家的牌',0
sz_your			db		'对手的牌',0
sz_fish			db		'鱼池--->>',0
sz_my_point		db		'玩家得分：%d',0
sz_your_point	db		'对手得分：%d',0
sz_my_aogo		db		'玩家上轮钓鱼情况',0
sz_your_aogo	db		'对手上轮钓鱼情况',0
;****************************************胜负字符串
sz_tishi			db		'请点“n”开始新的一局',0
sz_win			db		'你赢了',0
sz_lose			db		'你输了',0
sz_ping			db		'平手',0		

;****************************************实验用的字符串
sz_shiyang_pc	db	'鱼的值：%d',0
sz_gameover		db	'game over!',0
sz_shiyan		db	'随机数：%d',0
sz_computer_fish	db	'代替电脑钓鱼',0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 代码段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.code
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 窗口过程
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_proc_help	proc	uses	ebx esi edi	hwnd,wMsg,wParam,lParam
	
				mov		eax,wMsg
				.if		eax	==	WM_CLOSE
							invoke	EndDialog,hwnd,NULL
				.elseif	eax	==	WM_INITDIALOG

				.elseif	eax	==	WM_COMMAND

				.else
							mov		eax,FALSE
							ret
				.endif
				mov		eax,TRUE
				ret

_proc_help	endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_proc_me	proc	uses	ebx esi edi	hwnd,wMsg,wParam,lParam
			local		@stPs:PAINTSTRUCT
			local		@dw
			local		@hDc

			mov		eax,wMsg
			.if		eax	==	WM_CLOSE
						invoke	EndDialog,hwnd,NULL
			.elseif	eax	==	WM_PAINT
						invoke	BeginPaint,hwnd,addr @stPs
						mov		@hDc,eax
						invoke	BitBlt,@hDc,5,10,120,120,hDc_me,0,0,SRCCOPY	
						invoke	EndPaint,hwnd,addr @stPs
						
			.elseif	eax	==	WM_INITDIALOG
						invoke	GetDC,hWinMain
						mov	   @hDc,eax
						;***
						invoke	CreateCompatibleDC,@hDc
						mov	   hDc_me,eax
						invoke	ReleaseDC,hwnd,@hDc
						;***
						mov		@dw,IDB_4
						invoke   LoadBitmap,hInstance,@dw
						;***
						invoke	SelectObject,hDc_me,eax  
						;***
			.elseif	eax	==	WM_COMMAND

			.else
						mov		eax,FALSE
						ret
			.endif
			mov		eax,TRUE
			ret

_proc_me	endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_LoadRes			proc		uses ebx edi esi	;装载资源的子程序
		local		@hDc
		
		invoke	GetDC,hWinMain
		mov	   @hDc,eax
		
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      invoke	CreateCompatibleDC,@hDc
		mov	   hDc_map,eax
      ;invoke	ReleaseDC,hWinMain,@hDc
		;****************
		mov		dwNowBack,IDB_1
      invoke   LoadBitmap,hInstance,dwNowBack
		;****************
		invoke	SelectObject,hDc_map,eax  

		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      invoke	CreateCompatibleDC,@hDc
		mov	   hDc_back,eax
      ;invoke	ReleaseDC,hWinMain,@hDc
		;****************
		mov		dwNowBack,IDB_2
      invoke   LoadBitmap,hInstance,dwNowBack
		;****************
		invoke	SelectObject,hDc_back,eax  

		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      invoke	CreateCompatibleDC,@hDc
		mov	   hDc_kong,eax
      invoke	ReleaseDC,hWinMain,@hDc
		;****************
		mov		dwNowBack,IDB_3
      invoke   LoadBitmap,hInstance,dwNowBack
		;****************
		invoke	SelectObject,hDc_kong,eax  

		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
		ret

_LoadRes			endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
MAP_Paint		proc		uses ebx edi esi Dc:DWORD	;paint消息刷新的子程序
					local		@stRect:RECT
					
					;*************写游戏信息文字
					;RECT STRUCT
					;  left    dd      ?
					;  top     dd      ?
					;  right   dd      ?
					;  bottom  dd      ?
					;RECT ENDS
					;***对手字符串
					invoke	GetClientRect,hWinMain,addr	@stRect
					mov		@stRect.left,220d
					invoke	DrawText,Dc,addr	sz_your,-1,addr	@stRect,DT_SINGLELINE
					;***玩家字符串
					mov		@stRect.top,530d
					invoke	DrawText,Dc,addr	sz_my,-1,addr	@stRect,DT_SINGLELINE
					;***我得分情况字符串
					mov		@stRect.left,5d
					mov		@stRect.top,425d
					mov		al,my_points
					invoke	wsprintf,addr	sz_printf,addr	sz_my_point,al
					invoke	DrawText,Dc,addr	sz_printf,-1,addr	@stRect,DT_SINGLELINE
					;***对手得分情况的字符串
					mov		@stRect.top,45d
					mov		al,your_points
					invoke	wsprintf,addr	sz_printf,addr	sz_your_point,al
					invoke	DrawText,Dc,addr	sz_printf,-1,addr	@stRect,DT_SINGLELINE
					;***鱼池
					mov		@stRect.top,260d
					invoke	DrawText,Dc,addr	sz_fish,-1,addr	@stRect,DT_SINGLELINE
					;***我上轮钓鱼情况字符串
					mov		@stRect.top,530d
					mov		@stRect.left,500d
					invoke	DrawText,Dc,addr	sz_my_aogo,-1,addr	@stRect,DT_SINGLELINE					
					;***对手上轮钓鱼情况字符串
					mov		@stRect.top,0
					invoke	DrawText,Dc,addr	sz_your_aogo,-1,addr	@stRect,DT_SINGLELINE
					;*************
					;*************	
					;*************对手的牌
					;lea		esi,your_hand
					;sub		eax,eax
					;mov		al,BYTE ptr	[esi]
					;.if		al	==	0
					;			invoke	BitBlt,Dc,width_bmp*2,30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					;.else		
					;			dec	al
					;			mov	cl,71d
					;			mul	cl
					;			invoke	BitBlt,Dc,width_bmp*2,30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY

					;.endif
					;**************
					;sub		eax,eax
					;mov		al,BYTE ptr	[esi+1]
					;.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*3,30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					;.else		
					;			dec	al
					;			mov	cl,71d
					;			mul	cl
					;			invoke	BitBlt,Dc,width_bmp*3,30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					;.endif
					;**************
					;sub		eax,eax
					;mov		al,BYTE ptr	[esi+2]
					;.if		al	==	0
					;			invoke	BitBlt,Dc,width_bmp*4,30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					;.else		
					;			dec	al
					;			mov	cl,71d
					;			mul	cl
					;			invoke	BitBlt,Dc,width_bmp*4,30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					;.endif
					;**************					
					;*************对手的牌
					invoke	BitBlt,Dc,width_bmp*2,30,width_bmp,height_bmp,hDc_back,0,0,SRCCOPY
					invoke	BitBlt,Dc,width_bmp*3,30,width_bmp,height_bmp,hDc_back,0,0,SRCCOPY
					invoke	BitBlt,Dc,width_bmp*4,30,width_bmp,height_bmp,hDc_back,0,0,SRCCOPY
					;*************对手上轮粘的牌
					lea		esi,your_aogo
					sub		eax,eax
					mov		al,BYTE ptr [esi]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*6,30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*6,30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,your_aogo
					sub		eax,eax
					mov		al,BYTE ptr [esi+1]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*7,30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*7,30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************					
					lea		esi,your_aogo
					sub		eax,eax
					mov		al,BYTE ptr [esi+2]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*8,30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*8,30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,your_aogo
					sub		eax,eax
					mov		al,BYTE ptr [esi+3]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*9,30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*9,30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					;*************
					;*************
					;*************鱼池中的牌
					lea		esi,fishes
					sub		eax,eax
					mov		al,BYTE ptr [esi]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*1,height_bmp*2+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*1,height_bmp*2+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,fishes
					sub		eax,eax
					mov		al,BYTE ptr [esi+1]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*2,height_bmp*2+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*2,height_bmp*2+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,fishes
					sub		eax,eax
					mov		al,BYTE ptr [esi+2]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*3,height_bmp*2+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*3,height_bmp*2+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,fishes
					sub		eax,eax
					mov		al,BYTE ptr [esi+3]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*4,height_bmp*2+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*4,height_bmp*2+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,fishes
					sub		eax,eax
					mov		al,BYTE ptr [esi+4]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*5,height_bmp*2+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*5,height_bmp*2+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,fishes
					sub		eax,eax
					mov		al,BYTE ptr [esi+5]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*6,height_bmp*2+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*6,height_bmp*2+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,fishes
					sub		eax,eax
					mov		al,BYTE ptr [esi+6]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*7,height_bmp*2+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*7,height_bmp*2+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,fishes
					sub		eax,eax
					mov		al,BYTE ptr [esi+7]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*8,height_bmp*2+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*8,height_bmp*2+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					;*************
					;*************玩家的牌
					lea		esi,my_hand
					sub		eax,eax
					mov		al,BYTE ptr	[esi]
					.if		al	==	0
								invoke	BitBlt,Dc,my_hand1_x,my_hand1_y,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else		
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,my_hand1_x,my_hand1_y,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY

					.endif
					;**************
					sub		eax,eax
					mov		al,BYTE ptr	[esi+1]
					.if		al	==	0
								invoke	BitBlt,Dc,my_hand2_x,my_hand2_y,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else		
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,my_hand2_x,my_hand2_y,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;**************
					sub		eax,eax
					mov		al,BYTE ptr	[esi+2]
					.if		al	==	0
								invoke	BitBlt,Dc,my_hand3_x,my_hand3_y,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else		
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,my_hand3_x,my_hand3_y,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;**************
					;*************
					;*************
					;*************玩家上轮粘的牌
					lea		esi,my_aogo
					sub		eax,eax
					mov		al,BYTE ptr [esi]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*6,height_bmp*4+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*6,height_bmp*4+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,my_aogo
					sub		eax,eax
					mov		al,BYTE ptr [esi+1]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*7,height_bmp*4+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*7,height_bmp*4+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,my_aogo
					sub		eax,eax
					mov		al,BYTE ptr [esi+2]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*8,height_bmp*4+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*8,height_bmp*4+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					lea		esi,my_aogo
					sub		eax,eax
					mov		al,BYTE ptr [esi+3]
					.if		al	==	0
								invoke	BitBlt,Dc,width_bmp*9,height_bmp*4+30,width_bmp,height_bmp,hDc_kong,0,0,SRCCOPY
					.else
								dec	al
								mov	cl,71d
								mul	cl
								invoke	BitBlt,Dc,width_bmp*9,height_bmp*4+30,width_bmp,height_bmp,hDc_map,eax,0,SRCCOPY
					.endif
					;*************
					;*************
					;*************
					;*************


					ret

MAP_Paint		endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
give_puke		proc	uses ebx edi esi who_hand:DWORD,who_num:DWORD	;发牌的子程序

					invoke	InvalidateRect,hWinMain,NULL,TRUE

					;*******************判断游戏是否结束
							lea	esi,my_hand
							lea	edi,your_hand
							lea	ebx,puke
							mov	edx,lp_puke_head

							mov	al,BYTE ptr [ebx+edx]				;未发的牌，取出一张

							mov	ah,BYTE ptr [esi]				;手中的牌1
							mov	cl,BYTE ptr [esi+1]			;手中的牌2
							mov	ch,BYTE ptr [esi+2]			;手中的牌3

							.if	ax	==	0	&&	cx	==	0			;手中的没牌且没牌可发的时候
									
									;mov	al,BYTE ptr [edi]	
									;mov	ah,BYTE ptr [edi+1]
									;mov	cl,BYTE ptr [edi+2]

									;.if	ax	==	0	&&	cl	==	0	;对手手中没牌

											;*******************************
											lea		esi,my_points	
											lea		edi,your_points
											mov		al,BYTE ptr	[esi]
											mov		bl,BYTE ptr [edi]
											.if		al	>	bl
														invoke	MessageBox,hWinMain,addr sz_win,addr sz_tishi,MB_OK
											.elseif	al	<	bl
														invoke	MessageBox,hWinMain,addr sz_lose,addr sz_tishi,MB_OK
											.elseif	al	==	bl
														invoke	MessageBox,hWinMain,addr sz_ping,addr sz_tishi,MB_OK
											.endif	
											
											mov		eax,'n'
											invoke	PostMessage,hWinMain,WM_CHAR,eax,eax
											;invoke	PostMessage,hWinMain,WM_NEWGAME,NULL,NULL
											ret	
											;*******************************

									;.endif
							.endif

					;*******************
	

					mov	edi,who_hand
					lea	esi,puke
					mov	edx,who_num
					mov	ebx,lp_puke_head
					mov	ecx,3
					give1:

							mov	al,BYTE ptr [edi]
							.if	al
									jmp	give2
							.endif

							mov	al,BYTE ptr [esi+ebx]
							mov	BYTE ptr [edi],al
							;****************	;把刚发的牌的大小放到my_hand_num的相应的位置上去
							.if		al < 14d

							.elseif	al	> 13d	&&	al	<	27d
										sub	al,13d
							.elseif	al	> 26d &&	al <  40d
										sub	al,26d
							.elseif	al > 39d && al	<	53d
										sub	al,39d
							.endif
							mov		BYTE ptr [edx],al
							;****************
							inc   ebx

							give2:
									inc   edi
									inc	edx
									loop  give1

							mov	lp_puke_head,ebx

					ret

give_puke		endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_jingong			proc	uses ebx edi esi					;我钓鱼的子程序

					mov	eax,hitpoint.x						;鼠标左键单击时的坐标
					mov	ebx,hitpoint.y
					;********************这里的功能，就是把手里的第1张牌，抽上、放下和相关变量的处理
					.if		eax	>	my_hand1_x		&&	ebx	>	my_hand1_y	\
							&&	eax	<	width_bmp*2+71	&&	ebx	<	height_bmp*4+30+96

							;*************************************;这里判断手中有没有牌 
							lea		esi,my_hand						  ;要是没有（0），就不执行任何操作              
							mov		al,BYTE ptr [esi]				                                           
							.if		al	==	0
										ret
							.endif
							;**************************************
							.if		my_hand1_y	==	height_bmp*4+30-16
																					
										add		my_hand1_y,16				;下降		
										mov		eax,my_will_fish
										dec      eax
										mov		my_will_fish,eax
										;******************
										lea		esi,who_will
										mov		BYTE ptr [esi],0
										;******************
							.elseif	my_hand1_y	==	height_bmp*4+30
										sub		my_hand1_y,16				;上升
										mov		eax,my_will_fish
										inc      eax
										mov		my_will_fish,eax
										;******************
										lea		esi,who_will
										mov		BYTE ptr [esi],1
										;******************
							.endif
							invoke	InvalidateRect,hWinMain,NULL,TRUE

							ret
					.endif
					;********************这里的功能，就是把手里的第2张牌，抽上、放下和相关变量的处理
					.if		eax	>	my_hand2_x		&&	ebx	>	my_hand2_y	\
							&&	eax	<	width_bmp*3+71	&&	ebx	<	height_bmp*4+30+96	

							;*************************************;这里判断手中有没有牌 
							lea		esi,my_hand						  ;要是没有（0），就不执行任何操作              
							mov		al,BYTE ptr [esi+1]				                                           
							.if		al	==	0
										ret
							.endif
							;**************************************
							.if		my_hand2_y	==	height_bmp*4+30-16
										add		my_hand2_y,16
										mov		eax,my_will_fish
										dec      eax
										mov		my_will_fish,eax
										;******************
										lea		esi,who_will
										mov		BYTE ptr [esi+1],0
										;******************
							.elseif	my_hand2_y	==	height_bmp*4+30
										sub		my_hand2_y,16
										mov		eax,my_will_fish
										inc      eax
										mov		my_will_fish,eax
										;******************
										lea		esi,who_will
										mov		BYTE ptr [esi+1],1
										;******************
							.endif
							invoke	InvalidateRect,hWinMain,NULL,TRUE

							ret
					.endif
					;********************这里的功能，就是把手里的第3张牌，抽上、放下和相关变量的处理
					.if		eax	>	my_hand3_x		&&	ebx	>	my_hand3_y	\
							&&	eax	<	width_bmp*4+71	&&	ebx	<	height_bmp*4+30+96	

							;*************************************;这里判断手中有没有牌 
							lea		esi,my_hand						  ;要是没有（0），就不执行任何操作              
							mov		al,BYTE ptr [esi+2]				                                           
							.if		al	==	0
										ret
							.endif
							;**************************************
							.if		my_hand3_y	==	height_bmp*4+30-16
										add		my_hand3_y,16
										mov		eax,my_will_fish
										dec      eax
										mov		my_will_fish,eax
										;******************
										lea		esi,who_will
										mov		BYTE ptr [esi+2],0
										;******************
							.elseif	my_hand3_y	==	height_bmp*4+30
										sub		my_hand3_y,16
										mov		eax,my_will_fish
										inc      eax
										mov		my_will_fish,eax
										;******************
										lea		esi,who_will
										mov		BYTE ptr [esi+2],1
										;******************
							.endif
							invoke	InvalidateRect,hWinMain,NULL,TRUE

							ret
					.endif
					;********************
					;********************
					push		eax
					;***********
					mov		eax,who_fish
					.if		eax

								pop	eax

								ret
					.endif
					;***********
					pop		eax
					;********************如果是这里就调用“粘”的子程序11111111111111111111111111111111111111111111111111
					.if		eax	>	width_bmp*1		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*2		&&	ebx	<	height_bmp*2+30+96	
							;*******************
							mov	eax,my_will_fish	;看看手上出去的牌有几张
							.if	eax					;不是0张，就钓鱼
									;*************
									sub	edx,edx
									mov	ecx,3d
									lea	esi,who_will
									lea	edi,my_hand_num
									kill_fish1_1:
											mov	al,BYTE ptr [esi]
											.if	al
													mov	al,BYTE ptr [edi]
													add	dl,al
											.endif
													inc	esi
													inc   edi

											loop	kill_fish1_1
									;******
									lea	esi,fishes
									mov	al,BYTE ptr [esi]
									;******
									.if		al < 14d

									.elseif	al	> 13d	&&	al	<	27d
												sub	al,13d
									.elseif	al	> 26d &&	al <  40d
												sub	al,26d
									.elseif	al > 39d && al	<	53d
												sub	al,39d
									.endif
									;*******
									add		dl,al
									.if		dl	==	14d	;能钓，下面是钓鱼功能部分代码
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************把我手里的出去的牌，放到my_aogo中
																			;cjc需要解决的问题是在次同时，完成算分功能
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish1_2:
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;为了获得本次钓鱼的总得分，把所有参与钓鱼的牌都加到bl中
																mov	BYTE ptr [edi],0
																mov	BYTE ptr [edx],al
																mov	BYTE ptr [esi],0
														.else
																mov	BYTE ptr [edx],0
														.endif
																inc	esi
																inc   edi
																inc	edx

														loop	kill_fish1_2
												;**********************把fishes中的被钓的鱼，放到my_aogo中
												lea	esi,fishes
												lea	edi,fish_num
												mov	BYTE ptr [edi],0
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************计算本轮得分，并加到my_points中去
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;看看手上出去的牌有几张
												.if		eax	==	1
															inc	bl
															inc	bl
												.elseif	eax	==	2
															inc	bl
															inc	bl
															inc	bl
												.elseif	eax	==	3
															inc	bl
															inc   bl
															inc	bl
															inc	bl
												.endif
												mov		bh,my_points
												add		bh,bl
												mov		my_points,bh
												;**********************如果玩家手中没牌了,就发牌
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************该清0的清0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************一些该还原的数据还原
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;不能钓，返回
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;是0张，返回
									ret
							.endif
							;*******************
					.endif
					;********************222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
					.if		eax	>	width_bmp*2		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*3		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;看看手上出去的牌有几张
							.if	eax					;不是0张，就钓鱼
									;*************
									sub	edx,edx
									mov	ecx,3d
									lea	esi,who_will
									lea	edi,my_hand_num
									kill_fish2_1:
											mov	al,BYTE ptr [esi]
											.if	al
													mov	al,BYTE ptr [edi]
													add	dl,al
											.endif
													inc	esi
													inc   edi

											loop	kill_fish2_1
									;******
									lea	esi,fishes
									inc	esi
									mov	al,BYTE ptr [esi]
									;******
									.if		al < 14d

									.elseif	al	> 13d	&&	al	<	27d
												sub	al,13d
									.elseif	al	> 26d &&	al <  40d
												sub	al,26d
									.elseif	al > 39d && al	<	53d
												sub	al,39d
									.endif
									;*******
									add		dl,al
									.if		dl	==	14d	;能钓，下面是钓鱼功能部分代码
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************把我手里的出去的牌，放到my_aogo中
																			;cjc需要解决的问题是在次同时，完成算分功能
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish2_2:
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;为了获得本次钓鱼的总得分，把所有参与钓鱼的牌都加到bl中
																mov	BYTE ptr [edi],0
																mov	BYTE ptr [edx],al
																mov	BYTE ptr [esi],0
														.else
																mov	BYTE ptr [edx],0
														.endif
																inc	esi
																inc   edi
																inc	edx

														loop	kill_fish2_2
												;**********************把fishes中的被钓的鱼，放到my_aogo中
												lea	esi,fishes
												lea	edi,fish_num
												inc	edi
												mov	BYTE ptr [edi],0
												inc	esi
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************计算本轮得分，并加到my_points中去
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;看看手上出去的牌有几张
												.if		eax	==	1
															inc	bl
															inc	bl
												.elseif	eax	==	2
															inc	bl
															inc	bl
															inc	bl
												.elseif	eax	==	3
															inc	bl
															inc   bl
															inc	bl
															inc	bl
												.endif
												mov		bh,my_points
												add		bh,bl
												mov		my_points,bh
												;**********************如果玩家手中没牌了,就发牌
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************该清0的清0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************一些该还原的数据还原
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;不能钓，返回
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;是0张，返回
									ret
							.endif
							;*******************
					.endif
					;********************33333333333333333333333333333333333333333333333
					.if		eax	>	width_bmp*3		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*4		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;看看手上出去的牌有几张
							.if	eax					;不是0张，就钓鱼
									;*************
									sub	edx,edx
									mov	ecx,3d
									lea	esi,who_will
									lea	edi,my_hand_num
									kill_fish3_1:								;?????????????????????????????????????????????
											mov	al,BYTE ptr [esi]
											.if	al
													mov	al,BYTE ptr [edi]
													add	dl,al
											.endif
													inc	esi
													inc   edi

											loop	kill_fish3_1				;?????????????????????????????????????????????
									;******
									lea	esi,fishes
									inc	esi
									inc	esi									;?????????????????????????????????????????????
									mov	al,BYTE ptr [esi]
									;******
									.if		al < 14d

									.elseif	al	> 13d	&&	al	<	27d
												sub	al,13d
									.elseif	al	> 26d &&	al <  40d
												sub	al,26d
									.elseif	al > 39d && al	<	53d
												sub	al,39d
									.endif
									;*******
									add		dl,al
									.if		dl	==	14d	;能钓，下面是钓鱼功能部分代码
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************把我手里的出去的牌，放到my_aogo中
																			;cjc需要解决的问题是在次同时，完成算分功能
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish3_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;为了获得本次钓鱼的总得分，把所有参与钓鱼的牌都加到bl中
																mov	BYTE ptr [edi],0
																mov	BYTE ptr [edx],al
																mov	BYTE ptr [esi],0
														.else
																mov	BYTE ptr [edx],0
														.endif
																inc	esi
																inc   edi
																inc	edx

														loop	kill_fish3_2			;????????????????????????????????????????????????
												;**********************把fishes中的被钓的鱼，放到my_aogo中
												lea	esi,fishes
												lea	edi,fish_num
												inc	edi
												inc	edi
												mov	BYTE ptr [edi],0
												inc	esi
												inc	esi								;?????????????????????????????????????????????????
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************计算本轮得分，并加到my_points中去
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;看看手上出去的牌有几张
												.if		eax	==	1
															inc	bl
															inc	bl
												.elseif	eax	==	2
															inc	bl
															inc	bl
															inc	bl
												.elseif	eax	==	3
															inc	bl
															inc   bl
															inc	bl
															inc	bl
												.endif
												mov		bh,my_points
												add		bh,bl
												mov		my_points,bh
												;**********************如果玩家手中没牌了,就发牌
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************该清0的清0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************一些该还原的数据还原
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;不能钓，返回
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;是0张，返回
									ret
							.endif
							;*******************
					.endif
					;********************44444444444444444444444444444444444444444444444
					.if		eax	>	width_bmp*4		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*5		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;看看手上出去的牌有几张
							.if	eax					;不是0张，就钓鱼
									;*************
									sub	edx,edx
									mov	ecx,3d
									lea	esi,who_will
									lea	edi,my_hand_num
									kill_fish4_1:								;?????????????????????????????????????????????
											mov	al,BYTE ptr [esi]
											.if	al
													mov	al,BYTE ptr [edi]
													add	dl,al
											.endif
													inc	esi
													inc   edi

											loop	kill_fish4_1				;?????????????????????????????????????????????
									;******
									lea	esi,fishes
									inc	esi
									inc	esi									;?????????????????????????????????????????????
									inc	esi
									mov	al,BYTE ptr [esi]
									;******
									.if		al < 14d

									.elseif	al	> 13d	&&	al	<	27d
												sub	al,13d
									.elseif	al	> 26d &&	al <  40d
												sub	al,26d
									.elseif	al > 39d && al	<	53d
												sub	al,39d
									.endif
									;*******
									add		dl,al
									.if		dl	==	14d	;能钓，下面是钓鱼功能部分代码
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************把我手里的出去的牌，放到my_aogo中
																			;cjc需要解决的问题是在次同时，完成算分功能
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish4_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;为了获得本次钓鱼的总得分，把所有参与钓鱼的牌都加到bl中
																mov	BYTE ptr [edi],0
																mov	BYTE ptr [edx],al
																mov	BYTE ptr [esi],0
														.else
																mov	BYTE ptr [edx],0
														.endif
																inc	esi
																inc   edi
																inc	edx

														loop	kill_fish4_2			;????????????????????????????????????????????????
												;**********************把fishes中的被钓的鱼，放到my_aogo中
												lea	esi,fishes
												lea	edi,fish_num
												inc	edi
												inc	edi
												inc	edi
												mov	BYTE ptr [edi],0
												inc	esi
												inc	esi
												inc	esi								;?????????????????????????????????????????????????
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************计算本轮得分，并加到my_points中去
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;看看手上出去的牌有几张
												.if		eax	==	1
															inc	bl
															inc	bl
												.elseif	eax	==	2
															inc	bl
															inc	bl
															inc	bl
												.elseif	eax	==	3
															inc	bl
															inc   bl
															inc	bl
															inc	bl
												.endif
												mov		bh,my_points
												add		bh,bl
												mov		my_points,bh
												;**********************如果玩家手中没牌了,就发牌
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************该清0的清0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************一些该还原的数据还原
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;不能钓，返回
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;是0张，返回
									ret
							.endif
							;*******************
					.endif
					;********************555555555555555555555555555555555555555555
					.if		eax	>	width_bmp*5		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*6		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;看看手上出去的牌有几张
							.if	eax					;不是0张，就钓鱼
									;*************
									sub	edx,edx
									mov	ecx,3d
									lea	esi,who_will
									lea	edi,my_hand_num
									kill_fish5_1:								;?????????????????????????????????????????????
											mov	al,BYTE ptr [esi]
											.if	al
													mov	al,BYTE ptr [edi]
													add	dl,al
											.endif
													inc	esi
													inc   edi

											loop	kill_fish5_1				;?????????????????????????????????????????????
									;******
									lea	esi,fishes
									inc	esi
									inc	esi
									inc	esi
									inc	esi									;?????????????????????????????????????????????
									mov	al,BYTE ptr [esi]
									;******
									.if		al < 14d

									.elseif	al	> 13d	&&	al	<	27d
												sub	al,13d
									.elseif	al	> 26d &&	al <  40d
												sub	al,26d
									.elseif	al > 39d && al	<	53d
												sub	al,39d
									.endif
									;*******
									add		dl,al
									.if		dl	==	14d	;能钓，下面是钓鱼功能部分代码
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************把我手里的出去的牌，放到my_aogo中
																			;cjc需要解决的问题是在次同时，完成算分功能
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish5_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;为了获得本次钓鱼的总得分，把所有参与钓鱼的牌都加到bl中
																mov	BYTE ptr [edi],0
																mov	BYTE ptr [edx],al
																mov	BYTE ptr [esi],0
														.else
																mov	BYTE ptr [edx],0
														.endif
																inc	esi
																inc   edi
																inc	edx

														loop	kill_fish5_2			;????????????????????????????????????????????????
												;**********************把fishes中的被钓的鱼，放到my_aogo中
												lea	esi,fishes
												lea	edi,fish_num
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												mov	BYTE ptr [edi],0
												inc	esi
												inc	esi
												inc	esi
												inc	esi								;?????????????????????????????????????????????????
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************计算本轮得分，并加到my_points中去
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;看看手上出去的牌有几张
												.if		eax	==	1
															inc	bl
															inc	bl
												.elseif	eax	==	2
															inc	bl
															inc	bl
															inc	bl
												.elseif	eax	==	3
															inc	bl
															inc   bl
															inc	bl
															inc	bl
												.endif
												mov		bh,my_points
												add		bh,bl
												mov		my_points,bh
												;**********************如果玩家手中没牌了,就发牌
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************该清0的清0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************一些该还原的数据还原
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;不能钓，返回
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;是0张，返回
									ret
							.endif
							;*******************
					.endif
					;********************66666666666666666666666666666666666666666666
					.if		eax	>	width_bmp*6		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*7		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;看看手上出去的牌有几张
							.if	eax					;不是0张，就钓鱼
									;*************
									sub	edx,edx
									mov	ecx,3d
									lea	esi,who_will
									lea	edi,my_hand_num
									kill_fish6_1:								;?????????????????????????????????????????????
											mov	al,BYTE ptr [esi]
											.if	al
													mov	al,BYTE ptr [edi]
													add	dl,al
											.endif
													inc	esi
													inc   edi

											loop	kill_fish6_1				;?????????????????????????????????????????????
									;******
									lea	esi,fishes
									inc	esi
									inc	esi
									inc	esi
									inc	esi
									inc	esi									;?????????????????????????????????????????????
									mov	al,BYTE ptr [esi]
									;******
									.if		al < 14d

									.elseif	al	> 13d	&&	al	<	27d
												sub	al,13d
									.elseif	al	> 26d &&	al <  40d
												sub	al,26d
									.elseif	al > 39d && al	<	53d
												sub	al,39d
									.endif
									;*******
									add		dl,al
									.if		dl	==	14d	;能钓，下面是钓鱼功能部分代码
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************把我手里的出去的牌，放到my_aogo中
																			;cjc需要解决的问题是在次同时，完成算分功能
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish6_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;为了获得本次钓鱼的总得分，把所有参与钓鱼的牌都加到bl中
																mov	BYTE ptr [edi],0
																mov	BYTE ptr [edx],al
																mov	BYTE ptr [esi],0
														.else
																mov	BYTE ptr [edx],0
														.endif
																inc	esi
																inc   edi
																inc	edx

														loop	kill_fish6_2			;????????????????????????????????????????????????
												;**********************把fishes中的被钓的鱼，放到my_aogo中
												lea	esi,fishes
												lea	edi,fish_num
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												mov	BYTE ptr [edi],0
												inc	esi
												inc	esi
												inc	esi
												inc	esi
												inc	esi								;?????????????????????????????????????????????????
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************计算本轮得分，并加到my_points中去
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;看看手上出去的牌有几张
												.if		eax	==	1
															inc	bl
															inc	bl
												.elseif	eax	==	2
															inc	bl
															inc	bl
															inc	bl
												.elseif	eax	==	3
															inc	bl
															inc   bl
															inc	bl
															inc	bl
												.endif
												mov		bh,my_points
												add		bh,bl
												mov		my_points,bh
												;**********************如果玩家手中没牌了,就发牌
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************该清0的清0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************一些该还原的数据还原
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;不能钓，返回
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;是0张，返回
									ret
							.endif
							;*******************
					.endif
					;********************77777777777777777777777777777777777777777777
					.if		eax	>	width_bmp*7		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*8		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;看看手上出去的牌有几张
							.if	eax					;不是0张，就钓鱼
									;*************
									sub	edx,edx
									mov	ecx,3d
									lea	esi,who_will
									lea	edi,my_hand_num
									kill_fish7_1:								;?????????????????????????????????????????????
											mov	al,BYTE ptr [esi]
											.if	al
													mov	al,BYTE ptr [edi]
													add	dl,al
											.endif
													inc	esi
													inc   edi

											loop	kill_fish7_1				;?????????????????????????????????????????????
									;******
									lea	esi,fishes
									inc	esi
									inc	esi
									inc	esi
									inc	esi
									inc	esi
									inc	esi									;?????????????????????????????????????????????
									mov	al,BYTE ptr [esi]
									;******
									.if		al < 14d

									.elseif	al	> 13d	&&	al	<	27d
												sub	al,13d
									.elseif	al	> 26d &&	al <  40d
												sub	al,26d
									.elseif	al > 39d && al	<	53d
												sub	al,39d
									.endif
									;*******
									add		dl,al
									.if		dl	==	14d	;能钓，下面是钓鱼功能部分代码
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************把我手里的出去的牌，放到my_aogo中
																			;cjc需要解决的问题是在次同时，完成算分功能
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish7_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;为了获得本次钓鱼的总得分，把所有参与钓鱼的牌都加到bl中
																mov	BYTE ptr [edi],0
																mov	BYTE ptr [edx],al
																mov	BYTE ptr [esi],0
														.else
																mov	BYTE ptr [edx],0
														.endif
																inc	esi
																inc   edi
																inc	edx

														loop	kill_fish7_2			;????????????????????????????????????????????????
												;**********************把fishes中的被钓的鱼，放到my_aogo中
												lea	esi,fishes
												lea	edi,fish_num
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												mov	BYTE ptr [edi],0
												inc	esi
												inc	esi
												inc	esi
												inc	esi
												inc	esi
												inc	esi								;?????????????????????????????????????????????????
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************计算本轮得分，并加到my_points中去
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;看看手上出去的牌有几张
												.if		eax	==	1
															inc	bl
															inc	bl
												.elseif	eax	==	2
															inc	bl
															inc	bl
															inc	bl
												.elseif	eax	==	3
															inc	bl
															inc   bl
															inc	bl
															inc	bl
												.endif
												mov		bh,my_points
												add		bh,bl
												mov		my_points,bh
												;**********************如果玩家手中没牌了,就发牌
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************该清0的清0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************一些该还原的数据还原
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;不能钓，返回
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;是0张，返回
									ret
							.endif
							;*******************
					.endif
					;********************88888888888888888888888888888888888888888888
					.if		eax	>	width_bmp*8		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*9		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;看看手上出去的牌有几张
							.if	eax					;不是0张，就钓鱼
									;*************
									sub	edx,edx
									mov	ecx,3d
									lea	esi,who_will
									lea	edi,my_hand_num
									kill_fish8_1:								;?????????????????????????????????????????????
											mov	al,BYTE ptr [esi]
											.if	al
													mov	al,BYTE ptr [edi]
													add	dl,al
											.endif
													inc	esi
													inc   edi

											loop	kill_fish8_1				;?????????????????????????????????????????????
									;******
									lea	esi,fishes
									inc	esi
									inc	esi
									inc	esi
									inc	esi
									inc	esi
									inc	esi
									inc	esi									;?????????????????????????????????????????????
									mov	al,BYTE ptr [esi]
									;******
									.if		al < 14d

									.elseif	al	> 13d	&&	al	<	27d
												sub	al,13d
									.elseif	al	> 26d &&	al <  40d
												sub	al,26d
									.elseif	al > 39d && al	<	53d
												sub	al,39d
									.endif
									;*******
									add		dl,al
									.if		dl	==	14d	;能钓，下面是钓鱼功能部分代码
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************把我手里的出去的牌，放到my_aogo中
																			;cjc需要解决的问题是在次同时，完成算分功能
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish8_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;为了获得本次钓鱼的总得分，把所有参与钓鱼的牌都加到bl中
																mov	BYTE ptr [edi],0
																mov	BYTE ptr [edx],al
																mov	BYTE ptr [esi],0
														.else
																mov	BYTE ptr [edx],0
														.endif
																inc	esi
																inc   edi
																inc	edx

														loop	kill_fish8_2			;????????????????????????????????????????????????
												;**********************把fishes中的被钓的鱼，放到my_aogo中
												lea	esi,fishes
												lea	edi,fish_num
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												inc	edi
												mov	BYTE ptr [edi],0
												inc	esi
												inc	esi
												inc	esi
												inc	esi
												inc	esi
												inc	esi
												inc	esi								;?????????????????????????????????????????????????
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************计算本轮得分，并加到my_points中去
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;看看手上出去的牌有几张
												.if		eax	==	1
															inc	bl
															inc	bl
												.elseif	eax	==	2
															inc	bl
															inc	bl
															inc	bl
												.elseif	eax	==	3
															inc	bl
															inc   bl
															inc	bl
															inc	bl
												.endif
												mov		bh,my_points
												add		bh,bl
												mov		my_points,bh
												;**********************如果玩家手中没牌了,就发牌
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************该清0的清0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************一些该还原的数据还原
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;不能钓，返回
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;是0张，返回
									ret
							.endif
							;*******************
					.endif
					;********************
					ret
_jingong	endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_free_fish		proc	uses ebx edi esi	;这个是我的逗牌的处理子程序
					local	go_puke:BYTE 


					;*******************
					mov	eax,my_will_fish	;看看手上出去的牌是不是只有一张，因为是不能逗两张牌的！
					.if	eax	==	1			;是一张，继续

					.else							;不是一张，不能逗，返回
							jmp	free_fish1
					.endif
					;*******************
					lea	edi,fishes			;逗牌的初始化
					lea	esi,my_hand
					;mov	,lp_puke_weiba
					;*******************
					mov	eax,hitpoint.x		;鼠标右键单击时的坐标
					mov	ebx,hitpoint.y
					;********************处理此处的“豆牌”111111111111111111111111111111111111111111
					.if		eax	>	width_bmp*1		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*2		&&	ebx	<	height_bmp*2+30+96	
							
							mov	al,BYTE ptr [edi]		;看看右击的地方有没有鱼
							mov	go_puke,al
							;***
							mov	my_will_fish,0	;手上出去的牌逗出去，所以my_will_fish变成0张,手上现在没有牌出去
							;******************************************
							lea	eax,who_will
							mov	cl,BYTE ptr [eax]
							mov	ch,BYTE ptr [eax+1]
							mov	bl,BYTE ptr [eax+2]
							.if		cl	==	1	
										mov	BYTE ptr [eax],0
							.elseif	ch	==	1				
										inc	esi
										mov	BYTE ptr [eax+1],0
							.elseif	bl	==	1
										inc	esi
										inc	esi
										mov	BYTE ptr [eax+2],0
							.endif	
							;******************************************
							mov	al,BYTE ptr [esi]
							mov	BYTE ptr [esi],0
							mov	BYTE ptr [edi],al
							;***把牌值放到fish_num的相应的位置上去
							lea	eax,my_hand
							sub	esi,eax
							lea	eax,my_hand_num
							add	eax,esi
							mov	bl,BYTE ptr [eax]
							lea	esi,fish_num
							mov	BYTE ptr [esi],bl
							;***
							mov	my_hand1_y,height_bmp*4+30		
							mov	my_hand2_y,height_bmp*4+30
							mov	my_hand3_y,height_bmp*4+30
							;******************************************把go_puke放到puke最后面去
							mov	al,go_puke
							.if	al
									mov	ebx,lp_puke_weiba
									lea	edx,puke
									mov	BYTE ptr	[edx+ebx],al
									inc	ebx
									mov	lp_puke_weiba,ebx
							.else
							.endif
							;******************************************逗牌完成,发牌		
							lea		esi,my_hand
							lea		edi,my_hand_num
							invoke	give_puke,esi,edi
							;******************************************
							invoke	InvalidateRect,hWinMain,NULL,TRUE	;刷新地图
							ret														;返回

					.endif
					;********************2222222222222222222222222222222222222222222222
					.if		eax	>	width_bmp*2		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*3		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+1]		;看看右击的地方有没有鱼
							mov	go_puke,al
									mov	my_will_fish,0	;手上出去的牌逗出去，所以my_will_fish变成0张,手上现在没有牌出去
									;******************************************
									lea	eax,who_will
									mov	cl,BYTE ptr [eax]
									mov	ch,BYTE ptr [eax+1]
									mov	bl,BYTE ptr [eax+2]
									.if		cl	==	1	
												mov	BYTE ptr [eax],0
									.elseif	ch	==	1				
												inc	esi
												mov	BYTE ptr [eax+1],0
									.elseif	bl	==	1
												inc	esi
												inc	esi
												mov	BYTE ptr [eax+2],0
									.endif		
									;******************************************
									mov	al,BYTE ptr [esi]
									mov	BYTE ptr [esi],0
									mov	BYTE ptr [edi+1],al
									;***把牌值放到fish_num的相应的位置上去
									lea	eax,my_hand
									sub	esi,eax
									lea	eax,my_hand_num
									add	eax,esi
									mov	bl,BYTE ptr [eax]
									lea	esi,fish_num
									mov	BYTE ptr [esi+1],bl
									;***
									mov	my_hand1_y,height_bmp*4+30		
									mov	my_hand2_y,height_bmp*4+30
									mov	my_hand3_y,height_bmp*4+30
									;******************************************把go_puke放到puke最后面去
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************逗牌完成,发牌		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;刷新地图
									ret														;逗牌完成，返回

							;.else
							;		ret
							;.endif

							;ret	;没鱼的话，返回
					.endif
					;********************33333333333333333333333333333333333333333333333
					.if		eax	>	width_bmp*3		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*4		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+2]		;看看右击的地方有没有鱼
							mov	go_puke,al
									mov	my_will_fish,0	;手上出去的牌逗出去，所以my_will_fish变成0张,手上现在没有牌出去
									;******************************************
									lea	eax,who_will
									mov	cl,BYTE ptr [eax]
									mov	ch,BYTE ptr [eax+1]
									mov	bl,BYTE ptr [eax+2]
									.if		cl	==	1	
												mov	BYTE ptr [eax],0
									.elseif	ch	==	1				
												inc	esi
												mov	BYTE ptr [eax+1],0
									.elseif	bl	==	1
												inc	esi
												inc	esi
												mov	BYTE ptr [eax+2],0
									.endif		
									;******************************************
									mov	al,BYTE ptr [esi]
									mov	BYTE ptr [esi],0
									mov	BYTE ptr [edi+2],al
									;***把牌值放到fish_num的相应的位置上去
									lea	eax,my_hand
									sub	esi,eax
									lea	eax,my_hand_num
									add	eax,esi
									mov	bl,BYTE ptr [eax]
									lea	esi,fish_num
									mov	BYTE ptr [esi+2],bl
									;***
									mov	my_hand1_y,height_bmp*4+30		
									mov	my_hand2_y,height_bmp*4+30
									mov	my_hand3_y,height_bmp*4+30
									;******************************************把go_puke放到puke最后面去
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************逗牌完成,发牌		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;刷新地图
									ret														;逗牌完成，返回

							;.else
							;		ret
							;.endif

							;ret	;没鱼的话，返回
					.endif
					;********************44444444444444444444444444444444444444444444444
					.if		eax	>	width_bmp*4		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*5		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+3]		;看看右击的地方有没有鱼
							mov	go_puke,al
									mov	my_will_fish,0	;手上出去的牌逗出去，所以my_will_fish变成0张,手上现在没有牌出去
									;******************************************
									lea	eax,who_will
									mov	cl,BYTE ptr [eax]
									mov	ch,BYTE ptr [eax+1]
									mov	bl,BYTE ptr [eax+2]
									.if		cl	==	1	
												mov	BYTE ptr [eax],0
									.elseif	ch	==	1				
												inc	esi
												mov	BYTE ptr [eax+1],0
									.elseif	bl	==	1
												inc	esi
												inc	esi
												mov	BYTE ptr [eax+2],0
									.endif		
									;******************************************
									mov	al,BYTE ptr [esi]
									mov	BYTE ptr [esi],0
									mov	BYTE ptr [edi+3],al
									;***把牌值放到fish_num的相应的位置上去
									lea	eax,my_hand
									sub	esi,eax
									lea	eax,my_hand_num
									add	eax,esi
									mov	bl,BYTE ptr [eax]
									lea	esi,fish_num
									mov	BYTE ptr [esi+3],bl
									;***
									mov	my_hand1_y,height_bmp*4+30		
									mov	my_hand2_y,height_bmp*4+30
									mov	my_hand3_y,height_bmp*4+30
									;******************************************把go_puke放到puke最后面去
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************逗牌完成,发牌		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;刷新地图
									ret														;逗牌完成，返回

							;.else
							;		ret
							;.endif

							;ret	;没鱼的话，返回
					.endif
					;********************555555555555555555555555555555555555555555
					.if		eax	>	width_bmp*5		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*6		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+4]		;看看右击的地方有没有鱼
							mov	go_puke,al
									mov	my_will_fish,0	;手上出去的牌逗出去，所以my_will_fish变成0张,手上现在没有牌出去
									;******************************************
									lea	eax,who_will
									mov	cl,BYTE ptr [eax]
									mov	ch,BYTE ptr [eax+1]
									mov	bl,BYTE ptr [eax+2]
									.if		cl	==	1	
												mov	BYTE ptr [eax],0
									.elseif	ch	==	1				
												inc	esi
												mov	BYTE ptr [eax+1],0
									.elseif	bl	==	1
												inc	esi
												inc	esi
												mov	BYTE ptr [eax+2],0
									.endif	
									;******************************************
									mov	al,BYTE ptr [esi]
									mov	BYTE ptr [esi],0
									mov	BYTE ptr [edi+4],al
									;***把牌值放到fish_num的相应的位置上去
									lea	eax,my_hand
									sub	esi,eax
									lea	eax,my_hand_num
									add	eax,esi
									mov	bl,BYTE ptr [eax]
									lea	esi,fish_num
									mov	BYTE ptr [esi+4],bl
									;***
									mov	my_hand1_y,height_bmp*4+30		
									mov	my_hand2_y,height_bmp*4+30
									mov	my_hand3_y,height_bmp*4+30
									;******************************************把go_puke放到puke最后面去
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************逗牌完成,发牌		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;刷新地图
									ret														;逗牌完成，返回

							;.else
							;		ret
							;.endif

							;ret	;没鱼的话，返回
					.endif
					;********************66666666666666666666666666666666666666666666
					.if		eax	>	width_bmp*6		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*7		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+5]		;看看右击的地方有没有鱼
							mov	go_puke,al
									mov	my_will_fish,0	;手上出去的牌逗出去，所以my_will_fish变成0张,手上现在没有牌出去
									;******************************************
									lea	eax,who_will
									mov	cl,BYTE ptr [eax]
									mov	ch,BYTE ptr [eax+1]
									mov	bl,BYTE ptr [eax+2]
									.if		cl	==	1	
												mov	BYTE ptr [eax],0
									.elseif	ch	==	1				
												inc	esi
												mov	BYTE ptr [eax+1],0
									.elseif	bl	==	1
												inc	esi
												inc	esi
												mov	BYTE ptr [eax+2],0
									.endif		
									;******************************************
									mov	al,BYTE ptr [esi]
									mov	BYTE ptr [esi],0
									mov	BYTE ptr [edi+5],al
									;***把牌值放到fish_num的相应的位置上去
									lea	eax,my_hand
									sub	esi,eax
									lea	eax,my_hand_num
									add	eax,esi
									mov	bl,BYTE ptr [eax]
									lea	esi,fish_num
									mov	BYTE ptr [esi+5],bl
									;***
									mov	my_hand1_y,height_bmp*4+30		
									mov	my_hand2_y,height_bmp*4+30
									mov	my_hand3_y,height_bmp*4+30
									;******************************************把go_puke放到puke最后面去
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************逗牌完成,发牌		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;刷新地图
									ret														;逗牌完成，返回

							;.else
							;		ret
							;.endif

							;ret	;没鱼的话，返回
					.endif
					;********************77777777777777777777777777777777777777777777
					.if		eax	>	width_bmp*7		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*8		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+6]		;看看右击的地方有没有鱼
							mov	go_puke,al
									mov	my_will_fish,0	;手上出去的牌逗出去，所以my_will_fish变成0张,手上现在没有牌出去
									;******************************************
									lea	eax,who_will
									mov	cl,BYTE ptr [eax]
									mov	ch,BYTE ptr [eax+1]
									mov	bl,BYTE ptr [eax+2]
									.if		cl	==	1	
												mov	BYTE ptr [eax],0
									.elseif	ch	==	1				
												inc	esi
												mov	BYTE ptr [eax+1],0
									.elseif	bl	==	1
												inc	esi
												inc	esi
												mov	BYTE ptr [eax+2],0
									.endif	
									;******************************************
									mov	al,BYTE ptr [esi]
									mov	BYTE ptr [esi],0
									mov	BYTE ptr [edi+6],al
									;***把牌值放到fish_num的相应的位置上去
									lea	eax,my_hand
									sub	esi,eax
									lea	eax,my_hand_num
									add	eax,esi
									mov	bl,BYTE ptr [eax]
									lea	esi,fish_num
									mov	BYTE ptr [esi+6],bl
									;***
									mov	my_hand1_y,height_bmp*4+30		
									mov	my_hand2_y,height_bmp*4+30
									mov	my_hand3_y,height_bmp*4+30
									;******************************************把go_puke放到puke最后面去
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************逗牌完成,发牌		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;刷新地图
									ret														;逗牌完成，返回

							;.else
							;		ret
							;.endif

							;ret	;没鱼的话，返回
					.endif
					;********************88888888888888888888888888888888888888888888
					.if		eax	>	width_bmp*8		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*9		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+7]		;看看右击的地方有没有鱼
							mov	go_puke,al
									mov	my_will_fish,0	;手上出去的牌逗出去，所以my_will_fish变成0张,手上现在没有牌出去
									;******************************************
									lea	eax,who_will
									mov	cl,BYTE ptr [eax]
									mov	ch,BYTE ptr [eax+1]
									mov	bl,BYTE ptr [eax+2]
									.if		cl	==	1	
												mov	BYTE ptr [eax],0
									.elseif	ch	==	1				
												inc	esi
												mov	BYTE ptr [eax+1],0
									.elseif	bl	==	1
												inc	esi
												inc	esi
												mov	BYTE ptr [eax+2],0
									.endif	
									;******************************************
									mov	al,BYTE ptr [esi]
									mov	BYTE ptr [esi],0
									mov	BYTE ptr [edi+7],al
									;***把牌值放到fish_num的相应的位置上去
									lea	eax,my_hand
									sub	esi,eax
									lea	eax,my_hand_num
									add	eax,esi
									mov	bl,BYTE ptr [eax]
									lea	esi,fish_num
									mov	BYTE ptr [esi+7],bl
									;***
									mov	my_hand1_y,height_bmp*4+30		
									mov	my_hand2_y,height_bmp*4+30
									mov	my_hand3_y,height_bmp*4+30
									;******************************************把go_puke放到puke最后面去
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************逗牌完成,发牌		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;刷新地图
									ret														;逗牌完成，返回

							;.else									;要逗牌的地方有鱼
																	;覆盖那一出的牌
									
								;	ret
							;.endif

							;ret	;没鱼的话，返回
					.endif
					;********************
free_fish1:
					mov	eax,012345678h						;多于一张牌从手中出来，逗牌失败

					ret

_free_fish		endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
computer_fish	proc	uses eax ebx ecx edx esi edi 
					;local	shiyan1:BYTE
					local		cjc_eax			;:DWORD   
					local		cjc_ebx			;:DWORD 	 				
					local		cjc_ecx			;:DWORD 

					;***保存	ax,bx,cx
					mov		cjc_eax,eax
					mov		cjc_ebx,ebx
					mov		cjc_ecx,ecx
					;***		钓鱼
					mov		dl,cl
					add		dl,ch
					add		dl,bh				;待钓鱼的牌的大小总和在dl中
					;***
					mov		dh,al
					add		dh,ah
					add		dh,bl				;待钓鱼的牌的牌码总和在dh中
					;***
					mov		ecx,8d
					lea		esi,fish_num
					lea		edi,fishes
					computer_fish2:
								push	ecx
								push	esi
								push	edi
								push	edx
								mov	cl,BYTE ptr [esi]
								.if	cl	==	0d
										jmp	computer_fish3
								.endif
								add	dl,cl
								.if	dl	==	14d
										;**********************把牌的分值加到dh中
										mov	cl,BYTE ptr [edi]
										add	dh,cl
										;***                   计算本轮得分，并加到your_max_point中去
										sub	dh,14d
										mov	cl,13d
										sub	eax,eax
										mov	al,dh
										div	cl
										mov	dh,al
										mov	al,add_points
										add	dh,al
										;**********************算好的分在dh中
										mov		al,your_max_point
										;则替换最高分
										;则替换your_aogo
										.if		dh		>	al
													mov	your_max_point,dh
													;***
													mov		dh,fish_way_hand
													mov		fish_way_hand1,dh
													;***
													lea		eax,fishes
													sub		edi,eax
													mov		fish_way_fishes,edi
										.endif
										;**********************
								.endif
								computer_fish3:
								pop   edx
								pop	edi
								pop	esi
								pop	ecx
								inc	edi
								inc	esi
								.if		ecx	>	0
											dec	ecx
											jmp	computer_fish2
								.endif
					;********************************************
					ret
computer_fish	endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ProcWinMain	proc	uses ebx edi esi,hWnd,uMsg,wParam,lParam
		local		@stPs:PAINTSTRUCT
		local		@stRect:RECT
      local		@hDc

		mov		eax,uMsg
;********************************************************************
		.if		eax ==	WM_PAINT
					invoke	BeginPaint,hWnd,addr @stPs
					mov		@hDc,eax
					invoke	MAP_Paint,@hDc	
					invoke	EndPaint,hWnd,addr @stPs
;********************************************************************
		.elseif	eax ==   WM_TIMER
					invoke	KillTimer,hWnd,TimerID
					invoke	PostMessage,hWnd,WM_computer_fish,NULL,NULL
;********************************************************************
		.elseif	eax ==	WM_LBUTTONDOWN
               mov		eax,lParam 
               and		eax,0FFFFh 
               mov		hitpoint.x,eax 
               mov		eax,lParam 
               shr		eax,16 
               mov		hitpoint.y,eax

					invoke	_jingong				;此处处理要求区别逗牌和粘牌
														;逗牌后马上启动电脑粘牌子程序
;********************************************************************
		.elseif	eax ==	WM_RBUTTONDOWN
               mov		eax,lParam 
               and		eax,0FFFFh 
               mov		hitpoint.x,eax 
               mov		eax,lParam 
               shr		eax,16 
               mov		hitpoint.y,eax
					;***********
					mov		eax,who_fish
					.if		eax	==	2
					
								ret
					.endif
					;***********
					invoke	_free_fish
					;***********
					.if		eax	==	012345678h	;逗牌失败，不启动“电脑钓鱼的程序”

								ret
					.endif
					mov		who_fish,2		;其实用2没有什么用处，但是此时考虑到可能用到多线程，所以用了2
													;如果不使用多线程的话，就不用2，改回去cjc
					;***********cjc我想应该是在此处触发电脑钓鱼的子程序功能，注意：要是电脑处理的程序比较漫长的话（违反1/8秒规则）
									;就用多线程的方法
					invoke	SetTimer,hWnd,TimerID,500,NULL
					;

;********************************************************************处理电脑钓鱼
		.elseif	eax ==	WM_computer_fish

					;***
					mov		al,0							;最高分清0
					mov		your_max_point,al			;最高分清0
					mov		fish_way_hand1,al
					mov		eax,0ffffffffh
					mov		fish_way_fishes,eax
					;******************************************
					mov		ecx,7d

					computer1:
					push		ecx
					lea		esi,your_hand			
					lea		edi,your_hand_num
					;**************************************************
					.if		ecx	==	7d
								mov		al,BYTE ptr [esi]
								sub		ah,ah
								sub		bl,bl
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		cl,BYTE ptr [edi]
								sub		ch,ch
								sub		bh,bh
								;***
								mov		dl,7d
								mov		fish_way_hand,dl
								;***
								mov		dl,2
								mov		add_points,dl
								invoke	computer_fish
								;********
					.elseif	ecx	==	6d
								sub		al,al
								mov		ah,BYTE ptr [esi+1]
								sub		bl,bl
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								sub		cl,cl
								mov		ch,BYTE ptr [edi+1]
								sub		bh,bh
								;***
								mov		dl,6d
								mov		fish_way_hand,dl
								;***
								mov		dl,2
								mov		add_points,dl
								invoke	computer_fish
								;********
					.elseif	ecx	==	5d
								sub		al,al
								sub		ah,ah
								mov		bl,BYTE ptr [esi+2]
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								sub		cl,cl
								sub		ch,ch
								mov		bh,BYTE ptr [edi+2]
								;***
								mov		dl,5d
								mov		fish_way_hand,dl
								;***
								mov		dl,2
								mov		add_points,dl
								invoke	computer_fish
								;********
					.elseif	ecx	==	4d
								mov		al,BYTE ptr [esi]
								mov		ah,BYTE ptr [esi+1]
								sub		bl,bl
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		cl,BYTE ptr [edi]
								mov		ch,BYTE ptr [edi+1]
								sub		bh,bh
								;***
								mov		dl,4d
								mov		fish_way_hand,dl
								;***
								mov		dl,3
								mov		add_points,dl
								invoke	computer_fish
								;********
					.elseif	ecx	==	3d
								mov		al,BYTE ptr [esi]
								sub		ah,ah
								mov		bl,BYTE ptr [esi+2]
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		cl,BYTE ptr [edi]
								sub		ch,ch
								mov		bh,BYTE ptr [edi+2]
								;***
								mov		dl,3d
								mov		fish_way_hand,dl
								;***
								mov		dl,3
								mov		add_points,dl
								invoke	computer_fish
								;********
					.elseif	ecx	==	2d
								sub		al,al
								mov		ah,BYTE ptr [esi+1]
								mov		bl,BYTE ptr [esi+2]
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								sub		cl,cl
								mov		ch,BYTE ptr [edi+1]
								mov		bh,BYTE ptr [edi+2]
								;***
								mov		dl,2d
								mov		fish_way_hand,dl
								;***
								mov		dl,3
								mov		add_points,dl
								invoke	computer_fish
								;********
					.elseif	ecx	==	1d
								mov		al,BYTE ptr [esi]
								mov		ah,BYTE ptr [esi+1]
								mov		bl,BYTE ptr [esi+2]
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		cl,BYTE ptr [edi]
								mov		ch,BYTE ptr [edi+1]
								mov		bh,BYTE ptr [edi+2]
								;***
								mov		dl,1d
								mov		fish_way_hand,dl
								;***
								mov		dl,4
								mov		add_points,dl
								invoke	computer_fish
								;********
					.endif

					pop		ecx
					.if		ecx	>	0
								dec	ecx
								jmp	computer1
					.endif
					;*********************************************这里再处理牌的转移和清0
					;*********************************************这里再处理牌的转移和清0
					mov		al,your_max_point			;最高分清0
					.if		al	==	0
								jmp	computer_fish_over
					.endif
					;*********************************************这里再处理牌的转移和清0
					mov		cl,fish_way_hand1
					lea		esi,your_hand			
					lea		edi,your_hand_num
					sub		dl,dl
					sub		eax,eax
					sub		ebx,ebx
					;********
					.if		cl		==	7d

								mov		al,BYTE ptr [esi]
								mov		BYTE ptr [esi],dl
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		BYTE ptr [edi],dl
								;***
					.elseif	cl		==	6d
								mov		ah,BYTE ptr [esi+1]
								mov		BYTE ptr [esi+1],dl
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		BYTE ptr [edi+1],dl
								;***
					.elseif	cl		==	5d
								mov		bl,BYTE ptr [esi+2]
								mov		BYTE ptr [esi+2],dl
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		BYTE ptr [edi+2],dl
								;***
					.elseif	cl		==	4d
								mov		al,BYTE ptr [esi]
								mov		ah,BYTE ptr [esi+1]
								mov		BYTE ptr [esi],dl  
								mov		BYTE ptr [esi+1],dl
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		BYTE ptr [edi],dl  
								mov		BYTE ptr [edi+1],dl 
								;***
					.elseif	cl		==	3d
								mov		al,BYTE ptr [esi]
								mov		bl,BYTE ptr [esi+2]
								mov		BYTE ptr [esi],dl   
								mov		BYTE ptr [esi+2],dl 
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		BYTE ptr [edi],dl  
								mov		BYTE ptr [edi+2],dl
								;***
					.elseif	cl		==	2d
								mov		ah,BYTE ptr [esi+1]
								mov		bl,BYTE ptr [esi+2]
								mov		BYTE ptr [esi+1],dl
								mov		BYTE ptr [esi+2],dl
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		BYTE ptr [edi+1],dl   
								mov		BYTE ptr [edi+2],dl   
								;***
					.elseif	cl		==	1d
								mov		al,BYTE ptr [esi]
								mov		ah,BYTE ptr [esi+1]
								mov		bl,BYTE ptr [esi+2]
								mov		BYTE ptr [esi],dl  
								mov		BYTE ptr [esi+1],dl
								mov		BYTE ptr [esi+2],dl
								;***把电脑手中的牌的大小放到bh，cl，ch，中
								mov		BYTE ptr [edi],dl  
								mov		BYTE ptr [edi+1],dl
								mov		BYTE ptr [edi+2],dl
								;***
					.else

					.endif
					;***
					lea		edx,your_aogo
					mov		BYTE ptr [edx],al	
					inc		edx
					mov		BYTE ptr [edx],ah
					inc		edx
					mov		BYTE ptr [edx],bl
					;***
					inc		edx
					mov		ebx,fish_way_fishes
					.if		ebx	==	0ffffffffh
					
					.else
								lea	esi,fishes
								lea	edi,fish_num
								sub	ah,ah
								mov	BYTE ptr [edi+ebx],ah
								mov	al,BYTE ptr [esi+ebx]
								mov	BYTE ptr [esi+ebx],ah
								mov	BYTE ptr [edx],al
					.endif
					;*********************************************把本轮钓鱼的分加到总分中去
					mov		al,your_points
					mov		ah,your_max_point
					add		al,ah
					mov		your_points,al
					;**********************************************************************************************清0
					computer_fish_over:
					;**********************************给对手（电脑）发牌        
					lea		esi,your_hand                                         					
					lea		edi,your_hand_num                                     
					invoke	give_puke,esi,edi
					;**********************************对手（电脑）斗牌
					lea		esi,fishes
					lea		edi,fish_num
					add		esi,7d
					add		edi,7d
					mov		ecx,8d
					computer_free_fish1:
								mov	al,BYTE ptr [esi]
								.if	al	==	0
										jmp	computer_free_fish2
								.else
										
								.endif
								dec	esi
								dec	edi
					loop		computer_free_fish1
					computer_free_fish2:		
					mov		ebx,esi		;esi中是电脑要斗牌的地址
					mov		edx,edi		;edi中是电脑要斗牌的num的地址
					;***
					lea		esi,your_hand                                         					
					lea		edi,your_hand_num
					mov		ecx,3d
					computer_free_fish3:
								mov	al,BYTE ptr [esi]
								.if	al
										mov	ah,BYTE ptr [edi]
										sub	cl,cl
										mov	BYTE ptr [esi],cl
										mov	BYTE ptr [edi],cl
										mov	BYTE ptr [ebx],al
										mov	BYTE ptr [edx],ah
										jmp	computer_free_fish4
								.else

								.endif
								inc	esi
								inc	edi
					loop		computer_free_fish3
					computer_free_fish4:
					;***
					;**********************************再给对手（电脑）发牌 
					lea		esi,your_hand                                         					
					lea		edi,your_hand_num                                     
					invoke	give_puke,esi,edi
					;**********************************
					;**********************************
					;**********************************
					;**********************************给对手（电脑）换牌
					mov		eax,lp_puke_head
					.if		eax	<	51d	;&&		eax	>	7d
								mov		al,can_huanpai
								.if		al	<	4d
											lea		esi,your_hand
											lea		edi,puke
											mov		ebx,lp_puke_head
											;***
											mov		al,BYTE ptr [edi+ebx]
											mov		ah,BYTE ptr [edi+ebx+1]
											mov		cl,BYTE ptr [edi+ebx+2]
											push		eax
											push		ecx
											mov		al,BYTE ptr [esi]  		
											mov		ah,BYTE ptr [esi+1]
											mov		cl,BYTE ptr [esi+2]
											;***
											mov		BYTE ptr [edi+ebx],al  
											mov		BYTE ptr [edi+ebx+1],ah
											mov		BYTE ptr [edi+ebx+2],cl
											;***
											pop		ecx
											pop		eax
											mov		BYTE ptr [esi],al  
											mov		BYTE ptr [esi+1],ah
											mov		BYTE ptr [esi+2],cl
											;******************
											;****************	;把刚发的牌的大小放到my_hand_num的相应的位置上去
											.if		al < 14d

											.elseif	al	> 13d	&&	al	<	27d
														sub	al,13d
											.elseif	al	> 26d &&	al <  40d
														sub	al,26d
											.elseif	al > 39d && al	<	53d
														sub	al,39d
											.endif
											;****************	;把刚发的牌的大小放到my_hand_num的相应的位置上去
											.if		ah < 14d

											.elseif	ah	> 13d	&&	ah	<	27d
														sub	ah,13d
											.elseif	ah	> 26d &&	ah <  40d
														sub	ah,26d
											.elseif	ah > 39d && ah	<	53d
														sub	ah,39d
											.endif
											;****************	;把刚发的牌的大小放到my_hand_num的相应的位置上去
											.if		cl < 14d

											.elseif	cl	> 13d	&&	cl	<	27d
														sub	cl,13d
											.elseif	cl	> 26d &&	cl <  40d
														sub	cl,26d
											.elseif	cl > 39d && cl	<	53d
														sub	cl,39d
											.endif
											;****************
											lea		esi,your_hand_num
											mov		BYTE ptr [esi],al
											mov		BYTE ptr [esi+1],ah
											mov		BYTE ptr [esi+2],cl
											mov		al,can_huanpai
											inc		al
											mov		can_huanpai,al
								.else
											sub		al,al
											mov		can_huanpai,al
								.endif
					.endif
					;**********************************
					;**********************************
					;**********************************
					mov		who_fish,0					;把轮换位清0
					invoke	InvalidateRect,hWinMain,NULL,TRUE
					ret
;********************************************************************这个消息处理要是用不上的话，游戏全部完成后删除它
      .elseif  eax ==   WM_CHAR        ;多用于实验          
					mov		eax,wParam
               .if      eax == "n"
					;*********
					;invoke	MessageBox,hWinMain,addr sz_lose,addr sz_tishi,MB_OK
					invoke	PostMessage,hWinMain,WM_NEWGAME,NULL,NULL
					;*********
               .endif
;********************************************************************
		.elseif	eax ==	WM_NEWGAME
					;*********************************
					invoke	KillTimer,hWnd,TimerID
					;*********************************给我手中的牌的坐标赋值（因为这些值经常变化，所以要用变量来表示它们）
					mov		my_hand1_x,width_bmp*2
					mov		my_hand1_y,height_bmp*4+30
					mov		my_hand2_x,width_bmp*3
					mov		my_hand2_y,height_bmp*4+30
					mov		my_hand3_x,width_bmp*4
					mov		my_hand3_y,height_bmp*4+30
					;**********************************需要清0的一些变量
					invoke	RtlZeroMemory,addr	my_hand,180d
					mov		my_will_fish,0
					mov		who_fish,0
					;**********************************实验专用

					;**********************************未发的牌的首位指针的初始化
					mov		lp_puke_head,0
					mov		lp_puke_weiba,52d
					;**********************************给未发的牌（此时为所有的牌）赋值
					mov		ecx,52d
					lea		edi,puke	
					mov		al,1d
					begin3:
					mov		BYTE ptr [edi],al
					inc		edi
					inc		al
					loop		begin3
					;**********************************
					mov		ecx,52d
					begin4:
								lea		edi,puke
								invoke	GetTickCount
								;***
								mov	ebx,ecx
								inc	ebx
								begin2:
								.if		ax	> bx
											sub	ax,bx
											jmp	begin2
								.endif
								;***
								sub		ebx,ebx
								mov		bl,al

								mov		al,BYTE ptr [edi+ebx]
								mov		ah,BYTE ptr [edi+ecx-1]
								
								mov		BYTE ptr [edi+ebx],ah
								mov		BYTE ptr [edi+ecx-1],al
								loop		begin4
					;*************************************
					mov		ecx,52d
					begin5:
								lea		edi,puke
								invoke	GetTickCount
								;***
								mov	ebx,ecx
								inc	ebx
								begin6:
								.if		ax	> bx
											sub	ax,bx
											jmp	begin6
								.endif
								;***
								sub		ebx,ebx
								mov		bl,al

								mov		al,BYTE ptr [edi+ebx]
								mov		ah,BYTE ptr [edi+ecx-1]
								
								mov		BYTE ptr [edi+ebx],ah
								mov		BYTE ptr [edi+ecx-1],al
								loop		begin5
					;****************************************************************************************************
					;**********************清0一些变量
					sub		al,al
					mov		can_huanpai,al
					mov		your_points,al
					;**********************************给fishes发牌              
					lea		esi,fishes
					;add		esi,4
					lea		edi,fish_num 
					;add		edi,4
					invoke	give_puke,esi,edi			                            
					;**********************************给我发牌                  
					lea		esi,my_hand                                         					
					lea		edi,my_hand_num                                     
					invoke	give_puke,esi,edi                                   
					;**********************************给对手（电脑）发牌        
					lea		esi,your_hand                                         					
					lea		edi,your_hand_num                                     
					invoke	give_puke,esi,edi                           
					;**********************************                          
					invoke	InvalidateRect,hWinMain,NULL,TRUE		;刷新地图    
																									 
					ret              
					
;**************************************************************************************
;********************************************************************
;********************************************************************
;********************************************************************
		.elseif	eax ==	WM_COMMAND
					mov		eax,wParam
					.if		eax	==	IDM_NEW
								invoke	PostMessage,hWnd,WM_NEWGAME,NULL,NULL
					.elseif	eax	==	IDM_HELP
								invoke	CreateDialogParam,hdlg_help,DLG_HELP,hWinMain,_proc_help,NULL		
					.elseif	eax	==	IDM_ME
								invoke	CreateDialogParam,hdlg_me,DLG_ME,hWinMain,_proc_me,NULL								
					.elseif	eax	==	IDM_EXIT
								invoke	DestroyWindow,hWinMain
								invoke	PostQuitMessage,NULL
					.endif
;********************************************************************
		;.elseif	eax ==   WM_cjc

					;ret
;********************************************************************
		.elseif	eax ==	WM_CLOSE
					invoke	DestroyWindow,hWinMain
					invoke	PostQuitMessage,NULL
;********************************************************************
		.elseif	eax ==   WM_CREATE
					invoke	LoadIcon,hInstance,ICO_MAIN
					invoke	SendMessage,hWnd,WM_SETICON,ICON_BIG,eax
					mov		eax,hWnd											;窗口句柄放到hWinMain中
					mov		hWinMain,eax
					;*********************
					mov		my_hand1_x,width_bmp*2
					mov		my_hand1_y,height_bmp*4+30
					mov		my_hand2_x,width_bmp*3
					mov		my_hand2_y,height_bmp*4+30
					mov		my_hand3_x,width_bmp*4
					mov		my_hand3_y,height_bmp*4+30
					;*********************
					invoke	_LoadRes	
					invoke	PostMessage,hWnd,WM_NEWGAME,NULL,NULL
;********************************************************************
		.else
					invoke	DefWindowProc,hWnd,uMsg,wParam,lParam
					ret
		.endif
;********************************************************************
		xor		eax,eax
		ret

_ProcWinMain	endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_WinMain			proc
		local		@stWndClass:WNDCLASSEX
		local		@stMsg:MSG

		invoke	GetModuleHandle,NULL
		mov		hInstance,eax
	  ;*****************************************************
		invoke	LoadMenu,hInstance,IDM_MAIN
		mov		hMenu,eax
	  ;*****************************************************
		invoke	RtlZeroMemory,addr @stWndClass,sizeof @stWndClass
                                    
;********************************************************************
; 注册窗口类
;********************************************************************
		invoke	LoadCursor,0,IDC_ARROW
		mov		@stWndClass.hCursor,eax
		push		hInstance
		pop		@stWndClass.hInstance
		mov		@stWndClass.cbSize,sizeof WNDCLASSEX
		mov		@stWndClass.style,CS_HREDRAW or CS_VREDRAW
		mov		@stWndClass.lpfnWndProc,offset _ProcWinMain
		;invoke	GetStockObject,BLACK_BRUSH	怎么获取兰色的画刷？？？？？？？？？？？？
		mov		@stWndClass.hbrBackground,COLOR_WINDOW +	1
		mov		@stWndClass.lpszClassName,offset szClassName
		invoke	RegisterClassEx,addr @stWndClass
;********************************************************************
; 建立并显示窗口
;********************************************************************
		invoke	CreateWindowEx,WS_EX_CLIENTEDGE,offset szClassName,offset szCaptionMain,\
					WS_MINIMIZEBOX+WS_SYSMENU,\		;WS_OVERLAPPEDWINDOW
					10,10,750,600,\
					NULL,hMenu,hInstance,NULL
		mov		hWinMain,eax
		invoke	ShowWindow,hWinMain,SW_SHOWNORMAL
		invoke	UpdateWindow,hWinMain
;********************************************************************
; 消息循环
;********************************************************************
		.while	TRUE
		invoke	GetMessage,addr @stMsg,NULL,0,0
		.break	.if		eax	== 0
               invoke	TranslateMessage,addr @stMsg
					invoke	DispatchMessage,addr @stMsg
		.endw
		ret
_WinMain	endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
start:
		call		_WinMain
		invoke	ExitProcess,NULL
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		end		start
