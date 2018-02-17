ENTRY(_start)

MEMORY
{
    flash (rx) : ORIGIN = 0x08000000, LENGTH = 64K
    ram  (rwx) : ORIGIN = 0x20000000, LENGTH = 160K
}

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

  .ramvector : AT(ORIGIN(ram)) 
  { 
    KEEP(*(.ramcode)); 
    . = ALIGN(4);
  } > flash
  
  .data ORIGIN(ram) + SIZEOF (.ramvector):
  {
    *(.data)
    *(.data*)
    . = ALIGN(4);
  } > ram
  
  .bss : { *(.bss) }  > ram
}
