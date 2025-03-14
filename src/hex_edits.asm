; Always allow level exit (doesn't work for boss fights)
.org 0x080083EE
	cmp r0, #0xFF
; Adding boss exit could be possible, but forcing it in the pause menu causes your respawn to go OoB and it's a softlock (see RAM 0x02007D60)

; Never lose lives
.org 0x08009A9A
    add r2, r2, #0

; Lives set to 99 (this makes no difference it's just cosmetic)
.org 0x0800B13A
	mov r0, #0x63

; Always have boss rush and meta knightmare
.org 0x0800C766
	and r0, r0

; Battle boss fight if L is held while entering door
.org 0x08024D54	; see if L is being held
	cmp r2, #0x02
.org 0x08024D94	; change address being read to controller inputs
	.word 0x03002441
	.word 0x03002441

; this code might be problematic (stops multiplayer)
; Switches always respawn
.org 0x080B497A
    cmp r0, r0

; this code might be problematic (stops multiplayer)
; Skip goal games
.org 0x08025374
    cmp r0, #0xFF


;; All of the below code is for handling all doors unlocked
; Activate the Star rooms unlocked automatically (mark the levels associated with them as cleared)
.org 0x080225E0
    mov r0, #0x02

; Activate all unlockable Star rooms (mark the star room switches as cleared)
.org 0x08022590
	cmp r0, #0xFF

; Keep walls cleared after a level clear
.org 0x0802781A
	mov r0, #0x02

; bonus doors (idk what this did so im leaving it commented)
;.org 0x08027898
;    nop : nop

; for some reason this code will sometimes de-activate bonus doors?
;.org 0x08027946
;	mov r0, #0xFF

; Destroy all walls in overworlds
.org 0x08027964
    mov r0, #0x02

; Destroy all bonus door walls
.org 0x08027966
	cmp r0, #0xFF

; Make bonus doors visible
.org 0x0802802C
    mov r0, #0x02
	cmp r0, #0xFF

; Make stage doors visible
.org 0x08028086
	mov r0, #0x08

; Make all stages set to cleared
;.org 0x080280A2
;    mov r0, #0x02


