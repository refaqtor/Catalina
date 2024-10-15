' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export isnumber

 alignl ' align long
C_isnumber ' <symbol:isnumber>
 calld PA,#NEWF
 sub SP, #4
 calld PA,#PSHM
 long $f80000 ' save registers
 mov r23, r3 ' reg var <- reg arg
 mov r21, r2 ' reg var <- reg arg
 cmps r21,  #10 wcz
 if_a jmp #\C_isnumber_2 ' GTI4
 mov r22, r23 ' CVUI
 and r22, cviu_m1 ' zero extend
 subs r22, #48 ' SUBI4 coni
 mov r20, r22 ' CVI, CVU or LOAD
 cmp r20,  #10 wcz 
 if_ae jmp #\C_isnumber_5 ' GEU4
 cmps r22, r21 wcz
 if_ae jmp #\C_isnumber_5 ' GEI4
 mov r19, #1 ' reg <- coni
 jmp #\@C_isnumber_6 ' JUMPV addrg
C_isnumber_5
 mov r19, #0 ' reg <- coni
C_isnumber_6
 mov r0, r19 ' CVI, CVU or LOAD
 jmp #\@C_isnumber_1 ' JUMPV addrg
C_isnumber_2
 mov r2, r23 ' CVUI
 and r2, cviu_m1 ' zero extend
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C_tolower ' CALL addrg
 mov r22, r0 ' CVI, CVU or LOAD
 mov RI, FP
 sub RI, #-(-8)
 wrbyte r22, RI ' ASGNU1 addrli reg
 mov r22, FP
 sub r22, #-(-8) ' reg <- addrli
 rdbyte r22, r22 ' reg <- CVUI4 INDIRU1 reg
 subs r22, #48 ' SUBI4 coni
 mov r20, r22 ' CVI, CVU or LOAD
 cmp r20,  #10 wcz 
 if_ae jmp #\C_isnumber_12 ' GEU4
 cmps r22, r21 wcz
 if_b jmp #\C_isnumber_11 ' LTI4
C_isnumber_12
 mov r22, FP
 sub r22, #-(-8) ' reg <- addrli
 rdbyte r22, r22 ' reg <- CVUI4 INDIRU1 reg
 mov r20, ##@C___ctype+1 ' reg <- addrg
 adds r20, r22 ' ADDI/P (2)
 rdbyte r20, r20 ' reg <- CVUI4 INDIRU1 reg
 and r20, #3 ' BANDI4 coni
 cmps r20,  #0 wz
 if_z jmp #\C_isnumber_9 ' EQI4
 subs r22, #97 ' SUBI4 coni
 mov r20, r21
 subs r20, #10 ' SUBI4 coni
 cmps r22, r20 wcz
 if_ae jmp #\C_isnumber_9 ' GEI4
C_isnumber_11
 mov r19, #1 ' reg <- coni
 jmp #\@C_isnumber_10 ' JUMPV addrg
C_isnumber_9
 mov r19, #0 ' reg <- coni
C_isnumber_10
 mov r0, r19 ' CVI, CVU or LOAD
C_isnumber_1
 calld PA,#POPM ' restore registers
 add SP, #4 ' framesize
 calld PA,#RETF


' Catalina Export tonumber

 alignl ' align long
C_tonumber ' <symbol:tonumber>
 calld PA,#NEWF
 calld PA,#PSHM
 long $d00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r22, r23 ' CVUI
 and r22, cviu_m1 ' zero extend
 subs r22, #48 ' SUBI4 coni
 cmp r22,  #10 wcz 
 if_ae jmp #\C_tonumber_14 ' GEU4
 mov r22, r23 ' CVUI
 and r22, cviu_m1 ' zero extend
 mov r0, r22
 subs r0, #48 ' SUBI4 coni
 jmp #\@C_tonumber_13 ' JUMPV addrg
C_tonumber_14
 mov r22, r23 ' CVUI
 and r22, cviu_m1 ' zero extend
 mov r20, ##@C___ctype+1 ' reg <- addrg
 adds r22, r20 ' ADDI/P (1)
 rdbyte r22, r22 ' reg <- CVUI4 INDIRU1 reg
 and r22, #3 ' BANDI4 coni
 cmps r22,  #0 wz
 if_z jmp #\C_tonumber_16 ' EQI4
 mov r2, r23 ' CVUI
 and r2, cviu_m1 ' zero extend
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C_tolower ' CALL addrg
 mov r22, r0
 subs r22, #97 ' SUBI4 coni
 mov r0, r22
 adds r0, #10 ' ADDI4 coni
 jmp #\@C_tonumber_13 ' JUMPV addrg
C_tonumber_16
 mov r0, #0 ' reg <- coni
C_tonumber_13
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Import tolower

' Catalina Import __ctype
' end
