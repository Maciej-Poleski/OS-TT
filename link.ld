OUTPUT_FORMAT("binary")
ENTRY("kernel_32")
SECTIONS {
    .text 0x10000 : {
        code = . ; _code = . ;
        *(.text)
    }
    .data : {
        *(.data)
    }
    .bss : {
        bss = . ; _bss = . ;
        *(.bss)
        *(.COMMON)
    }
    end = . ; _end = . ;
}