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


;0x249A84 blank spot
;0x2FE000 blank
;0x3CEC00 free spot thats actually inside code