[org 0x7c00]
[bits 16]
    
    cli
    cld
    mov ax,0x1000		;stos
    mov ss,ax
    xor esp,esp
    
    xor ah,ah
    mov al,0x3
    int 0x10
    
    mov ax,0x020a
    mov cx,2
    xor dx,dx
    mov bx,0x1000
    mov es,bx
    xor bx,bx
    int 0x13
    
    unlock_a20:
    ;fast a20 unlock
    ;in al,0x92
    ;test al,2
    ;jnz unlock_a20.end
    ;or al,2
    ;out 0x92,al
    unlock_a20.end:

    
    lgdt [gdt.descr]	; ładujemy GDT
    
    mov eax,cr0		; Tryb Chroniony - osiągnięto 04.08.08-00:27 CEST
    or eax,1
    mov cr0,eax
    
    mov ax,0x10		; Ustawiam segmenty korzystając z GDT
    mov ss,ax
    mov ds,ax
    mov es,ax
    mov fs,ax
    mov gs,ax
    
    jmp 0x08:start32
    
    gdt:
    
    dd	0,0		; NULL Descriptor
    
    dw	0xffff		; systemowy, kod, baza=0, limit=4G, DPL=0
    dw	0
    db	0
    db	10011010b
    db	11001111b
    db	0
    
    dw	0xffff		; systemowy, dane, baza=0, limit=4G, DPL=0
    dw	0
    db	0
    db	10010010b
    db	11001111b
    db	0
    gdt.end:
    
    gdt.descr:
    dw	gdt.end-gdt-1	; rozmiar gdt
    dd	gdt
    
    [bits 32]
    start32:
    
    jmp 0x08:0x10000
    
    times 510-($-$$) db 0
    dw 0xaa55