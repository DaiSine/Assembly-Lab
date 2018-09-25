;已知数组A包含15个互不相等的整数，数组B包含10个互不相等的整数。
;试编制一程序，把既在A中又在B中出现的整数存放于数组C中。然后将数组C逐个显示出来。
;要求：要写流程图，代码必须规范，有必要的注释。
;说明：数组表示可参考教材例5.5。datarea segment        				  ;define data segment
aArray dw 1,2,3,4,5,6,7,8,9,14,16,11,12,13,15
bArray dw 1,2,3,4,5,6,7,8,9,10
cArray dw 0,0,0,0,0,0,0,0,0,0    
datarea ends


stacks segment                              ;定义堆栈段
       db 200 dup(?)
stacks ends

 
codes segment                               ;define code segment

assume cs:codes,ds:datarea,ss:stacks  
start:             				            ;starting execution address
					   	                    ;set up stack for return
       push ds  		                	;save old data address
       sub ax,ax				            ;put zero in AX
       push ax 			  		            ;save in on stack 
							                ;set DS register to current data segment
       mov ax,datarea
       mov ds,ax
;---------------------------------------
;根据要求编写代码开始 
      mov dx,0 
      mov cx,10                             ;设置循环次数为10
      mov bx,0                              ;从b数组的第一个元素开始
     
first:
      push cx                               ;保存当前cx的值
      push ax                               ;保存当前ax的值
      mov cx,15                             ;设置b[i]与a数组的15个元素比较次数为15
next:
      mov ax,bArray[bx]                     ;将该次循环的b[i]赋值给ax
      add bx,2                              ;bx的值自加2
      push bx                               ;保存当前bx的值
      mov bx,0                              ;将bx设置为0，从a数组的第一个元素开始与b[i]比较
find: 
      cmp ax,aArray[bx]                     ;比较b[i]和a数组的第bx个元素
      jz follow                             ;如果相等的话，跳转到follow语句
      add bx,2                              ;bx的值自加2
      loop find                             ;继续循环find
      pop bx
      pop ax
      pop cx
      loop next
      jmp flag
follow:
      mov bx,dx                             ;将dx的值赋给bx
      mov cArray[bx],ax                     ;将b[i]加入到c数组中
      add dx,2                              ;dx的值自加2
      pop bx                                ;bx的值出栈
      pop ax                                ;ax的值出栈
      pop cx                                ;cx的值出栈 
      loop first

flag:  
      mov cx,dx
      mov bx,0
over:
      mov ax,cArray[bx]						         ;以字符形式输出c数组中的值
      dec cx
      add bx,2
      add al,30h
      mov dl,al
      mov ah,02h
      int 21h  
      loop over
;根据要求编写代码结束
;-------------------------------------------------------------
     mov ah,4ch
     int 21h
codes ends
    end start