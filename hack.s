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

patchat 0x08009A9A
    add r2, r2, #0

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