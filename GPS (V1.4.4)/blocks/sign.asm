; Sign Blocks v2, by ICB. Uses code from Bio's Sign Block
; and Lightvayne's Info Box. Give cred to all if used, please.
; (BTSD-ification by WYE, no credit needed whatsoever.)


!level = $01	; Level Number to play message from (if greater than 24, subtract #$DC)
!message = $01	; Message Number (1 or 2)


	db $42
	JMP Mario : JMP Mario : JMP Mario
	JMP Return : JMP Return : JMP Return : JMP Return
	JMP Mario : JMP Mario : JMP Mario

;don't touch
if !level > $24
  !PrintLvlNumber = !level+$00DC
else
  !PrintLvlNumber = !level
endif

print "This block is designed to print a message ", hex(!message),", set level number for message: ", hex(!PrintLvlNumber)

Mario:
	LDA $15		; Controller Data
	AND #$08	; If not UP
	BEQ Return	; Go to Return

	LDA #!level	; Level Number to play message from
	STA $13BF|!addr	; Write New Level Number

	LDA #!message	; Message Number (1 or 2)
	STA $1426|!addr	; Play Message
Return:
	RTL

if !level > $5F
error "Invalid level number."
endif