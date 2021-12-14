@==============================================================================
@ Periferic Devices Macro Definitions
@==============================================================================
@ ===== - 8 Segment Display - =====
.equ SWI_SETSEG8, 0x200 @display on 8 Segment

@ ----- - Segment Patters:
.equ SEG_A, 0x80 @ patterns for 8 segment display
.equ SEG_B, 0x40 @byte values for each segment
.equ SEG_C, 0x20 @of the 8 segment display
.equ SEG_D, 0x08
.equ SEG_E, 0x04
.equ SEG_F, 0x02
.equ SEG_G, 0x01
.equ SEG_P, 0x10

@ ===== - LCD - =====
@ ----- - Clearing LCD:
.equ SWI_CLEAR_DISPLAY,0x206 @clear LCD
.equ SWI_CLEAR_LINE, 0x208 @clear a line on LCD

@ ----- - Printing on LCD:
.equ SWI_DRAW_STRING, 0x204 @display a string on LCD
.equ SWI_DRAW_INT, 0x205 @display an int on LCD
.equ SWI_DRAW_CHAR, 0x207 @display a char on LCD

@ ===== - Black Button - =====
@ ----- - Check if the button was pressed:
.equ SWI_CheckBlack, 0x202

.equ LEFT_BLACK_BUTTON,0x02 @bit patterns for black buttons
.equ RIGHT_BLACK_BUTTON,0x01 @and for blue buttons

@ ===== - Blue Button - =====
@ ----- - Check if the button was pressed:
.equ SWI_CheckBlue, 0x203 

@ ----- - Button Mapping:
.equ BLUE_KEY_00, 1<<0 @button(0)
.equ BLUE_KEY_01, 1<<1 @button(1)
.equ BLUE_KEY_02, 1<<2 @button(2)
.equ BLUE_KEY_03, 1<<3 @button(3)
.equ BLUE_KEY_04, 1<<4 @button(4)
.equ BLUE_KEY_05, 1<<5 @button(5)
.equ BLUE_KEY_06, 1<<6 @button(6)
.equ BLUE_KEY_07, 1<<7 @button(7)
.equ BLUE_KEY_08, 1<<8 @button(8)
.equ BLUE_KEY_09, 1<<9 @button(9)
.equ BLUE_KEY_10, 1<<10 @button(10)
.equ BLUE_KEY_11, 1<<11 @button(11)
.equ BLUE_KEY_12, 1<<12 @button(12)
.equ BLUE_KEY_13, 1<<13 @button(13)
.equ BLUE_KEY_14, 1<<14 @button(14)
.equ BLUE_KEY_15, 1<<15 @button(15)

@ ===== - Timer - =====
@ ----- - Get Current Time:
.equ SWI_GetTicks, 0x6d

@ ===== - Program Termination - =====
.equ SWI_EXIT, 0x11

.equ SWI_SETLED, 0x201 @LEDs on/off
.equ LEFT_LED, 0x02 @bit patterns for LED lights
.equ RIGHT_LED, 0x01

.text


@==============================================================================
@ Game Script
@==============================================================================

_start:
	@ Clearing display
	swi SWI_CLEAR_DISPLAY
	mov r0, #0 @General purpose
	mov r1, #0
	mov r2, #0
	mov r3, #50 @Time increment
	mov r4, #1 @Round counter
	mov r5, #0 @seconds counter
	mov r6, #0 @ms counter
	mov r7, #0 @Stores the random generated number
	
	BL PrintLCD
	
buttonCheck1:
	mov r0, #0
	swi SWI_CheckBlack
	cmp r0, #0
	beq buttonCheck1
	bne generateRandomNumber
	
generateRandomNumber:
	swi SWI_GetTicks
	mov r7, r0
	and r0, r7, #0b00001111
	BL Display8Segment
	mov r7, r0
	
	
blueButtonLoop:
	BL Wait
	add r6, r6, r3
	BL PrintLCD
	mov r0, #0
	swi SWI_CheckBlue
	cmp r0, #0
	bne blueButtonCheck    
	BL blueButtonLoop


blueButtonCheck:
	cmp r0, #BLUE_KEY_15
	beq randomNumberCheck15

	cmp r0, #BLUE_KEY_14
	beq randomNumberCheck14

	cmp r0, #BLUE_KEY_13
	beq randomNumberCheck13

	cmp r0, #BLUE_KEY_12
	beq randomNumberCheck12

	cmp r0, #BLUE_KEY_11
	beq randomNumberCheck11

	cmp r0, #BLUE_KEY_10
	beq randomNumberCheck10

	cmp r0, #BLUE_KEY_09
	beq randomNumberCheck9

	cmp r0, #BLUE_KEY_08
	beq randomNumberCheck8

	cmp r0, #BLUE_KEY_07
	beq randomNumberCheck7

	cmp r0, #BLUE_KEY_06
	beq randomNumberCheck6

	cmp r0, #BLUE_KEY_05
	beq randomNumberCheck5

	cmp r0, #BLUE_KEY_04
	beq randomNumberCheck4

	cmp r0, #BLUE_KEY_03
	beq randomNumberCheck3

	cmp r0, #BLUE_KEY_02
	beq randomNumberCheck2

	cmp r0, #BLUE_KEY_01
	beq randomNumberCheck1

	cmp r0, #BLUE_KEY_00
	beq randomNumberCheck0

	
randomNumberCheck0:
	cmp r7, #0
	beq roundCheck
	bne failureEnd


randomNumberCheck1:
	cmp r7, #1
	beq roundCheck
	bne failureEnd


randomNumberCheck2:
	cmp r7, #2
	beq roundCheck
	bne failureEnd


randomNumberCheck3:
	cmp r7, #3
	beq roundCheck
	bne failureEnd


randomNumberCheck4:
	cmp r7, #4
	beq roundCheck
	bne failureEnd


randomNumberCheck5:
	cmp r7, #5
	beq roundCheck
	bne failureEnd


randomNumberCheck6:
	cmp r7, #6
	beq roundCheck
	bne failureEnd


randomNumberCheck7:
	cmp r7, #7
	beq roundCheck
	bne failureEnd


randomNumberCheck8:
	cmp r7, #8
	beq roundCheck
	bne failureEnd


randomNumberCheck9:
	cmp r7, #9
	beq roundCheck
	bne failureEnd


randomNumberCheck10:
	cmp r7, #10
	beq roundCheck
	bne failureEnd


randomNumberCheck11:
	cmp r7, #11
	beq roundCheck
	bne failureEnd


randomNumberCheck12:
	cmp r7, #12
	beq roundCheck
	bne failureEnd


randomNumberCheck13:
	cmp r7, #13
	beq roundCheck
	bne failureEnd


randomNumberCheck14:
	cmp r7, #14
	beq roundCheck
	bne failureEnd


randomNumberCheck15:
	cmp r7, #15
	beq roundCheck
	bne failureEnd


roundCheck:
	cmp r4, #6
	beq exit
	add r4, r4, #1
	BL generateRandomNumber


failureEnd:
	swi SWI_CLEAR_DISPLAY
	mov r0, #12
	mov r1, #8
	ldr r2, =failure
	swi SWI_DRAW_STRING


exit:
	swi SWI_EXIT
 
@==============================================================================
@ Functions
@==============================================================================
@ ===== - Display8Segment (Number:R0; Point:R1) - =====
@ Displays the number 0-9 in R0 on the 8-segment display
@ If R1 = 1, the point is also shown

Display8Segment:
	stmfd sp!,{r0-r2,lr}
	
	ldr r2,=Digits
	ldr r0,[r2,r0,lsl#2]
	tst r1,#0x01 @if r1=1,
	orrne r0,r0,#SEG_P @then show P

	swi SWI_SETSEG8
	
	ldmfd sp!,{r0-r2,pc}

@ ===== - PrintLCD(Round:r4; Seconds:r5; Milliseconds:r6) - =====
PrintLCD:
	stmfd sp!,{r0-r6,lr}
	
	mov r0, #8                    @posição x do display LCD
	mov r1, #8                    @posição y do display LCD
	ldr r2, =roundString
	swi SWI_DRAW_STRING           @imprime a string armazenada em r2
	
	mov r0, #15                   @posição x do display LCD 
	mov r2, r4
	swi SWI_DRAW_INT              @imprime o inteiro armazenado em r2
	
	mov r0, #16
	ldr r2, =colonSymbol
	swi SWI_DRAW_STRING           @imprime o tempo inicial armazenado em r2
	
	mov r0, #18
	
	cmp r5, #100
	bge printCurrentSeconds
	
	cmp r5, #10
	bge printWithMoreThanTenSeconds
	blt printWithLessThanTenSeconds
	
	printWithLessThanTenSeconds:
		mov r2, #0
		swi SWI_DRAW_INT
		add r0, r0, #1
		
	printWithMoreThanTenSeconds:
		mov r2, #0
		swi SWI_DRAW_INT
		add r0, r0, #1
		
	printCurrentSeconds:
		mov r2, r5
		swi SWI_DRAW_INT
		
	add r0, r0, #1
	ldr r2, =decimalPoint
	swi SWI_DRAW_STRING
	
	add r0, r0, #1
	cmp r6, #100
	bge printCurrentMillis
	
	cmp r6, #10
	bge printWithMoreThan100Millis
	blt printWithLessThan100Millis
	
	printWithLessThan100Millis:
		mov r2, #0
		swi SWI_DRAW_INT
		add r0, r0, #1
	
	printWithMoreThan100Millis:
		mov r2, #0
		swi SWI_DRAW_INT
		add r0, r0, #1
	
	printCurrentMillis:
		mov r2, r6
		swi SWI_DRAW_INT
		
	add r0, r0, #1
	ldr r2, =secondsSymbol
	swi SWI_DRAW_STRING
	
	ldmfd sp!,{r0-r6,pc}

@ ===== - Wait(Delay:r3) wait for r3 milliseconds - =====
@ Delays for the amount of time stored in r3 for a 15-bit timer
Wait:
	stmfd sp!,{r0-r5,lr}
	ldr r4,=0x00007FFF @mask for 15-bit timer
	SWI SWI_GetTicks @Get start time
	and r1,r0,r4 @adjusted time to 15-bit
Wloop:
	SWI SWI_GetTicks @Get current time
	and r2,r0,r4 @adjusted time to 15-bit
	cmp r2,r1
	blt Roll @rolled above 15 bits
	sub r5,r2,r1 @compute easy elapsed time
	bal CmpLoop
Roll:
	sub r5,r4,r1 @compute rolled elapsed time
	add r5,r5,r2
CmpLoop:
	cmp r5,r3 @is elapsed time < delay?
	blt Wloop @Continue with delay
Xwait:
	ldmfd sp!,{r0-r5,pc}

@==============================================================================
@ Stored Data
@==============================================================================
@ ===== - Constant Ints - =====
initialRound: .byte 1
timeIncrement: .byte 50
@* - Strings
.data
roundString: .asciz "Rodada"
colonSymbol: .asciz ":"
space: .asciz " "
decimalPoint: .asciz "."
secondsSymbol: .asciz " s"
initial_time: .asciz ": 00.000 s"
failure: .asciz "PERDEU!!!"

@* - 8 Segment Display Digits:
Digits:
.word SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_G @0
.word SEG_B|SEG_C @1
.word SEG_A|SEG_B|SEG_F|SEG_E|SEG_D @2
.word SEG_A|SEG_B|SEG_F|SEG_C|SEG_D @3
.word SEG_G|SEG_F|SEG_B|SEG_C @4
.word SEG_A|SEG_G|SEG_F|SEG_C|SEG_D @5
.word SEG_A|SEG_G|SEG_F|SEG_E|SEG_D|SEG_C @6
.word SEG_A|SEG_B|SEG_C @7
.word SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G @8
.word SEG_A|SEG_B|SEG_F|SEG_G|SEG_C @9
.word SEG_A|SEG_B|SEG_C|SEG_E|SEG_F|SEG_G @A
.word SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G @b
.word SEG_A|SEG_D|SEG_E|SEG_G @C
.word SEG_B|SEG_C|SEG_D|SEG_E|SEG_F @d
.word SEG_A|SEG_D|SEG_E|SEG_F|SEG_G @E
.word SEG_A|SEG_E|SEG_F|SEG_G @F
.word 0  @Blank display

.end