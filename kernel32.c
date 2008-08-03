void puts(unsigned char *wsk, unsigned char color)
{
    unsigned char *vga;
    vga=(unsigned char *)0xb8000;
    while(*wsk)
    {
	*vga=*wsk;
	vga[1]=color;
	++wsk;
	wsk+=2;
    }
}

void kernel_32(void)
{
    puts("System 1 Cora ALPHA v 0.0.1.0",7);
}