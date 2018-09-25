
;1）   把从LIST 到LIST+316中的字符串传送到BLK到BLK+316 中去；
;2）    在BLK到BLK+100中查找字符“cqu”字符串，并记下“CQU”字符串出现的起始位置到BX中。

data segment                              ;定义数据段
      mess1 db 'Chongqing University CQU) is a key national university and a member of the “Excellence League”,'
            db 'located in Chongqing, Southwest China. '
            db 'It is also one of the “211 Project" and "985 Project” universities with full support in construction and development from the central government and Chongqing Municipal Government.$'

      QU    db   'QU'
data ends


extra segment                             ;定义附加段
mess2 db 316 dup(?)
extra ends

code segment
assume cs:code,ds:data,es:extra           ;对数据段、堆栈段、代码段进行申明
start:
      mov ax,data     
      mov ds,ax        
      mov ax,extra     
      mov es,ax  
;-----------------------------------------------------------
;根据要求编写代码开始        
      lea si,mess1
      lea di,mess2
      mov cx,316
      cld
      rep movsb                           ;将mess1的内容传送到mess2;
      lea di,mess2
      mov al,'C'                          ;将‘C’的Ascii码值赋给al以便于之后的对比查找
      mov bx,100                          ;在mess2的前100个字符中进行查找 
 find:
      mov cx,bx
      cld
      repne scasb
      mov bx,cx                           ;从mees2中查找指定字符'C'
      jz goon                             
 goon:
      lea si,QU
      mov cx,2
      repz cmpsb
      cmp cx,0                            ;找到C之后，继续对比之后的两个字符是否分别为Q和U
      je count
      jne find                            ;如果C之后不为QU,则接着继续从mess2中查找下一个c
count: 
      mov bx,di                           ;将‘CQU’的末地址赋给bx
      sub bx,3                            ;bx减去3,存入bx,相当于‘CQU’的首地址赋给bx
;根据要求编写代码结束
;-----------------------------------------------------------
      mov ah,4ch
      int 21h
Code ends
End start
                                          ;20161724_代欣月_实验3



