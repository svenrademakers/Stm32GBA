        .syntax unified
        .cpu cortex-m4
        .fpu softvfp
        .thumb
        
        .global	_start
        
        _start:
        .long 0x0
        b       _reset    @ reset
        b       .         @ NMI
        b       .         @ Hard fault
        b       .         @ Memory management fault
        b       .         @ Bus fault
        b       .         @ Usage fault
        
        _reset:
        @ make sure flash is mapped to 0
        .equ    SYSCFG, 0x40013800
        mov     r0, #0
        ldr     r1, =SYSCFG
        str     r0, [r1]
        
        bl      low_level_init

        @copy data to ram
        ldr     r0, =_sdata
        ldr     r1, =_edata
        ldr     r2, =_ramstart
1:      ittt    ne
        cmpne   r0, r1
        ldmne   r0!, {r3}
        stmne   r2!, {r3}
        bne     1b
        
        @ use ram vector table
        .equ    VTOR, 0xE000ED08
        mov     r0, #0x20000000
        ldr     r1, =VTOR
        str     r0, [r1]

        @ clear bss
        ldr     r0, =_sbss
        ldr     r1, =_ebss
        mov     r2, #0
1:      itt     ne
        cmpne   r0, r1
        stmne   r0!, {r2}
        bne     1b

        .equ stack_watermark, 0xDEADBEEF
        ldr     r0, =_sstack
        ldr     r1, =_estack
        ldr     r2, =stack_watermark
1:      itt     ne
        cmpne   r0, r1
        stmne   r0!, {r2}
        bne     1b

        @ going to main 
        ldr     sp, =_estack
        b       main
        b       .
        
        .section .ramvector,"ax",%progbits
        b       _reset_handler
        b       _NMI_handler
        b       _hard_fault_handler
        b       _memory_management_fault_handler
        b       _bus_fault_handler
        b       _usage_fault_handler
