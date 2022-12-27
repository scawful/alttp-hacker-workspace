lorom

!ADD = "CLC : ADC"
!SUB = "SEC : SBC"
!BLT = "BCC"
!BGE = "BCS"

;=================================================================
;UseImplicitRegIndexedLocalJumpTable
org $008781;JP VALID
UseImplicitRegIndexedLocalJumpTable:
;=================================================================

;=================================================================
org $09AE64 ;JP VALID
Sprite_SetSpawnedCoords:

;=================================================================
;Sprite_PrepOamCoord LONG
;set the oam coordinate for the sprite draw
org $06E416 ; 06E420 MAYBE? - YEP
Sprite_PrepOamCoord:

;=================================================================
;Sprite_CheckDamageFromPlayer LONG
;check if the sprite is getting damage from player or items
org $06F2AA ;06F2B0
Sprite_CheckDamageFromPlayer:

;=================================================================
;Sprite_CheckDamageToPlayer LONG
;check if the sprite is touching the player to damage
org $06F121 ;06F127
Sprite_CheckDamageToPlayer:

;=================================================================
;Sprite_AttemptDamageToPlayerPlusRecoil LONG
;damage the player everywhere on screen?
org $06F41F ; 06F425
Sprite_AttemptDamageToPlayerPlusRecoil:

;=================================================================
;Sprite_OAM_AllocateDeferToPlayer LONG
;Draw the sprite depending of the position of the player (if he has to be over or under link)
org $06F864 ;06F86A
Sprite_OAM_AllocateDeferToPlayer:


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
;=================================================================
;ApplyRumbleToSprites LONG
;makes all the sprites on screen shaking?
org $0680FA;JP VALID
ApplyRumbleToSprites:


;=================================================================
;CheckIfHitBoxesOverlap LONG
;args : 
;!pos1_low  = $00
;!pos1_size = $02
;!pos2_low  = $04
;!pos2_size = $06
;!pos1_high = $08
;!pos2_high = $0A
;!ans_low   = $0F
;!ans_high  = $0C
;returns carry clear if there was no overlap
org $0683E6;JP VALID
CheckIfHitBoxesOverlap:

;=================================================================
;Sprite_Get_16_bit_Coords LONG
;$0FD8 = sprite's X coordinate, $0FDA = sprite's Y coordinate
org $0684BD;JP VALID
Sprite_Get_16_bit_Coords:

;=================================================================
;Sprite_PrepAndDrawSingleLarge LONG
;load / draw a  16x16 sprite
org $06DBF0 ;06DBF8
Sprite_PrepAndDrawSingleLarge:

;=================================================================
;Sprite_PrepAndDrawSingleSmall LONG
;load / draw a  8x8 sprite
org $06DBF8 ;06DC00
Sprite_PrepAndDrawSingleSmall:

;=================================================================
;Sprite_DrawShadow LONG
;draw shadow 
org $06DC54 ;06DC5C
Sprite_DrawShadow:

;=================================================================
;Sprite_CheckTileCollision LONG
;check if the sprite is colliding with a solid tile set $0E70, X
;----udlr , u = up, d = down, l = left, r = right
org $06E496 ;06E49C
Sprite_CheckTileCollision:

;=================================================================
;Sprite_GetTileAttr LONG
; $00[0x02] - Entity Y coordinate
; $02[0x03?] - Entity X coordinate
;$0FA5
org $06E87B ;06E881
Sprite_GetTileAttr:

;=================================================================
;Sprite_CheckSlopedTileCollision LONG
;check if the sprite is colliding with a solid sloped tile  -  NEED INVESTIGATION LEAD TO A 6B BYTE WHICH IS A RETURN???
org $06E903
Sprite_CheckSlopedTileCollision:

;=================================================================
;Sprite_ApplySpeedTowardsPlayer LONG
;set the velocity x,y towards the player (A = speed)
org $06EA12 ;06EA18
Sprite_ApplySpeedTowardsPlayer:

;=================================================================
;Sprite_DirectionToFacePlayer LONG
; \return       $0E is low byte of player_y_pos - sprite_y_pos
; \return       $0F is low byte of player_x_pos - sprite_x_pos
org $06EAA0 ;06EAA6
Sprite_DirectionToFacePlayer:

;=================================================================
;Sprite_IsToRightOfPlayer LONG
;if Link is to the left of the sprite, Y = 1, otherwise Y = 0.
org $06EACD ;06EAD3
Sprite_IsToRightOfPlayer:

;=================================================================
;Sprite_IsBelowPlayer LONG
;return Y=1 sprite is below player, otherwise Y = 0
org $06EAE4 ;06EAEA
Sprite_IsBelowPlayer:

;=================================================================
;Sprite_CheckDamageToPlayerSameLayer LONG
;check damage done to player if they collide and if they are on same layer
org $06F129 ;06F12F
Sprite_CheckDamageToPlayerSameLayer:

;=================================================================
;Sprite_CheckDamageToPlayerIgnoreLayer LONG
;check damage done to player if they collide even if they are not on same layer
org $06F131 ;06F137
Sprite_CheckDamageToPlayerIgnoreLayer:

;=================================================================
;Sound_SetSfx2PanLong LONG
;play a sound loaded in A
org $0DBB7C;JP VALID
Sound_SetSfx2PanLong:

;=================================================================
;Sprite_SpawnDynamically LONG
;spawn a new sprite on screen, A = sprite id
;when using this function you have to set the position yourself
;these values belong to the sprite who used that function not the new one 
;$00 low x, $01 high x
;$02 low y, $03 high y
;$04 height, $05 low x (overlord)
;$06 high x (overlord), $07 low y (overlord)
;$08 high y (overlord)
org $1DF65D;JP VALID
Sprite_SpawnDynamically:

org $07F1A3 ;07F18C
Player_ResetState:
;=================================================================
;Sprite_ApplyConveyorAdjustment LONG
;move the sprite if he stand on a conveyor belt
org $1D8010;JP VALID
Sprite_ApplyConveyorAdjustment:

;=================================================================
;SetupHitBox LONG
;set the hitbox of the player (i think)
org $0683EA;JP VALID
SetupHitBox:

;=================================================================
;Dungeon_SpriteInducedTilemapUpdate LONG
;set tile of dungeon
org $01E7A9 ; 01E7A7
Dungeon_SpriteInducedTilemapUpdate:
;=================================================================
;Get random INT LONG
;Store a random value in Accumulator
org $0DBA71;JP VALID
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
;Link_ReceiveItem
;Y = item id
org $0799AD
Link_ReceiveItem:

;=================================================================
;Sprite_ShowSolicitedMessageIfPlayerFacing
;show a message if we press A and face the sprite
; A = low byte of message ID to use.
; Y = high byte of message ID to use.
org $05E1A7
Sprite_ShowSolicitedMessageIfPlayerFacing:

;=================================================================
;Sprite_ShowMessageFromPlayerContact
;show a message if we touch the sprite should be used with Sprite_PlayerCantPassThrough
; A = low byte of message ID to use.
; Y = high byte of message ID to use.
org $05E1F0
Sprite_ShowMessageFromPlayerContact:


