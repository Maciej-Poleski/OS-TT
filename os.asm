use16
push 0xb800 ;segment ekranu
pop es
xor di,di
mov al,'a'
mov ah,9
stosw
hlt