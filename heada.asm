[bits 16]
[org 0]

    mov ax,0x7c0		; baza stosu
    mov ss,ax
    mov sp,0x3fe		; wierzchołek stosu
    
    xor ah,ah			; tryb graficzny
    mov al,0x6a
    int 0x10
    
    mov bl,00000111b		; ustawiam kolor czcionki i tła
    
    mov ax,napis
    call puts
    
    main:
    xor ah,ah
    int 0x16
    cmp al,0x1b
    je reset
    jmp main
    
    reset:			; restartujemy
    mov ax, 40h
    mov ds, ax
    mov word [ds:0x72], 0x1234
    jmp 0xFFFF:0000
    
    putc:			; wyświatla znak
    mov ah,9			; al=znak bl=kolor
    mov bh,0
    mov cx,1
    int 0x10
    
    mov ah,3			; odczytuje pozycje kursora
    int 0x10
    
    dec ah			; zwiększam pozycje o 1
    inc dl
    int 0x10
    
    ret
    
    puts:			; wyświetla ciąg znaków
    mov si,ax
    mov al,[cs:si]
    test al,al
    jz puts.end
    call putc
    inc si
    jmp puts
    puts.end:
    ret
    
; ========================DANE=======================
napis:	db	"System 1 Core ALPHA v 0.0.0.1",0