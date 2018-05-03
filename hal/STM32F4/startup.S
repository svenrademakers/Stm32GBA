    .syntax unified
    .cpu cortex-m4
    .fpu softvfp
    .thumb
    
	.global	Reset_Handler
	.global isr_vector

@ use real isr as dummy before switching isr to ram via ..
   .section .isr_vector,"a",%progbits
	  .word   _estack
	  b Reset_Handler
	  b NMI_Handler
	  b HardFault_Handler
	  b	MemManage_Handler
	  b	BusFault_Handler
	  b	UsageFault_Handler
	  b	0
	  b	0
	  b	0
	  b	0
	  b	SVC_Handler
	  b	DebugMon_Handler
	  b	0
	  b	PendSV_Handler
	  b	SysTick_Handler
	  b	WWDG_IRQHandler              			/* Window Watchdog interrupt                                          */
	  b	PVD_IRQHandler               			/* PVD through EXTI line detection interrupt                          */
	  b	TAMP_STAMP_IRQHandler        			/* Tamper and TimeStamp interrupts through the EXTI line              */
	  b	RTC_WKUP_IRQHandler          			/* RTC Wakeup interrupt through the EXTI line                         */
	  b	FLASH_IRQHandler             			/* Flash global interrupt                                             */
	  b	RCC_IRQHandler               			/* RCC global interrupt                                               */
	  b	EXTI0_IRQHandler             			/* EXTI Line0 interrupt                                               */
	  b	EXTI1_IRQHandler             			/* EXTI Line1 interrupt                                               */
	  b	EXTI2_IRQHandler             			/* EXTI Line2 interrupt                                               */
	  b	EXTI3_IRQHandler             			/* EXTI Line3 interrupt                                               */
	  b	EXTI4_IRQHandler             			/* EXTI Line4 interrupt                                               */
	  b	DMA1_Stream0_IRQHandler      			/* DMA1 Stream0 global interrupt                                      */
	  b	DMA1_Stream1_IRQHandler      			/* DMA1 Stream1 global interrupt                                      */
	  b	DMA1_Stream2_IRQHandler      			/* DMA1 Stream2 global interrupt                                      */
	  b	DMA1_Stream3_IRQHandler      			/* DMA1 Stream3 global interrupt                                      */
	  b	DMA1_Stream4_IRQHandler      			/* DMA1 Stream4 global interrupt                                      */
	  b	DMA1_Stream5_IRQHandler      			/* DMA1 Stream5 global interrupt                                      */
	  b	DMA1_Stream6_IRQHandler      			/* DMA1 Stream6 global interrupt                                      */
	  b	ADC_IRQHandler               			/* ADC3 global interrupts                                             */
	  b	CAN1_TX_IRQHandler           			/* CAN1 TX interrupts                                                 */
	  b	CAN1_RX0_IRQHandler          			/* CAN1 RX0 interrupts                                                */
	  b	CAN1_RX1_IRQHandler          			/* CAN1 RX1 interrupts                                                */
	  b	CAN1_SCE_IRQHandler          			/* CAN1 SCE interrupt                                                 */
	  b	EXTI9_5_IRQHandler           			/* EXTI Line[9:5] interrupts                                          */
	  b	TIM1_BRK_TIM9_IRQHandler     			/* TIM1 Break interrupt and TIM9 global interrupt                     */
	  b	TIM1_UP_TIM10_IRQHandler     			/* TIM1 Update interrupt and TIM10 global interrupt                   */
	  b	TIM1_TRG_COM_TIM11_IRQHandler			/* TIM1 Trigger and Commutation interrupts and TIM11 global interrupt */
	  b	TIM1_CC_IRQHandler           			/* TIM1 Capture Compare interrupt                                     */
	  b	TIM2_IRQHandler              			/* TIM2 global interrupt                                              */
	  b	TIM3_IRQHandler              			/* TIM3 global interrupt                                              */
	  b	TIM4_IRQHandler              			/* TIM4 global interrupt                                              */
	  b	I2C1_EV_IRQHandler           			/* I2C1 event interrupt                                               */
	  b	I2C1_ER_IRQHandler           			/* I2C1 error interrupt                                               */
	  b	I2C2_EV_IRQHandler           			/* I2C2 event interrupt                                               */
	  b	I2C2_ER_IRQHandler           			/* I2C2 error interrupt                                               */
	  b	SPI1_IRQHandler              			/* SPI1 global interrupt                                              */
	  b	SPI2_IRQHandler              			/* SPI2 global interrupt                                              */
	  b	USART1_IRQHandler            			/* USART1 global interrupt                                            */
	  b	USART2_IRQHandler            			/* USART2 global interrupt                                            */
	  b	USART3_IRQHandler            			/* USART3 global interrupt                                            */
	  b	EXTI15_10_IRQHandler         			/* EXTI Line[15:10] interrupts                                        */
	  b	RTC_Alarm_IRQHandler         			/* RTC Alarms (A and B) through EXTI line interrupt                   */
	  b	OTG_FS_WKUP_IRQHandler       			/* USB On-The-Go FS Wakeup through EXTI line interrupt                */
	  b	TIM8_BRK_TIM12_IRQHandler    			/* TIM8 Break interrupt and TIM12 global interrupt                    */
	  b	TIM8_UP_TIM13_IRQHandler     			/* TIM8 Update interrupt and TIM13 global interrupt                   */
	  b	TIM8_TRG_COM_TIM14_IRQHandler			/* TIM8 Trigger and Commutation interrupts and TIM14 global interrupt */
	  b	TIM8_CC_IRQHandler           			/* TIM8 Capture Compare interrupt                                     */
	  b	DMA1_Stream7_IRQHandler      			/* DMA1 Stream7 global interrupt                                      */
	  b	FMC_IRQHandler               			/* FMC global interrupt                                               */
	  b	SDIO_IRQHandler              			/* SDIO global interrupt                                              */
	  b	TIM5_IRQHandler              			/* TIM5 global interrupt                                              */
	  b	SPI3_IRQHandler              			/* SPI3 global interrupt                                              */
	  b	UART4_IRQHandler             			/* UART4 global interrupt                                             */
	  b	UART5_IRQHandler             			/* UART5 global interrupt                                             */
	  b	TIM6_DAC_IRQHandler          			/* TIM6 global interrupt, DAC1 and DAC2 underrun error interrupt      */
	  b	TIM7_IRQHandler              			/* TIM7 global interrupt                                              */
	  b	DMA2_Stream0_IRQHandler      			/* DMA2 Stream0 global interrupt                                      */
	  b	DMA2_Stream1_IRQHandler      			/* DMA2 Stream1 global interrupt                                      */
	  b	DMA2_Stream2_IRQHandler      			/* DMA2 Stream2 global interrupt                                      */
	  b	DMA2_Stream3_IRQHandler      			/* DMA2 Stream3 global interrupt                                      */
	  b	DMA2_Stream4_IRQHandler      			/* DMA2 Stream4 global interrupt                                      */
	  b	ETH_IRQHandler               			/* Ethernet global interrupt                                          */
	  b	ETH_WKUP_IRQHandler          			/* Ethernet Wakeup through EXTI line interrupt                        */
	  b	CAN2_TX_IRQHandler           			/* CAN2 TX interrupts                                                 */
	  b	CAN2_RX0_IRQHandler          			/* CAN2 RX0 interrupts                                                */
	  b	CAN2_RX1_IRQHandler          			/* CAN2 RX1 interrupts                                                */
	  b	CAN2_SCE_IRQHandler          			/* CAN2 SCE interrupt                                                 */
	  b	OTG_FS_IRQHandler            			/* USB On The Go FS global interrupt                                  */
	  b	DMA2_Stream5_IRQHandler      			/* DMA2 Stream5 global interrupt                                      */
	  b	DMA2_Stream6_IRQHandler      			/* DMA2 Stream6 global interrupt                                      */
	  b	DMA2_Stream7_IRQHandler      			/* DMA2 Stream7 global interrupt                                      */
	  b	USART6_IRQHandler            			/* USART6 global interrupt                                            */
	  b	I2C3_EV_IRQHandler           			/* I2C3 event interrupt                                               */
	  b	I2C3_ER_IRQHandler           			/* I2C3 error interrupt                                               */
	  b	OTG_HS_EP1_OUT_IRQHandler    			/* USB On The Go HS End Point 1 Out global interrupt                  */
	  b	OTG_HS_EP1_IN_IRQHandler     			/* USB On The Go HS End Point 1 In global interrupt                   */
	  b	OTG_HS_WKUP_IRQHandler       			/* USB On The Go HS Wakeup through EXTI interrupt                     */
	  b	OTG_HS_IRQHandler            			/* USB On The Go HS global interrupt                                  */
	  b	DCMI_IRQHandler              			/* DCMI global interrupt                                              */
	  b	CRYP_IRQHandler              			/* CRYP crypto global interrupt                                       */
	  b	HASH_RNG_IRQHandler          			/* Hash and Rng global interrupt                                      */
	  b	FPU_IRQHandler               			/* Floating point interrupt                                           */
	  b	UART7_IRQHandler             			/* UART 7 global interrupt                                            */
	  b	UART8_IRQHandler             			/* UART 8 global interrupt                                            */
	  b	SPI4_IRQHandler              			/* SPI 4 global interrupt                                             */
	  b	SPI5_IRQHandler              			/* SPI 5 global interrupt                                             */
	  b	SPI6_IRQHandler              			/* SPI 6 global interrupt                                             */
	  b	SAI1_IRQHandler              			/* SAI1 global interrupt                                              */
	  b	LCD_TFT_IRQHandler           			/* LTDC global interrupt                                              */
	  b	LCD_TFT_1_IRQHandler         			/* LTDC global error interrupt                                        */
	  b	DMA2D_IRQHandler             			/* DMA2D global interrupt                                             */
	  b	QUADSPI_IRQHandler           			/* QuadSPI global interrupt                                           */

	/*******************************************************************************
	*
	* Provide weak aliases for each Exception handler to the Default_Handler.
	* As they are weak aliases, any function with the same name will override
	* this definition.
	*
	*******************************************************************************/

	  	.weak	NMI_Handler
		.thumb_set NMI_Handler,Default_Handler

	  	.weak	HardFault_Handler
		.thumb_set HardFault_Handler,Default_Handler

	  	.weak	MemManage_Handler
		.thumb_set MemManage_Handler,Default_Handler

	  	.weak	BusFault_Handler
		.thumb_set BusFault_Handler,Default_Handler

		.weak	UsageFault_Handler
		.thumb_set UsageFault_Handler,Default_Handler

		.weak	SVC_Handler
		.thumb_set SVC_Handler,Default_Handler

		.weak	DebugMon_Handler
		.thumb_set DebugMon_Handler,Default_Handler

		.weak	PendSV_Handler
		.thumb_set PendSV_Handler,Default_Handler

		.weak	SysTick_Handler
		.thumb_set SysTick_Handler,Default_Handler

		.weak	WWDG_IRQHandler
		.thumb_set WWDG_IRQHandler,Default_Handler

		.weak	PVD_IRQHandler
		.thumb_set PVD_IRQHandler,Default_Handler

		.weak	TAMP_STAMP_IRQHandler
		.thumb_set TAMP_STAMP_IRQHandler,Default_Handler

		.weak	RTC_WKUP_IRQHandler
		.thumb_set RTC_WKUP_IRQHandler,Default_Handler

		.weak	FLASH_IRQHandler
		.thumb_set FLASH_IRQHandler,Default_Handler

		.weak	RCC_IRQHandler
		.thumb_set RCC_IRQHandler,Default_Handler

		.weak	EXTI0_IRQHandler
		.thumb_set EXTI0_IRQHandler,Default_Handler

		.weak	EXTI1_IRQHandler
		.thumb_set EXTI1_IRQHandler,Default_Handler

		.weak	EXTI2_IRQHandler
		.thumb_set EXTI2_IRQHandler,Default_Handler

		.weak	EXTI3_IRQHandler
		.thumb_set EXTI3_IRQHandler,Default_Handler

		.weak	EXTI4_IRQHandler
		.thumb_set EXTI4_IRQHandler,Default_Handler

		.weak	DMA1_Stream0_IRQHandler
		.thumb_set DMA1_Stream0_IRQHandler,Default_Handler

		.weak	DMA1_Stream1_IRQHandler
		.thumb_set DMA1_Stream1_IRQHandler,Default_Handler

		.weak	DMA1_Stream2_IRQHandler
		.thumb_set DMA1_Stream2_IRQHandler,Default_Handler

		.weak	DMA1_Stream3_IRQHandler
		.thumb_set DMA1_Stream3_IRQHandler,Default_Handler

		.weak	DMA1_Stream4_IRQHandler
		.thumb_set DMA1_Stream4_IRQHandler,Default_Handler

		.weak	DMA1_Stream5_IRQHandler
		.thumb_set DMA1_Stream5_IRQHandler,Default_Handler

		.weak	DMA1_Stream6_IRQHandler
		.thumb_set DMA1_Stream6_IRQHandler,Default_Handler

		.weak	ADC_IRQHandler
		.thumb_set ADC_IRQHandler,Default_Handler

		.weak	CAN1_TX_IRQHandler
		.thumb_set CAN1_TX_IRQHandler,Default_Handler

		.weak	CAN1_RX0_IRQHandler
		.thumb_set CAN1_RX0_IRQHandler,Default_Handler

		.weak	CAN1_RX1_IRQHandler
		.thumb_set CAN1_RX1_IRQHandler,Default_Handler

		.weak	CAN1_SCE_IRQHandler
		.thumb_set CAN1_SCE_IRQHandler,Default_Handler

		.weak	EXTI9_5_IRQHandler
		.thumb_set EXTI9_5_IRQHandler,Default_Handler

		.weak	TIM1_BRK_TIM9_IRQHandler
		.thumb_set TIM1_BRK_TIM9_IRQHandler,Default_Handler

		.weak	TIM1_UP_TIM10_IRQHandler
		.thumb_set TIM1_UP_TIM10_IRQHandler,Default_Handler

		.weak	TIM1_TRG_COM_TIM11_IRQHandler
		.thumb_set TIM1_TRG_COM_TIM11_IRQHandler,Default_Handler

		.weak	TIM1_CC_IRQHandler
		.thumb_set TIM1_CC_IRQHandler,Default_Handler

		.weak	TIM2_IRQHandler
		.thumb_set TIM2_IRQHandler,Default_Handler

		.weak	TIM3_IRQHandler
		.thumb_set TIM3_IRQHandler,Default_Handler

		.weak	TIM4_IRQHandler
		.thumb_set TIM4_IRQHandler,Default_Handler

		.weak	I2C1_EV_IRQHandler
		.thumb_set I2C1_EV_IRQHandler,Default_Handler

		.weak	I2C1_ER_IRQHandler
		.thumb_set I2C1_ER_IRQHandler,Default_Handler

		.weak	I2C2_EV_IRQHandler
		.thumb_set I2C2_EV_IRQHandler,Default_Handler

		.weak	I2C2_ER_IRQHandler
		.thumb_set I2C2_ER_IRQHandler,Default_Handler

		.weak	SPI1_IRQHandler
		.thumb_set SPI1_IRQHandler,Default_Handler

		.weak	SPI2_IRQHandler
		.thumb_set SPI2_IRQHandler,Default_Handler

		.weak	USART1_IRQHandler
		.thumb_set USART1_IRQHandler,Default_Handler

		.weak	USART2_IRQHandler
		.thumb_set USART2_IRQHandler,Default_Handler

		.weak	USART3_IRQHandler
		.thumb_set USART3_IRQHandler,Default_Handler

		.weak	EXTI15_10_IRQHandler
		.thumb_set EXTI15_10_IRQHandler,Default_Handler

		.weak	RTC_Alarm_IRQHandler
		.thumb_set RTC_Alarm_IRQHandler,Default_Handler

		.weak	OTG_FS_WKUP_IRQHandler
		.thumb_set OTG_FS_WKUP_IRQHandler,Default_Handler

		.weak	TIM8_BRK_TIM12_IRQHandler
		.thumb_set TIM8_BRK_TIM12_IRQHandler,Default_Handler

		.weak	TIM8_UP_TIM13_IRQHandler
		.thumb_set TIM8_UP_TIM13_IRQHandler,Default_Handler

		.weak	TIM8_TRG_COM_TIM14_IRQHandler
		.thumb_set TIM8_TRG_COM_TIM14_IRQHandler,Default_Handler

		.weak	TIM8_CC_IRQHandler
		.thumb_set TIM8_CC_IRQHandler,Default_Handler

		.weak	DMA1_Stream7_IRQHandler
		.thumb_set DMA1_Stream7_IRQHandler,Default_Handler

		.weak	FMC_IRQHandler
		.thumb_set FMC_IRQHandler,Default_Handler

		.weak	SDIO_IRQHandler
		.thumb_set SDIO_IRQHandler,Default_Handler

		.weak	TIM5_IRQHandler
		.thumb_set TIM5_IRQHandler,Default_Handler

		.weak	SPI3_IRQHandler
		.thumb_set SPI3_IRQHandler,Default_Handler

		.weak	UART4_IRQHandler
		.thumb_set UART4_IRQHandler,Default_Handler

		.weak	UART5_IRQHandler
		.thumb_set UART5_IRQHandler,Default_Handler

		.weak	TIM6_DAC_IRQHandler
		.thumb_set TIM6_DAC_IRQHandler,Default_Handler

		.weak	TIM7_IRQHandler
		.thumb_set TIM7_IRQHandler,Default_Handler

		.weak	DMA2_Stream0_IRQHandler
		.thumb_set DMA2_Stream0_IRQHandler,Default_Handler

		.weak	DMA2_Stream1_IRQHandler
		.thumb_set DMA2_Stream1_IRQHandler,Default_Handler

		.weak	DMA2_Stream2_IRQHandler
		.thumb_set DMA2_Stream2_IRQHandler,Default_Handler

		.weak	DMA2_Stream3_IRQHandler
		.thumb_set DMA2_Stream3_IRQHandler,Default_Handler

		.weak	DMA2_Stream4_IRQHandler
		.thumb_set DMA2_Stream4_IRQHandler,Default_Handler

		.weak	ETH_IRQHandler
		.thumb_set ETH_IRQHandler,Default_Handler

		.weak	ETH_WKUP_IRQHandler
		.thumb_set ETH_WKUP_IRQHandler,Default_Handler

		.weak	CAN2_TX_IRQHandler
		.thumb_set CAN2_TX_IRQHandler,Default_Handler

		.weak	CAN2_RX0_IRQHandler
		.thumb_set CAN2_RX0_IRQHandler,Default_Handler

		.weak	CAN2_RX1_IRQHandler
		.thumb_set CAN2_RX1_IRQHandler,Default_Handler

		.weak	CAN2_SCE_IRQHandler
		.thumb_set CAN2_SCE_IRQHandler,Default_Handler

		.weak	OTG_FS_IRQHandler
		.thumb_set OTG_FS_IRQHandler,Default_Handler

		.weak	DMA2_Stream5_IRQHandler
		.thumb_set DMA2_Stream5_IRQHandler,Default_Handler

		.weak	DMA2_Stream6_IRQHandler
		.thumb_set DMA2_Stream6_IRQHandler,Default_Handler

		.weak	DMA2_Stream7_IRQHandler
		.thumb_set DMA2_Stream7_IRQHandler,Default_Handler

		.weak	USART6_IRQHandler
		.thumb_set USART6_IRQHandler,Default_Handler

		.weak	I2C3_EV_IRQHandler
		.thumb_set I2C3_EV_IRQHandler,Default_Handler

		.weak	I2C3_ER_IRQHandler
		.thumb_set I2C3_ER_IRQHandler,Default_Handler

		.weak	OTG_HS_EP1_OUT_IRQHandler
		.thumb_set OTG_HS_EP1_OUT_IRQHandler,Default_Handler

		.weak	OTG_HS_EP1_IN_IRQHandler
		.thumb_set OTG_HS_EP1_IN_IRQHandler,Default_Handler

		.weak	OTG_HS_WKUP_IRQHandler
		.thumb_set OTG_HS_WKUP_IRQHandler,Default_Handler

		.weak	OTG_HS_IRQHandler
		.thumb_set OTG_HS_IRQHandler,Default_Handler

		.weak	DCMI_IRQHandler
		.thumb_set DCMI_IRQHandler,Default_Handler

		.weak	CRYP_IRQHandler
		.thumb_set CRYP_IRQHandler,Default_Handler

		.weak	HASH_RNG_IRQHandler
		.thumb_set HASH_RNG_IRQHandler,Default_Handler

		.weak	FPU_IRQHandler
		.thumb_set FPU_IRQHandler,Default_Handler

		.weak	UART7_IRQHandler
		.thumb_set UART7_IRQHandler,Default_Handler

		.weak	UART8_IRQHandler
		.thumb_set UART8_IRQHandler,Default_Handler

		.weak	SPI4_IRQHandler
		.thumb_set SPI4_IRQHandler,Default_Handler

		.weak	SPI5_IRQHandler
		.thumb_set SPI5_IRQHandler,Default_Handler

		.weak	SPI6_IRQHandler
		.thumb_set SPI6_IRQHandler,Default_Handler

		.weak	SAI1_IRQHandler
		.thumb_set SAI1_IRQHandler,Default_Handler

		.weak	LCD_TFT_IRQHandler
		.thumb_set LCD_TFT_IRQHandler,Default_Handler

		.weak	LCD_TFT_1_IRQHandler
		.thumb_set LCD_TFT_1_IRQHandler,Default_Handler

		.weak	DMA2D_IRQHandler
		.thumb_set DMA2D_IRQHandler,Default_Handler

		.weak	QUADSPI_IRQHandler
		.thumb_set QUADSPI_IRQHandler,Default_Handler
        
        .text
		Default_Handler:
		b .
        
        Reset_Handler:
@       @ make sure flash is mapped to 0
@       .equ    SYSCFG, 0x40013800
@       mov     r0, #0
@       ldr     r1, =SYSCFG
@       str     r0, [r1]
        
        @copy data to ram
        ldr     r0, =_sdata
        ldr     r1, =_edata
        ldr     r2, =_ramstart
1:      ittt    ne
        cmpne   r0, r1
        ldmne   r0!, {r3}
        stmne   r2!, {r3}
        bne     1b

        bl      low_level_init

        
@       @ use ram vector table
@       .equ    VTOR, 0xE000ED08
@       mov     r0, #0x20000000
@       ldr     r1, =VTOR
@       str     r0, [r1]

        @ clear bss
        ldr     r0, =_sbss
        ldr     r1, =_ebss
        mov     r2, #0
1:      itt     ne
        cmpne   r0, r1
        stmne   r0!, {r2}
        bne     1b

        .equ stack_watermark, 0xDEADBEEF
        ldr     r0, =_sstack
        ldr     r1, =_estack
        ldr     r2, =stack_watermark
1:      itt     ne
        cmpne   r0, r1
        stmne   r0!, {r2}
        bne     1b

        @ going to main 
        b       main
        b       .
        
@        .section .ramvector,"ax",%progbits
@        b       _reset_handler
@        b       _NMI_handler
@        b       _hard_fault_handler
@        b       _memory_management_fault_handler
@        b       _bus_fault_handler
@        b       _usage_fault_handler
