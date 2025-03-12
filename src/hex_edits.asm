; Always allow level exit (doesn't work for boss fights)
.org 0x080083EE
	cmp r0, #0xFF

; Never lose lives
.org 0x08009A9A
    add r2, r2, #0

; Always have boss rush and meta knightmare
.org 0x0800C766
	and r0, r0

; Battle boss fight if L is held while entering door
.org 0x08024D54	; see if L is being held
	cmp r2, #0x02
.org 0x08024D94	; change address being read to controller inputs
	.word 0x03002441
	.word 0x03002441

; Switches always respawn
;.org 0x080B497A
;    cmp r0, r0

; Skip goal games
;.org 0x08025374
;    cmp r0, #0xFF


;; All of the below code is for handling all doors unlocked
; Bonus doors (this also puts all stars in star hub room)
.org 0x08022590
	cmp r0, #0xFF

; Level doors
.org 0x080225E0
    mov r0, #0x02

.org 0x0802781A
	mov r0, #0x02

; bonus doors
.org 0x08027898
    nop
	nop

.org 0x08027946
	mov r0, #0xFF

.org 0x08027964
    mov r0, #0x02

.org 0x0802802C
    mov r0, #0x02
	cmp r0, #0xFF

; always make doors appear
.org 0x08028086
	mov r0, #0x08
	
.org 0x080280A2
    mov r0, #0x02



;0x0800124E runs every frame
;0x08040202 runs every gameplay frame

;0x0249A84 blank spot
;0x02FE000 blank
;0x083CEC00 free spot thats actually inside code


;0x08032754 state updater?

; this code was when i was screwing with trying to get mknightmare multiplayer working
; lol
;.org 0x0800C2B6
;    mov r1, #0x01
;	nop
;	nop
;.org 0x0800C2C4
;	STRB #0x01, [R0, #0x00]
;.org 0x0800C2C0
;	mov r1, #0x01
