data segment                              ;定义数据段
 dw  0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
data ends
stack segment
  dw  0,0,0,0,0,0,0,0,0,0,0
stack ends

code segment                              ;定义堆栈段
assume cs:code,ds:data,ss:stack
start:mov ax,stack
      mov ss,ax
      mov sp,20h  ;设置栈顶SS:SP指向stack:20
 
      mov ax,data 
      mov ds,ax   ;ds指向data段

      mov bx,0    ;ds:bx指向data段中的第一个单元
      
      mov  cx,8
;-----------------------------------------------------------
;根据要求编写代码开始
   s:  push [bx]
      add  bx,2
      loop  s  ;以上将data段中的0~15单元中的8个字型数据依次入栈

      mov  bx,0

      mov  cx,8
  s0:  pop [bx]
      add bx,2
      loop s0   ;以上依次出栈8个字型数据到data段中的0~15单元中
;根据要求编写代码结束
;-----------------------------------------------------------
      mov  ax,4c00h
      int 21h

code  ends
end  start
                                        ;20161724_代欣月_实验3

