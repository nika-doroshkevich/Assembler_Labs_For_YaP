        org 100h
Start:
        mov ah, 09h
        mov dx, Str1
        int 21h

        mov ah, 0Ah
        mov dx, InputStr
        int 21h

        mov ah, 09h
        mov dx, Next
        int 21h

        mov ah, 09h
        mov dx, Str2
        int 21h

        mov ah, 0Ah
        mov dx, Symbol
        int 21h

        mov ah, 09h
        mov dx, Next
        int 21h

        xor bx, bx
        mov di, InputStr
        add di, 2

.Cycle:
        inc bl
        mov al, [Symbol+2]
        scasb
        je .Output
        jmp .NoOutput

.Output:
        mov ah, 02h
        mov dl, bl
        add dl, '0'
        int 21h

        mov ah, 02h
        mov dl, $20
        int 21h

.NoOutput:
        cmp bl, [InputStr+1]
        jne .Cycle

        mov ah, 08h
        int 21h
        ret

Str1 db 'Enter string:$'
Str2 db 'Enter symbol:$'
InputStr db 10, 0, 10 dup(?)
Symbol db 2, 0, 2 dup(?)
Next db 10, 13, '$'