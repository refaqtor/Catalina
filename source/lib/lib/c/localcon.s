' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export localeconv

 alignl ' align long
C_localeconv ' <symbol:localeconv>
 calld PA,#PSHM
 long $d00000 ' save registers
 mov r23, ##@C__lc ' reg <- addrg
 mov r22, ##@C_localeconv_2_L000003 ' reg <- addrg
 wrlong r22, r23 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #4 ' ADDP4 coni
 mov r20, ##@C_localeconv_4_L000005 ' reg <- addrg
 wrlong r20, r22 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #8 ' ADDP4 coni
 mov r20, ##@C_localeconv_4_L000005 ' reg <- addrg
 wrlong r20, r22 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #12 ' ADDP4 coni
 mov r20, ##@C_localeconv_4_L000005 ' reg <- addrg
 wrlong r20, r22 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #16 ' ADDP4 coni
 mov r20, ##@C_localeconv_4_L000005 ' reg <- addrg
 wrlong r20, r22 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #20 ' ADDP4 coni
 mov r20, ##@C_localeconv_4_L000005 ' reg <- addrg
 wrlong r20, r22 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #24 ' ADDP4 coni
 mov r20, ##@C_localeconv_4_L000005 ' reg <- addrg
 wrlong r20, r22 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #28 ' ADDP4 coni
 mov r20, ##@C_localeconv_4_L000005 ' reg <- addrg
 wrlong r20, r22 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #32 ' ADDP4 coni
 mov r20, ##@C_localeconv_4_L000005 ' reg <- addrg
 wrlong r20, r22 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #36 ' ADDP4 coni
 mov r20, ##@C_localeconv_4_L000005 ' reg <- addrg
 wrlong r20, r22 ' ASGNP4 reg reg
 mov r22, r23
 adds r22, #40 ' ADDP4 coni
 mov r20, #127 ' reg <- coni
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r23
 adds r22, #41 ' ADDP4 coni
 mov r20, #127 ' reg <- coni
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r23
 adds r22, #42 ' ADDP4 coni
 mov r20, #127 ' reg <- coni
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r23
 adds r22, #43 ' ADDP4 coni
 mov r20, #127 ' reg <- coni
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r23
 adds r22, #44 ' ADDP4 coni
 mov r20, #127 ' reg <- coni
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r23
 adds r22, #45 ' ADDP4 coni
 mov r20, #127 ' reg <- coni
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r23
 adds r22, #46 ' ADDP4 coni
 mov r20, #127 ' reg <- coni
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r22, r23
 adds r22, #47 ' ADDP4 coni
 mov r20, #127 ' reg <- coni
 wrbyte r20, r22 ' ASGNU1 reg reg
 mov r0, r23 ' CVI, CVU or LOAD
' C_localeconv_1 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETN


' Catalina Import _lc

' Catalina Cnst

DAT ' const data segment

 alignl ' align long
C_localeconv_4_L000005 ' <symbol:4>
 byte 0

 alignl ' align long
C_localeconv_2_L000003 ' <symbol:2>
 byte 46
 byte 0

' Catalina Code

DAT ' code segment
' end
