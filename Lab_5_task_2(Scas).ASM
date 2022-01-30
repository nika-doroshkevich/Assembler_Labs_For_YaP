        org 100h
Start:
        mov ah, 09h
        mov dx, Str1
        int 21h


        mov ah, 09h
        mov dx, Next
        int 21h


        xor cx, cx
        mov cl, 5
        mov di, InputStr
        ;add di, 2

Cycle:
        cmp byte[di], 'a'
        jb Reg

        cmp byte[di], 'z'
        ja Reg

Reg:

        sub byte[di], 'a'
        add byte[di], 'A'
        inc di

        loop Cycle

         xor cx, cx
         mov cl, 5
         mov bx, 0
Output:
        mov ah, 02h
        mov dl, [InputStr+bx]
        int 21h
        inc bx
        loop Output

        mov ah, 08h
        int 21h
        ret

Str1 db 'Enter string:$'
InputStr db 'sdfgh$'
Next db 10, 13, '$'