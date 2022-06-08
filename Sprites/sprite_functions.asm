;=================================================================
;  Sprite Functions Hooks Library
;=================================================================

lorom

!ADD = "CLC : ADC"
!SUB = "SEC : SBC"
!BLT = "BCC"
!BGE = "BCS"

;=================================================================
; List of all functions of the sprites, all functions are LONG
;
; UseImplicitRegIndexedLocalJumpTable
; SetSpawnedCoords
; PrepOamCoord
; CheckDamageFromPlayer
; CheckDamageToPlayer
; AttemptDamageToPlayerPlusRecoil
; OAM_AllocateDeferToPlayer
; ApplyRumbleToSprites
; CheckIfHitBoxesOverlap
; Sprite_Get_16_bit_Coords
; PrepAndDrawSingleLarge
; PrepAndDrawSingleSmall
; DrawShadow
; CheckTileCollision
; GetTileAttr
; CheckSlopedTileCollision
; ApplySpeedTowardsPlayer
; DirectionToFacePlayer
; IsToRightOfPlayer
; IsBelowPlayer
; CheckDamageToPlayerSameLayer
; CheckDamageToPlayerIgnoreLayer
; Sound_SetSfx2PanLong
; SpawnDynamically
; ResetState
; ApplyConveyorAdjustment
; SetupHitBox
; Link_ReceiveItem
; ShowSolicitedMessageIfPlayerFacing
; ShowMessageFromPlayerContact
; PlayerCantPassThrough
; NullifyHookshotDrag
; CheckIfLifted
; MoveHoriz
; MoveVert
; MoveAltitude
; Move = (MoveHoriz, MoveVert)
; MoveXyz = (MoveHoriz, MoveVert, MoveAltitude)
; BouceTowardPlayer
;=================================================================



;=================================================================
; UseImplicitRegIndexedLocalJumpTable
org $008781
UseImplicitRegIndexedLocalJumpTable:


;=================================================================
; Sprite_SetSpawnedCoords
org $09AE64
Sprite_SetSpawnedCoords:


;=================================================================
; Sprite_PrepOamCoord LONG
; set the oam coordinate for the sprite draw
org $06E416
Sprite_PrepOamCoord:


;=================================================================
; Sprite_CheckDamageFromPlayer LONG
; check if the sprite is getting damage from player or items
org $06F2AA
Sprite_CheckDamageFromPlayer:


;=================================================================
; Sprite_CheckDamageToPlayer LONG
; check if the sprite is touching the player to damage
org $06F121
Sprite_CheckDamageToPlayer:


;=================================================================
; Sprite_AttemptDamageToPlayerPlusRecoil LONG
; damage the player everywhere on screen?
org $06F41F
Sprite_AttemptDamageToPlayerPlusRecoil:


;=================================================================
; Sprite_OAM_AllocateDeferToPlayer LONG
; check if the player is close enough before drawing the sprite
; Draw the sprite depending of the position of the player (if he has to be over or under link)
org $06F864
Sprite_OAM_AllocateDeferToPlayer:

;------------------------------------------ 
org $0DBA80;JP VALID
OAM_AllocateFromRegionA:
org $0DBA84;JP VALID
OAM_AllocateFromRegionB:
org $0DBA88;JP VALID
OAM_AllocateFromRegionC:
org $0DBA8C;JP VALID
OAM_AllocateFromRegionD:
org $0DBA90;JP VALID
OAM_AllocateFromRegionE:
org $0DBA94;JP VALID
OAM_AllocateFromRegionF:

org $05DF70;JP VALID
Sprite_DrawMultiple_quantity_preset:
;------------------------------------------


;=================================================================
; ApplyRumbleToSprites LONG
; makes all the sprites on screen shaking
org $0680FA
ApplyRumbleToSprites:


;=================================================================
; CheckIfHitBoxesOverlap LONG
; args : 
; !pos1_low  = $00
; !pos1_size = $02
; !pos2_low  = $04
; !pos2_size = $06
; !pos1_high = $08
; !pos2_high = $0A
; !ans_low   = $0F
; !ans_high  = $0C
; returns carry clear if there was no overlap
org $0683E6
CheckIfHitBoxesOverlap:


;=================================================================
; Sprite_Get_16_bit_Coords LONG
; $0FD8 = sprite's X coordinate, $0FDA = sprite's Y coordinate
org $0684BD
Sprite_Get_16_bit_Coords:


;=================================================================
; Sprite_PrepAndDrawSingleLarge LONG
; load / draw a  16x16 sprite
org $06DBF0
Sprite_PrepAndDrawSingleLarge:


;=================================================================
; Sprite_PrepAndDrawSingleSmall LONG
; load / draw a  8x8 sprite
org $06DBF8
Sprite_PrepAndDrawSingleSmall:


;=================================================================
; Sprite_DrawShadow LONG
; draw shadow 
org $06DC54
Sprite_DrawShadow:


;=================================================================
; Sprite_CheckTileCollision LONG
; check if the sprite is colliding with a solid tile set $0E70, X
; ----udlr , u = up, d = down, l = left, r = right
org $06E496
Sprite_CheckTileCollision:


;=================================================================
; Sprite_GetTileAttr LONG
;  $00[0x02] - Entity Y coordinate
;  $02[0x03?] - Entity X coordinate
org $06E87B
Sprite_GetTileAttr:


;=================================================================
; Sprite_CheckSlopedTileCollision LONG
; check if the sprite is colliding with a solid sloped tile
org $06E8FD
Sprite_CheckSlopedTileCollision:


;=================================================================
; Sprite_ApplySpeedTowardsPlayer LONG
; set the velocity x,y towards the player (A = speed)
org $06EA12
Sprite_ApplySpeedTowardsPlayer:


;=================================================================
; Sprite_DirectionToFacePlayer LONG
;  \return       $0E is low byte of player_y_pos - sprite_y_pos
;  \return       $0F is low byte of player_x_pos - sprite_x_pos
org $06EAA0
Sprite_DirectionToFacePlayer:


;=================================================================
; Sprite_IsToRightOfPlayer LONG
; if Link is to the left of the sprite, Y = 1, otherwise Y = 0.
org $06EACD
Sprite_IsToRightOfPlayer:


;=================================================================
; Sprite_IsBelowPlayer LONG
; return Y=1 sprite is below player, otherwise Y = 0
org $06EAE4
Sprite_IsBelowPlayer:


;=================================================================
; Sprite_CheckDamageToPlayerSameLayer LONG
; check damage done to player if they collide and if they are on same layer
org $06F129
Sprite_CheckDamageToPlayerSameLayer:


;=================================================================
; Sprite_CheckDamageToPlayerIgnoreLayer LONG
; check damage done to player if they collide even if they are not on same layer
org $06F131
Sprite_CheckDamageToPlayerIgnoreLayer:


;=================================================================
; Sound_SetSfx2PanLong LONG
; play a sound loaded in A
org $0DBB7C
Sound_SetSfx2PanLong:


;=================================================================
; Sprite_SpawnDynamically LONG
; spawn a new sprite on screen, A = sprite id
; when using this function you have to set the position yourself
; these values belong to the sprite who used that function not the new one 
; $00 low x, $01 high x
; $02 low y, $03 high y
; $04 height, $05 low x (overlord)
; $06 high x (overlord), $07 low y (overlord)
; $08 high y (overlord)
org $1DF65D
Sprite_SpawnDynamically:


;=================================================================
; Player_ResetState LONG
; TODO(scawful): describe this
org $07F1A3 
Player_ResetState:


;=================================================================
; Sprite_ApplyConveyorAdjustment LONG
; move the sprite if he stand on a conveyor belt
org $1D8010
Sprite_ApplyConveyorAdjustment:


;=================================================================
; SetupHitBox LONG
; set the hitbox of sprite
org $0683EA
SetupHitBox:


;=================================================================
; Dungeon_SpriteInducedTilemapUpdate LONG
; set tile of dungeon
org $01E7A9
Dungeon_SpriteInducedTilemapUpdate:


;=================================================================
; Get rnadom INT LONG
; GetRandomInt
org $0DBA71
GetRandomInt:

;=================================================================
;Sprite_PlayerCantPassThrough
;player can't pass through the sprite
org $1EF4F3 ; 1EF4E7
Sprite_PlayerCantPassThrough:


;=================================================================
;Sprite_NullifyHookshotDrag
;player can't hookshot to that sprite
org $0FF540 ;1CF500
Sprite_NullifyHookshotDrag:


;=================================================================
;Player_HaltDashAttack
;stop the dash attack of the player
org $0791B9 ; 0791B3
Player_HaltDashAttack:


;=================================================================
;Sprite_ShowMessageUnconditional
;show a message box without any condition
; A = low byte of message ID to use.
; Y = high byte of message ID to use.
org $05E219
Sprite_ShowMessageUnconditional:

;=================================================================
; Link_ReceiveItem
; Y = item id
org $0799AD
Link_ReceiveItem:

;=================================================================
; Sprite_ShowSolicitedMessageIfPlayerFacing
; show a message if we press A and face the sprite
; A = low byte of message ID to use.
; Y = high byte of message ID to use.
org $05E1A7
Sprite_ShowSolicitedMessageIfPlayerFacing:

;=================================================================
; Sprite_ShowMessageFromPlayerContact
; show a message if we touch the sprite should be used with Sprite_PlayerCantPassThrough
; A = low byte of message ID to use.
; Y = high byte of message ID to use.
org $05E1F0
Sprite_ShowMessageFromPlayerContact:


;=================================================================
; Sprite_CheckIfLifted LONG
; allow being able to lift that sprite and throw it
org !jaddr

    Sprite_CheckIfLifted:
    {
		LDA $11 : ORA $3C : ORA $0FC1 : BNE .return
	
		LDA $EE : CMP $0F20, X : BNE .return
		
		.next_sprite
    
        ;  See if any enemies are in Link's hands
        ;  yes, an enemy is being held
        LDA $0DD0, X : CMP.b #$0A : BEQ .return
        
        DEY : BPL .next_sprite
	; Alternate Entry point that let you lift anything that is not chicken or bomb
        LDA $0372 : BNE .return
        
        ;  check if the current sprite is the same one Link is touching.
        LDA $02F4 : DEC A : CMP $0FA0 : BEQ .player_picks_up_sprite
        
        ;  Set up player's hit box.
        ;  $37705 IN ROM
		
        JSR lift_ext
        JSL SetupHitBox
        
        JSL CheckIfHitBoxesOverlap : BCC .return
        
        TXA : INC A : STA $0314
                      STA $0FB2
        
        RTL
    
    .player_picks_up_sprite
    
        STZ $F6
        
        STZ $0E90, X
        
        ;  Play pick up object sound.
        LDA.b #$1D : JSL Sound_SetSfx2PanLong
        
        LDA $0DD0, X : STA $7FFA2C, X
		
        ; LDA.b #$10 : STA $0F70, X
		
        LDA.b #$0A : STA $0DD0, X
        LDA.b #$10 : STA $0DF0, X
        
        LDA.b #$00 : STA $7FFA1C, X : STA $7FF9C2, X
        
        ; JSL Sprite_DirectionToFacePlayer
        
        ; LDA $F139, Y : STA $2F
		; PLA : PLA : PLA
    .return
    
        RTL
    }
	
	lift_ext:
	    {
        LDA $037B : BNE .no_player_interaction_with_sprites
    
    ;  *$3770A ALTERNATE ENTRY POINT
    
        LDA.b #$08 : STA $02
                     STA $03
        
        LDA $22 : !ADD #$04 : STA $00
        LDA $23 : ADC.b #$00 : STA $08
        
        LDA $20 : ADC.b #$08 : STA $01
        LDA $21 : ADC.b #$00 : STA $09
        
        RTS
    
    .no_player_interaction_with_sprites
    
        ;  \wtf Kind of .... lazy if you ask me. This ensures that the player hit
        ;  box is so out of range of whatever we're going to compare with so that
        ;  the hit boxes can't possibly overlap.
        ;  (with a Y coordinate of 0x8000 to 0x80ff, it's highly unlikely).
        LDA.b #$80 : STA $09
        
        RTS
    }

	

;=================================================================
; Sprite_MoveHoriz LONG
; make the sprite move X axis
Sprite_MoveHoriz:
{
	TXA : !ADD #$10 : TAX
	
	JSL Sprite_MoveVert
	
	LDX $0FA0
	
	RTL
}

;=================================================================
; Sprite_MoveVert LONG
; make the sprite move Y axis
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
; Sprite_MoveAltitude LONG
; make the sprite move Z axis (height)
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
; Sprite_Move LONG
; make the sprite move both direction (do not include the height)
Sprite_Move:
{
	JSL Sprite_MoveVert
	JSL Sprite_MoveHoriz
	
	RTL
}

;=================================================================
; Sprite_MoveXyz LONG
; make the sprite move both direction (include height)
Sprite_MoveXyz:
{
	JSL Sprite_MoveAltitude
	JSL Sprite_MoveHoriz
	JSL Sprite_MoveVert
	
	RTL
}

;=================================================================
; Sprite_BouceTowardPlayer LONG
; make the sprite bounce toward player (like vitreous)
; Movement, Collision are handled by this function (height:20 = vitreous)
; $09 = speed, $08 = max height 
Sprite_BouceTowardPlayer:
{
	JSL Sprite_MoveXyz
	; JSL CheckTileCollision ; Bug?
	
	DEC $0F80, X : DEC $0F80, X
	
	LDA $0F70, X : BPL .aloft
	
	STZ $0F70, X
	
	LDA $08 : STA $0F80, X ;  set height from Y
	
	LDA $09
	
	JSL Sprite_ApplySpeedTowardsPlayer
	
	LDA.b #$21 : JSL Sound_SetSfx2PanLong

	.aloft

	RTL
}

;=================================================================
; Sprite_CheckIfActive LONG
; check if sprite is active, if we are not in the menu
; Should be called right after the Draw
Sprite_CheckIfActive:
{
	LDA $0DD0, X : CMP.b #$09 : BNE .inactive

	LDA $0FC1 : BNE .inactive
	
	LDA $11 : BNE .inactive
	
	LDA $0CAA, X : BMI .active
	
	LDA $0F00, X : BEQ .active
	
.inactive

	PLA : PLA : PLA ; Remove one RTL to jump back in main and ignore this sprite

.active

	RTL
	print pc
}

;=================================================================
; Sprite_CheckIfRecoiling
; Check if the sprite is currently recoiling
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