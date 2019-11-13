$title (snake program);For ATMEL 89C52
;Instruction set: http://www.keil.com/dd/docs/datashts/atmel/at_c51ism.pdf (pg.11)
snake equ 0000h

org snake

; Do initialisation of Stack Pointer and p2 port register 
MOV SP, #00000111b
MOV p2, #00000000b
; In this link: https://www.datsi.fi.upm.es/docencia/Micro_C/atmel/doc0313.pdf 
; you'll find the necessary hardware specifications and diagrams (1st and 2nd pages)
; that'll guide you on how to wire your LEDs to the AT89C52. Being P2.0 the lsb (2^0)

SJMP main
main: 
CLR C ; Clears a register. This is the same as mov C,#0
MOV a, #00h ; we have 0 in acumulator
;Remember CLR is a microcontroller-specific instruction

acall fill_to_FF_left
acall fill_to_00_left
acall fill_to_FF_right
acall fill_to_00_right
SJMP  main


;******************
; output to LEDs
outputLED:
MOV p2,a ; this is how we turn the LEDs ON/OFF (8-bit port p2)
acall mdelay ;  unconditionally waits 1 sec
RET
;*******************

;******************************
; Starting from 0x00, fill to 0xFF right to left.
; 00000000 through 00001111 to 11111111
fill_to_FF_left:
RL a ; moves bit 00000001 -> 00000010
INC a ; turns ON the rightmost LED
acall outputLED
CJNE a,#0FFh,fill_to_FF_left ; jumps to *fill_to_FF_left* until all acc bits are set thus all LEDs are ON
RET
;******************************

;******************************
; Starting from 0xFF, fill to 0x00 right to left.
; 11111111 through 11110000 to 00000000
fill_to_00_left:
RL a ; moves bit 11111110 -> 11111101 (Rotate Left)
DEC a ; turns OFF the rightmost ON LED
acall outputLED
JNZ fill_to_00_left ; jumps to *fill_to_00_left* until all acc bits are zero thus all LEDs are OFF
RET
;******************************

;******************************
; Starting from 0x00, fill to 0xFF left to right.
; 00000000 through 11110000 to 11111111
fill_to_FF_right:
INC a ; turns ON the rightmost LED
RR a ; moves bit 00000001 -> 10000000 
acall outputLED
CJNE a,#0FFh,fill_to_FF_right ; jumps to *fill_to_FF_right* until all acc bits are set thus all LEDs are ON
RET
;******************************

;******************************
; Starting from 0xFF, fill to 0x00 left to right.
; 11111111 through 00001111 to 00000000
fill_to_00_right:
DEC a ; turns OFF the leftmost ON LED
RR a ; moves bit 11111110 -> 01111111 (Rotate Right)
acall outputLED
JNZ fill_to_00_right ; jumps to *fill_to_00_right* until all acc bits are zero thus all LEDs are OFF
RET
;******************************

mdelay: ;creating a 1sec delay. According to AT89C52 instruction set: djnz consumes 24 cycles, so, we need the 
;equation: 24A + (24AB + 36B) + (24AC + 24ABC + 36BC + 36C) + 36 = 11,059,200 MHz to handle delay in the ;following code: 
MOV r0, #00Fh ; 15 decimal
outermost: MOV r1, #FFFh ; 255 decimal   
middle: MOV r2, #06Fh ; 111 decimal  
innerMost: ;setting the 3 values r0, r1, r2 then moving to the first loop
DJNZ r2, innermost  
DJNZ r1, middle
DJNZ r0, outermost
RET ; it returns to "outputLED"

END
;Special thanks to modi123_1 @ dreamincode.net who gave me valuable feedback about the last version and allowed me to create this one.
