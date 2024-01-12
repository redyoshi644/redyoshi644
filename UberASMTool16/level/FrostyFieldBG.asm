!FreeRAM = $7F9E00
if !sa1
!FreeRAM = $409E00
endif

macro SetScanlines(count,addr)
!i = <count>
	while !i != 0
		db $01 : dw !FreeRAM+<addr>
	!i #= !i-$1
endif

endmacro

init:
;; Setup HDMA for layer 2
	REP #$20
	LDA #$0F42
	STA $4330
	LDA.w #main_Layer2+3
	STA $4332
	SEP #$20
	LDA.b #main_Layer2>>16
	STA $4334
	LDA.b #!FreeRAM>>16
	STA $4337
	LDA #$08
	TSB $0D9F|!addr
;; Setup HDMA for layer 3
	REP #$20
	LDA #$1142
	STA $4340
	LDA.w #main_Layer3+3
	STA $4342
	SEP #$20
	LDA.b #main_Layer3>>16
	STA $4344
	LDA.b #!FreeRAM>>16
	STA $4347
	LDA #$10
	TSB $0D9F|!addr
;; Setup HDMA for layer priority
	REP #$20
	LDA.w #$2C01
	STA $4360
	LDA.w #main_MainSubScreen
	STA $4362
	SEP #$20
	LDA.b #main_MainSubScreen>>16
	STA $4364
	LDA #$40
	TSB $0D9F|!addr
main:
;; Manage parallax addresses
	REP #$20
	LDA $1462|!addr
	LSR
	STA !FreeRAM
	LSR
	STA !FreeRAM+2
	LSR
	STA !FreeRAM+4
	LSR
	STA !FreeRAM+6
	LSR
	STA !FreeRAM+8
	LDA #$0000
	STA !FreeRAM+10
	SEP #$20
	RTL

.Layer2	%SetScanlines(95,10)	; Blank area above mountains
	%SetScanlines(48,6)	; Mountains
	%SetScanlines(32,2)	; Trees
	%SetScanlines(1,0)	; Cliffs
	db $00

.Layer3	%SetScanlines(39,10)	; Status bar
	%SetScanlines(48,10)	; Blank area above far mountains
	%SetScanlines(48,8)	; Far mountains
	%SetScanlines(1,4)	; Trees
	db $00

.MainSubScreen
;;    Scanlines  Main Screen     Sub Screen
	db 39 : db %00010100 : db %00000011	; Status bar
	db 97 : db %00010011 : db %00000100	; Mountains layer
	db 8  : db %00010101 : db %00000010	; Transition between layer 3 trees and layer 2 mountains
	db 1  : db %00010011 : db %00000100	; Layer 2 Trees & cliffs
	db $00