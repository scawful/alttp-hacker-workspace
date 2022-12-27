; 
; Credit to Zarby89 
; 

lorom

!End = $00
!Rest = $C9
!Tie = $C8

macro SetChannelVolume(v)
db $ED, v
endmacro

macro SetMasterVolume(v)
db $E5, v
endmacro

macro SetTempo(v)
db $E7, v
endmacro

macro SetInstrument(v)
db $E0, v
endmacro

macro CallSubroutine(addr, repeat)
db $EF
dw addr
db repeat
endmacro

org $1A9FF8 ; Hyrule Castle (Song Header information)
Sections: 
!ARAMAddr = $D0FF
!StartingAddr = Sections
dw !ARAMAddr+$0A
dw !ARAMAddr+$0A
dw $00FF
dw !ARAMAddr
dw $0000

Channels: 
!ARAMC = !ARAMAddr-Sections
dw Channel0+!ARAMC
dw $0000
dw $0000
dw $0000
dw $0000
dw $0000
dw $0000
dw $0000


Channel0:
SetMasterVolume($80)
SetTempo($40)
SetInstrument($17)

db !Rest, !Rest, !Rest

db !End