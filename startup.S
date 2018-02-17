.syntax unified 
.cpu cortex-m4
.fpu softvfp
.thumb
 
.global _start

_start:
    nop         @ initial sp
    b _reset    @ reset
    b .         @ NMI
    b .         @ Hard fault
    b .         @ Memory management fault
    b .         @ Bus fault
    b .         @ Usage fault

_reset:
@ make sure flash is mapped to 0
.equ SYSCFG, 0x40013800
    mov     r0, #0x00000000
    ldr     r1, =SYSCFG
    str     r0, [r1]

    bl       low_level_init

@ use ram vector table
.equ VTOR, 0xE000ED08
    mov     r0, #0x20000000
    ldr     r1, =VTOR
    str     r0, [r1]

_cstartup:
    b main
    b .

.section    .ramcode,"ax",%progbits
    b   _reset_handler
    b   _NMI_handler
    b   _hard_fault_handler
    b   _memory_management_fault_handler
    b   _bus_fault_handler
    b   _usage_fault_handler