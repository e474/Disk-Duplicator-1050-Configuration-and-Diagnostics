
;
; Author:	E474
; Version: 	1.0
; Copyright (c) 2020, E474, Portugal.
; File:		DD1050.asm
;
; Configure and diagnose a Disk Duplicator 1050 
;  
;
; Handy system equates defined as part of ATASM
;

	.INCLUDE "OS.asm"

;
; Equates for sizes, buffers and variables
;

;VERSION_STRING = "1.0"

;COMMAND_TABLE_SIZE	 	= 	$20		; Number of SIO commands that can be defined
;COMMAND_TABLE_POINTER 	= 	$80		; Page zero variable used for indirect addressing

;COMMAND_TABLE_BUFFER	=	$600	; Command table from drive is loaded here

;ROM_BANK_BUFFER			= 	$3000

;ROM_BANK_1_BUFFER		=	$6000	; Drive ROM 1 is dumped to this buffer 
;ROM_BANK_2_BUFFER		=	$7000	; Drive ROM 2 is dumped to this buffer 



;DRIVE_COMMAND_TABLE		= 	$9780	; Location in Drive RAM of Command Table 
;DRIVE_COMMAND_ADDRESS	= 	$9000	; Location in Drive RAM to write new commands 
									; to. This memory location is also used on 
									; the 8-bit, e.g. assembled to, as it 
									; simplifies coding

SIO_READ_DATA			= $40
SIO_WRITE_DATA			= $80

;
; Start of actual program area
;
									
	*= $2000
	JMP PROGRAM_INIT				; Jump over Strings defined at start of
									; program (stops some assemblers complaining)
;
; MAC65 Macro files. Mainly used for I/O Macros
;

	.INCLUDE "SYSEQU.M65"
	.INCLUDE "IOMAC.LIB"
	
	
;
; Strings and variables
;
	
	.INCLUDE "TEXT.asm"
  
;
;
;
;
;
;
;
; Start here
; 

PROGRAM_INIT	

	LDA #0
	STA LMARGN											; set left margin to zero

	OPEN 2,4,0,"K:"									; open keyboard for reading


;
; main loop
;
GET_DRIVE_NUMBER

; Greeting, purpose, exit method

	BPUT 0, WELCOME_TEXT,WELCOME_TEXT_LENGTH
	
;	BPUT 0,DRIVE_SELECTED_MESSAGE, DRIVE_SELECTED_LENGTH
	BGET 2,DRIVE_NUMBER_CHAR,1  							; Read keystroke
    BPUT 0,DRIVE_NUMBER_CHAR,1  							; Echo keystroke


PROCESS_KEYPRESS

	LDA DRIVE_NUMBER_CHAR								; Validate drive number is in range 1 - 4
    CMP #'1
    BMI INVALID_DRIVE_NUMBER
    CMP #'5
    BMI VALID_DRIVE_NUMBER
INVALID_DRIVE_NUMBER								; not a valid drive

	BPUT 0, BAD_DRIVE_NUMBER_TEXT, BAD_DRIVE_NUMBER_TEXT_LENGTH	
	
	JMP GET_DRIVE_NUMBER							; try again
	
	
	
	
VALID_DRIVE_NUMBER

	SEC
	LDA	DRIVE_NUMBER_CHAR					; convert DRIVE_NUMBER_CHAR into actual drive number (1..4)
	SBC #'0		 							;
	STA DRIVE_NUMBER


; display main menu and get user selection	

DISPLAY_MAIN_MENU
	BPUT 0, MAIN_MENU_TEXT,MAIN_MENU_TEXT_LENGTH


; see if valid character entered

PROCESS_MENU_INPUT

	BGET 2,MENU_CHOICE_CHAR,1  							; Read keystroke

	LDA MENU_CHOICE_CHAR
	CMP #'1
	BMI PROCESS_MENU_INPUT
	CMP #'6
	BMI VALID_MENU_CHOICE

INVALID_MENU_NUMBER

	JMP PROCESS_MENU_INPUT							; try again


VALID_MENU_CHOICE

    BPUT 0,MENU_CHOICE_CHAR,1  							; Echo keystroke
	
;
	LDA MENU_CHOICE_CHAR
	CMP #'1
	BEQ CALL_DRIVE_COLDSTART_ROUTINE_DIRECTLY
	CMP #'2 
	BEQ UPLOAD_COLDSTART_CODE
	CMP #'3
	BEQ TURN_ON_TRACK_BUFFERING
	CMP #'4
	BEQ TURN_OFF_TRACK_BUFFERING
	;
	; must be 5 - get drive #
	JMP GET_DRIVE_NUMBER

UPLOAD_COLDSTART_CODE
	JSR UPLOAD_COLDSTART_CODE_SUB
	JMP DISPLAY_MAIN_MENU
	
TURN_ON_TRACK_BUFFERING
	JSR TURN_ON_TRACK_BUFFERING_SUB
	JMP DISPLAY_MAIN_MENU

TURN_OFF_TRACK_BUFFERING
	JSR TURN_OFF_TRACK_BUFFERING_SUB
	JMP DISPLAY_MAIN_MENU

CALL_DRIVE_COLDSTART_ROUTINE_DIRECTLY

	JSR CALL_DRIVE_COLDSTART_ROUTINE_DIRECTLY_SUB
	JMP DISPLAY_MAIN_MENU

;
; subroutines
;


CALL_DRIVE_COLDSTART_ROUTINE_DIRECTLY_SUB	 

		BPUT 0, CALLING_COLDSTART_DRIVE_TEXT,CALLING_COLDSTART_DRIVE_TEXT_LENGTH
	
	


;	LDA	#<COMMAND_TABLE_BUFFER
;	STA	DBUFLO
;	LDA	#>COMMAND_TABLE_BUFFER
;	STA	DBUFHI
	
	LDA	#$FF		; COLDSTART - 1
	STA	DAUX1	
	LDA	#$df		
	STA DAUX2
	LDA #'r							
	STA DCOMND
	
	LDX #SIO_READ_DATA
	STX DSTATS
	
	LDA #$31						; SIO code for disk drive
	STA DDEVIC
	
	LDA DRIVE_NUMBER
	STA DUNIT
	
	LDA #2
	STA DTIMLO
	
	LDA #$80
	STA DBYTLO
	LDA #0
	STA DBYTHI
	
    JSR	SIOV
    
 ;   BMI	ERROR
    
    RTS
    
UPLOAD_COLDSTART_CODE_SUB

		BPUT 0, UPLOADING_COLDSTART_CODE_TEXT,UPLOADING_COLDSTART_CODE_TEXT_LENGTH

;
; set load address to $2000 on the drive first	
;
	
	LDA	#0
	STA	DAUX1	
	LDA	#$20
	STA DAUX2
	LDA #'s							
	STA DCOMND
	
	LDX #SIO_READ_DATA
	STX DSTATS
	
	LDA #$31						; SIO code for disk drive
	STA DDEVIC
	
	LDA DRIVE_NUMBER
	STA DUNIT
	
	LDA #2
	STA DTIMLO
	
	LDA #$80
	STA DBYTLO
	LDA #0
	STA DBYTHI
	
    JSR	SIOV
    
 ;   BMI	ERROR
   
; upload actual code



	LDA	#<COMMAND_CODE_BUFFER
	STA	DBUFLO
	LDA	#>COMMAND_CODE_BUFFER
	STA	DBUFHI
	
;	LDA	#$FF		; COLDSTART - 1
;	STA	DAUX1	
;	LDA	#$df		
;	STA DAUX2
	LDA #'u							
	STA DCOMND
	
	LDX #SIO_READ_DATA
	STX DSTATS
	
	LDA #$31						; SIO code for disk drive
	STA DDEVIC
	
	LDA DRIVE_NUMBER
	STA DUNIT
	
	LDA #2
	STA DTIMLO
	
	LDA #0
	STA DBYTLO
	LDA #1
	STA DBYTHI
	
    JSR	SIOV
   
 ; call code on drive

	LDA	#$FF		; COLDSTART - 1
	STA	DAUX1	
	LDA	#$1f		
	STA DAUX2
	LDA #'r							
	STA DCOMND
	
	LDX #SIO_READ_DATA
	STX DSTATS
	
	LDA #$31						; SIO code for disk drive
	STA DDEVIC
	
	LDA DRIVE_NUMBER
	STA DUNIT
	
	LDA #2
	STA DTIMLO
	
	LDA #$80
	STA DBYTLO
	LDA #0
	STA DBYTHI
	
    JSR	SIOV
   

	RTS  
    
 
TURN_ON_TRACK_BUFFERING_SUB

		BPUT 0, TURN_ON_BUFFERING_TEXT,TURN_ON_BUFFERING_TEXT_LENGTH

	LDA	#0		; turn on track buffering
	STA	DAUX1	
	LDA #'b						
	STA DCOMND
	
	LDX #SIO_READ_DATA
	STX DSTATS
	
	LDA #$31						; SIO code for disk drive
	STA DDEVIC
	
	LDA DRIVE_NUMBER
	STA DUNIT
	
	LDA #2
	STA DTIMLO
	
	LDA #$80
	STA DBYTLO
	LDA #0
	STA DBYTHI
	
    JSR	SIOV
 
	


	RTS
	
	
	
TURN_OFF_TRACK_BUFFERING_SUB
		BPUT 0, TURN_OFF_BUFFERING_TEXT,TURN_OFF_BUFFERING_TEXT_LENGTH

	LDA	#1		; turn off track buffering
	STA	DAUX1	
	LDA #'b						
	STA DCOMND
	
	LDX #SIO_READ_DATA
	STX DSTATS
	
	LDA #$31						; SIO code for disk drive
	STA DDEVIC
	
	LDA DRIVE_NUMBER
	STA DUNIT
	
	LDA #2
	STA DTIMLO
	
	LDA #$80
	STA DBYTLO
	LDA #0
	STA DBYTHI
	
    JSR	SIOV
 



	RTS	

;
;HEX TO ASCII
;  A = ENTRY VALUE
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

;  A = MSN ASCII CHAR
;  Y = LSN ASCII CHAR

	RTS



;
;
;
COMMAND_CODE_BUFFER


	JMP $E000
	

;
	
;
; (DOS) START ADDRESS 
; 
	*= $02E0
	.WORD PROGRAM_INIT
		
