#define FILE_TO_PATCH "original.gba"

.text
start:
baseaddress = 0x08000000
.global _start
_start = baseaddress

@@@@@@@@@@@@@@@@@@@@@@@
@ MACROS
@@@@@@@@@@@@@@@@@@@@@@@

.macro patchat address
		@copy bytes in file from current address to specified address
		.incbin FILE_TO_PATCH, (. - start), (\address - baseaddress - (. - start))
.endm

.macro load32 rx, value
		eor \rx, \rx, \rx
		add \rx, \rx, #((\value / 0x1000000) & 0xFF)
		lsl \rx, \rx, #8
		add \rx, \rx, #((\value / 0x10000) & 0xFF)
		lsl \rx, \rx, #8
		add \rx, \rx, #((\value / 0x100) & 0xFF)
		lsl \rx, \rx, #8
		add \rx, \rx, #(\value & 0xFF)
.endm

.thumb

@@@@@@@@@@@@@@@@@@@@@@@
@ HEX EDITS
@@@@@@@@@@@@@@@@@@@@@@@

@ Never lose lives
patchat 0x08009A9A
    add r2, r2, #0

@ Bonus doors (this also puts all stars in star hub room)
patchat 0x08022590
	cmp r0, #0xFF

@ Always have levels unlocked
@ Level doors
patchat 0x080225E0
    mov r0, #0x02

patchat 0x0802781A
	mov r0, #0x02

@ bonus doors
patchat 0x08027898
    nop
	nop

patchat 0x08027946
	mov r0, #0xFF

patchat 0x08027964
    mov r0, #0x02

patchat 0x0802802C
     mov r0, #0x02
	 cmp r0, #0xFF
	
patchat 0x080280A2
    mov r0, #0x02

@ Leave this last
patchat 0x08800000


@0x249A84 blank spot
@0x2FE000 blank
@0x3CEC00 free spot thats actually inside code

@@@@@@@@@@@@@@@@@@@@@@@
@ HIJACKS
@@@@@@@@@@@@@@@@@@@@@@@

	
@@@@@@@@@@@@@@@@@@@@@@@
@ CODE
@@@@@@@@@@@@@@@@@@@@@@@


@@@@@@@@@@@@@@@@@@@@@@@
@ NOTES
@@@@@@@@@@@@@@@@@@@@@@@