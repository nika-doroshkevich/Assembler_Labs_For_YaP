        org     100h
Start:

        mov     ah, 0Ah
        mov     dx, StrBufInput
        int     21h

        mov     ah, 09h
        mov     dx, strNextLine
        int     21h

        mov     cl, [StrBufInput+4]
        cmp     cl, 'A'
        jb      No
        cmp     cl, 'Z'
        ja      Yes

        xor     cl, cl
        mov     cl, [StrBufInput+6]
        cmp     cl, 'A'
        jb      No
        cmp     cl, 'Z'
        ja      Yes

        mov     bl, [StrBufInput+4]
        mov     bh, [StrBufInput+6]
        cmp     bl, bh
        jne     No

Yes:
        mov     ah, 09h
        mov     dx, strYes
        int     21h
        jmp     Output

No:
        mov     ah, 09h
        mov     dx, strNo
        int     21h
Output:
        mov     ah, 08h
        int     21h
        ret

StrBufInput:
        db      7, 0, 7 dup(?)
strNextLine:
        db      10, 13, '$'
strNo:
        db      "No$"
strYes:
        db      "Yes$"