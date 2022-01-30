        org 100h
Start:

        mov ah, 09h
        mov dx, Str1
        int 21h

        mov ah, 0Ah
        mov dx, Mas
        int 21h

        mov ah, 09h
        mov dx, Ent
        int 21h

        mov ah, 09h
        mov dx, Str2
        int 21h

        mov ah, 0Ah
        mov dx, Simbol
        int 21h

        mov ah, 09h
        mov dx, Ent
        int 21h

        xor ch, ch
        mov cl, [Mas+1]
        mov di, Mas
        add di, 2
Loop1:

        mov al, [Simbol+2]
        scasb
        jz .LowReg
        jmp .EndLoop

.LowReg:
        dec di
        sub byte[di], 'a'
        add byte[di], 'A'
        inc di
        jmp .EndLoop

.EndLoop:
        loop Loop1



        xor ch, ch
        mov cl, [Mas+1]
        mov si, Mas
        add si, 2
Output:
        mov ah, 02h
        mov dl, [si]
        int 21h
        inc si
        loop Output

        mov ah, 08h
        int 21h

Mas db 20, 0, 20 dup(?)
Ent db 13, 10, '$'
Str1 db 'Enter your string: $'
Str2 db 'Enter your symbol: $'
Simbol db 2, 0, 1 dup(?)