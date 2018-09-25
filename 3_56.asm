;计算(V-(X*Y+Z - 540))/X 其中X、Y、Z、V均为16位带符号数,已分别装入X、 Y、Z、V单元中,
;要求计算结果的商存入AX，余数存入DX寄存器
data segment
x dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h

data ends

stack segment
  dw 0,0,0,0,0,0,0,0,0,0,0
stack ends



code segment
assume cs:code,ds:data,ss:stack
start:mov ax,stack
      mov ss,ax
      mov sp,20h
 
      mov ax,data 
      mov ds,ax   

      mov bx,0    
      
      mov ax,x[bx]
	  imul x[bx+2]
	  mov cx,ax
	  mov bx,dx
	  mov ax,x[bx+4]
	  cwd
	  add cx,ax
	  adc bx,dx
	  sub cx,540
	  sbb bx,0
	  mov ax,x[bx+6]
	  cwd
	  sub ax,cx
	  sbb dx,bx
	  idiv x

      mov ah,4ch
      int 21h
