;custom code jump test
.org 0x08001130
	bl @test

.org 0x083CEC00
	@test:
		; dont touch this
		push {lr}
		; custom code:



		; Jump back to controller code first
		bl 0x080011C0
		; Jump back to main game code
		pop {r0}
		bx r0
		.pool

; Never lose lives
.org 0x08009A9A
    add r2, r2, #0