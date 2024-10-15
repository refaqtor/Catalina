' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Init

DAT ' initialized data segment

 alignl ' align long
C_sp4_670edcd4_digits_L000001 ' <symbol:digits>
 byte 48
 byte 49
 byte 50
 byte 51
 byte 52
 byte 53
 byte 54
 byte 55
 byte 56
 byte 57
 byte 97
 byte 98
 byte 99
 byte 100
 byte 101
 byte 102

' Catalina Export _printf_putls

' Catalina Code

DAT ' code segment

 alignl ' align long
C__printf_putls ' <symbol:_printf_putls>
 calld PA,#NEWF
 sub SP, #12
 calld PA,#PSHM
 long $fa8000 ' save registers
 mov r23, r4 ' reg var <- reg arg
 mov r21, r3 ' reg var <- reg arg
 mov r19, r2 ' reg var <- reg arg
 mov r22, #0 ' reg <- coni
 mov RI, FP
 sub RI, #-(-5)
 wrbyte r22, RI ' ASGNU1 addrli reg
 mov r17, FP
 sub r17, #-(-6) ' reg <- addrli
 cmps r19,  #0 wz
 if_z jmp #\C__printf_putls_5 ' EQI4
 cmps r21,  #10 wz
 if_nz jmp #\C__printf_putls_5 ' NEI4
 mov r22, r23 ' CVI, CVU or LOAD
 cmps r22,  #0 wcz
 if_ae jmp #\C__printf_putls_5 ' GEI4
 mov r22, r23 ' CVI, CVU or LOAD
 neg r22, r22 ' NEGI4
 mov r23, r22 ' CVI, CVU or LOAD
 mov r2, #45 ' reg ARG coni
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C_putchar ' CALL addrg
C__printf_putls_5
C__printf_putls_7
 mov r22, r21 ' CVI, CVU or LOAD
 #ifndef NO_INTERRUPTS
  stalli
 #endif
 qdiv r23, r22 ' MODU4
 getqy r1
 #ifndef NO_INTERRUPTS
  allowi
 #endif
 mov r15, r1 ' CVI, CVU or LOAD
 #ifndef NO_INTERRUPTS
  stalli
 #endif
 qdiv r23, r22 ' DIVU4
 getqx r0
 #ifndef NO_INTERRUPTS
  allowi
 #endif
 mov r23, r0 ' CVI, CVU or LOAD
 mov r22, r17 ' CVI, CVU or LOAD
 mov r20, ##-1 ' reg <- con
 mov r17, r22 ' ADDI/P
 adds r17, r20 ' ADDI/P (3)
 mov r20, ##@C_sp4_670edcd4_digits_L000001 ' reg <- addrg
 adds r20, r15 ' ADDI/P (2)
 rdbyte r20, r20 ' reg <- INDIRU1 reg
 wrbyte r20, r22 ' ASGNU1 reg reg
' C__printf_putls_8 ' (symbol refcount = 0)
 cmp r23,  #0 wz
 if_nz jmp #\C__printf_putls_7  ' NEU4
 mov r2, r17
 adds r2, #1 ' ADDP4 coni
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C_putstr ' CALL addrg
' C__printf_putls_2 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 add SP, #12 ' framesize
 calld PA,#RETF


' Catalina Import putstr

' Catalina Import putchar
' end
