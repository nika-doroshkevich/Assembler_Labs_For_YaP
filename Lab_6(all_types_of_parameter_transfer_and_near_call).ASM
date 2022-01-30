        org 100h


        mov     ah, 09h
        mov     dx, TextC
        int     21h

        mov     ah, 0Ah
        mov     dx, C
        int     21h

        call    ProcEntr

        mov     ah, 09h
        mov     dx, TextD
        int     21h

        mov     ah, 0Ah
        mov     dx, D
        int     21h

        call    ProcEntr

        mov    ax, C
        call Convert
        mov  [ResC], ax

        mov    ax, D
        call Convert
        mov  [ResD], ax

     
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


C       db      7,0,7 dup (?)
D       db      7,0,7 dup (?)
Entr    db      13,10,'$'
TextC   db      'Enter C: $'    ;-32768 to 32767
TextD   db      'Enter D: $'    ;-128 to 127
ResC       dw      ?
ResD       dw      ?
Result  db      'C/(D^2+1)+1 = $'


Calculate:
        push    bp
        mov     bp, sp
        sub     sp, 2

        mov     bx, [ResD]

        mov     al, bl
        mov     cl, bl
        imul    cl
        add     ax, 1
        mov     [bp-2], ax

        mov     ax, [ResC]
        cwd
        mov     cx, [bp-2]
        idiv    cx
        add     ax, 1

        mov     sp, bp
        pop     bp
        ret

Convert:
        push    bp
        mov     bp, sp
        sub     sp, 4
        push    si
        push    bx
        mov     si, ax
        mov     word[bp-2], 0

        mov     cl, [si+1]
        movzx   cx, cl
        add     si, cx
        add     si, 1
        mov     word[bp-4], 1
        std
.Calc:
        lodsb

        cmp     al, '-'
        je      .Minus

        sub     al, '0'
        movzx   ax, al
        mul     word[bp-4]
        add     [bp-2], ax

        mov     ax, [bp-4]
        mov     dx, 10
        mul     dx
        mov     [bp-4], ax

        loop    .Calc
        jmp     .End

.Minus:
        neg     word[bp-2]
.End:
        mov     ax, [bp-2]
        pop     bx
        pop     si
        mov     sp, bp
        pop     bp
        ret

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