[bits 32]

    mov edi,0xb8000
    mov ah,7
    mov al,'X'
    stosw
    
    hlt