' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export getc

 alignl ' align long
C_getc ' <symbol:getc>
 calld PA,#NEWF
 calld PA,#PSHM
 long $d40000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 rdlong r22, r23 ' reg <- INDIRI4 reg
 subs r22, #1 ' SUBI4 coni
 wrlong r22, r23 ' ASGNI4 reg reg
 cmps r22,  #0 wcz
 if_b jmp #\C_getc_2 ' LTI4
 mov r22, r23
 adds r22, #20 ' ADDP4 coni
 rdlong r20, r22 ' reg <- INDIRP4 reg
 mov r18, r20
 adds r18, #1 ' ADDP4 coni
 wrlong r18, r22 ' ASGNP4 reg reg
 rdbyte r0, r20 ' reg <- CVUI4 INDIRU1 reg
 jmp #\@C_getc_1 ' JUMPV addrg
C_getc_2
 mov r2, r23 ' CVI, CVU or LOAD
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C___fillbuf ' CALL addrg
 mov r22, r0 ' CVI, CVU or LOAD
C_getc_1
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Import __fillbuf
' end
