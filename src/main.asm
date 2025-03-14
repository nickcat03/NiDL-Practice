;;; Hijacks 

; This runs every frame
.org 0x08001130
	bl @hijack_every_frame

; This runs every gameplay frame
; (There are two because one is for the world lobby, one is for in levels)
.org 0x08007692
	bl @hijack_every_gameplay_frame
.org 0x0800737C
	bl @hijack_every_gameplay_frame

.org 0x083CEC00
	@hijack_every_frame:
		; push pointer to jump back later
		push {r2-r5,lr}

		bl @every_frame

		; Jump back to controller code first
		bl 0x080011C0
		; Jump back to main game code, pop the pushed pointer
		pop {r2-r5}
		pop {r0}
		bx r0

	@hijack_every_gameplay_frame:
		; push pointer to jump back later
		push {r2-r4,lr}

		bl @every_gameplay_frame

		; Jump back to controller code first
		bl 0x080401D4
		; Jump back to main game code, pop the pushed pointer
		pop {r2-r4}
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

/*
@every_gameplay_frame:
	push {lr}
	bl @@ability_select

	pop r0
	bx r0

	@@ability_select:
		ldr r3, =#ability_select_toggle
		ldrh r3, [r3]
		cmp r3, #0x01
		bne @@check_input
		push {lr}
		bl @@while_selecting_ability
		pop r0 
		bx r0

	@@check_input:
		ldr     r3,=#input_everyframe		; get controller input addr
		ldrh    r3,[r3]					; write controller input value to r3
		ldr     r4,=#KEY_R			; write select button value to r4
		and     r3, r4
		cmp     r3,#0x00				; if they equal 0 it means the button isn't being pressed
		bne     @@freeze
		bx lr

		@@enable_ability_select:
			push {lr}

			; freeze everything
			;bl 0x080774B0	

			; bring up ability portrait
			mov r0, #0x02
			ldr r1, =#raise_ability_HUD
			strb r0, [r1]

			; dim screen
			mov r0, #0x04
			ldr r1, =#0xFFFE
			ldr r2, =#0x0873F440
			bl 0x080008CC

			; set ability select to on
			mov r0, #0x01
			ldr r1, =#ability_select_toggle
			strb r0, [r1]

			pop r0
			bx r0

	@@while_selecting_ability:
		push {lr}

		; Keep ability HUD on screen
		ldr r0, =#0x00B4
		ldr r1, =#ability_HUD_timer
		strh r0, [r1]

		; get current ability
		ldr r1, =#ability
		mov r0, #0x01
		strb r0, [r1]

		mov r1, r0
		
		; run code to give ability
		mov r2, #0x00
		bl 0x08009BF4
		;BL 0x08047D72
		;bl 0x0803F930

		; set ability select to off
		mov r0, #0x00
		ldr r1, =#ability_select_toggle
		strb r0, [r1]

		pop r0 
		bx r0
*/



; Leave this last, this is the constant pool
.pool



; 2450 room number
; 217D ability

; 2793 freeze kirby
; 0800633A subroutine for freezing all enemies

;0x08007692 possibly a room reload function
;0x080B6F08 is more likely it(?)

;Mix roulette code:
; 0x08005066: triggers when kirby is doing anything except standing
; 0x020061D4 is responsible for bringing the ability HUD up (setting it to 2)
; 0x0200801C is the timer for the ability HUD (starts at 0xB400)