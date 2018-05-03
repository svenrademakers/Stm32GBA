add_library(STM32F4_platform
	${CMAKE_CURRENT_LIST_DIR}/startup.S
	${CMAKE_CURRENT_LIST_DIR}/stm32f4.ld
	${CMAKE_CURRENT_LIST_DIR}/isr_vector.c
	${CMAKE_CURRENT_LIST_DIR}/low_level_init.c)
