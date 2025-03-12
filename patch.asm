; This script uses armips: https://github.com/Kingcom/armips

.gba
.include "src/defines.asm"
.open "original.gba", "NiDL-Practice.gba", 0x08000000
.include "src/hex_edits.asm"
.include "src/main.asm"
;.include "src/metaknight-multiplayer.asm"
.close