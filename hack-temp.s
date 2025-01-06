# 0 "hack.s"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "hack.s"


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
  .incbin "original.gba", (. - start), (\address - baseaddress - (. - start))
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


@@@@@@@@@@@@@@@@@@@@@@@
@ HIJACKS
@@@@@@@@@@@@@@@@@@@@@@@


@@@@@@@@@@@@@@@@@@@@@@@
@ CODE
@@@@@@@@@@@@@@@@@@@@@@@


@@@@@@@@@@@@@@@@@@@@@@@
@ NOTES
@@@@@@@@@@@@@@@@@@@@@@@
