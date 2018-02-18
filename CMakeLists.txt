cmake_minimum_required(VERSION 3.8.0)
project(Stm32GBA C ASM)

#if (CMAKE_BUILD_TYPE matches "Debug")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Og")
#endif()

#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Ofast")

add_subdirectory(STM32F4)

add_executable(${PROJECT_NAME}
	main.c)
target_link_libraries(${PROJECT_NAME} STM32F4_platform)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T ${CMAKE_SOURCE_DIR}/STM32F4/main.ld")

add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND arm-none-eabi-objdump -D ./${PROJECT_NAME} > "${PROJECT_NAME}.asm"
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
    
add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND arm-none-eabi-objcopy ./${PROJECT_NAME} -S -O binary ./${PROJECT_NAME}.bin
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR})