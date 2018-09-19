;课本P331例9.13。
;具体命令可以参考该文档上面部分的介绍和第三章书上的内容)
;******************************************
;eg9-13.asm
;purpose:display characters in a window until Esc pressed
;******************************************
		.model	small
;------------------------------------------
		.stack
;------------------------------------------
		.code
Esc_key   equ 1bh			;ASCII of Esc key
win_ulc   equ 30			;window upper left column
win_ulr   equ 8				;window upper left row
win_lrc   equ 50			;window lower right column
win_lrr   equ 16			;window lower right row
win_width equ 20			;width of window



;Main program
main 	proc far
		call clear_screen
locate:		
		mov ah,2
		mov dh,win_lrr
		mov dl,win_ulc
		mov bh,0
		int 10h
;get characters from kbd
		mov cx,win_width
get_char:
		mov ah,1
		int 21h
		cmp al,Esc_key
		jz,exit
		loop get_char
;scroll up
		mov ah,6
		mov al,1
		mov ch,win_ulr
		mov cl,win_ulc
		mov dh,win_lrr
		mov dl,win_lrc
		mov bh,7
		int 10h
		jmp locate
exit:
		mov ax,4c00h
		int 21h 
		main endp
;------------------------------------------
;eg9-11.asm
clear_screen proc near
;save register
		push ax
		push bx
		push cx
		push dx
;clear screen
		mov ah,6
		mov al,0
		mov bh,7
		mov ch,0
		mov cl,0
		mov dh,24
		mov dl,79
		int 10h
;locate cursor
		mov dx,0
		mov ah,2
		int 10h
;restore registers
		pop dx
		pop cx
		pop bx
		pop ax
clear_screen	endp
;------------------------------------------