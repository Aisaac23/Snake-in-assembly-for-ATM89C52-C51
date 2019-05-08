$title (snake program);For ATMEL 89C52
snake equ 0000h
org snake
sjmp main
main: 
clr C ; Clears a register. This instruction performs an Exclusive OR between a register and itself. This will clear all bits in the register.
mov a, #01h ; we have 1 in ac
clr 01h ; clears bit 1
clr 02h ; clears bit 2
clr 03h ; clears bit 3
;Being clr a microcontroller-specific instruction

cycle: ;label for loop 
mov p2,a ; this is how we turn the LEDs ON/OFF (8-bit port p2)

acall mdelay ;  unconditionally waits 1 sec

;******************
;at the beginning none of these jumps
jb 03h, fourth
jb 02h, third
jb 01h,second
;*******************

;******************************
;this cyclically jumps to *firstA* until all the LEDs are ON. First step  
first:
CJNE a,#0FFh,firstA; calls *firstA* until all acc bits are set thus all LEDs are ON
cpl 01h ; we use this bit as a flag
jb 01h, second ; if bit is set to one goes to *second*
;******************************

;******************************
;this cyclically moves the bits to the left 
firstA:  
rl a ; moves bit 00000001 -> 00000010
inc a ; turns ON the rightmost LED 
sjmp cycle ; calls *cycle* to set acc to p2 and turn on the LEDs
;********************************

;******************************
;cyclically turns OFF LEDs the bits from right to left. firstA step
second:
rl a
dec a ;turns OFF the rightmost LED (now the snake is leaving)
jz secondA; if acc goes to ZERO, then jumps to *secondA* to move to the next step
sjmp cycle
;******************************

;******************************
;cyclically turns ON LEDs the bits from left to right. Third step
third:
CJNE a,#0FFh, thirdA
cpl 03h; once set, it goes for the last step, turning the LEDs OFF from the left  
jb 03h, fourth

thirdA:
inc a ;turns ON the rightmost LED 
rr a ;Rotate Accumulator Right (now the snake is coming back from the left)
sjmp cycle
;******************************

;******************************
;cyclically turns OFF LEDs the bits from left to right. Last step
fourth:
dec a ;turns OFF the rightmost LED 
rr a; Rotate Accumulator Right (now the snake is leaving from left to right)
jz reset ; once the snake left (all LEDs went OFF) we call *reset* to start over
sjmp cycle
;******************************

secondA: 
cpl 02h ; now it will jump to *third* that will turn ON the LEDs form left to right
sjmp cycle

reset:; setting bits from 1 to 0
cpl 01h 
cpl 02h
cpl 03h
sjmp cycle

mdelay: ; creating a 1sec delay. This is accurate because we are using a 11.0592 MHZ crystal
; according to AT89C52 instruction set: djnz consumes 24hz, so 16x120x240x24hz = 11059200 HZ = 1sec
mov r0, #10h ; 16 dec
jump0: mov r1, #78h ; 120 decimal   
jump1:mov r2, #0f0h ; 240 decimal  
jump2: ;setting the 3 values r0, r1, r2 then moving to the first loop
djnz r2,jump2 ; 
djnz r1,jump ;
djnz r0, jump0 ;
ret
end
