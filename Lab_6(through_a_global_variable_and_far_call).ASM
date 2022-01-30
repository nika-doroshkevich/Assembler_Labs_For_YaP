        format MZ
        entry Main:Start


segment Main

Start:

     
        push  cs
        pop   ds

        mov     ah, 09h
        mov     dx, TypeC
        int     21h

        mov     ah, 0Ah
        mov     dx, C
        int     21h

        call    ProcEntr

        mov     ah, 09h
        mov     dx, TypeD
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

    
        push     cs
        call far Lib:Calculate

        push    ax

        mov     ah, 09h
        mov     dx, Result
        int     21h

        pop     ax

        push    ax
        call    ToDec

        call    ReadKey

        mov     ax, $4C00
        int     21h


C       db      7,0,7 dup (?)
D       db      7,0,7 dup (?)
Entr    db      13,10,'$'
TypeC   db      'Type C from -32768 to 32767: $'
TypeD   db      'Type D from -128 to 127: $'
ResC       dw      ?
ResD       dw      ?
Result  db      'C/(D^2+1)+1 = $'

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


segment Lib

Calculate:
        push    bp
        mov     bp, sp
        sub     sp, 6
        push    ds
        mov     ds, [bp+6]

        mov     ax, [ResC]
        mov     dx, [ResD]
        mov     [bp-4], ax
        mov     [bp-6], dx

        mov     bx, [bp-6]

        mov     al, bl
        mov     cl, bl
        imul    cl
        add     ax, 1
        mov     [bp-2], ax

        mov     ax, [bp-4]
        cwd
        mov     cx, [bp-2]
        idiv    cx
        add     ax, 1

        pop     ds
        mov     sp, bp
        pop     bp
        retf    2