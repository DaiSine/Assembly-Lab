;编写 99+97+…..+3+1 的累加和程序并调试通过，并记录程序执行结束后CX的值是多少？
code segment
assume cs:code
start:
;----------------------------------------
;根据要求编写代码开始
      mov cx,50				;从99、97..3、1 一共需要相加50次，即循环次数为50
      mov bx,99				;将第一个待加数赋给bx
      mov ax,0				;对ax进行清零操作以便ax存储累加结果
loop1:add ax,bx
      dec bx
      dec bx				;bx自减2为下一个待加数
      loop loop1
;根据要求编写代码结束
;----------------------------------------
      mov ah,4ch
      int 21h
Code ends
End start