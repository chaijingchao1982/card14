;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.386
		.model	flat, stdcall
		option	casemap :none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Include �ļ�����
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include			windows.inc
include			gdi32.inc
includelib		gdi32.lib
include			user32.inc
includelib		user32.lib
include			kernel32.inc
includelib		kernel32.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Equ ��ֵ����
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;*****************************
width_bmp		equ	71
height_bmp		equ	96
;*****************************;��Դ
ICO_MAIN			equ	1000h		;ͼ��
IDB_1				equ	1
IDB_2				equ	2
IDB_3				equ	3
IDB_4				equ	4
DLG_HELP			equ	1
DLG_ME			equ	2

;*****************************�˵�
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
; ���ݶ�
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.data?
;***************************************�������õ�ȫ�ֱ���
hWinMain			dd		?						;�����ھ��
hdlg_help		dd		?						;help���ھ��
hdlg_me			dd		?
hMenu				dd		?						;�˵����
hInstance		dd		?						;�������ʵ���Ӿ��
hDc_map			dd		?						;��ͼλͼ���
hDc_back			dd		?						;�Ƶı����λͼ���
hDc_kong			dd		?						;û����ʱ��λ��λͼ���
dwNowBack		dd		?						;����λͼ������м����
hDc_me			dd		?
hitpoint			POINT <>						;��갴��ʱ������
who_fish			dd		?						;������Ϸ���̵��ֻ�����
random_count	dd		?
TimerID			dd		?
;***************************************�����ǵ������ܵ����ӳ��������õ���һЩ����
fish_way_hand	db		?
fish_way_hand1	db		?
fish_way_fishes	dd	?
;***************************************
lp_puke_head	dd		?						;δ����ȥ���Ƶ�ͷָ��
lp_puke_weiba	dd		?						;δ����ȥ���Ƶ�βָ��
my_will_fish	dd		?						;�����г�ȥ���Ƶ�����
;***************************************������������Ƶ�����
my_hand1_x		dd		?
my_hand1_y		dd		?
my_hand2_x		dd		?
my_hand2_y		dd		?
my_hand3_x		dd		?
my_hand3_y		dd		?

;***************************************
add_points		db		?						;����ķ�
can_huanpai		db		?						;�����ܷ���
;***************************************�ַ���
sz_printf		db		128d  dup	(?)	;��ʾʱ���õ��ַ���	

;***************************************ʵ���ñ���
;sz_printf_shiyan	db	128d  dup	(?)
;can_fish			dd		?
;***************************************���������Ŵ�
;wash_random		db		60d	dup	(?)	;����Ӧ����52d�ģ�����������������Զ���������ֽڣ��Ǻǣ�����

;***************************************��ҺͶ������е�������
my_hand			db		3d		dup	(?)	;�����е���
no1				dd		?						;������������

my_hand_num		db		3d		dup	(?)	;�����е��ƵĴ�С
no2				dd		?						;������������

my_aogo			db		4d		dup	(?)	;���ϰѵ�������
no3				dd		?						;������������

your_hand		db		3d		dup	(?)	;�������е���
no4				dd		?						;������������

your_aogo		db		4d		dup	(?)	;�����ϰѵ�������
no6				dd		?						;������������

your_hand_num	db		3d		dup	(?)	;�������е��ƵĴ�С
no5				dd		?						;������������


;***************************************��ҺͶ��ֱ��ֵ��ܵ÷�
no7				db		?,?,?,?
my_points		db		?
your_points		db		?
;***************************************
puke				db		54d	dup	(?)	;���е��˿˱���
puke_wash		db		54d	dup	(?)	;ϴ��ר�õĿռ�

fishes			db		8d		dup	(?)	;���
fish_num			db		8d		dup	(?)	;������������ֵ
who_will			db		3d		dup	(?)	;��������ȥ���Ƶ�ָʾ����������������˭��ȥ��
;***************************************
your_max_point	db		?
no					db		?,?
;***************************************

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.const
;****************************************��Ϸ���������ַ���
sz_num			db		'Ŀǰ�÷�',0
szClassName		db		'MyClass',0
szCaptionMain	db		'~~~14�����~~~1.0������~~~',0
;****************************************ʵ���õ��ַ���

;****************************************paint�����õ����ַ���
sz_my				db		'��ҵ���',0
sz_your			db		'���ֵ���',0
sz_fish			db		'���--->>',0
sz_my_point		db		'��ҵ÷֣�%d',0
sz_your_point	db		'���ֵ÷֣�%d',0
sz_my_aogo		db		'������ֵ������',0
sz_your_aogo	db		'�������ֵ������',0
;****************************************ʤ���ַ���
sz_tishi			db		'��㡰n����ʼ�µ�һ��',0
sz_win			db		'��Ӯ��',0
sz_lose			db		'������',0
sz_ping			db		'ƽ��',0		

;****************************************ʵ���õ��ַ���
sz_shiyang_pc	db	'���ֵ��%d',0
sz_gameover		db	'game over!',0
sz_shiyan		db	'�������%d',0
sz_computer_fish	db	'������Ե���',0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; �����
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		.code
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; ���ڹ���
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
_LoadRes			proc		uses ebx edi esi	;װ����Դ���ӳ���
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
MAP_Paint		proc		uses ebx edi esi Dc:DWORD	;paint��Ϣˢ�µ��ӳ���
					local		@stRect:RECT
					
					;*************д��Ϸ��Ϣ����
					;RECT STRUCT
					;  left    dd      ?
					;  top     dd      ?
					;  right   dd      ?
					;  bottom  dd      ?
					;RECT ENDS
					;***�����ַ���
					invoke	GetClientRect,hWinMain,addr	@stRect
					mov		@stRect.left,220d
					invoke	DrawText,Dc,addr	sz_your,-1,addr	@stRect,DT_SINGLELINE
					;***����ַ���
					mov		@stRect.top,530d
					invoke	DrawText,Dc,addr	sz_my,-1,addr	@stRect,DT_SINGLELINE
					;***�ҵ÷�����ַ���
					mov		@stRect.left,5d
					mov		@stRect.top,425d
					mov		al,my_points
					invoke	wsprintf,addr	sz_printf,addr	sz_my_point,al
					invoke	DrawText,Dc,addr	sz_printf,-1,addr	@stRect,DT_SINGLELINE
					;***���ֵ÷�������ַ���
					mov		@stRect.top,45d
					mov		al,your_points
					invoke	wsprintf,addr	sz_printf,addr	sz_your_point,al
					invoke	DrawText,Dc,addr	sz_printf,-1,addr	@stRect,DT_SINGLELINE
					;***���
					mov		@stRect.top,260d
					invoke	DrawText,Dc,addr	sz_fish,-1,addr	@stRect,DT_SINGLELINE
					;***�����ֵ�������ַ���
					mov		@stRect.top,530d
					mov		@stRect.left,500d
					invoke	DrawText,Dc,addr	sz_my_aogo,-1,addr	@stRect,DT_SINGLELINE					
					;***�������ֵ�������ַ���
					mov		@stRect.top,0
					invoke	DrawText,Dc,addr	sz_your_aogo,-1,addr	@stRect,DT_SINGLELINE
					;*************
					;*************	
					;*************���ֵ���
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
					;*************���ֵ���
					invoke	BitBlt,Dc,width_bmp*2,30,width_bmp,height_bmp,hDc_back,0,0,SRCCOPY
					invoke	BitBlt,Dc,width_bmp*3,30,width_bmp,height_bmp,hDc_back,0,0,SRCCOPY
					invoke	BitBlt,Dc,width_bmp*4,30,width_bmp,height_bmp,hDc_back,0,0,SRCCOPY
					;*************��������ճ����
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
					;*************����е���
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
					;*************��ҵ���
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
					;*************�������ճ����
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
give_puke		proc	uses ebx edi esi who_hand:DWORD,who_num:DWORD	;���Ƶ��ӳ���

					invoke	InvalidateRect,hWinMain,NULL,TRUE

					;*******************�ж���Ϸ�Ƿ����
							lea	esi,my_hand
							lea	edi,your_hand
							lea	ebx,puke
							mov	edx,lp_puke_head

							mov	al,BYTE ptr [ebx+edx]				;δ�����ƣ�ȡ��һ��

							mov	ah,BYTE ptr [esi]				;���е���1
							mov	cl,BYTE ptr [esi+1]			;���е���2
							mov	ch,BYTE ptr [esi+2]			;���е���3

							.if	ax	==	0	&&	cx	==	0			;���е�û����û�ƿɷ���ʱ��
									
									;mov	al,BYTE ptr [edi]	
									;mov	ah,BYTE ptr [edi+1]
									;mov	cl,BYTE ptr [edi+2]

									;.if	ax	==	0	&&	cl	==	0	;��������û��

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
							;****************	;�Ѹշ����ƵĴ�С�ŵ�my_hand_num����Ӧ��λ����ȥ
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
_jingong			proc	uses ebx edi esi					;�ҵ�����ӳ���

					mov	eax,hitpoint.x						;����������ʱ������
					mov	ebx,hitpoint.y
					;********************����Ĺ��ܣ����ǰ�����ĵ�1���ƣ����ϡ����º���ر����Ĵ���
					.if		eax	>	my_hand1_x		&&	ebx	>	my_hand1_y	\
							&&	eax	<	width_bmp*2+71	&&	ebx	<	height_bmp*4+30+96

							;*************************************;�����ж�������û���� 
							lea		esi,my_hand						  ;Ҫ��û�У�0�����Ͳ�ִ���κβ���              
							mov		al,BYTE ptr [esi]				                                           
							.if		al	==	0
										ret
							.endif
							;**************************************
							.if		my_hand1_y	==	height_bmp*4+30-16
																					
										add		my_hand1_y,16				;�½�		
										mov		eax,my_will_fish
										dec      eax
										mov		my_will_fish,eax
										;******************
										lea		esi,who_will
										mov		BYTE ptr [esi],0
										;******************
							.elseif	my_hand1_y	==	height_bmp*4+30
										sub		my_hand1_y,16				;����
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
					;********************����Ĺ��ܣ����ǰ�����ĵ�2���ƣ����ϡ����º���ر����Ĵ���
					.if		eax	>	my_hand2_x		&&	ebx	>	my_hand2_y	\
							&&	eax	<	width_bmp*3+71	&&	ebx	<	height_bmp*4+30+96	

							;*************************************;�����ж�������û���� 
							lea		esi,my_hand						  ;Ҫ��û�У�0�����Ͳ�ִ���κβ���              
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
					;********************����Ĺ��ܣ����ǰ�����ĵ�3���ƣ����ϡ����º���ر����Ĵ���
					.if		eax	>	my_hand3_x		&&	ebx	>	my_hand3_y	\
							&&	eax	<	width_bmp*4+71	&&	ebx	<	height_bmp*4+30+96	

							;*************************************;�����ж�������û���� 
							lea		esi,my_hand						  ;Ҫ��û�У�0�����Ͳ�ִ���κβ���              
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
					;********************���������͵��á�ճ�����ӳ���11111111111111111111111111111111111111111111111111
					.if		eax	>	width_bmp*1		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*2		&&	ebx	<	height_bmp*2+30+96	
							;*******************
							mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
							.if	eax					;����0�ţ��͵���
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
									.if		dl	==	14d	;�ܵ��������ǵ��㹦�ܲ��ִ���
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************��������ĳ�ȥ���ƣ��ŵ�my_aogo��
																			;cjc��Ҫ������������ڴ�ͬʱ�������ֹ���
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish1_2:
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;Ϊ�˻�ñ��ε�����ܵ÷֣������в��������ƶ��ӵ�bl��
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
												;**********************��fishes�еı������㣬�ŵ�my_aogo��
												lea	esi,fishes
												lea	edi,fish_num
												mov	BYTE ptr [edi],0
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************���㱾�ֵ÷֣����ӵ�my_points��ȥ
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
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
												;**********************����������û����,�ͷ���
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************����0����0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************һЩ�û�ԭ�����ݻ�ԭ
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;���ܵ�������
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;��0�ţ�����
									ret
							.endif
							;*******************
					.endif
					;********************222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
					.if		eax	>	width_bmp*2		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*3		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
							.if	eax					;����0�ţ��͵���
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
									.if		dl	==	14d	;�ܵ��������ǵ��㹦�ܲ��ִ���
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************��������ĳ�ȥ���ƣ��ŵ�my_aogo��
																			;cjc��Ҫ������������ڴ�ͬʱ�������ֹ���
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish2_2:
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;Ϊ�˻�ñ��ε�����ܵ÷֣������в��������ƶ��ӵ�bl��
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
												;**********************��fishes�еı������㣬�ŵ�my_aogo��
												lea	esi,fishes
												lea	edi,fish_num
												inc	edi
												mov	BYTE ptr [edi],0
												inc	esi
												mov	al,BYTE ptr [esi]
												mov	BYTE ptr [esi],0
												add	bl,al
												mov	BYTE ptr [edx],al
												;**********************���㱾�ֵ÷֣����ӵ�my_points��ȥ
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
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
												;**********************����������û����,�ͷ���
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************����0����0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************һЩ�û�ԭ�����ݻ�ԭ
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;���ܵ�������
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;��0�ţ�����
									ret
							.endif
							;*******************
					.endif
					;********************33333333333333333333333333333333333333333333333
					.if		eax	>	width_bmp*3		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*4		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
							.if	eax					;����0�ţ��͵���
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
									.if		dl	==	14d	;�ܵ��������ǵ��㹦�ܲ��ִ���
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************��������ĳ�ȥ���ƣ��ŵ�my_aogo��
																			;cjc��Ҫ������������ڴ�ͬʱ�������ֹ���
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish3_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;Ϊ�˻�ñ��ε�����ܵ÷֣������в��������ƶ��ӵ�bl��
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
												;**********************��fishes�еı������㣬�ŵ�my_aogo��
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
												;**********************���㱾�ֵ÷֣����ӵ�my_points��ȥ
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
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
												;**********************����������û����,�ͷ���
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************����0����0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************һЩ�û�ԭ�����ݻ�ԭ
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;���ܵ�������
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;��0�ţ�����
									ret
							.endif
							;*******************
					.endif
					;********************44444444444444444444444444444444444444444444444
					.if		eax	>	width_bmp*4		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*5		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
							.if	eax					;����0�ţ��͵���
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
									.if		dl	==	14d	;�ܵ��������ǵ��㹦�ܲ��ִ���
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************��������ĳ�ȥ���ƣ��ŵ�my_aogo��
																			;cjc��Ҫ������������ڴ�ͬʱ�������ֹ���
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish4_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;Ϊ�˻�ñ��ε�����ܵ÷֣������в��������ƶ��ӵ�bl��
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
												;**********************��fishes�еı������㣬�ŵ�my_aogo��
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
												;**********************���㱾�ֵ÷֣����ӵ�my_points��ȥ
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
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
												;**********************����������û����,�ͷ���
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************����0����0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************һЩ�û�ԭ�����ݻ�ԭ
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;���ܵ�������
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;��0�ţ�����
									ret
							.endif
							;*******************
					.endif
					;********************555555555555555555555555555555555555555555
					.if		eax	>	width_bmp*5		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*6		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
							.if	eax					;����0�ţ��͵���
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
									.if		dl	==	14d	;�ܵ��������ǵ��㹦�ܲ��ִ���
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************��������ĳ�ȥ���ƣ��ŵ�my_aogo��
																			;cjc��Ҫ������������ڴ�ͬʱ�������ֹ���
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish5_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;Ϊ�˻�ñ��ε�����ܵ÷֣������в��������ƶ��ӵ�bl��
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
												;**********************��fishes�еı������㣬�ŵ�my_aogo��
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
												;**********************���㱾�ֵ÷֣����ӵ�my_points��ȥ
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
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
												;**********************����������û����,�ͷ���
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************����0����0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************һЩ�û�ԭ�����ݻ�ԭ
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;���ܵ�������
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;��0�ţ�����
									ret
							.endif
							;*******************
					.endif
					;********************66666666666666666666666666666666666666666666
					.if		eax	>	width_bmp*6		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*7		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
							.if	eax					;����0�ţ��͵���
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
									.if		dl	==	14d	;�ܵ��������ǵ��㹦�ܲ��ִ���
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************��������ĳ�ȥ���ƣ��ŵ�my_aogo��
																			;cjc��Ҫ������������ڴ�ͬʱ�������ֹ���
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish6_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;Ϊ�˻�ñ��ε�����ܵ÷֣������в��������ƶ��ӵ�bl��
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
												;**********************��fishes�еı������㣬�ŵ�my_aogo��
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
												;**********************���㱾�ֵ÷֣����ӵ�my_points��ȥ
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
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
												;**********************����������û����,�ͷ���
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************����0����0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************һЩ�û�ԭ�����ݻ�ԭ
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;���ܵ�������
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;��0�ţ�����
									ret
							.endif
							;*******************
					.endif
					;********************77777777777777777777777777777777777777777777
					.if		eax	>	width_bmp*7		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*8		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
							.if	eax					;����0�ţ��͵���
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
									.if		dl	==	14d	;�ܵ��������ǵ��㹦�ܲ��ִ���
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************��������ĳ�ȥ���ƣ��ŵ�my_aogo��
																			;cjc��Ҫ������������ڴ�ͬʱ�������ֹ���
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish7_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;Ϊ�˻�ñ��ε�����ܵ÷֣������в��������ƶ��ӵ�bl��
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
												;**********************��fishes�еı������㣬�ŵ�my_aogo��
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
												;**********************���㱾�ֵ÷֣����ӵ�my_points��ȥ
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
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
												;**********************����������û����,�ͷ���
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************����0����0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************һЩ�û�ԭ�����ݻ�ԭ
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;���ܵ�������
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;��0�ţ�����
									ret
							.endif
							;*******************
					.endif
					;********************88888888888888888888888888888888888888888888
					.if		eax	>	width_bmp*8		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*9		&&	ebx	<	height_bmp*2+30+96	

							;*******************
							mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
							.if	eax					;����0�ţ��͵���
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
									.if		dl	==	14d	;�ܵ��������ǵ��㹦�ܲ��ִ���
												;invoke	MessageBox,hWinMain,addr sz_can,addr sz_can,MB_OK
												;*********************��������ĳ�ȥ���ƣ��ŵ�my_aogo��
																			;cjc��Ҫ������������ڴ�ͬʱ�������ֹ���
												lea		esi,who_will
												lea		edi,my_hand
												lea		edx,my_aogo
												mov		ecx,3d
												sub		ebx,ebx
												kill_fish8_2:							;??????????????????????????????????????????????
														mov	al,BYTE ptr [esi]
														.if	al
																mov	al,BYTE ptr [edi]
																add	bl,al		;Ϊ�˻�ñ��ε�����ܵ÷֣������в��������ƶ��ӵ�bl��
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
												;**********************��fishes�еı������㣬�ŵ�my_aogo��
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
												;**********************���㱾�ֵ÷֣����ӵ�my_points��ȥ
												sub	bl,14d
												mov	cl,13d
												sub	eax,eax
												mov	al,bl
												div	cl
												mov	bl,al
												;***
												mov	eax,my_will_fish	;�������ϳ�ȥ�����м���
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
												;**********************����������û����,�ͷ���
												lea		esi,my_hand

												mov		al,BYTE ptr [esi]
												mov		ah,BYTE ptr [esi+1]
												mov		cl,BYTE ptr [esi+2]

												.if		ax	==	0 &&	cl ==	0
															lea	esi,my_hand
															lea	edi,my_hand_num
															invoke	give_puke,esi,edi
												.endif
												;**********************����0����0
												mov		my_will_fish,0
												;lea		esi,who_will
												;mov		BYTE ptr [esi],0
												;mov		BYTE ptr [esi+1],0
												;mov		BYTE ptr [esi+2],0
												;**********************һЩ�û�ԭ�����ݻ�ԭ
												mov	who_fish,1
												mov	my_hand1_y,height_bmp*4+30		
												mov	my_hand2_y,height_bmp*4+30
												mov	my_hand3_y,height_bmp*4+30
												;**********************
												invoke	InvalidateRect,hWinMain,NULL,TRUE
												ret
									.else		;���ܵ�������
												;invoke	MessageBox,hWinMain,addr sz_nocan,addr sz_nocan,MB_OK
												ret
									.endif
									;*************
									ret
							.else							;��0�ţ�����
									ret
							.endif
							;*******************
					.endif
					;********************
					ret
_jingong	endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_free_fish		proc	uses ebx edi esi	;������ҵĶ��ƵĴ����ӳ���
					local	go_puke:BYTE 


					;*******************
					mov	eax,my_will_fish	;�������ϳ�ȥ�����ǲ���ֻ��һ�ţ���Ϊ�ǲ��ܶ������Ƶģ�
					.if	eax	==	1			;��һ�ţ�����

					.else							;����һ�ţ����ܶ�������
							jmp	free_fish1
					.endif
					;*******************
					lea	edi,fishes			;���Ƶĳ�ʼ��
					lea	esi,my_hand
					;mov	,lp_puke_weiba
					;*******************
					mov	eax,hitpoint.x		;����Ҽ�����ʱ������
					mov	ebx,hitpoint.y
					;********************����˴��ġ����ơ�111111111111111111111111111111111111111111
					.if		eax	>	width_bmp*1		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*2		&&	ebx	<	height_bmp*2+30+96	
							
							mov	al,BYTE ptr [edi]		;�����һ��ĵط���û����
							mov	go_puke,al
							;***
							mov	my_will_fish,0	;���ϳ�ȥ���ƶ���ȥ������my_will_fish���0��,��������û���Ƴ�ȥ
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
							;***����ֵ�ŵ�fish_num����Ӧ��λ����ȥ
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
							;******************************************��go_puke�ŵ�puke�����ȥ
							mov	al,go_puke
							.if	al
									mov	ebx,lp_puke_weiba
									lea	edx,puke
									mov	BYTE ptr	[edx+ebx],al
									inc	ebx
									mov	lp_puke_weiba,ebx
							.else
							.endif
							;******************************************�������,����		
							lea		esi,my_hand
							lea		edi,my_hand_num
							invoke	give_puke,esi,edi
							;******************************************
							invoke	InvalidateRect,hWinMain,NULL,TRUE	;ˢ�µ�ͼ
							ret														;����

					.endif
					;********************2222222222222222222222222222222222222222222222
					.if		eax	>	width_bmp*2		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*3		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+1]		;�����һ��ĵط���û����
							mov	go_puke,al
									mov	my_will_fish,0	;���ϳ�ȥ���ƶ���ȥ������my_will_fish���0��,��������û���Ƴ�ȥ
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
									;***����ֵ�ŵ�fish_num����Ӧ��λ����ȥ
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
									;******************************************��go_puke�ŵ�puke�����ȥ
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************�������,����		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;ˢ�µ�ͼ
									ret														;������ɣ�����

							;.else
							;		ret
							;.endif

							;ret	;û��Ļ�������
					.endif
					;********************33333333333333333333333333333333333333333333333
					.if		eax	>	width_bmp*3		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*4		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+2]		;�����һ��ĵط���û����
							mov	go_puke,al
									mov	my_will_fish,0	;���ϳ�ȥ���ƶ���ȥ������my_will_fish���0��,��������û���Ƴ�ȥ
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
									;***����ֵ�ŵ�fish_num����Ӧ��λ����ȥ
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
									;******************************************��go_puke�ŵ�puke�����ȥ
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************�������,����		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;ˢ�µ�ͼ
									ret														;������ɣ�����

							;.else
							;		ret
							;.endif

							;ret	;û��Ļ�������
					.endif
					;********************44444444444444444444444444444444444444444444444
					.if		eax	>	width_bmp*4		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*5		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+3]		;�����һ��ĵط���û����
							mov	go_puke,al
									mov	my_will_fish,0	;���ϳ�ȥ���ƶ���ȥ������my_will_fish���0��,��������û���Ƴ�ȥ
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
									;***����ֵ�ŵ�fish_num����Ӧ��λ����ȥ
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
									;******************************************��go_puke�ŵ�puke�����ȥ
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************�������,����		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;ˢ�µ�ͼ
									ret														;������ɣ�����

							;.else
							;		ret
							;.endif

							;ret	;û��Ļ�������
					.endif
					;********************555555555555555555555555555555555555555555
					.if		eax	>	width_bmp*5		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*6		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+4]		;�����һ��ĵط���û����
							mov	go_puke,al
									mov	my_will_fish,0	;���ϳ�ȥ���ƶ���ȥ������my_will_fish���0��,��������û���Ƴ�ȥ
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
									;***����ֵ�ŵ�fish_num����Ӧ��λ����ȥ
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
									;******************************************��go_puke�ŵ�puke�����ȥ
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************�������,����		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;ˢ�µ�ͼ
									ret														;������ɣ�����

							;.else
							;		ret
							;.endif

							;ret	;û��Ļ�������
					.endif
					;********************66666666666666666666666666666666666666666666
					.if		eax	>	width_bmp*6		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*7		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+5]		;�����һ��ĵط���û����
							mov	go_puke,al
									mov	my_will_fish,0	;���ϳ�ȥ���ƶ���ȥ������my_will_fish���0��,��������û���Ƴ�ȥ
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
									;***����ֵ�ŵ�fish_num����Ӧ��λ����ȥ
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
									;******************************************��go_puke�ŵ�puke�����ȥ
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************�������,����		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;ˢ�µ�ͼ
									ret														;������ɣ�����

							;.else
							;		ret
							;.endif

							;ret	;û��Ļ�������
					.endif
					;********************77777777777777777777777777777777777777777777
					.if		eax	>	width_bmp*7		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*8		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+6]		;�����һ��ĵط���û����
							mov	go_puke,al
									mov	my_will_fish,0	;���ϳ�ȥ���ƶ���ȥ������my_will_fish���0��,��������û���Ƴ�ȥ
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
									;***����ֵ�ŵ�fish_num����Ӧ��λ����ȥ
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
									;******************************************��go_puke�ŵ�puke�����ȥ
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************�������,����		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;ˢ�µ�ͼ
									ret														;������ɣ�����

							;.else
							;		ret
							;.endif

							;ret	;û��Ļ�������
					.endif
					;********************88888888888888888888888888888888888888888888
					.if		eax	>	width_bmp*8		&&	ebx	>	height_bmp*2+30	\
							&&	eax	<	width_bmp*9		&&	ebx	<	height_bmp*2+30+96	

							mov	al,BYTE ptr [edi+7]		;�����һ��ĵط���û����
							mov	go_puke,al
									mov	my_will_fish,0	;���ϳ�ȥ���ƶ���ȥ������my_will_fish���0��,��������û���Ƴ�ȥ
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
									;***����ֵ�ŵ�fish_num����Ӧ��λ����ȥ
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
									;******************************************��go_puke�ŵ�puke�����ȥ
									mov	al,go_puke
									.if	al
											mov	ebx,lp_puke_weiba
											lea	edx,puke
											mov	BYTE ptr	[edx+ebx],al
											inc	ebx
											mov	lp_puke_weiba,ebx
									.else
									.endif
									;******************************************�������,����		
									lea		esi,my_hand
									lea		edi,my_hand_num
									invoke	give_puke,esi,edi
									;******************************************
									invoke	InvalidateRect,hWinMain,NULL,TRUE	;ˢ�µ�ͼ
									ret														;������ɣ�����

							;.else									;Ҫ���Ƶĵط�����
																	;������һ������
									
								;	ret
							;.endif

							;ret	;û��Ļ�������
					.endif
					;********************
free_fish1:
					mov	eax,012345678h						;����һ���ƴ����г���������ʧ��

					ret

_free_fish		endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
computer_fish	proc	uses eax ebx ecx edx esi edi 
					;local	shiyan1:BYTE
					local		cjc_eax			;:DWORD   
					local		cjc_ebx			;:DWORD 	 				
					local		cjc_ecx			;:DWORD 

					;***����	ax,bx,cx
					mov		cjc_eax,eax
					mov		cjc_ebx,ebx
					mov		cjc_ecx,ecx
					;***		����
					mov		dl,cl
					add		dl,ch
					add		dl,bh				;��������ƵĴ�С�ܺ���dl��
					;***
					mov		dh,al
					add		dh,ah
					add		dh,bl				;��������Ƶ������ܺ���dh��
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
										;**********************���Ƶķ�ֵ�ӵ�dh��
										mov	cl,BYTE ptr [edi]
										add	dh,cl
										;***                   ���㱾�ֵ÷֣����ӵ�your_max_point��ȥ
										sub	dh,14d
										mov	cl,13d
										sub	eax,eax
										mov	al,dh
										div	cl
										mov	dh,al
										mov	al,add_points
										add	dh,al
										;**********************��õķ���dh��
										mov		al,your_max_point
										;���滻��߷�
										;���滻your_aogo
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

					invoke	_jingong				;�˴�����Ҫ�������ƺ�ճ��
														;���ƺ�������������ճ���ӳ���
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
					.if		eax	==	012345678h	;����ʧ�ܣ������������Ե���ĳ���

								ret
					.endif
					mov		who_fish,2		;��ʵ��2û��ʲô�ô������Ǵ�ʱ���ǵ������õ����̣߳���������2
													;�����ʹ�ö��̵߳Ļ����Ͳ���2���Ļ�ȥcjc
					;***********cjc����Ӧ�����ڴ˴��������Ե�����ӳ����ܣ�ע�⣺Ҫ�ǵ��Դ���ĳ���Ƚ������Ļ���Υ��1/8�����
									;���ö��̵߳ķ���
					invoke	SetTimer,hWnd,TimerID,500,NULL
					;

;********************************************************************������Ե���
		.elseif	eax ==	WM_computer_fish

					;***
					mov		al,0							;��߷���0
					mov		your_max_point,al			;��߷���0
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
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
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
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
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
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
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
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
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
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
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
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
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
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
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
					;*********************************************�����ٴ����Ƶ�ת�ƺ���0
					;*********************************************�����ٴ����Ƶ�ת�ƺ���0
					mov		al,your_max_point			;��߷���0
					.if		al	==	0
								jmp	computer_fish_over
					.endif
					;*********************************************�����ٴ����Ƶ�ת�ƺ���0
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
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
								mov		BYTE ptr [edi],dl
								;***
					.elseif	cl		==	6d
								mov		ah,BYTE ptr [esi+1]
								mov		BYTE ptr [esi+1],dl
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
								mov		BYTE ptr [edi+1],dl
								;***
					.elseif	cl		==	5d
								mov		bl,BYTE ptr [esi+2]
								mov		BYTE ptr [esi+2],dl
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
								mov		BYTE ptr [edi+2],dl
								;***
					.elseif	cl		==	4d
								mov		al,BYTE ptr [esi]
								mov		ah,BYTE ptr [esi+1]
								mov		BYTE ptr [esi],dl  
								mov		BYTE ptr [esi+1],dl
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
								mov		BYTE ptr [edi],dl  
								mov		BYTE ptr [edi+1],dl 
								;***
					.elseif	cl		==	3d
								mov		al,BYTE ptr [esi]
								mov		bl,BYTE ptr [esi+2]
								mov		BYTE ptr [esi],dl   
								mov		BYTE ptr [esi+2],dl 
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
								mov		BYTE ptr [edi],dl  
								mov		BYTE ptr [edi+2],dl
								;***
					.elseif	cl		==	2d
								mov		ah,BYTE ptr [esi+1]
								mov		bl,BYTE ptr [esi+2]
								mov		BYTE ptr [esi+1],dl
								mov		BYTE ptr [esi+2],dl
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
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
								;***�ѵ������е��ƵĴ�С�ŵ�bh��cl��ch����
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
					;*********************************************�ѱ��ֵ���ķּӵ��ܷ���ȥ
					mov		al,your_points
					mov		ah,your_max_point
					add		al,ah
					mov		your_points,al
					;**********************************************************************************************��0
					computer_fish_over:
					;**********************************�����֣����ԣ�����        
					lea		esi,your_hand                                         					
					lea		edi,your_hand_num                                     
					invoke	give_puke,esi,edi
					;**********************************���֣����ԣ�����
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
					mov		ebx,esi		;esi���ǵ���Ҫ���Ƶĵ�ַ
					mov		edx,edi		;edi���ǵ���Ҫ���Ƶ�num�ĵ�ַ
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
					;**********************************�ٸ����֣����ԣ����� 
					lea		esi,your_hand                                         					
					lea		edi,your_hand_num                                     
					invoke	give_puke,esi,edi
					;**********************************
					;**********************************
					;**********************************
					;**********************************�����֣����ԣ�����
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
											;****************	;�Ѹշ����ƵĴ�С�ŵ�my_hand_num����Ӧ��λ����ȥ
											.if		al < 14d

											.elseif	al	> 13d	&&	al	<	27d
														sub	al,13d
											.elseif	al	> 26d &&	al <  40d
														sub	al,26d
											.elseif	al > 39d && al	<	53d
														sub	al,39d
											.endif
											;****************	;�Ѹշ����ƵĴ�С�ŵ�my_hand_num����Ӧ��λ����ȥ
											.if		ah < 14d

											.elseif	ah	> 13d	&&	ah	<	27d
														sub	ah,13d
											.elseif	ah	> 26d &&	ah <  40d
														sub	ah,26d
											.elseif	ah > 39d && ah	<	53d
														sub	ah,39d
											.endif
											;****************	;�Ѹշ����ƵĴ�С�ŵ�my_hand_num����Ӧ��λ����ȥ
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
					mov		who_fish,0					;���ֻ�λ��0
					invoke	InvalidateRect,hWinMain,NULL,TRUE
					ret
;********************************************************************�����Ϣ����Ҫ���ò��ϵĻ�����Ϸȫ����ɺ�ɾ����
      .elseif  eax ==   WM_CHAR        ;������ʵ��          
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
					;*********************************�������е��Ƶ����긳ֵ����Ϊ��Щֵ�����仯������Ҫ�ñ�������ʾ���ǣ�
					mov		my_hand1_x,width_bmp*2
					mov		my_hand1_y,height_bmp*4+30
					mov		my_hand2_x,width_bmp*3
					mov		my_hand2_y,height_bmp*4+30
					mov		my_hand3_x,width_bmp*4
					mov		my_hand3_y,height_bmp*4+30
					;**********************************��Ҫ��0��һЩ����
					invoke	RtlZeroMemory,addr	my_hand,180d
					mov		my_will_fish,0
					mov		who_fish,0
					;**********************************ʵ��ר��

					;**********************************δ�����Ƶ���λָ��ĳ�ʼ��
					mov		lp_puke_head,0
					mov		lp_puke_weiba,52d
					;**********************************��δ�����ƣ���ʱΪ���е��ƣ���ֵ
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
					;**********************��0һЩ����
					sub		al,al
					mov		can_huanpai,al
					mov		your_points,al
					;**********************************��fishes����              
					lea		esi,fishes
					;add		esi,4
					lea		edi,fish_num 
					;add		edi,4
					invoke	give_puke,esi,edi			                            
					;**********************************���ҷ���                  
					lea		esi,my_hand                                         					
					lea		edi,my_hand_num                                     
					invoke	give_puke,esi,edi                                   
					;**********************************�����֣����ԣ�����        
					lea		esi,your_hand                                         					
					lea		edi,your_hand_num                                     
					invoke	give_puke,esi,edi                           
					;**********************************                          
					invoke	InvalidateRect,hWinMain,NULL,TRUE		;ˢ�µ�ͼ    
																									 
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
					mov		eax,hWnd											;���ھ���ŵ�hWinMain��
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
; ע�ᴰ����
;********************************************************************
		invoke	LoadCursor,0,IDC_ARROW
		mov		@stWndClass.hCursor,eax
		push		hInstance
		pop		@stWndClass.hInstance
		mov		@stWndClass.cbSize,sizeof WNDCLASSEX
		mov		@stWndClass.style,CS_HREDRAW or CS_VREDRAW
		mov		@stWndClass.lpfnWndProc,offset _ProcWinMain
		;invoke	GetStockObject,BLACK_BRUSH	��ô��ȡ��ɫ�Ļ�ˢ������������������������
		mov		@stWndClass.hbrBackground,COLOR_WINDOW +	1
		mov		@stWndClass.lpszClassName,offset szClassName
		invoke	RegisterClassEx,addr @stWndClass
;********************************************************************
; ��������ʾ����
;********************************************************************
		invoke	CreateWindowEx,WS_EX_CLIENTEDGE,offset szClassName,offset szCaptionMain,\
					WS_MINIMIZEBOX+WS_SYSMENU,\		;WS_OVERLAPPEDWINDOW
					10,10,750,600,\
					NULL,hMenu,hInstance,NULL
		mov		hWinMain,eax
		invoke	ShowWindow,hWinMain,SW_SHOWNORMAL
		invoke	UpdateWindow,hWinMain
;********************************************************************
; ��Ϣѭ��
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
