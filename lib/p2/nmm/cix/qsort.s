' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export qsort

 alignl ' align long
C_qsort ' <symbol:qsort>
 calld PA,#NEWF
 calld PA,#PSHM
 long $ea0000 ' save registers
 mov r23, r5 ' reg var <- reg arg
 mov r21, r4 ' reg var <- reg arg
 mov r19, r3 ' reg var <- reg arg
 mov r17, r2 ' reg var <- reg arg
 cmp r21,  #0 wz
 if_nz jmp #\C_qsort_8  ' NEU4
 jmp #\@C_qsort_7 ' JUMPV addrg
C_qsort_8
 wrlong r17, ##@C_saqg1_67070707_qcompar_L000004 ' ASGNP4 addrg reg
 mov r2, r19 ' CVI, CVU or LOAD
 mov r22, r21
 sub r22, #1 ' SUBU4 coni
 #ifndef NO_INTERRUPTS
  stalli
 #endif
 qmul r22, r19 ' MULU4
 getqx r0
 #ifndef NO_INTERRUPTS
  allowi
 #endif
 mov r3, r0 ' ADDI/P
 adds r3, r23 ' ADDI/P (3)
 mov r4, r23 ' CVI, CVU or LOAD
 mov BC, #12 ' arg size, rpsize = 12, spsize = 12
 sub SP, #8 ' stack space for reg ARGs
 calld PA,#CALA
 long @C_saqg_67070707_qsort1_L000003
 add SP, #8 ' CALL addrg
C_qsort_7
 calld PA,#POPM ' restore registers
 calld PA,#RETF


 alignl ' align long
C_saqg_67070707_qsort1_L000003 ' <symbol:qsort1>
 calld PA,#NEWF
 calld PA,#PSHM
 long $faaa00 ' save registers
 mov r23, r4 ' reg var <- reg arg
 mov r21, r3 ' reg var <- reg arg
 mov r19, r2 ' reg var <- reg arg
C_saqg_67070707_qsort1_L000003_11
 mov r22, r21 ' CVI, CVU or LOAD
 mov r20, r23 ' CVI, CVU or LOAD
 cmp r22, r20 wcz 
 if_a jmp #\C_saqg_67070707_qsort1_L000003_15 ' GTU4
 jmp #\@C_saqg_67070707_qsort1_L000003_10 ' JUMPV addrg
C_saqg_67070707_qsort1_L000003_15
 mov r17, r23 ' CVI, CVU or LOAD
 mov r15, r21 ' CVI, CVU or LOAD
 mov r22, r21 ' CVI, CVU or LOAD
 mov r20, r23 ' CVI, CVU or LOAD
 sub r22, r20 ' SUBU (1)
 add r22, r19 ' ADDU (1)
 mov r20, r19
 shl r20, #1 ' LSHU4 coni
 #ifndef NO_INTERRUPTS
  stalli
 #endif
 qdiv r22, r20 ' DIVU4
 getqx r0
 #ifndef NO_INTERRUPTS
  allowi
 #endif
 #ifndef NO_INTERRUPTS
  stalli
 #endif
 qmul r19, r0 ' MULU4
 getqx r0
 #ifndef NO_INTERRUPTS
  allowi
 #endif
 mov r22, r0 ' ADDI/P
 adds r22, r23 ' ADDI/P (3)
 mov r11, r22 ' CVI, CVU or LOAD
 mov r13, r22 ' CVI, CVU or LOAD
 jmp #\@C_saqg_67070707_qsort1_L000003_19 ' JUMPV addrg
C_saqg_67070707_qsort1_L000003_18
 cmps r9,  #0 wcz
 if_ae jmp #\C_saqg_67070707_qsort1_L000003_21 ' GEI4
 adds r17, r19 ' ADDI/P (2)
 jmp #\@C_saqg_67070707_qsort1_L000003_22 ' JUMPV addrg
C_saqg_67070707_qsort1_L000003_21
 subs r13, r19 ' SUBI/P (1)
 mov r2, r19 ' CVI, CVU or LOAD
 mov r3, r13 ' CVI, CVU or LOAD
 mov r4, r17 ' CVI, CVU or LOAD
 mov BC, #12 ' arg size, rpsize = 12, spsize = 12
 sub SP, #8 ' stack space for reg ARGs
 calld PA,#CALA
 long @C_saqg2_67070707_qexchange_L000005
 add SP, #8 ' CALL addrg
C_saqg_67070707_qsort1_L000003_22
C_saqg_67070707_qsort1_L000003_19
 mov r22, r17 ' CVI, CVU or LOAD
 mov r20, r13 ' CVI, CVU or LOAD
 cmp r22, r20 wcz 
 if_ae jmp #\C_saqg_67070707_qsort1_L000003_23 ' GEU4
 mov r2, r13 ' CVI, CVU or LOAD
 mov r3, r17 ' CVI, CVU or LOAD
 mov r22, ##@C_saqg1_67070707_qcompar_L000004
 rdlong r22, r22 ' reg <- INDIRP4 addrg
 mov BC, #8 ' arg size, rpsize = 8, spsize = 8
 sub SP, #4 ' stack space for reg ARGs
 mov RI, r22
 calld PA,#CALI
 add SP, #4 ' CALL indirect
 mov r9, r0 ' CVI, CVU or LOAD
 cmps r0,  #0 wcz
 if_be jmp #\C_saqg_67070707_qsort1_L000003_18 ' LEI4
C_saqg_67070707_qsort1_L000003_23
 jmp #\@C_saqg_67070707_qsort1_L000003_25 ' JUMPV addrg
C_saqg_67070707_qsort1_L000003_24
 mov r2, r11 ' CVI, CVU or LOAD
 mov r3, r15 ' CVI, CVU or LOAD
 mov r22, ##@C_saqg1_67070707_qcompar_L000004
 rdlong r22, r22 ' reg <- INDIRP4 addrg
 mov BC, #8 ' arg size, rpsize = 8, spsize = 8
 sub SP, #4 ' stack space for reg ARGs
 mov RI, r22
 calld PA,#CALI
 add SP, #4 ' CALL indirect
 mov r9, r0 ' CVI, CVU or LOAD
 cmps r0,  #0 wcz
 if_ae jmp #\C_saqg_67070707_qsort1_L000003_27 ' GEI4
 mov r22, r17 ' CVI, CVU or LOAD
 mov r20, r13 ' CVI, CVU or LOAD
 cmp r22, r20 wcz 
 if_ae jmp #\C_saqg_67070707_qsort1_L000003_29 ' GEU4
 mov r2, r19 ' CVI, CVU or LOAD
 mov r3, r15 ' CVI, CVU or LOAD
 mov r4, r17 ' CVI, CVU or LOAD
 mov BC, #12 ' arg size, rpsize = 12, spsize = 12
 sub SP, #8 ' stack space for reg ARGs
 calld PA,#CALA
 long @C_saqg2_67070707_qexchange_L000005
 add SP, #8 ' CALL addrg
 adds r17, r19 ' ADDI/P (2)
 subs r15, r19 ' SUBI/P (1)
 jmp #\@C_saqg_67070707_qsort1_L000003_19 ' JUMPV addrg
C_saqg_67070707_qsort1_L000003_29
 adds r11, r19 ' ADDI/P (2)
 mov r2, r19 ' CVI, CVU or LOAD
 mov r3, r15 ' CVI, CVU or LOAD
 mov r4, r11 ' CVI, CVU or LOAD
 mov r5, r17 ' CVI, CVU or LOAD
 mov BC, #16 ' arg size, rpsize = 16, spsize = 16
 sub SP, #12 ' stack space for reg ARGs
 calld PA,#CALA
 long @C_saqg3_67070707_q3exchange_L000006
 add SP, #12 ' CALL addrg
 adds r13, r19 ' ADDI/P (2)
 mov r17, r13 ' CVI, CVU or LOAD
 jmp #\@C_saqg_67070707_qsort1_L000003_28 ' JUMPV addrg
C_saqg_67070707_qsort1_L000003_27
 cmps r9,  #0 wz
 if_nz jmp #\C_saqg_67070707_qsort1_L000003_31 ' NEI4
 adds r11, r19 ' ADDI/P (2)
 mov r2, r19 ' CVI, CVU or LOAD
 mov r3, r11 ' CVI, CVU or LOAD
 mov r4, r15 ' CVI, CVU or LOAD
 mov BC, #12 ' arg size, rpsize = 12, spsize = 12
 sub SP, #8 ' stack space for reg ARGs
 calld PA,#CALA
 long @C_saqg2_67070707_qexchange_L000005
 add SP, #8 ' CALL addrg
 jmp #\@C_saqg_67070707_qsort1_L000003_32 ' JUMPV addrg
C_saqg_67070707_qsort1_L000003_31
 subs r15, r19 ' SUBI/P (1)
C_saqg_67070707_qsort1_L000003_32
C_saqg_67070707_qsort1_L000003_28
C_saqg_67070707_qsort1_L000003_25
 mov r22, r15 ' CVI, CVU or LOAD
 mov r20, r11 ' CVI, CVU or LOAD
 cmp r22, r20 wcz 
 if_a jmp #\C_saqg_67070707_qsort1_L000003_24 ' GTU4
 mov r22, r17 ' CVI, CVU or LOAD
 mov r20, r13 ' CVI, CVU or LOAD
 cmp r22, r20 wcz 
 if_ae jmp #\C_saqg_67070707_qsort1_L000003_33 ' GEU4
 subs r13, r19 ' SUBI/P (1)
 mov r2, r19 ' CVI, CVU or LOAD
 mov r3, r17 ' CVI, CVU or LOAD
 mov r4, r13 ' CVI, CVU or LOAD
 mov r5, r15 ' CVI, CVU or LOAD
 mov BC, #16 ' arg size, rpsize = 16, spsize = 16
 sub SP, #12 ' stack space for reg ARGs
 calld PA,#CALA
 long @C_saqg3_67070707_q3exchange_L000006
 add SP, #12 ' CALL addrg
 subs r11, r19 ' SUBI/P (1)
 mov r15, r11 ' CVI, CVU or LOAD
 jmp #\@C_saqg_67070707_qsort1_L000003_19 ' JUMPV addrg
C_saqg_67070707_qsort1_L000003_33
 mov r2, r19 ' CVI, CVU or LOAD
 mov r3, r13 ' SUBI/P
 subs r3, r19 ' SUBI/P (3)
 mov r4, r23 ' CVI, CVU or LOAD
 mov BC, #12 ' arg size, rpsize = 12, spsize = 12
 sub SP, #8 ' stack space for reg ARGs
 calld PA,#CALA
 long @C_saqg_67070707_qsort1_L000003
 add SP, #8 ' CALL addrg
 mov r23, r19 ' ADDI/P
 adds r23, r11 ' ADDI/P (3)
 jmp #\@C_saqg_67070707_qsort1_L000003_11 ' JUMPV addrg
C_saqg_67070707_qsort1_L000003_10
 calld PA,#POPM ' restore registers
 calld PA,#RETF


 alignl ' align long
C_saqg2_67070707_qexchange_L000005 ' <symbol:qexchange>
 calld PA,#PSHM
 long $d00000 ' save registers
 jmp #\@C_saqg2_67070707_qexchange_L000005_37 ' JUMPV addrg
C_saqg2_67070707_qexchange_L000005_36
 mov r22, r4 ' CVI, CVU or LOAD
 rdbyte r23, r22 ' reg <- CVUI4 INDIRU1 reg
 mov r4, r22
 adds r4, #1 ' ADDP4 coni
 rdbyte r20, r3 ' reg <- INDIRU1 reg
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r3 ' CVI, CVU or LOAD
 mov r3, r22
 adds r3, #1 ' ADDP4 coni
 mov r20, r23 ' CVI, CVU or LOAD
 wrbyte r20, r22 ' ASGNU1 reg reg
C_saqg2_67070707_qexchange_L000005_37
 mov r22, r2 ' CVI, CVU or LOAD
 mov r2, r22
 sub r2, #1 ' SUBU4 coni
 cmp r22,  #0 wz
 if_nz jmp #\C_saqg2_67070707_qexchange_L000005_36  ' NEU4
' C_saqg2_67070707_qexchange_L000005_35 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETN


 alignl ' align long
C_saqg3_67070707_q3exchange_L000006 ' <symbol:q3exchange>
 calld PA,#PSHM
 long $d00000 ' save registers
 jmp #\@C_saqg3_67070707_q3exchange_L000006_41 ' JUMPV addrg
C_saqg3_67070707_q3exchange_L000006_40
 mov r22, r5 ' CVI, CVU or LOAD
 rdbyte r23, r22 ' reg <- CVUI4 INDIRU1 reg
 mov r5, r22
 adds r5, #1 ' ADDP4 coni
 rdbyte r20, r3 ' reg <- INDIRU1 reg
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r3 ' CVI, CVU or LOAD
 mov r3, r22
 adds r3, #1 ' ADDP4 coni
 rdbyte r20, r4 ' reg <- INDIRU1 reg
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r4 ' CVI, CVU or LOAD
 mov r4, r22
 adds r4, #1 ' ADDP4 coni
 mov r20, r23 ' CVI, CVU or LOAD
 wrbyte r20, r22 ' ASGNU1 reg reg
C_saqg3_67070707_q3exchange_L000006_41
 mov r22, r2 ' CVI, CVU or LOAD
 mov r2, r22
 sub r2, #1 ' SUBU4 coni
 cmp r22,  #0 wz
 if_nz jmp #\C_saqg3_67070707_q3exchange_L000006_40  ' NEU4
' C_saqg3_67070707_q3exchange_L000006_39 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETN


' Catalina Data

DAT ' uninitialized data segment

 alignl ' align long
C_saqg1_67070707_qcompar_L000004 ' <symbol:qcompar>
 byte 0[4]

' Catalina Code

DAT ' code segment
' end
