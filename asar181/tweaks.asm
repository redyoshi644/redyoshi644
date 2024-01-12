; Tweaks v1.0 (2021-09-29)

@asar 1.70

math pri on
math round off

!sa1 = 0                ; SA-1 flag
!dp = $0000             ; Direct Page remap ($0000 - LoROM/FastROM, $3000 - SA-1 ROM)
!addr = $0000           ; Address remap ($0000 - LoROM/FastROM, $6000 - SA-1 ROM)
!ram = $7E0000          ; WRAM/BW-RAM remap ($7E0000 - LoROM/FastROM, $400000 - SA-1 ROM)
!bank = $800000         ; Long address remap ($800000 - FastROM, $000000 - SA-1 ROM)
!bank8 = $80            ; Bank byte remap ($80 - FastROM, $00 - SA-1 ROM)
!SprSize = $0C          ; Number of sprite slots (12 - FastROM, 22 - SA-1 ROM)

; SA-1 detection code
if read1($00FFD5) == $23
    sa1rom

    !sa1 = 1
    !dp = $3000
    !addr = $6000
    !ram = $400000
    !bank = $000000
    !bank8 = $00
    !SprSize = $16
endif

!EXLEVEL = 0

if (((read1($0FF0B4)-'0')*100)+((read1($0FF0B4+2)-'0')*10)+(read1($0FF0B4+3)-'0')) > 253
    !EXLEVEL = 1
endif

macro define_sprite_table(name, name2, addr, addr_sa1)
    if !sa1 == 0
        !<name> = <addr>
    else
        !<name> = <addr_sa1>
    endif

    !<name2> = !<name>
endmacro

; Regular sprite tables
%define_sprite_table(sprite_num, "9E", $9E, $3200)
%define_sprite_table(sprite_speed_y, "AA", $AA, $9E)
%define_sprite_table(sprite_speed_x, "B6", $B6, $B6)
%define_sprite_table(sprite_misc_c2, "C2", $C2, $D8)
%define_sprite_table(sprite_y_low, "D8", $D8, $3216)
%define_sprite_table(sprite_x_low, "E4", $E4, $322C)
%define_sprite_table(sprite_status, "14C8", $14C8, $3242)
%define_sprite_table(sprite_y_high, "14D4", $14D4, $3258)
%define_sprite_table(sprite_x_high, "14E0", $14E0, $326E)
%define_sprite_table(sprite_speed_y_frac, "14EC", $14EC, $74C8)
%define_sprite_table(sprite_speed_x_frac, "14F8", $14F8, $74DE)
%define_sprite_table(sprite_misc_1504, "1504", $1504, $74F4)
%define_sprite_table(sprite_misc_1510, "1510", $1510, $750A)
%define_sprite_table(sprite_misc_151c, "151C", $151C, $3284)
%define_sprite_table(sprite_misc_1528, "1528", $1528, $329A)
%define_sprite_table(sprite_misc_1534, "1534", $1534, $32B0)
%define_sprite_table(sprite_misc_1540, "1540", $1540, $32C6)
%define_sprite_table(sprite_misc_154c, "154C", $154C, $32DC)
%define_sprite_table(sprite_misc_1558, "1558", $1558, $32F2)
%define_sprite_table(sprite_misc_1564, "1564", $1564, $3308)
%define_sprite_table(sprite_misc_1570, "1570", $1570, $331E)
%define_sprite_table(sprite_misc_157c, "157C", $157C, $3334)
%define_sprite_table(sprite_blocked_status, "1588", $1588, $334A)
%define_sprite_table(sprite_misc_1594, "1594", $1594, $3360)
%define_sprite_table(sprite_off_screen_horz, "15A0", $15A0, $3376)
%define_sprite_table(sprite_misc_15ac, "15AC", $15AC, $338C)
%define_sprite_table(sprite_slope, "15B8", $15B8, $7520)
%define_sprite_table(sprite_off_screen, "15C4", $15C4, $7536)
%define_sprite_table(sprite_being_eaten, "15D0", $15D0, $754C)
%define_sprite_table(sprite_obj_interact, "15DC", $15DC, $7562)
%define_sprite_table(sprite_oam_index, "15EA", $15EA, $33A2)
%define_sprite_table(sprite_oam_properties, "15F6", $15F6, $33B8)
%define_sprite_table(sprite_misc_1602, "1602", $1602, $33CE)
%define_sprite_table(sprite_misc_160e, "160E", $160E, $33E4)
%define_sprite_table(sprite_index_in_level, "161A", $161A, $7578)
%define_sprite_table(sprite_misc_1626, "1626", $1626, $758E)
%define_sprite_table(sprite_behind_scenery, "1632", $1632, $75A4)
%define_sprite_table(sprite_misc_163e, "163E", $163E, $33FA)
%define_sprite_table(sprite_in_water, "164A", $164A, $75BA)
%define_sprite_table(sprite_tweaker_1656, "1656", $1656, $75D0)
%define_sprite_table(sprite_tweaker_1662, "1662", $1662, $75EA)
%define_sprite_table(sprite_tweaker_166e, "166E", $166E, $7600)
%define_sprite_table(sprite_tweaker_167a, "167A", $167A, $7616)
%define_sprite_table(sprite_tweaker_1686, "1686", $1686, $762C)
%define_sprite_table(sprite_off_screen_vert, "186C", $186C, $7642)
%define_sprite_table(sprite_misc_187b, "187B", $187B, $3410)
%define_sprite_table(sprite_tweaker_190f, "190F", $190F, $7658)
%define_sprite_table(sprite_misc_1fd6, "1FD6", $1FD6, $766E)
%define_sprite_table(sprite_cape_disable_time, "1FE2", $1FE2, $7FD6)

; Romi's Sprite Tool defines.
%define_sprite_table(sprite_extra_bits, "7FAB10", $7FAB10, $6040)
%define_sprite_table(sprite_new_code_flag, "7FAB1C", $7FAB1C, $6056)
%define_sprite_table(sprite_extra_prop1, "7FAB28", $7FAB28, $6057)
%define_sprite_table(sprite_extra_prop2, "7FAB34", $7FAB34, $606D)
%define_sprite_table(sprite_custom_num, "7FAB9E", $7FAB9E, $6083)
%define_sprite_table(sprite_extra_byte1, "7FAB40", $7FAB40, $60A4)
%define_sprite_table(sprite_extra_byte2, "7FAB4C", $7FAB4C, $60BA)
%define_sprite_table(sprite_extra_byte3, "7FAB58", $7FAB58, $60D0)
%define_sprite_table(sprite_extra_byte4, "7FAB64", $7FAB64, $60E6)

macro Tweak_8_NoFadeOutGoal()
    org $00AF35
        JMP $B091
        NOP

    org $00B091
        LDA $13C6|!addr
        BEQ $FA
        LDA $13
        AND #$03
        JMP $AF39
endmacro

macro Tweak_32_DisableScorecard()
    org $05CC66
        rts
endmacro

macro Tweak_54_RemoveMARIOSTART()
    org $0096A6
    db $80,$03
endmacro

; No-Fade Out Goal
%Tweak_8_NoFadeOutGoal()

; Disable Scorecard
%Tweak_32_DisableScorecard()

; Remove "MARIO START!"
%Tweak_54_RemoveMARIOSTART()
