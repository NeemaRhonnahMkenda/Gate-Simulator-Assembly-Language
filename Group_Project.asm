.model small    ;defines memory structure
.stack 100h     ;defines memory block for stack data
.data           ;defines the memory location
menu db '*****************MENU*********************$'
menu1 db 'Press 1 for Gate A$'
menu2 db 'Press 2 for Gate B$'
menu3 db 'Press 3 to exit$'
msg1 db 'Wrong input$'
msg2 db 'Gate A open$'  
msg3 db 'Gate B open$'
msg4 db 'Maximum capacity'
amount dw 0
count dw '0'
am1 dw ?        ;shows the addressing mode where the first value is stored
am2 dw ?        ;shows the addressing mode where the 16-bit data will be stored
am3 dw ?        ;shows the addressing mode where the second value is stored
GA dw '0'
GB dw '0'

.code
main proc
mov ax,@data     ;the variable that holds the value of the location in memory
mov ds,ax
while_:  
             ;Menu
mov dx,10
mov ah,2    ;write character to standard output
int 21h
mov dx,13
mov ah,2
int 21h

mov dx,offset menu
mov ah,9    ;output menu string
int 21h
mov dx,10
mov ah,2    ;write character to standard output
int 21h
mov dx,13
mov ah,2    ;write character to standard output
int 21h

mov dx,offset menu1
mov ah,9    ;output menu string
int 21h

mov dx,10
mov ah,2
int 21h     ;write character to standard output
mov dx,13
mov ah,2
int 21h     ;write character to standard output

mov dx,offset menu2
mov ah,9
int 21h     ;output menu string

mov dx,10
mov ah,2
int 21h     ;write character to standard output
mov dx,13
mov ah,2
int 21h     ;write character to standard output

mov dx,offset menu3
mov ah,9
int 21h     ;output menu string
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h     ;write character to standard output

  ;userinput

mov ah,1     
int 21h     ;read character from standard output
mov bl,al   ;move result in al to bl register
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h     ;write character to standard output

mov al,bl
cmp al,'1'     ;now compare
je A           ;jump if equal to A (open gate A)
cmp al,'2'     ;now compare
je B           ;jump if equal to B (open gate B)
cmp al,'3'     ;now compare
je end_        ;jump to end of the program if equal to 3 (close program)
mov dx,offset msg1
mov ah,9
int 21h        ;output message string

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h        ;write character to standard output
jmp while_

A:
call A1       ;pushes the return address onto the stack and transfers control to the procedure
B:
call B1       ;pushes the return address onto the stack and transfers control to the procedure
end_:
mov ah, 4Ch   ;return control to operating system
int 21h

main endp

AA proc
    cmp count,'8'
    jle A1     ;jump short if less or equal to the number of entries input
    mov dx, offset msg4   ;if capacity is reached, display maximum capacity
    mov ah, 9
    int 21h
    jmp while_
    jmp end_

A1:
mov dx, offset msg2
mov ah, 9
int 21h       ;output message string

mov ax, 200   ;move 200 into ax register
add amount, ax
mov dx, 0
mov bx, 10
mov cx, 0
l2:
        div bx
        push dx    ;store value of dx in stack
        mov dx,0
        mov ah,0
        inc cx     ;increment cx 
        cmp ax,0
        jne l2     ;jump if not equal to 12
   l3:
        pop dx     ;restore original value of dx
        add dx,48
        mov ah,2
        int 21h
loop l3

inc count

inc GA 
jmp while_
jmp end_

BB proc
cmp count,'8'
jle B1          ;jump if not equal to B1 
mov dx,offset msg4
mov ah,9
int 21h         ;output message string
jmp while_
jmp end_
B1:
mov dx, offset msg3
mov ah, 9
int 21h         ;output message string

mov ax,300
add amount, ax
mov dx,0           ;move sero into dx register
mov bx,10          ;store ten into bx register
mov cx,0           ;initialize cx register to zero
l22:
        div bx     ;store value of dx in stack
        push dx
        mov dx,0
        mov ah,0
        inc cx     ;increment cx
        cmp ax,0
       jne l22     ;jump if not equal to l22
   
l33:
        pop dx     ;increment stack pointer
        add dx,48
        mov ah,2
        int 21h    ;write character to standard output
loop l33           ;repeats the block of statement above


inc count          ;increment count
inc GB             ;increment GB
jmp while_
jmp end_
end main           ;return program to the operating system