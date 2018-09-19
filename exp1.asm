;课本P322例9.5。
;******************************************
;eg9-5.asm
;purpose:read a string from keyboard
;       this procedure read up tp 50keys
;******************************************
		.model	small
;------------------------------------------
		.stack
;------------------------------------------
		.data
;------------------------------------------
user_string db 50,0,50 dup(?)
;------------------------------------------
		.code
;Main program
read_keys proc far
		mov ax,@data		;ds<=data segment
		mov ds,ax

		lea dx,user_string  ;read string
		mov ah,0ah
		int 21h

		sub ch,ch			;cx<=character number
		mov cl,user_string+1
		add dx,2			;make DX point to string
	exit:
		mov ax,4c00h
		int 21h
read_keys endp