.syntax unified 
.cpu cortex-m4
.fpu softvfp
.thumb
 
.global _start

_start:
    nop         @ initial sp
	B _reset	@ reset
	B .			@ NMI
	B .			@ Hard fault
	B .			@ Memory management fault
	B .			@ Bus fault
	B .			@ Usage fault

_reset:
    B main
    B . 

.section    .ramcode,"ax",%progbits
    B _reset_handler
    B _NMI_handler
    B _hard_fault_handler
    B _memory_management_fault_handler
    B _bus_fault_handler
    B _usage_fault_handler