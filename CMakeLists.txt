cmake_minimum_required(VERSION 3.8.0)
project(bare_metal_pi C ASM)

#if (CMAKE_BUILD_TYPE matches "Debug")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Og")
#endif()

#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Ofast")

add_executable(${PROJECT_NAME}
	startup.S
	main.c
	main.ld
	isr_vector.c
	low_level_init.c)	
	
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T ${CMAKE_SOURCE_DIR}/main.ld")

#set_target_properties(${PROJECT_NAME} PROPERTIES LINK_DEPENDS main.ld)

add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND arm-none-eabi-objdump -D ./${PROJECT_NAME} > "${PROJECT_NAME}.asm"
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
    
add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND arm-none-eabi-objcopy ./${PROJECT_NAME} -S -O binary ./${PROJECT_NAME}.bin
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})