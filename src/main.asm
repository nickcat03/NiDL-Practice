;;; Hijacks 

; This runs every frame
.org 0x08001130
	bl @hijack_every_frame

; This runs every gameplay frame
.org 0x08007692
	bl @hijack_every_gameplay_frame

.org 0x083CEC00
	@hijack_every_frame:
		; push pointer to jump back later
		push {lr}

		bl @every_frame

		; Jump back to controller code first
		bl 0x080011C0
		; Jump back to main game code, pop the pushed pointer
		pop {r0}
		bx r0

	@hijack_every_gameplay_frame:
		; push pointer to jump back later
		push {lr}

		bl @every_gameplay_frame

		; Jump back to controller code first
		bl 0x080401D4
		; Jump back to main game code, pop the pushed pointer
		pop {r0}
		bx r0
        


;;; Custom Code

@every_frame:
	bx lr


@every_gameplay_frame:
    ldr     r3,=#input_everyframe		; get controller input addr
    ldrh    r3,[r3]					; write controller input value to r3
    ldr     r4,=#KEY_R			; write select button value to r4
    and     r3, r4
    cmp     r3,#0x00				; if they equal 0 it means the button isn't being pressed
    bne     @@freeze
    bx lr
    @@freeze:
        push {lr}
        ;bl 0x08066A38
        bl 0x080774B0	; freeze everything
        mov r5, #0x02   ; reset room (for some reason writing to r5 here causes a room reset, conveniently)
        pop r0
        bx r0
    @@unfreeze:
        push{lr}
        bl 0x08066A60	; unfreeze everything
        pop r0 
        bx r0





; Leave this last, this is the constant pool
.pool






; 2450 room number
; 217D ability

; 2793 freeze kirby
; 0800633A subroutine for freezing all enemies

;0x08007692 possibly a room reload function
;0x080B6F08 is more likely it(?)