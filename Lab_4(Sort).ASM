        org 100h

        N = 7

        mov cx, N
        sub cx, 1
Loop1:
        push cx

        mov bp, Mas
.Loop2:
        mov al, [bp]
        mov dl, [bp+1]
        cmp al, dl
        jg .More
        jmp .EndLoop2

.More:
        mov [bp+1], al
        mov [bp], dl
        jmp .EndLoop2

.EndLoop2:
        add bp, 1
        loop .Loop2

        pop cx

        loop Loop1



        mov cx, N
        mov bp, Mas
LoopOut:

        push cx

        mov ax, [bp]
        push ax
        call ToDec

        pop cx

        mov ah, 02h
        mov dl, ' '
        int 21h

        add bp, 1
        loop LoopOut


        mov ah, 08h
        int 21h

        ret

Mas db 102, 0, -5, -67, 0, 33, 87
Ent db 13,10, '$'
Spc db ' $'

ToDec:
        push bp
        mov bp, sp
        push bx

        mov bx, 10
        xor cx, cx
        mov ax, [bp+4]
        cbw

        cmp ax, 0
        jnl .DigitLoop

        mov ah, 02h
        mov dl, '-'
        int 21h

        mov ax, [bp+4]
        cbw
        neg ax

.DigitLoop:
        xor dx, dx
        div bx

        push dx
        inc cx

        cmp ax, 0
        jne .DigitLoop

        mov ah, 02h
.WriteLoop:

        pop dx
        add dl, '0'
        int 21h
        loop .WriteLoop

        pop bx
        pop bp
        ret 2