@echo off
if exist build ( 
	del /Q build
) else (
	mkdir build    
)

chdir build
cmake .. -DCMAKE_TOOLCHAIN_FILE=hal/STM32F4/toolchain-STM32F4.cmake -G"MinGW Makefiles"
pause