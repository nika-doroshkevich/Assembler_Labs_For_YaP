program Lab_7;

{$APPTYPE CONSOLE}

Var
  Mas: Array [1..10] of Integer;
  i, LenMas: Integer;

begin
  Writeln('Start array:');
  Randomize;
  LenMas:=Length(Mas);
  For i:=1 to LenMas do
  Begin
    Mas[i]:=Random(20);
    Write(Mas[i],' ')
  End;
  Writeln;

  asm
    mov ecx, LenMas
    inc ecx

  @Loop1:
    lea edi, [Mas]
    lea esi, [Mas]
    add edi, 4
    dec ecx
    cmp ecx, 1
    jbe @Loop1End
    xor ebx, ebx
    mov ebx, 1

  @Loop2:
    cmpsd
    jbe @Loop2End
    mov eax, [esi-4]
    mov edx, [edi-4]
    mov [esi-4], edx
    mov [edi-4], eax

  @Loop2End:
    inc ebx
    cmp ebx, ecx
    jb @Loop2
    je @Loop1

  @Loop1End:
  end;

  Writeln;
  Writeln('Sort array:');
  For i:=Low(Mas) to High(Mas) do
    Write(Mas[i],' ');

  Readln;
end.
