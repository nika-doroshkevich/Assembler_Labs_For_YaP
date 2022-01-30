        org 100h

        mov     ah, 09h
        mov     dx, TypeA
        int     21h

        mov     ah, 0Ah
        mov     dx, A
        int     21h

        call    ProcEntr

        mov     ah, 09h
        mov     dx, TypeB
        int     21h

        mov     ah, 0Ah
        mov     dx, B
        int     21h

        call    ProcEntr

        push   A
        call Convert
        mov     al, dl
        cbw

        push   ax
      
        push   B
        call Convert

        pop     ax
        movsx     dx, dl

     
        push   dx
        push   ax
        call    Calculate

        push    ax

        mov     ah, 09h
        mov     dx, Result
        int     21h

        pop     ax

        push    ax
        call    ToDec

        call    ReadKey

        ret


A       db      5,0,5 dup (?)
B       db      5,0,5 dup (?)
Entr    db      13,10,'$'
TypeA   db      'Type C: $'
TypeB   db      'Type D: $'
Result  db      'C/(D^2+1)+1 = $'


Calculate:
        push    bp
        mov     bp, sp
        sub     sp, 2
        push    bx

        mov     al, [bp+4]
        mov     ah, [bp+6]
        mov     bx, ax

        mov     al, bh
        mov     cl, bh
        imul    cl
        add     ax, 1
        mov     [bp-2], ax

        mov     al, bl
        cbw
        cwd
        mov     cx, [bp-2]
        idiv    cx
        add     ax, 1

        pop     bx
        mov     sp, bp
        pop     bp
        ret     4

Convert:
        push    bp
        mov     bp, sp
        push    si
        mov     si, [bp+4]

        mov     cl, [si+1]
        movzx   cx, cl
        add     si, cx
        add     si, 1
        mov     dh, 1
        xor     dl, dl
        std
.Calc:
        lodsb

        cmp     al, '-'
        je      .Minus

        sub     al, '0'
        mul     dh
        add     dl, al

        mov     al, dh
        mov     dh, 10
        mul     dh
        mov     dh, al

        loop    .Calc
        jmp     .End

.Minus:
        neg     dl
.End:
        pop     si
        mov     sp, bp
        pop     bp
        ret     2


ToDec:
        push    bp
        mov     bp, sp
        push    bx

        mov     bx, 10
        xor     cx, cx
        mov     ax, [bp+4]

        cmp     ax, 0
        jnl     .DigitLoop

        mov     ah, 02h
        mov     dl, '-'
        int     21h

        mov     ax, [bp+4]
        neg     ax

.DigitLoop:
        xor     dx, dx
        div     bx

        push    dx
        inc     cx

        cmp     ax, 0
        jne     .DigitLoop

        mov     ah, 02h
.WriteLoop:
        pop     dx
        add     dl, '0'
        int     21h
        loop    .WriteLoop

        pop     bx
        pop     bp
        ret     2

ReadKey:
     mov        ax, $0C08
     int        21h
     movzx      dx, al
     test       al, al
     jnz        @F
     mov        ah, $08
     int        21h
     mov        dh, al
@@:
     mov        ax, dx
     ret

ProcEntr:
        mov     ah, 09h
        mov     dx, Entr
        int     21h

        ret