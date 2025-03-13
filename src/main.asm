;custom code jump test
.org 0x08001130
	bl @test

.org 0x083CEC00
	@test:
		; dont touch this
		push {lr}
		; custom code:

		bl @run_code

		; Jump back to controller code first
		bl 0x080011C0
		; Jump back to main game code
		pop {r0}
		bx r0


@run_code:
	ldr     r3,=#input_everyframe		; get controller input addr
    ldrh    r3,[r3]					; write controller input value to r3
    ldr     r5,=#KEY_SELECT			; write select button value to r5
    ;and     r3,r5					; do AND to see if they equal 0
    cmp     r3,#0x04				; if they equal 0 it means the button isn't being pressed
    beq     @@freeze
	ldr 	r5,=#KEY_B
	;and	 	r3, r5 
	cmp 	r3,#0x02
	beq 	@@unfreeze
	bx lr
@@freeze:
	push {lr}
	;bl 0x08066A38
	bl 0x080774B0	; freeze everything
	pop r0
	bx r0
@@unfreeze:
	push{lr}
	bl 0x08066A60	; unfreeze everything
	pop r0 
	bx r0




.pool


; 2450 room number
; 217D ability

; 2793 freeze kirby
; 0800633A subroutine for freezing all enemies