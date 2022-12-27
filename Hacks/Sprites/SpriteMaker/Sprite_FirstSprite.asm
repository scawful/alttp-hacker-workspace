;----------------------------------------------------------------------------------------------------------------------------------
;Sprites Variables, X is the sprite ID - All informations come from the Zelda_3_Ram.log file
;----------------------------------------------------------------------------------------------------------------------------------
;$0B58, X ; Timers for stunned enemies. Counts down from 0xFF.

;$0B6B, X ; Multiples Bits Data [ttttacbp]
;t - 'Tile Interaction Hit Box', a, c, b - 'Dies like a boss', p - Sprite ignores falling into a pit when frozen?

;$0B89, X ; Object priority stuff for sprites?

;$0BA0, X ; Seems to indicate that it ignores all projectile interactions if set.

;$0BB0, X ; For sprites that interact with speical objects, the special object will identify its type to the sprite via this location.

;$0BE0, X ; [iwbspppp]
;i - If set, disable tile interactions for the sprite, such as falling into holes, moving floors, and conveyor belts
;w - set if in water whether that's deep water or shallow water
;b - If set, the sprite can be blocked by a shield
;s - If set, play the 'enemy taking damage' sound effect. Otherwise, play the basic 'sprite getting hit' sound effect
;p - Prize pack to grant

;$0C9A, X ; Room or Area number that the sprite has been loaded to. (If in a dungeon, only contains the lower byte)

;$0CAA, X ; Multiples Bits Data [abcdefgh]
;a - If set... creates some condition where it may or may not die
;b - Same as bit 'a' in some contexts (Zora in particular)
;c - While this is set and unset in a lot of places for various sprites, its
;    status doesn't appear to ever be queried. Based on the pattern of its
;	 usage, however, the best deduction I can make is that this was a flag
;	 intended to signal that a sprite is an interactive object that Link can
;	 push against, pull on, or otherwise exerts a physical presence.
;	 In general, it might have indicated some kind of A button (action
;	 button) affinity for the sprite, but I think this is merely informative
;	 rather than something relevant to gameplay.
;d - If hit from front, deflect Ice Rod, Somarian missile,
;	 boomerang, hookshot, and sword beam, and arrows stick in
;	 it harmlessly.  If bit 1 is also set, frontal arrows will
;	 instead disappear harmlessly.  No monsters have bit 4 set
;	 in the ROM data, but it was functional and interesting
;	 enough to include.
;e - If set, makes the sprite collide with less tiles than usual
;f - If set, makes sprite impervious to sword and hammer type attacks
;g - ???? Seems to make sprite impervious to arrows, but may have other additional meanings.
;h - disabled???

;$0CBA, X ; Sprite drop when he die:
;0x00: nothing happens. / 0x01: leaves a normal key. / 0x03: single green rupee. / anything else: Big Key

;$0CD2, X ; Bump damage the sprite can inflict on the player.

;$0CE2, X ; When the sprite is hit, this is written to with the amount of damage to subtract from the sprite's HP.

;$0CF2, X ; Damage type determiner

;$0D00, X ; The lower byte of a sprite's Y - coordinate.

;$0D10, X ; The lower byte of a sprite's X - coordinate.

;$0D20, X ; The high byte of a sprite's Y - coordinate.

;$0D30, X ; The high byte of a sprite's X - coordinate.

;$0D40, X ; Y velocity

;$0D50, X ; X velocity

;$0D60, X ; Y "second derivative" to give a path a more rounded shape when needed.

;$0D70, X ; X "second derivative" to give a path a more rounded shape when needed.

;$0D80, X ; Controls whether the sprite has been spawned yet. 0 - no. Not 0 - yes. Also used as an AI pointer

;$0D90, X ; In some creatures, used as an index for determining $0DC0 *Unused by sprite Test can be used for anything*

;$0DA0, X ; usage varies considerably for each sprite type **USED by the sprite Test to intialize the sprite**

;$0DB0, X ; Various usages *Unused by sprite Test can be used for anything*

;$0DC0, X ; Designate which graphic to use.

;$0DD0, X ; Sprite State:
;0x00 - Sprite is dead, totally inactive
;0x01 - Sprite falling into a pit with generic animation.
;0x02 - Sprite transforms into a puff of smoke, often producing an item
;0x03 - Sprite falling into deep water (optionally making a fish jump up?)
;0x04 - Death Mode for Bosses (lots of explosions).
;0x05 - Sprite falling into a pit that has a special animation (e.g. Soldier)
;0x06 - Death Mode for normal creatures.
;0x08 - Sprite is being spawned at load time. An initialization routine will
;       be run for one frame, and then move on to the active state (0x09) the very next frame.
;0x09 - Sprite is in the normal, active mode.
;0x0A - Sprite is being carried by the player.
;0x0B - Sprite is frozen and / or stunned.

;$0DE0, X ; Sprite Directions *Unused by sprite Test can be used for anything*

;$0DF0, X ; Main delay timer [decreased every frames from sprites routine until it reach 0]

;$0E00, X ; Main Delay Timer 1 [decreased every frames from sprites routine until it reach 0]

;$0E10, X ; Main Delay Timer 2 [decreased every frames from sprites routine until it reach 0]

;$0E20, X ; ID of the sprite that control which sprite type the sprite is

;$0E30, X ; Subtype designation 1?

;$0E40, X ; Bits 0-4: If zero, the sprite is invisible. Otherwise, visible.

;$0E50, X ; Health of the sprite

;$0E60, X ; [niospppu]
;n - If set, don't draw extra death animation sprites over the sprite as it is expiring.
;i - if set, sprite is impervious to all attacks (also collisions?)
;o - If set, adjust coordinates of sprites spawned off of this one, such as water splashes. In general this would roughly approximate the
;    concept of 'width' of the sprite, and for this reason usually absorbable items like arrows, rupees, and heart refills utilize this.
;s - If set, draw a shadow for the sprite when doing OAM handling
;p - (Note: 3-bit) Palette into that actually is not used by this variable, but ends up getting copied to the array $0F50 (bitwise and with 0x0F).
;u - unused?

;$0E70, X ; Bit set When a sprite is moving and has hit a wall: ----udlr

;$0E80, X ; Subtype Designation 2?

;$0E90, X ; When a Pikit grabs something from you it gets stored here. *Unused by sprite Test can be used for anything*

;$0EA0, X ; When sprite is taking damage. palette cycling index 0x80 -  Signal that the recoil process has finished and will terminate

;$0EB0, X ; For sprites that have a head set the direction of the head *Unused by sprite Test can be used for anything*

;$0EC0, X ; Animation Clock? *Unused by sprite Test can be used for anything*

;$0ED0, X ; ??? *Unused by sprite Test can be used for anything*

;$0EE0, X ; Auxiliary Delay Timer 3 [decreased every frames from sprites routine until it reach 0]

;$0EF0, X ; Death Timer [abbbbbbb]
;a - start death timer?
;b - death timer?

;$0F00, X ; Pause button for sprites apparently. If nonzero they don't do anything.

;$0F10, X ; Auxiliary Delay Timer 4 [decreased every frames from sprites routine until it reach 0]

;$0F20, X ; Floor the sprite stand on

;$0F30, X ; Recoiling Y Velocity when sprite being hit

;$0F40, X ; Recoiling X Velocity when sprite being hit

;$0F50, X ; OAM Related - [vhoopppN]
;v - vflip
;h - hflip
;o - priority
;p - palette
;N - name table

;$0F60, X ; [isphhhhh]
;i - Ignore collision settings and always check tile interaction on the same layer that the sprite is on.
;s - 'Statis'. If set, indicates that the sprite should not be considered as "alive" in routines that try
; 	 to check that property. Functionally, the sprites might not actually be considered to be in statis though.
;	 Example: Bubbles (aka Fire Faeries) are not considered alive for the purposes of puzzles, because it's
;	 not expected that you always have the resources to kill them. Thus, they always have this bit set.
;p - 'Persist' If set, keeps the sprite from being deactivated from being too far offscreen from the camera.
;	 The sprite will continue to move and interact with the game map and other sprites that are also active.
;h - 5-bit value selecting the sprite's hit box dimensions and perhaps other related parameters.

;$0F70, X ; Height value (how far the enemy is from its shadow)

;$0F80, X ; Height Velocity for jump/fall if sprite_move_z is used else can be used for anything

;$0F90, X ; Subpixel portion of altitude.

;$0FC7, X ; Affects something to do with prizes...?

;----------------------------------------------------------------------------------------------------------------------------------
;Timers - all these variables decrease by 1 every frame automically - very useful for sprite making ;)
;----------------------------------------------------------------------------------------------------------------------------------
;timer1[$0E00, X]
;timer2[$0E10, X]
;timer3[$0EE0, X]
;timer4[$0DF0, X]
;timer5[$0F10, X]
;----------------------------------------------------------------------------------------------------------------------------------
;==================================================================================================================================
;Sprite_Main
;----------------------------------------------------------------------------------------------------------------------------------
;The core of the sprite that is executing all the subfunctions
;==================================================================================================================================
Sprite_FirstSprite_Main: ; LONG
{
	PHB : PHK : PLB ;We get the new working bank since we made a long jump
	    JSR Sprite_FirstSprite_JumpTable
	PLB
	RTL
}

Sprite_FirstSprite_JumpTable: 
{
    JSR Sprite_FirstSprite_Draw
	;Check if the sprite is active, if not (for example pause menu or transition) we skip the next code
	LDA $0D80, X ; Jump Table Index
    ;Here is the main code of the sprite we use a jump table for simplicity so we can make our sprite do different action easily
	JSL UseImplicitRegIndexedLocalJumpTable
	dw Sprite_FirstSprite_Create ;0
	dw Sprite_FirstSprite_Update ;1
}

Sprite_FirstSprite_Create: ;Index 0
{
    LDA #$00 : STA $0F50, X ;Set Palette / Mirroring Stuff
    INC $0D80, X ;We increase Jump Table Index so that Create code won't be called again
	RTS
}

Sprite_FirstSprite_Update: ;Index 1 - Main Loop
{
	
	LDY #$00 ;set Y to 00 otherwise it will load Y + A to go higher than FF we don't want that
	JSL GetRandomInt ; Load in Accumulator a random value from 00 to FF
	JSL Sprite_ShowMessageFromPlayerContact ;show message when we touch the sprite
	RTS
}

Sprite_FirstSprite_Draw: ;Main Draw Code (Complicated Part), you can find a draw code generator in my tools ;)
{
	JSL Sprite_PrepOamCoord
	LDA #$10 : STA $7EF343
	STZ $06
	LDY.b #$00
	PHX
	
	;number of tile readed in the array to draw - 1
	LDX.b #$01
	
	.next_subsprite ;Loop through all tiles
	
	PHX
	
	TXA : !ADD $06 : PHA : ASL A : TAX

	REP #$20
	
	;Set tiles positions
	LDA $00 : !ADD .x_offsets, X : STA ($90), Y
	
	AND.w #$0100 : STA $0E
	
	LDA $02 : !ADD .y_offsets, X : INY : STA ($90), Y
	
	!ADD #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
	
	LDA.b #$F0 : STA ($90), Y
	
	.on_screen_y
	PLX
	
	;Set tiles Properties, id
	LDA .chr, X : INY : STA ($90), Y
	
	LDA .properties, X : ORA $05 : INY : STA ($90), Y
	
	PHY
	
	TYA : LSR #2 : TAY
	
	LDA .sizes, X : ORA $0F : STA ($92), Y
	
	PLY : INY
	
	PLX : DEX : BPL .next_subsprite
	
	PLX
	RTS
	
		.x_offsets
		dw 0
		.y_offsets
		dw 0
		.chr
		db $00
		.properties
		db $02
		.sizes
		db $02
}
