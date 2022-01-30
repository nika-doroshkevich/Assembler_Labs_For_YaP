        org 100h

        N = 8

Start:
        mov cx, N
        mov bp, Mas
        mov al, [Mas]


.Loop1:
        mov al, [bp]
        cmp al, 0
        jl .LessZero
        jnl .GreatZero


        .LessZero:
        mov al, [MaxMinus]
        cmp al, [bp]
        jnl @F
        mov al, [bp]
        mov [MaxMinus], al
@@:
        jmp .EndOfCycle


        .GreatZero:
        mov al, [MinPlus]
        cmp al, [bp]
        jng @F
        mov al, [bp]
        mov [MinPlus], al
@@:
        jmp .EndOfCycle




        .EndOfCycle:
        inc bp
        loop .Loop1



        mov ah, 09h
        mov dx, Str1
        int 21h

        mov ah, 02h
        mov dl, '-'
        int 21h

        mov ah, 02h
        mov dl, [MaxMinus]
        neg dl
        add dl, 48
        int 21h

        mov ah, 09h
        mov dx, Ent
        int 21h


        mov ah, 09h
        mov dx, Str2
        int 21h

        mov ah, 02h
        mov dl, [MinPlus]
        add dl, 48
        int 21h

    
        mov ah, 08h
        int 21h

        ret

Mas db 4, -3, 4, 3, -5, -4, 8, -1
Ent db 13,10,'$'
Str1 db 'Max minus: $'
Str2 db 'Min plus: $'
MaxMinus db -9
MinPlus db 9