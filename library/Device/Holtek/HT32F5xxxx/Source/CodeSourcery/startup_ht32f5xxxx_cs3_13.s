/*---------------------------------------------------------------------------------------------------------*/
/* Holtek Semiconductor Inc.                                                                               */
/*                                                                                                         */
/* Copyright (C) Holtek Semiconductor Inc.                                                                 */
/* All rights reserved.                                                                                    */
/*                                                                                                         */
/*-----------------------------------------------------------------------------------------------------------
;  File Name        : startup_ht32f5xxxx_cs3_13.s
;  Version          : $Rev:: 7704         $
;  Date             : $Date:: 2024-05-10 #$
;  Description      : Startup code.
;-----------------------------------------------------------------------------------------------------------*/

/*
;  Supported Device
;  ========================================
;   HT32F50020, HT32F50030
;   HT32F61630
;   HT32F61030
;   HT32F61730
*/

;/* <<< Use Configuration Wizard in Context Menu >>>                                                        */
/*
;// <o>  HT32 Device
;//      <0=> By Project Asm Define
;//      <25=> HT32F50020/30
;//      <25=> HT32F61630
;//      <25=> HT32F61030
;//      <25=> HT32F61730
*/
    .equ    USE_HT32_CHIP_SET, 0

    .equ _HT32FWID, 0xFFFFFFFF
/*
    .equ _HT32FWID, 0x00050020
    .equ _HT32FWID, 0x00050030
    .equ _HT32FWID, 0x00061630
    .equ _HT32FWID, 0x00061030
    .equ _HT32FWID, 0x00061730
*/

    .equ HT32F50020_30, 25
    .equ HT32F61630, 25
    .equ HT32F61030, 25
    .equ HT32F61730, 25

  .if USE_HT32_CHIP_SET == 0
  .else
    .equ USE_HT32_CHIP, USE_HT32_CHIP_SET
  .endif

/*
; Amount of memory (in bytes) allocated for Stack and Heap
; Tailor those values to your application needs
;//   <o> Stack Size (in Bytes, must 8 byte aligned) <:8>
*/
    .equ    Stack_Size, 512
    .section ".stack", "w"
    .align  3
    .globl  __cs3_stack_mem
    .globl  __cs3_stack
    .globl  __cs3_stack_size
    .globl  __HT_check_sp
__HT_check_sp:
__cs3_stack_mem:
    .if     Stack_Size
    .space  Stack_Size
    .endif
__cs3_stack:
    .size   __cs3_stack_mem,  . - __cs3_stack_mem
    .set    __cs3_stack_size, . - __cs3_stack_mem

/*
;//   <o>  Heap Size (in Bytes) <:8>
*/
    .equ    Heap_Size, 0
    .section ".heap", "w"
    .align  3
    .globl  __cs3_heap_start
    .globl  __cs3_heap_end
    .globl  __HT_check_heap
__HT_check_heap:
__cs3_heap_start:
    .if     Heap_Size
    .space  Heap_Size
    .endif
__cs3_heap_end:

    .equ    _RESERVED, 0xFFFFFFFF
/*
;*******************************************************************************
; Fill-up the Vector Table entries with the exceptions ISR address
;********************************************************************************/
                    .section ".cs3.interrupt_vector"
                    .globl  __cs3_interrupt_vector_cortex_m
                    .type   __cs3_interrupt_vector_cortex_m, %object
__cs3_interrupt_vector_cortex_m:
                    .long  __cs3_stack                        /* ---, 00, 0x000, Top address of Stack       */
                    .long  __cs3_reset                        /* ---, 01, 0x004, Reset Handler              */
                    .long  NMI_Handler                        /* -14, 02, 0x008, NMI Handler                */
                    .long  HardFault_Handler                  /* -13, 03, 0x00C, Hard Fault Handler         */
                    .long  _RESERVED                          /* ---, 04, 0x010, Reserved                   */
                    .long  _RESERVED                          /* ---, 05, 0x014, Reserved                   */
                    .long  _RESERVED                          /* ---, 06, 0x018, Reserved                   */
                    .long  _RESERVED                          /* ---, 07, 0x01C, Reserved                   */
                    .long  _HT32FWID                          /* ---, 08, 0x020, Reserved                   */
                    .long  _RESERVED                          /* ---, 09, 0x024, Reserved                   */
                    .long  _RESERVED                          /* ---, 10, 0x028, Reserved                   */
                    .long  SVC_Handler                        /* -05, 11, 0x02C, SVC Handler                */
                    .long  _RESERVED                          /* ---, 12, 0x030, Reserved                   */
                    .long  _RESERVED                          /* ---, 13, 0x034, Reserved                   */
                    .long  PendSV_Handler                     /* -02, 14, 0x038, PendSV Handler             */
                    .long  SysTick_Handler                    /* -01, 15, 0x03C, SysTick Handler            */

                    /* External Interrupt Handler                                                           */
                    .long  LVD_BOD_IRQHandler                 /*  00, 16, 0x040,                            */
                    .long  RTC_IRQHandler                     /*  01, 17, 0x044,                            */
                    .long  FLASH_IRQHandler                   /*  02, 18, 0x048,                            */
                    .long  EVWUP_IRQHandler                   /*  03, 19, 0x04C,                            */
                    .long  EXTI0_1_IRQHandler                 /*  04, 20, 0x050,                            */
                    .long  EXTI2_3_IRQHandler                 /*  05, 21, 0x054,                            */
                    .long  EXTI4_7_IRQHandler                 /*  06, 22, 0x058,                            */
                    .long  _RESERVED                          /*  07, 23, 0x05C,                            */
                    .long  ADC_IRQHandler                     /*  08, 24, 0x060,                            */
                    .long  _RESERVED                          /*  09, 25, 0x064,                            */
                    .long  _RESERVED                          /*  10, 26, 0x068,                            */
                    .long  _RESERVED                          /*  11, 27, 0x06C,                            */
                    .long  _RESERVED                          /*  12, 28, 0x070,                            */
                    .long  SCTM0_IRQHandler                   /*  13, 29, 0x074,                            */
                    .long  SCTM1_IRQHandler                   /*  14, 30, 0x078,                            */
                    .long  SCTM2_IRQHandler                   /*  15, 31, 0x07C,                            */
                    .long  _RESERVED                          /*  16, 32, 0x080,                            */
                    .long  BFTM0_IRQHandler                   /*  17, 33, 0x084,                            */
                    .long  _RESERVED                          /*  18, 34, 0x088,                            */
                    .long  I2C0_IRQHandler                    /*  19, 35, 0x08C,                            */
                    .long  _RESERVED                          /*  20, 36, 0x090,                            */
                    .long  SPI0_IRQHandler                    /*  21, 37, 0x094,                            */
                    .long  _RESERVED                          /*  22, 38, 0x098,                            */
                    .long  _RESERVED                          /*  23, 39, 0x09C,                            */
                    .long  _RESERVED                          /*  24, 40, 0x0A0,                            */
                    .long  UART0_IRQHandler                   /*  25, 41, 0x0A4,                            */
                    .long  UART1_IRQHandler                   /*  26, 42, 0x0A8,                            */
                    .long  _RESERVED                          /*  27, 43, 0x0AC,                            */
                    .long  _RESERVED                          /*  28, 44, 0x0B0,                            */
                    .long  LEDC_IRQHandler                    /*  29, 45, 0x0B4,                            */

    .size   __cs3_interrupt_vector_cortex_m, . - __cs3_interrupt_vector_cortex_m


    .thumb


/* Reset Handler */

    .section .cs3.reset,"x",%progbits
    .thumb_func
    .globl  __cs3_reset_cortex_m
    .type   __cs3_reset_cortex_m, %function
__cs3_reset_cortex_m:
    .fnstart
                    LDR     R0, =SystemInit
                    BLX     R0
                    LDR     R0, =_start
                    BX      R0
    .thumb_func
    .pool
    .cantunwind
    .fnend
    .size   __cs3_reset_cortex_m,.-__cs3_reset_cortex_m

    .section ".text"

/* Exception Handlers */

    .weak   NMI_Handler
    .type   NMI_Handler, %function
NMI_Handler:
                    B       .
    .size   NMI_Handler, . - NMI_Handler

    .weak   HardFault_Handler
    .type   HardFault_Handler, %function
HardFault_Handler:
                    B       .
    .size   HardFault_Handler, . - HardFault_Handler

    .weak   SVC_Handler
    .type   SVC_Handler, %function
SVC_Handler:
                    B       .
    .size   SVC_Handler, . - SVC_Handler

    .weak   PendSV_Handler
    .type   PendSV_Handler, %function
PendSV_Handler:
                    B       .
    .size   PendSV_Handler, . - PendSV_Handler

    .weak   SysTick_Handler
    .type   SysTick_Handler, %function
SysTick_Handler:
                    B       .
    .size   SysTick_Handler, . - SysTick_Handler


/* IRQ Handlers */

    .globl  Default_Handler
    .type   Default_Handler, %function
Default_Handler:
                    B       .
    .size   Default_Handler, . - Default_Handler

    .macro  IRQ handler
    .weak   \handler
    .set    \handler, Default_Handler
    .endm

    IRQ     LVD_BOD_IRQHandler
    IRQ     RTC_IRQHandler
    IRQ     FLASH_IRQHandler
    IRQ     EVWUP_IRQHandler
    IRQ     EXTI0_1_IRQHandler
    IRQ     EXTI2_3_IRQHandler
    IRQ     EXTI4_7_IRQHandler
    IRQ     ADC_IRQHandler
    IRQ     SCTM0_IRQHandler
    IRQ     SCTM1_IRQHandler
    IRQ     SCTM2_IRQHandler
    IRQ     BFTM0_IRQHandler
    IRQ     I2C0_IRQHandler
    IRQ     SPI0_IRQHandler
    IRQ     UART0_IRQHandler
    IRQ     UART1_IRQHandler
    IRQ     LEDC_IRQHandler

    .end
