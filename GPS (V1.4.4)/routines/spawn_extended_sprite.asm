;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; generate extra sprite
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input: A = sprite number
;
;output Y = index to extended sprite (#$FF means no sprite spawned)
;       C = Carry Set = spawn failed, Carry Clear = spawn successful.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

code:
	XBA
	LDY #$07
-
	LDA $170B|!addr,y
	BEQ +
	DEY
	BPL -
	SEC
	RTL
+
	XBA
	STA $170B|!addr,y   ;number

	LDA $98
	STA $1715|!addr,y   ;y_low
	LDA $99
	STA $1729|!addr,y   ;y_high

	LDA $9A
	STA $171F|!addr,y   ;x_low
	LDA $9B
	STA $1733|!addr,y   ;x_high

	LDA #$00
	STA $173D|!addr,y   ;y_speed
	LDA #$00
	STA $1747|!addr,y   ;x_speed

	CLC
	RTL