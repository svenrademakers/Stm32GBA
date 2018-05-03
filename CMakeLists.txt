cmake_minimum_required(VERSION 3.8.0)
project(Stm32GBA C ASM)

#if (CMAKE_BUILD_TYPE matches "Debug")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Og")

#endif()

#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Ofast")

add_subdirectory(hal)

add_executable(${PROJECT_NAME}
	main.c)
target_link_libraries(${PROJECT_NAME} STM32F4_platform)
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}.elf")

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T ${CMAKE_SOURCE_DIR}/hal/STM32F4/stm32f4.ld -nostartfiles")

add_custom_target("${PROJECT_NAME}_bin"
    ALL arm-none-eabi-objcopy ./${PROJECT_NAME}.elf -S -Obinary ./${PROJECT_NAME}.bin
    DEPENDS ${PROJECT_NAME}) 
	
add_custom_target("${PROJECT_NAME}_asm_dump"
    ALL arm-none-eabi-objdump -h -D ./${PROJECT_NAME}.elf > "${PROJECT_NAME}.asm"
    DEPENDS ${PROJECT_NAME})
 
add_custom_target("${PROJECT_NAME}_map"
   ALL arm-none-eabi-objdump -x ./${PROJECT_NAME}.elf > "${PROJECT_NAME}.map"
   DEPENDS ${PROJECT_NAME})
    
install(CODE "execute_process(COMMAND ST-LINK_CLI.exe -P ${PROJECT_NAME}.bin )")
