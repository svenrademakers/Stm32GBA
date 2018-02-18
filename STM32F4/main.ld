ENTRY(_start)

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
  . = 0x00;
  .text :
  {
    *(.text) 
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
  } > flash

  .data :
  {
    _sdata = .;
    KEEP(*(.ramvector)); 
    *(.data)
    *(.data*)
    . = ALIGN(4);
    _edata = .;
  } > flash AT>ram

  .bss (NOLOAD) :
  {
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
