;3.50已知X、Y、Z均为双精度数,它们分别存放在地址 为X,X+2;Y,Y+2;Z,Z+2的存储单元中,高字节在高 ;地址,低字节在低地址。用指令序列实现: W←X+Y+Z*2 

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
      mov dx,x[bx+2]
 
      add ax,x[bx+4]
      adc dx,x[bx+6]

      
      add ax,24
      adc dx,0
      sub ax,x[bx+8]
      sbb dx,x[bx+10]

      mov x[bx+12],ax
      mov x[bx+14],dx
      mov ah,4ch
      int 21h
Code ends
End start