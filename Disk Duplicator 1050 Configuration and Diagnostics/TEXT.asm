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
	.BYTE "Copyright (c) E474 26 April, 2022",EOL
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
	.BYTE "1) Call drive coldstart routine.",EOL,EOL
	.BYTE "2) Upload and call coldstart routine.",EOL,EOL
	.BYTE "3) Turn on track buffering.",EOL,EOL
	.BYTE "4) Turn off track buffering.",EOL,EOL
	.BYTE "5) Select a different drive.",EOL,EOL

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
	.BYTE 	EOL,EOL,"Calling drive coldstart routine.", EOL		; inform user
CALLING_COLDSTART_DRIVE_TEXT_LENGTH = * - CALLING_COLDSTART_DRIVE_TEXT


UPLOADING_COLDSTART_CODE_TEXT
	.BYTE 	EOL,EOL,"Uploading coldstart routine.", EOL		; inform user
UPLOADING_COLDSTART_CODE_TEXT_LENGTH = * - UPLOADING_COLDSTART_CODE_TEXT


TURN_ON_BUFFERING_TEXT
	.BYTE 	EOL,EOL,"Turning on buffering.", EOL		; inform user
TURN_ON_BUFFERING_TEXT_LENGTH = * - TURN_ON_BUFFERING_TEXT

TURN_OFF_BUFFERING_TEXT
	.BYTE 	EOL,EOL,"Turning off buffering.", EOL		; inform user
TURN_OFF_BUFFERING_TEXT_LENGTH = * - TURN_OFF_BUFFERING_TEXT


;
; Text buffer, used for converting a byte into hexadecimal text representation
;
COMMAND_TABLE_INDEX .BYTE 0
CURRENT_COMMAND		.BYTE 0
.BYTE " = $"
HEX_VALS
.BYTE "     "
.BYTE EOL
DISPLAY_CURRENT_COMMAND = * - CURRENT_COMMAND		; length of string, used as argument to PRINT macro

OVER_WRITE_CHAR
	.BYTE 0, EOL

ROM_DUMPED_MESSAGE_TEXT	
	; .BYTE EOL,
	.BYTE "+ ROM dumped",EOL, "Pleased to be of service",EOL 
ROM_DUMPED_MESSAGE_TEXT_LENGTH = * - ROM_DUMPED_MESSAGE_TEXT ; length of string, used as argument to PRINT macro


EXISTING_FILE_MESSAGE
	.BYTE "Over-write "
EXISTING_FILE_NAME
	.BYTE 0
	* = * + 40				; 40 bytes buffer for file name
EXISTING_FILE_NAME_LENGTH = * - EXISTING_FILE_NAME
	
OUTPUT_OVERWRITE_EXISTING_FILE_MESSAGE_TEXT	
	.BYTE "Over-write "
OUTPUT_OVERWRITE_EXISTING_FILE_MESSAGE_TEXT_PREFIX_LENGTH = * - OUTPUT_OVERWRITE_EXISTING_FILE_MESSAGE_TEXT	
OVER_WRITE_EXISTING_FILE_NAME
	.BYTE 0
	* = * + 40
OUTPUT_OVERWRITE_EXISTING_FILE_MESSAGE_TEXT_LENGTH = * - OUTPUT_OVERWRITE_EXISTING_FILE_MESSAGE_TEXT	

YES_NO_TEXT
	.BYTE "? (Y/N): "		
YES_NO_TEXT_LENGTH = * - YES_NO_TEXT

SYNTHESISED_OVER_WRITE_LENGTH
	.BYTE 0
	

	