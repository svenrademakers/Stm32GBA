include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR STM32F4)
set(CMAKE_COMP "C:/compilert/arm-none-eabi-gcc.exe" )
CMAKE_FORCE_C_COMPILER(${CMAKE_COMP} GNU)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfpu=fpv4-sp-d16")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mcpu=cortex-m4 -mthumb")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfloat-abi=hard")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mtune=cortex-m4")
#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -nostartfiles")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" )
set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" )
