        org     100h
Start:

         
        mov ah, 0Ah
        mov dx, BufInput
        int 21h

        mov ah, 09h
        mov dx, strNextLine
        int 21h

        mov bl, [BufInput+9]
        mov bh, [BufInput+10]
        mov [BufInput+9], bh
        mov [BufInput+10], bl
        int 21h

        mov bl, [BufInput+5]
        sub bl, [BufInput+8]
        mov cl, [BufInput+2]
        sub cl, bl
        mov [BufInput+4], cl
        int 21h

        mov ah, 40h
        mov bx, 01h
        mov cl, [BufInput+1]
        mov dx, BufInput+2
        int 21h

        mov ah, 08h
        int 21h
        
        ret

BufInput: db 10, 0, 10 dup(?)
strNextLine: db 10, 13, '$'
