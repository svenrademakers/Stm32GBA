ENTRY(Reset_Handler)

MEMORY
{
    flash (rx) : ORIGIN = 0x00000000, LENGTH = 64K
    ccm  (rwx) : ORIGIN = 0x10000000, LENGTH = 64K
    ram  (rwx) : ORIGIN = 0x20000000, LENGTH = 160K
}

_stacksize = 0x10000;
_ramstart = ORIGIN(ram);

SECTIONS
{
  . = 0x0;
  
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector)) /* reset vector + dummy isr handlers */
    . = ALIGN(4);
  } >flash
  
  .text :
  {
	. = ALIGN(4);
    *(.text) 
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
  } > flash

  .data :
  {
	. = ALIGN(4);
    _sdata = .;
    *(.data)
    *(.data*)
    . = ALIGN(4);
    _edata = .;
  } >ram AT> flash

  .bss (NOLOAD) :
  {
	. = ALIGN(4);
    _sbss = .;
    *(.bss)
    . = ALIGN(4);
    _ebss = .;
  } > ram

  .stack (NOLOAD) :
  {
    _sstack = .;
    . += _stacksize;
    _estack = .;
  } > ram 
}
