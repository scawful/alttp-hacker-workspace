

;Sprite_CheckIfLinkFaceAndA
;return A = 1 if A button is pressed and collide with sprite
    Sprite_CheckIfLinkFaceAndA:
    {
        LDA $11 : ORA $3C : ORA $0FC1 : BNE .return
        
        LDA $EE : CMP $0F20, X : BNE .return

    .next_sprite
    
        ; See if any enemies are in Link's hands
        ; yes, an enemy is being held
        LDA $0DD0, X : CMP.b #$0A : BEQ .return
        
        DEY : BPL .next_sprite

        LDA $0372 : BNE .return

        ; Set up player's hit box.
        JSR lift_ext
        JSL SetupHitBox
        
        JSL CheckIfHitBoxesOverlap : BCC .return
        LDA $F6 : AND #$80 : BEQ .return
			LDA #$01
			STZ $F6
			BRA .return2
        
        
		.return
		LDA #$00
		.return2
        RTL
    }
;=================================================================

	Sprite_CheckIfLifted:
    {
		LDA $11 : ORA $3C : ORA $0FC1 : BNE .return
	
		LDA $EE : CMP $0F20, X : BNE .return
		
		.next_sprite
    
        ; See if any enemies are in Link's hands
        ; yes, an enemy is being held
        LDA $0DD0, X : CMP.b #$0A : BEQ .return
        
        DEY : BPL .next_sprite
	;Alternate Entry point that let you lift anything that is not chicken or bomb
        LDA $0372 : BNE .return
        
        ; check if the current sprite is the same one Link is touching.
        LDA $02F4 : DEC A : CMP $0FA0 : BEQ .player_picks_up_sprite
        
        ; Set up player's hit box.
        ; $37705 IN ROM
		
        JSR lift_ext
        JSL SetupHitBox
        
        JSL CheckIfHitBoxesOverlap : BCC .return
        
        TXA : INC A : STA $0314
                      STA $0FB2
        
        RTL
    
    .player_picks_up_sprite
    
        STZ $F6
        
        STZ $0E90, X
        
        ; Play pick up object sound.
        LDA.b #$1D : JSL Sound_SetSfx2PanLong
        
        LDA $0DD0, X : STA $7FFA2C, X
		
        ;LDA.b #$10 : STA $0F70, X
		
        LDA.b #$0A : STA $0DD0, X
        LDA.b #$10 : STA $0DF0, X
        
        LDA.b #$00 : STA $7FFA1C, X : STA $7FF9C2, X
        
        ;JSL Sprite_DirectionToFacePlayer
        
        ;LDA $F139, Y : STA $2F
		PLA : PLA : PLA : PLA : PLA
    .return
    
        RTL
    }
	
	lift_ext:
	    {
        LDA $037B : BNE .no_player_interaction_with_sprites
    
    ; *$3770A ALTERNATE ENTRY POINT
    
        LDA.b #$08 : STA $02
                     STA $03
        
        LDA $22 : !ADD #$04 : STA $00
        LDA $23 : ADC.b #$00 : STA $08
        
        LDA $20 : ADC.b #$08 : STA $01
        LDA $21 : ADC.b #$00 : STA $09
        
        RTS
    
    .no_player_interaction_with_sprites
    
        ; \wtf Kind of .... lazy if you ask me. This ensures that the player hit
        ; box is so out of range of whatever we're going to compare with so that
        ; the hit boxes can't possibly overlap.
        ; (with a Y coordinate of 0x8000 to 0x80ff, it's highly unlikely).
        LDA.b #$80 : STA $09
        
        RTS
    }


;=================================================================
;Sprite_MoveHoriz LONG
;make the sprite move X axis
Sprite_MoveHoriz:
{
	TXA : !ADD #$10 : TAX
	
	JSL Sprite_MoveVert
	
	LDX $0FA0
	
	RTL
}

;=================================================================
;Sprite_MoveVert LONG
;make the sprite move Y axis
Sprite_MoveVert:
{
	LDA $0D40, X : BEQ .no_velocity
	
	ASL #4 : !ADD $0D60, X : STA $0D60, X
	
	LDA $0D40, X : PHP : LSR #4 : LDY.b #$00 : PLP : BPL .positive
	
	ORA.b #$F0
	
	DEY

.positive

		  ADC $0D00, X : STA $0D00, X
	TYA : ADC $0D20, X : STA $0D20, X

.no_velocity

	RTL
}

;=================================================================
;Sprite_MoveAltitude LONG
;make the sprite move Z axis (height)
 Sprite_MoveAltitude:
{
	LDA $0F80, X : ASL #4 : !ADD $0F90, X : STA $0F90, X
	
	LDA $0F80, X : PHP : LSR #4 : PLP : BPL .positive
	
	ORA.b #$F0

.positive

	ADC $0F70, X : STA $0F70, X
	
	RTL
}



;=================================================================
;Sprite_Move LONG
;make the sprite move both direction (do not include the height)
Sprite_Move:
{
	JSL Sprite_MoveVert
	JSL Sprite_MoveHoriz
	
	RTL
}

;=================================================================
;Sprite_MoveXyz LONG
;make the sprite move both direction (include height)
Sprite_MoveXyz:
{
	JSL Sprite_MoveAltitude
	JSL Sprite_MoveHoriz
	JSL Sprite_MoveVert
	
	RTL
}

;=================================================================
;Sprite_BounceTowardPlayer LONG
;make the sprite bounce toward player (like vitreous)
;Movement, Collision are handled by this function (height:20 = vitreous)
;$09 = speed, $08 = max height 
Sprite_Bouncetowardplayer:
{

	JSL Sprite_MoveAltitude
	
	DEC $0F80, X : DEC $0F80, X
	
	LDA $0F70, X : BPL .aloft
	
	STZ $0F70, X
	
	LDA $08 : STA $0F80, X ; set height from 08
	
	LDA $09 
	
	JSL Sprite_ApplySpeedTowardsPlayer
	
	LDA.b #$21 : JSL Sound_SetSfx2PanLong
	
	.aloft
	LDA $0F70, X : BEQ .dontmove
		JSL Sprite_Move
	.dontmove
	RTL
}

;=================================================================
;Sprite_CheckIfActive LONG
;check if sprite is active, if we are not in the menu
;Should be called right after the Draw
Sprite_CheckIfActive:
{
	LDA $0DD0, X : CMP.b #$09 : BNE .inactive

	LDA $0FC1 : BNE .inactive
	
	LDA $11 : BNE .inactive
	
	LDA $0CAA, X : BMI .active
	
	LDA $0F00, X : BEQ .active
	
.inactive

	PLA : PLA : PLA ;Remove one RTL to jump back in main and ignore this sprite

.active

	RTL
	
}


;=================================================================
;Sprite_CheckIfRecoiling
;check if the sprite is currently recoiling
    Sprite_CheckIfRecoiling:
    {
        LDA $0EA0, X : BEQ .return
        AND.b #$7F   : BEQ .recoil_finished
        
        LDA $0D40, X : PHA
        LDA $0D50, X : PHA
        
        DEC $0EA0, X : BNE .not_halted_yet
        
        LDA $0F40, X : !ADD #$20 : CMP.b #$40 : BCS .too_fast_so_halt
        
        LDA $0F30, X : !ADD #$20 : CMP.b #$40 : BCC .slow_enough
    
    .too_fast_so_halt
    
        LDA.b #$90 : STA $0EA0, X
    
    .slow_enough
    .not_halted_yet
    
        LDA $0EA0, X : BMI .halted
        
        LSR #2 : TAY
        
        ;LDA $1A : AND $E8BF, Y : BNE .halted
        
        LDA $0F30, X : STA $0D40, X
        LDA $0F40, X : STA $0D50, X
        
        LDA $0CD2, X : BMI .no_wall_collision
        
        JSL Sprite_CheckTileCollision
        
        AND.b #$0F : BEQ .no_wall_collision
        CMP.b #$04 : BCS .y_axis_wall_collision
        
        STZ $0F40, X
        STZ $0D50, X
        
        BRA .moving_on
    
    .y_axis_wall_collision
    
        STZ $0F30, X
        STZ $0D40, X
    
    .moving_on
    
        BRA .halted
    
    .no_wall_collision
    
        JSL Sprite_Move
    
    .halted
    
        PLA : STA $0D50, X
        PLA : STA $0D40, X
        
        PLA : PLA : PLA : PLA : PLA
    
    .return
    
        RTL
    
    .recoil_finished
    
        STZ $0EA0, X
        
        RTL
    }
	;=================================================================
	;Draw a 16x16 sprite LONG
	;-----------------------------------------------------------------
	;$06 = start tile index
	;A = 0 or 1 (graphic block used)
	;$0DC0, X = index + $06
	;-----------------------------------------------------------------
	Sprite_DrawSingle16:
    {
		
		;PHX ; Save the sprite ID
		REP #$20

		LDA $00 : STA ($90), Y ; set oam X position
		
		AND.w #$0100 : STA $0E ; oam thing (?)

		LDA $02 : INY : STA ($90), Y ; set oam Y position

		!ADD #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y ; check if Y is on screen

		LDA.b #$F0 : STA ($90), Y ;if Y is not on screen then draw it outside of the room?
	  
	    LDA $0E60, X : AND.b #$10 : BNE .Sprite_DrawShadowX
        
        RTL
		
		.Sprite_DrawShadowX
		JSL Sprite_DrawShadow
		RTL
	  
	.on_screen_y
		LDA $0DC0, X : ASL : !ADD $06 : INY : STA ($90), Y ; oam thing (tile index used)

		LDA $07 : ORA $05 : INY : STA ($90), Y ; oam thing (mirror/palette?)

		TYA : LSR #2 : TAY ; set Y on size for the next line

		LDA #$02 : ORA $0F : STA ($92), Y ; Size (set on 16x16)

		RTL
		
		
	}
	
	

	
	Sprite_Math:
	{
	.cosine
	db 0, 1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1
	
	}
	
	Sprite_CrystalSwitchCollisionTile:
	{
		JSL Sprite_CheckDamageToPlayerSameLayer : BCC .no_player_collision
		
		JSL Sprite_NullifyHookshotDrag
		
		STZ $5E
		
		JSL Player_HaltDashAttack
		
		.no_player_collision
		JSL Sprite_CheckTileCollision
		
		RTL
	}
	
	
	NewSomariaPlatform:
	{
	
	
	LDA $0EC0, X : BEQ .platform_is_spawning
		LDA $0B7C : ORA $0B7D : ORA $0B7E : ORA $0B7F
		RTL
	.platform_is_spawning
	LDA #$FF : STA $0EC0, X
	
	RTL
	}
	

