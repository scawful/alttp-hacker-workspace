lorom

org $00FFD7 ; Set rom on 16mb
db #$0B

org $3FFFFF ; write at the last position to expand on 2mb
db #$00

incsrc Sprite_Functions_Hooks.asm

    org $05BCA2
        JSL Sprite_FirstSprite_Main
    RTS

org $24A000 ;This will need to be changed maybe
incsrc Sprite_Functions_New.asm
incsrc Sprite_FirstSprite.asm ;Replace this with your sprite name file