/*---------------------------------------------------------------------------------------------------------*/
/* Holtek Semiconductor Inc.                                                                               */
/*                                                                                                         */
/* Copyright (C) Holtek Semiconductor Inc.                                                                 */
/* All rights reserved.                                                                                    */
/*                                                                                                         */
/*-----------------------------------------------------------------------------------------------------------
;  File Name        : startup_ht32f5xxxx_es_03.s
;  Version          : $Rev:: 6887         $
;  Date             : $Date:: 2023-05-05 #$
;  Description      : Startup code.
;-----------------------------------------------------------------------------------------------------------*/

/*
;  Supported Device
;  ========================================
;   HT32F0008
;   HT32F52142
;   HT32F52344, HT32F52354
;   HT32F52357, HT32F52367
;   HT50F3200T
*/

;/* <<< Use Configuration Wizard in Context Menu >>>                                                        */
/*
;// <o>  HT32 Device
;//      <0=> By Project Asm Define
;//      <6=> HT32F0008
;//      <6=> HT32F52142
;//      <9=> HT32F52344/54
;//      <11=> HT32F52357/67
;//      <11=> HT50F3200T
*/
    .equ    USE_HT32_CHIP_SET, 0

    .equ _HT32FWID, 0xFFFFFFFF
/*
    .equ _HT32FWID, 0x00000008
    .equ _HT32FWID, 0x00052142
    .equ _HT32FWID, 0x00052344
    .equ _HT32FWID, 0x00052354
    .equ _HT32FWID, 0x00052357
    .equ _HT32FWID, 0x00052367
    .equ _HT32FWID, 0x0003200F
*/

    .equ HT32F0008,     6
    .equ HT32F52142,    6
    .equ HT32F52344_54, 9
    .equ HT32F52357_67, 11
    .equ HT50F3200T,    11

  .if USE_HT32_CHIP_SET == 0
  .else
    .equ USE_HT32_CHIP, USE_HT32_CHIP_SET
  .endif

    .equ    _RESERVED, 0xFFFFFFFF
/*
;*******************************************************************************
; Fill-up the Vector Table entries with the exceptions ISR address
;********************************************************************************/
                    .syntax unified
                    .global reset_handler
                    .global Reset_Handler
                    .equ Reset_Handler, reset_handler

                    .section  .vectors, "ax"
                    .section .vectors, "ax"
                    .code 16
                    .balign 2
                    .global _vectors
_vectors:
                    .long  __stack_end__                      /* ---, 00, 0x000, Top address of Stack       */
                    .long  reset_handler                      /* ---, 01, 0x004, Reset Handler              */
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
                    .long  EXTI4_15_IRQHandler                /*  06, 22, 0x058,                            */
                  .if (USE_HT32_CHIP==HT32F0008)
                    .long  _RESERVED                          /*  07, 23, 0x05C,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52344_54)
                    .long  COMP_IRQHandler                    /*  07, 23, 0x05C,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52357_67)
                    .long  COMP_DAC_IRQHandler                /*  07, 23, 0x05C,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F0008)
                    .long  _RESERVED                          /*  08, 24, 0x060,                            */
                  .else
                    .long  ADC_IRQHandler                     /*  08, 24, 0x060,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52357_67)
                    .long  AES_IRQHandler                     /*  09, 25, 0x064,                            */
                  .else
                    .long  _RESERVED                          /*  09, 25, 0x064,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F0008)
                    .long  _RESERVED                          /*  10, 26, 0x068,                            */
                  .else
                    .long  MCTM0_IRQHandler                   /*  10, 26, 0x068,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52357_67)
                    .long  QSPI_IRQHandler                    /*  11, 27, 0x06C,                            */
                  .else
                    .long  _RESERVED                          /*  11, 27, 0x06C,                            */
                  .endif
                    .long  GPTM0_IRQHandler                   /*  12, 28, 0x070,                            */
                  .if (USE_HT32_CHIP==HT32F0008)
                    .long  _RESERVED                          /*  13, 29, 0x074,                            */
                    .long  _RESERVED                          /*  14, 30, 0x078,                            */
                  .else
                    .long  SCTM0_IRQHandler                   /*  13, 29, 0x074,                            */
                    .long  SCTM1_IRQHandler                   /*  14, 30, 0x078,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F0008) || (USE_HT32_CHIP==HT32F52357_67)
                    .long  PWM0_IRQHandler                    /*  15, 31, 0x07C,                            */
                    .long  PWM1_IRQHandler                    /*  16, 32, 0x080,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52344_54)
                    .long  _RESERVED                          /*  15, 31, 0x07C,                            */
                    .long  _RESERVED                          /*  16, 32, 0x080,                            */
                  .endif
                    .long  BFTM0_IRQHandler                   /*  17, 33, 0x084,                            */
                    .long  BFTM1_IRQHandler                   /*  18, 34, 0x088,                            */
                    .long  I2C0_IRQHandler                    /*  19, 35, 0x08C,                            */
                  .if (USE_HT32_CHIP==HT32F0008) || (USE_HT32_CHIP==HT32F52344_54)
                    .long  _RESERVED                          /*  20, 36, 0x090,                            */
                  .else
                    .long  I2C1_IRQHandler                    /*  20, 36, 0x090,                            */
                  .endif
                    .long  SPI0_IRQHandler                    /*  21, 37, 0x094,                            */
                  .if (USE_HT32_CHIP==HT32F0008)
                    .long  _RESERVED                          /*  22, 38, 0x098,                            */
                  .else
                    .long  SPI1_IRQHandler                    /*  22, 38, 0x098,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52344_54)
                    .long  _RESERVED                          /*  23, 39, 0x09C,                            */
                  .else
                    .long  USART0_IRQHandler                  /*  23, 39, 0x09C,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F0008)
                    .long  _RESERVED                          /*  24, 40, 0x0A0,                            */
                    .long  UART0_IRQHandler                   /*  25, 41, 0x0A4,                            */
                    .long  _RESERVED                          /*  26, 42, 0x0A8,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52344_54)
                    .long  _RESERVED                          /*  24, 40, 0x0A0,                            */
                    .long  UART0_IRQHandler                   /*  25, 41, 0x0A4,                            */
                    .long  UART1_IRQHandler                   /*  26, 42, 0x0A8,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52357_67)
                    .long  USART1_IRQHandler                  /*  24, 40, 0x0A0,                            */
                    .long  UART0_UART2_IRQHandler             /*  25, 41, 0x0A4,                            */
                    .long  UART1_UART3_IRQHandler             /*  26, 42, 0x0A8,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52357_67)
                    .long  SCI_IRQHandler                     /*  27, 43, 0x0AC,                            */
                  .else
                    .long  _RESERVED                          /*  27, 43, 0x0AC,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F0008)
                    .long  AES_IRQHandler                     /*  28, 44, 0x0B0,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52344_54)
                    .long  _RESERVED                          /*  28, 44, 0x0B0,                            */
                  .endif
                  .if (USE_HT32_CHIP==HT32F52357_67)
                    .long  I2S_IRQHandler                     /*  28, 44, 0x0B0,                            */
                  .endif
                    .long  USB_IRQHandler                     /*  29, 45, 0x0B4,                            */
                    .long  PDMA_CH0_1_IRQHandler              /*  30, 46, 0x0B8,                            */
                    .long  PDMA_CH2_5_IRQHandler              /*  31, 47, 0x0BC,                            */



    .thumb


/* Reset Handler */

    .section .text.reset_handler
    .weak  reset_handler
    .type  reset_handler, %function
reset_handler:
                    LDR     R0, =__stack_end__      /* set stack pointer */
                    MOV     SP, R0
                    LDR     R0, =BootProcess
                    BLX     R0
                    LDR     R0, =SystemInit
                    BLX     R0
                    BL      _start

    .thumb_func
BootProcess:
                    LDR     R0, =0x40080300
                    LDR     R1,[R0, #0x10]
                    CMP     R1, #0
                    BNE     BP1
                    LDR     R1,[R0, #0x14]
                    CMP     R1, #0
                    BNE     BP1
                    LDR     R1,[R0, #0x18]
                    CMP     R1, #0
                    BNE     BP1
                    LDR     R1,[R0, #0x1C]
                    CMP     R1, #0
                    BEQ     BP2
BP1:
                    LDR     R0, =0x40080180
                    LDR     R1,[R0, #0xC]
                    LSLS    R1, R1, #4
                    LSRS    R1, R1, #20
                    CMP     R1, #0
                    BEQ     BP3
                    CMP     R1, #5
                    BEQ     BP3
                    CMP     R1, #6
                    BEQ     BP3
BP2:
                    DSB
                    LDR     R0, =0x20000000
                    LDR     R1, =0x05fa0004
                    STR     R1, [R0]
                    LDR     R1, =0xe000ed00
                    LDR     R0, =0x05fa0004
                    STR     R0, [R1, #0xC]
                    DSB
                    B       .
BP3:
                    LDR     R0, =0x20000000
                    LDR     R1, [R0]
                    LDR     R0, =0x05fa0004
                    CMP     R0, R1
                    BEQ     BP4
                    BX      LR
BP4:
                    LDR     R0, =0x40088100
                    LDR     R1, =0x00000001
                    STR     R1, [R0]
                    LDR     R0, =0x20000000
                    LDR     R1, =0x0
                    STR     R1, [R0]
                    BX      LR

    .size  Reset_Handler, .-Reset_Handler

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
    IRQ     EXTI4_15_IRQHandler
    IRQ     COMP_IRQHandler
    IRQ     COMP_DAC_IRQHandler
    IRQ     ADC_IRQHandler
    IRQ     MCTM0_IRQHandler
    IRQ     GPTM0_IRQHandler
    IRQ     SCTM0_IRQHandler
    IRQ     SCTM1_IRQHandler
    IRQ     PWM0_IRQHandler
    IRQ     PWM1_IRQHandler
    IRQ     BFTM0_IRQHandler
    IRQ     BFTM1_IRQHandler
    IRQ     I2C0_IRQHandler
    IRQ     I2C1_IRQHandler
    IRQ     SPI0_IRQHandler
    IRQ     SPI1_IRQHandler
    IRQ     QSPI_IRQHandler
    IRQ     USART0_IRQHandler
    IRQ     USART1_IRQHandler
    IRQ     UART0_IRQHandler
    IRQ     UART1_IRQHandler
    IRQ     UART0_UART2_IRQHandler
    IRQ     UART1_UART3_IRQHandler
    IRQ     SCI_IRQHandler
    IRQ     I2S_IRQHandler
    IRQ     AES_IRQHandler
    IRQ     USB_IRQHandler
    IRQ     PDMA_CH0_1_IRQHandler
    IRQ     PDMA_CH2_5_IRQHandler

    .end
