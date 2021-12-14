.equ SWI_SETSEG8, 0x200 @display on 8 Segment
.equ SWI_SETLED, 0x201 @LEDs on/off

.equ SWI_CheckBlack, 0x202 @check Black button
.equ SWI_CheckBlue, 0x203 @check press Blue button
.equ SWI_DRAW_STRING, 0x204 @display a string on LCD

.equ SWI_DRAW_INT, 0x205 @display an int on LCD
.equ SWI_CLEAR_DISPLAY,0x206 @clear LCD
.equ SWI_DRAW_CHAR, 0x207 @display a char on LCD

.equ SWI_CLEAR_LINE, 0x208 @clear a line on LCD
.equ SWI_EXIT, 0x11 @terminate program
.equ SWI_GetTicks, 0x6d @get current time 

.equ SEG_A, 0x80 @ patterns for 8 segment display
.equ SEG_B, 0x40 @byte values for each segment
.equ SEG_C, 0x20 @of the 8 segment display

.equ SEG_D, 0x08
.equ SEG_E, 0x04
.equ SEG_F, 0x02

.equ SEG_G, 0x01
.equ SEG_P, 0x10
.equ LEFT_LED, 0x02 @bit patterns for LED lights

.equ RIGHT_LED, 0x01
.equ LEFT_BLACK_BUTTON,0x02 @bit patterns for black buttons
.equ RIGHT_BLACK_BUTTON,0x01 @and for blue buttons
.equ BLUE_KEY_00, 0x01 @button(0)
.equ BLUE_KEY_01, 0x02 @button(1)
.equ BLUE_KEY_02, 0x04 @button(2)
.equ BLUE_KEY_03, 0x08 @button(3)
.equ BLUE_KEY_04, 0x10 @button(4)
.equ BLUE_KEY_05, 0x20 @button(5)
.equ BLUE_KEY_06, 0x40 @button(6)
.equ BLUE_KEY_07, 0x80 @button(7)
.equ BLUE_KEY_08, 1<<8 @button(8) - different way to set
.equ BLUE_KEY_09, 1<<9 @button(9)
.equ BLUE_KEY_10, 1<<10 @button(10)
.equ BLUE_KEY_11, 1<<11 @button(11)
.equ BLUE_KEY_12, 1<<12 @button(12)
.equ BLUE_KEY_13, 1<<13 @button(13)
.equ BLUE_KEY_14, 1<<14 @button(14)
.equ BLUE_KEY_15, 1<<15 @button(15)
.text

_start:
 swi SWI_CLEAR_DISPLAY
 mov r0, #8                    @posição x do display LCD
 mov r1, #8                    @posição y do display LCD
 ldr r2, =rodada
 swi SWI_DRAW_STRING           @imprime a string armazenada em r2
 mov r0, #15                   @posição x do display LCD 
 mov r1, #8                    @posição y do display LCD
 ldr r2, =1
 swi SWI_DRAW_INT              @imprime o inteiro armazenado em r2
 mov r0, #17
 mov r1, #8
 ldr r2, =tempo_inicial
 swi SWI_DRAW_STRING           @imprime o tempo inicial armazenado em r2
Check:
 mov r0, #0
 swi SWI_CheckBlack
 cmp r0, #0
 beq Check
 bne RodadaInicio
RodadaInicio:
 swi SWI_GetTicks
 str r0, [r1]
 add r1, r1, #7
 ldrb r2, [r1]                @tentativas de gerar valores aleatorios
 


.data
rodada: .asciz "Rodada"
tempo_inicial: .asciz ": 00.000 s"

.end