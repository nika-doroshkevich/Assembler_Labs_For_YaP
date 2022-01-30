        org 100h
Start:
        mov ah, 09h
        mov dx, StrHello
        int 21h

        mov ah, 0Ah
        mov dx, StrInput
        int 21h

        mov ah, 09h
        mov dx, NextLine
        int 21h

        mov ah, 09h
        mov dx, StrHello2
        int 21h

        mov cl, [StrInput+1]
        mov si, 2
Output:
        mov ah, 02h
        mov dl, [StrInput+si]
        int 21h
        inc si
        loop Output

        mov ah, 09h
        mov dx, StrHello3
        int 21h

        mov ah, 08h
        int 21h
        ret

StrHello db 'Enter your name:$'
NextLine db 10, 13, '$'
StrInput db 20, 0, 20 dup(?)
StrHello2 db 'Hello, $'
StrHello3 db '!$'