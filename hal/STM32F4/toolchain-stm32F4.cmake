include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR STM32F4)
CMAKE_FORCE_C_COMPILER("C:/Program Files (x86)/GNU Tools ARM Embedded/7 2017-q4-major/bin/arm-none-eabi-gcc.exe" GNU)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfpu=fpv4-sp-d16")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mcpu=cortex-m4")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfloat-abi=hard")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mtune=cortex-m4")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nostartfiles")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" )
set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" )
