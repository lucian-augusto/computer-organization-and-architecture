@==============================================================================
@ Periferic Devices Macro Definitions
@==============================================================================
@ ===== - 8 Segment Display - =====
.equ SWI_SETSEG8, 0x200				@display on 8 Segment

@ ----- - Segment Patters:
.equ SEG_A, 0x80 					@ patterns for 8 segment display
.equ SEG_B, 0x40 					@ byte values for each segment
.equ SEG_C, 0x20					@ of the 8 segment display
.equ SEG_D, 0x08
.equ SEG_E, 0x04
.equ SEG_F, 0x02
.equ SEG_G, 0x01
.equ SEG_P, 0x10

@ ===== - LCD - =====
@ ----- - Clearing LCD:
.equ SWI_CLEAR_DISPLAY,0x206		@ clear LCD
.equ SWI_CLEAR_LINE, 0x208			@ clear a line on LCD

@ ----- - Printing on LCD:
.equ SWI_DRAW_STRING, 0x204			@ display a string on LCD
.equ SWI_DRAW_INT, 0x205			@ display an int on LCD
.equ SWI_DRAW_CHAR, 0x207			@ display a char on LCD

@ ===== - Black Button - =====
@ ----- - Check if the button was pressed:
.equ SWI_CheckBlack, 0x202

.equ LEFT_BLACK_BUTTON,0x02			@ bit patterns for black buttons
.equ RIGHT_BLACK_BUTTON,0x01		@ and for blue buttons

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

.text


@==============================================================================
@ Game Script
@==============================================================================

_start:
	swi SWI_CLEAR_DISPLAY				@ Clearing display
	mov r0, #0						@ General purpose
	mov r1, #0
	mov r2, #0
	mov r3, #50						@ Time increment
	mov r4, #1						@ Round counter
	mov r5, #0						@ Seconds counter
	mov r6, #0						@ Milliseconds counter
	mov r7, #0						@ Stores the random generated number
	
	BL PrintLCD						@ Print the round and the timer on the LCD
	
buttonCheck1:						@ Loop that checks if the either of the black buttons was pressed
	mov r0, #0
	swi SWI_CheckBlack
	cmp r0, #0
	beq buttonCheck1
	bne generateRandomNumber
	
generateRandomNumber:				@ Generates a random value using the clock captured using the SWI_GetTicks macro
	swi SWI_GetTicks				@ Gets the clock
	mov r7, r0						@ Stores the obtained value in r7
	and r0, r7, #0b00001111			@ Gets the least significant byte using an AND operation
	BL Display8Segment				@ Prints the generated value on the 8 segment display
	mov r7, r0						@ Stores the printed value in r7
		
blueButtonLoop:						@ Loop that checks if any of the blue buttons were pressed
	BL Wait							@ Calls the function that causes a 50 ms delay
	BL UpdateTime					@ Calls the function that updates the time stored in r5 and r6
	BL PrintLCD						@ Prints the new values on the LCD
	mov r0, #0						@ Resets the value of r0
	swi SWI_CheckBlue				@ Checks if any of the blue buttons were pressed
	cmp r0, #0						@ Compares the value obtained by the previous macro (value stored in r0) to 0
	bne blueButtonCheck				@ If r0's value != 0 a button was pressed so the program checks which one was pressed
	BL blueButtonLoop				@ Returns to keep exeuting the loop

blueButtonCheck:					@ This sequence checks which button was pressed and then redirects the program flow
									@ to the equivalent check, where  it is verified if the chosen option was the correct
									@ one. If the wrong button was pressed, the flow is directed to the failureEnd label
									@ otherwise, to the roundCheck label
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

roundCheck:							@ Checks if the program should move on to the next round or end
	cmp r4, #6						@ Compares the value stored in r4 is equals to 6
	beq exit						@ If r4's value == 6 the program ends, otherwise the game moves on to the next round
	add r4, r4, #1					@ Increments the round by 1
	BL generateRandomNumber			@ Returns to the random number generation label, effectively starting another round

failureEnd:							@ Prints a failure message on the LCD and ends the program
	swi SWI_CLEAR_DISPLAY			@ Cleans the LCD screen
	mov r0, #12						@ Moves the "cursor" to the x position 12 
	mov r1, #8						@ Moves the "cursor" to the y position 8
	ldr r2, =failure				@ Loads the failure message into r2
	swi SWI_DRAW_STRING				@ Prints the String stored in r2 on the LCD 

exit:								@ Label to end the program
	swi SWI_EXIT					@ Effectively ends the program
 
@==============================================================================
@ Functions
@==============================================================================
@ ===== - Display8Segment (Number:R0; Point:R1) - =====
@ Displays the number 0-9 in R0 on the 8-segment display
@ If R1 = 1, the point is also shown

Display8Segment:
	stmfd sp!,{r0-r2,lr}			@ Stores registers r0 to r2 in memory
	
	ldr r2,=Digits
	ldr r0,[r2,r0,lsl#2]
	tst r1,#0x01 @if r1=1,
	orrne r0,r0,#SEG_P				@ Then show P

	swi SWI_SETSEG8
	
	ldmfd sp!,{r0-r2,pc}			@ Recovers values previously stored in the registers r0 to r2 from memory
									@ and returns to where the functions was called

@ ===== - PrintLCD(Round:r4; Seconds:r5; Milliseconds:r6) - =====
@ Prints the round and the timer on the LCD screen
PrintLCD:
	stmfd sp!,{r0-r6,lr}			@ Stores registers r0 to r6 in memory
	
	mov r0, #8						@ LCD's x postion
	mov r1, #8						@ LCD's y poxition
	ldr r2, =roundString			@ Loading the String "Rodada" into r2
	swi SWI_DRAW_STRING				@ Prints the string stored in r2
	
	mov r0, #15						@ LCD's x postion
	mov r2, r4						@ Loading value of r4 into r2
	swi SWI_DRAW_INT				@ Prints the string stored in r2
	
	mov r0, #16						@ Moving the "cursor" to the x position 20
	ldr r2, =colonSymbol			@ Loading the colon symbol (":") into r2
	swi SWI_DRAW_STRING				@ Prints the string stored in r2
	
	mov r0, #18						@ LCD's x postion
	cmp r5, #10						@ Comparing the current time (in seconds) in r5 to 10
	bge printCurrentSeconds			@ If r5's value is >= 10 we only print the value
	blt printWithLessThanTenSeconds	@ If r5's value is < 10 we print 0 and then the value
	
	printWithLessThanTenSeconds:	@ Printing the 0 before the value
		mov r2, #0
		swi SWI_DRAW_INT
		add r0, r0, #1
		
	printCurrentSeconds:			@ Printing the actual value
		mov r2, r5
		swi SWI_DRAW_INT
		
	mov r0, #20						@ Moving the "cursor" to the x position 20
	ldr r2, =decimalPoint			@ Loading the decimal point symbol into r2
	swi SWI_DRAW_STRING				@ Prints the string stored in r2
	
	add r0, r0, #1					@ Advancing the cursor in one position in the x direction
	cmp r6, #100					@ Comparing the current time (in seconds) in r5 to 100
	bge printCurrentMillis			@ If r6's value is >= 100 we only print the value
	
	cmp r6, #10						@ Comparing the current time (in seconds) in r5 to 10
	bge printWithMoreThan100Millis	@ If r6's value is >= 10 we print one 0 and then the value
	blt printWithLessThan100Millis	@ If r6's value is < 10 we print two 0s and then the value
	
	printWithLessThan100Millis:		@ Printing two 0s before the value
		mov r2, #0
		swi SWI_DRAW_INT
		add r0, r0, #1
	
	printWithMoreThan100Millis:		@ Printing one 0 before the value
		mov r2, #0
		swi SWI_DRAW_INT
		add r0, r0, #1
	
	printCurrentMillis:				@ Printing the actual value
		mov r2, r6
		swi SWI_DRAW_INT
		
	mov r0, #24						@ Moving the "cursor" to the x position 24
	ldr r2, =secondsSymbol			@ Loading the second symbol into r2
	swi SWI_DRAW_STRING				@ Prints the string stored in r2
	
	ldmfd sp!,{r0-r6,pc}			@ Recovers values previously stored in the registers r0 to r6 from memory
									@ and returns to where the functions was called
	
@ ===== - UpdateTime(Seconds:r5; Milliseconds:r6) - =====
@ Updates the time in the registers r5 and r6 (seconds and milliseconds respectively)
UpdateTime:
	stmfd sp!,{r0-r2,lr}			@ Stores registers r0 to r2 in memory
	add r6, r6, r3					@ Adds the time step to the milliseconds register
	cmp r6, #1000					@ Compares the value stored in r6 to 1000
	bge incrementSecond				@ If r6's value >= 1000 we increment the value of r5 and reset r6
	blt returnUpdateTime			@ If r6's value < 1000 we only return
	
	incrementSecond:
		add r5, r5, #1				@ Add 1 to the value of r5
		mov r6, #0					@ Reset the value of r6 to 0
		
	returnUpdateTime:
		ldmfd sp!,{r0-r2,pc}		@ Recovers values previously stored in the registers r0 to r2 from memory
									@ and returns to where the functions was called

@ ===== - Wait(Delay:r3) wait for r3 milliseconds - =====
@ Delays for the amount of time stored in r3 for a 15-bit timer
Wait:
	stmfd sp!,{r0-r5,lr}			@ Stores registers r0 to r5 in memory
	ldr r4,=0x00007FFF				@ mask for 15-bit timer
	SWI SWI_GetTicks				@ Get start time
	and r1,r0,r4 					@ Adjusted time to 15-bit
Wloop:
	SWI SWI_GetTicks				@ Get current time
	and r2,r0,r4 					@ Adjusted time to 15-bit
	cmp r2,r1
	blt Roll 						@ Rolled above 15 bits
	sub r5,r2,r1 					@ Compute easy elapsed time
	bal CmpLoop
Roll:
	sub r5,r4,r1					@ Compute rolled elapsed time
	add r5,r5,r2
CmpLoop:
	cmp r5,r3						@ Is elapsed time < delay?
	blt Wloop						@ Continue with delay
Xwait:
	ldmfd sp!,{r0-r5,pc}			@ Recovers values previously stored in the registers r0 to r5 from memory
									@ and returns to where the functions was called

@==============================================================================
@ Stored Data
@==============================================================================
.data
@ ===== - Strings - =====
roundString: .asciz "Rodada"
colonSymbol: .asciz ":"
decimalPoint: .asciz "."
secondsSymbol: .asciz " s"
failure: .asciz "PERDEU!!!"

@ ===== - 8 Segment Display Digits - =====
Digits:
.word SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_G		@0
.word SEG_B|SEG_C								@1
.word SEG_A|SEG_B|SEG_F|SEG_E|SEG_D				@2
.word SEG_A|SEG_B|SEG_F|SEG_C|SEG_D				@3
.word SEG_G|SEG_F|SEG_B|SEG_C					@4
.word SEG_A|SEG_G|SEG_F|SEG_C|SEG_D				@5
.word SEG_A|SEG_G|SEG_F|SEG_E|SEG_D|SEG_C		@6
.word SEG_A|SEG_B|SEG_C							@7
.word SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G	@8
.word SEG_A|SEG_B|SEG_F|SEG_G|SEG_C				@9
.word SEG_A|SEG_B|SEG_C|SEG_E|SEG_F|SEG_G		@A
.word SEG_C|SEG_D|SEG_E|SEG_F|SEG_G				@b
.word SEG_A|SEG_D|SEG_E|SEG_G					@C
.word SEG_B|SEG_C|SEG_D|SEG_E|SEG_F				@d
.word SEG_A|SEG_D|SEG_E|SEG_F|SEG_G				@E
.word SEG_A|SEG_E|SEG_F|SEG_G					@F
.word 0											@Blank display

.end