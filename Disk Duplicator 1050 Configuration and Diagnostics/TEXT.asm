;
; TEXT.asm
;

;	
; Strings used in text output, file names, etc. 
; These strings may get modified to show which drive number is being worked with, etc.
; Put at start of program due to some assemblers not liking forward references in Macros, etc., etc.	
;

WELCOME_TEXT
	.BYTE EOL
	.BYTE "--------------------------------------",EOL
	.BYTE "E474's DD 1050 Utility V. "
VERSION_NUMBER
	.BYTE "1.0",EOL
	.BYTE "Copyright (c) E474 01 June, 2022",EOL
    .BYTE "<"
    .BYTE +$80,"SYSTEM RESET"						; inverse video - specific to ATASM?
    .BYTE "> to exit",EOL
	.BYTE "Source code at github.com/e474",EOL
	.BYTE "--------------------------------------",EOL,EOL
    .BYTE "Select drive (1 - 4): "
WELCOME_TEXT_LENGTH = * - WELCOME_TEXT


BAD_DRIVE_NUMBER_TEXT
	.BYTE 	EOL,EOL,"* Error: Drive number not between 1 and 4", EOL		; inform user
BAD_DRIVE_NUMBER_TEXT_LENGTH = * - BAD_DRIVE_NUMBER_TEXT

	
MAIN_MENU_TEXT
	.BYTE EOL,EOL
	.BYTE "1) Call drive coldstart routine.",EOL
	.BYTE "2) Upload and call coldstart routine.",EOL
	.BYTE "3) Turn on track buffering.",EOL
	.BYTE "4) Turn off track buffering.",EOL
	.BYTE "5) Select a different drive.",EOL

    .BYTE "Choose (1 - 5): "
MAIN_MENU_TEXT_LENGTH = * - MAIN_MENU_TEXT

BAD_MENU_NUMBER_TEXT
	.BYTE 	EOL,EOL,"* Error: Drive number not between 1 and 4", EOL		; inform user
BAD_MENU_NUMBER_TEXT_LENGTH = * - BAD_MENU_NUMBER_TEXT




MENU_CHOICE_CHAR
	.BYTE	"1"										; This value is updated




;
; Feedback on which drive is being worked on
;
DRIVE_SELECTED_MESSAGE								
	.BYTE EOL, EOL, "* Reseting drive: "
DRIVE_NUMBER_CHAR
	.BYTE	"1"										; This value is updated
DRIVE_SELECTED_LENGTH = * - DRIVE_SELECTED_MESSAGE	; length of string, used as argument to PRINT macro

DRIVE_NUMBER
	.BYTE 0											; numeric drive number ($1..$4), (not
													; character code for drive number)


CALLING_COLDSTART_DRIVE_TEXT
	.BYTE 	EOL,"Calling drive coldstart routine.", EOL		; inform user
CALLING_COLDSTART_DRIVE_TEXT_LENGTH = * - CALLING_COLDSTART_DRIVE_TEXT


UPLOADING_COLDSTART_CODE_TEXT
	.BYTE 	EOL,"Uploading coldstart routine.", EOL		; inform user
UPLOADING_COLDSTART_CODE_TEXT_LENGTH = * - UPLOADING_COLDSTART_CODE_TEXT

SETTING_UPLOAD_CODE_ADDRESS_TEXT
	.BYTE 	EOL,"Setting upload address.", EOL		; inform user
SETTING_UPLOAD_CODE_ADDRESS_TEXT_LENGTH = * - SETTING_UPLOAD_CODE_ADDRESS_TEXT

CALLING_UPLOADED_CODE_TEXT
	.BYTE 	EOL,"Calling uploaded code.", EOL		; inform user
CALLING_UPLOADED_CODE_TEXT_LENGTH = * - CALLING_UPLOADED_CODE_TEXT


ERROR_CALL_CODE_DIRECTLY_TEXT
;	.BYTE +$80,"Error"
	.BYTE " Failed to call coldstart routine.", EOL		; inform user
ERROR_CALL_CODE_DIRECTLY_TEXT_LENGTH = * - ERROR_CALL_CODE_DIRECTLY_TEXT



ERROR_SET_LOAD_ADDRESS_TEXT 	
;	.BYTE +$80,"Error"
	.BYTE " Failed to set upload code address.", EOL		; inform user
ERROR_SET_LOAD_ADDRESS_TEXT_LENGTH = * - ERROR_SET_LOAD_ADDRESS_TEXT

ERROR_UPLOAD_CODE_TEXT
;	.BYTE +$80,"Error"
	.BYTE " Failed to upload code.", EOL		; inform user
ERROR_UPLOAD_CODE_TEXT_LENGTH = * - ERROR_UPLOAD_CODE_TEXT

ERROR_CALL_UPLOADED_CODE_TEXT
;	.BYTE +$80,"Error"
	.BYTE " Failed to call uploaded code.", EOL		; inform user
ERROR_CALL_UPLOADED_CODE_TEXT_LENGTH = * - ERROR_CALL_UPLOADED_CODE_TEXT


ERROR_TURN_ON_TRACK_BUFFERING_TEXT
;	.BYTE +$80,"Error"
	.BYTE " Could not turn on track buffering.", EOL		; inform user
ERROR_TURN_ON_TRACK_BUFFERING_TEXT_LENGTH = * - ERROR_TURN_ON_TRACK_BUFFERING_TEXT

ERROR_TURN_OFF_TRACK_BUFFERING_TEXT
;	.BYTE +$80,"Error"
	.BYTE " Could not turn off track buffering.", EOL		; inform user
ERROR_TURN_OFF_TRACK_BUFFERING_TEXT_LENGTH = * - ERROR_TURN_OFF_TRACK_BUFFERING_TEXT





SIO_ERROR_CODE_TEXT
	.BYTE " "
	.BYTE 	+$80,"SIO Error:" 		; inform userUPLOAD_COLDSTART_CODE_SUB
	.BYTE " "
SIO_ERROR_CODE_TEXT_LENGTH = * - SIO_ERROR_CODE_TEXT

TURN_ON_BUFFERING_TEXT
	.BYTE 	EOL,"Turning on buffering.", EOL		; inform user
TURN_ON_BUFFERING_TEXT_LENGTH = * - TURN_ON_BUFFERING_TEXT

TURN_OFF_BUFFERING_TEXT
	.BYTE 	EOL,"Turning off buffering.", EOL		; inform user
TURN_OFF_BUFFERING_TEXT_LENGTH = * - TURN_OFF_BUFFERING_TEXT


	
;BCD_VAL_3_ATASCII_CHARS
	.BYTE 0,0,0	
	
FILE_ERROR_TEXT
	.WORD 0,0
	
	
DECIMAL_TO_SCREEN
	.BYTE	"0123456789"
	
	
	

	