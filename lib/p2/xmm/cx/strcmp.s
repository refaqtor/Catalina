' Catalina Code

DAT ' code segment
'
' LCC 4.2 (LARGE) for Parallax Propeller
' (Catalina v2.5 Code Generator by Ross Higson)
'

' Catalina Export strcmp

 alignl ' align long
C_strcmp ' <symbol:strcmp>
 jmp #PSHM
 long $500000 ' save registers
 jmp #JMPA
 long @C_strcmp_3 ' JUMPV addrg
C_strcmp_2
 mov r22, r3 ' CVI, CVU or LOAD
 mov r3, r22
 adds r3, #1 ' ADDP4 coni
 mov RI, r22
 jmp #RBYT
 mov r22, BC ' reg <- INDIRU1 reg
 and r22, cviu_m1 ' zero extend
 cmps r22,  #0 wz
 jmp #BRNZ
 long @C_strcmp_5 ' NEI4
 mov r0, #0 ' reg <- coni
 jmp #JMPA
 long @C_strcmp_1 ' JUMPV addrg
C_strcmp_5
C_strcmp_3
 mov r22, r2 ' CVI, CVU or LOAD
 mov r2, r22
 adds r2, #1 ' ADDP4 coni
 mov RI, r3
 jmp #RBYT
 mov r20, BC ' reg <- INDIRU1 reg
 and r20, cviu_m1 ' zero extend
 mov RI, r22
 jmp #RBYT
 mov r22, BC ' reg <- INDIRU1 reg
 and r22, cviu_m1 ' zero extend
 cmps r20, r22 wz
 jmp #BR_Z
 long @C_strcmp_2 ' EQI4
 mov RI, r3
 jmp #RBYT
 mov r22, BC ' reg <- INDIRU1 reg
 and r22, cviu_m1 ' zero extend
 cmps r22,  #0 wz
 jmp #BRNZ
 long @C_strcmp_7 ' NEI4
 jmp #LODL
 long -1
 mov r0, RI ' reg <- con
 jmp #JMPA
 long @C_strcmp_1 ' JUMPV addrg
C_strcmp_7
 jmp #LODL
 long -1
 mov r22, RI ' reg <- con
 adds r22, r2 ' ADDI/P (2)
 mov r2, r22 ' CVI, CVU or LOAD
 mov RI, r22
 jmp #RBYT
 mov r22, BC ' reg <- INDIRU1 reg
 and r22, cviu_m1 ' zero extend
 cmps r22,  #0 wz
 jmp #BRNZ
 long @C_strcmp_9 ' NEI4
 mov r0, #1 ' reg <- coni
 jmp #JMPA
 long @C_strcmp_1 ' JUMPV addrg
C_strcmp_9
 mov RI, r3
 jmp #RBYT
 mov r22, BC ' reg <- INDIRU1 reg
 and r22, cviu_m1 ' zero extend
 mov RI, r2
 jmp #RBYT
 mov r20, BC ' reg <- INDIRU1 reg
 and r20, cviu_m1 ' zero extend
 mov r0, r22 ' SUBI/P
 subs r0, r20 ' SUBI/P (3)
C_strcmp_1
 jmp #POPM ' restore registers
 jmp #RETN

' end
