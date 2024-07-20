' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export strstr

 alignl ' align long
C_strstr ' <symbol:strstr>
 calld PA,#NEWF
 calld PA,#PSHM
 long $f80000 ' save registers
 mov r23, r3 ' reg var <- reg arg
 mov r21, r2 ' reg var <- reg arg
 mov r2, r21 ' CVI, CVU or LOAD
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C_strlen ' CALL addrg
 mov r19, r0 ' CVI, CVU or LOAD
 cmps r19,  #0 wz
 if_nz jmp #\C_strstr_5 ' NEI4
 mov r0, r23 ' CVI, CVU or LOAD
 jmp #\@C_strstr_1 ' JUMPV addrg
C_strstr_4
 mov r22, r23 ' CVI, CVU or LOAD
 mov r23, r22
 adds r23, #1 ' ADDP4 coni
 rdbyte r22, r22 ' reg <- CVUI4 INDIRU1 reg
 cmps r22,  #0 wz
 if_nz jmp #\C_strstr_7 ' NEI4
 mov r0, ##0 ' RET con
 jmp #\@C_strstr_1 ' JUMPV addrg
C_strstr_7
C_strstr_5
 rdbyte r22, r23 ' reg <- CVUI4 INDIRU1 reg
 rdbyte r20, r21 ' reg <- CVUI4 INDIRU1 reg
 cmps r22, r20 wz
 if_nz jmp #\C_strstr_4 ' NEI4
 mov r2, r19 ' CVI, CVU or LOAD
 mov r3, r21 ' CVI, CVU or LOAD
 mov r4, r23 ' CVI, CVU or LOAD
 mov BC, #12 ' arg size, rpsize = 12, spsize = 12
 sub SP, #8 ' stack space for reg ARGs
 calld PA,#CALA
 long @C_strncmp
 add SP, #8 ' CALL addrg
 cmps r0,  #0 wz
 if_nz jmp #\C_strstr_4 ' NEI4
 mov r0, r23 ' CVI, CVU or LOAD
C_strstr_1
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Import strlen

' Catalina Import strncmp
' end
