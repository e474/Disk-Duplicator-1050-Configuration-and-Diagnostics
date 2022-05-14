;   Copyright (C) 2019 e474 <e474sr@gmail.com>
;
;   This program is free software; you can redistribute it and/or modify
;   it under the terms of the GNU General Public License as published by
;   the Free Software Foundation; either version 3 of the License, or
;   (at your option) any later version.
;
;   This program is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU General Public License for more details.
;
;   You should have received a copy of the GNU General Public License
;   along with this program; if not, write to the Free Software
;   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


; BINMATHS.ASM

;
;
;
; BINBCD16
;

; 16-bit hex value to 24 bit decimal
; http://www.6502.org/source/integers/hex2dec-more.htm
; 
;
; Convert an 16 bit binary value to BCD
;
; This function converts a 16 bit binary value into a 24 bit BCD. It
; works by transferring one bit a time from the source and adding it
; into a BCD value that is being doubled on each iteration. As all the
; arithmetic is being done in BCD the result is a binary to decimal
; conversion. All conversions take 915 clock cycles.
;
; input: .WORD BIN_VAL (lo-byte, hi-byte)
; output: .BYTE BCD_VAL[3] (lowest 2 BCD digits, middle 2 BCD digits, highest BCD digits)


BIN_VAL			
	.WORD  12345

BCD_VAL		
	.BYTE  0,0,0
	


BINBCD16
		SED		; Switch to decimal mode
		LDA #0		; Ensure the result is clear
		STA BCD_VAL+0
		STA BCD_VAL+1
		STA BCD_VAL+2
		LDX #$10		; The number of source bits

CNVBIT		
		ASL BIN_VAL+0	; Shift out one bit
		ROL BIN_VAL+1
		LDA BCD_VAL+0	; And add into result
		ADC BCD_VAL+0
		STA BCD_VAL+0
		LDA BCD_VAL+1	; propagating any carry
		ADC BCD_VAL+1
		STA BCD_VAL+1
		LDA BCD_VAL+2	; ... thru whole result
		ADC BCD_VAL+2
		STA BCD_VAL+2
		DEX				; And repeat for next bit
		BNE CNVBIT
		CLD				; Back to binary
;
		RTS				; All Done.

;
;

;
;
; HEX_TO_ASCII 				- Convert a byte into 2 character hexadecimal 
;							representation. A holds input, output is returned
;							in A (high 4 bits) and Y (low 4 bits)
;
;
; https://atariage.com/forums/blogs/entry/11678-hex-to-ascii-string/
;
;HEX TO ASCII
;  A = ENTRY VALUE
; exit:
;  A = MSN ASCII CHAR
;  Y = LSN ASCII CHAR
;
HEX_TO_ASCII
	SED        ;2  @2
	TAX        ;2  @4
	AND #$0F   ;2  @6
	CMP #9+1   ;2  @8
	ADC #$30   ;2  @10
	TAY        ;2  @12
	TXA        ;2  @14
	LSR        ;2  @16
	LSR        ;2  @18
	LSR        ;2  @20
	LSR        ;2  @22
	CMP #9+1   ;2  @24
	ADC #$30   ;2  @26
	CLD        ;2  @28
	RTS
	
		