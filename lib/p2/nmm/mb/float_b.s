' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export mod

 alignl ' align long
C_mod ' <symbol:mod>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##@C_mod_3_L000004
 rdlong r2, r2
 ' reg ARG INDIR ADDRG
 mov r3, r23 ' CVI, CVU or LOAD
 mov r4, #19 ' reg ARG coni
 mov r5, #4 ' reg ARG coni
 mov BC, #16 ' arg size, rpsize = 16, spsize = 16
 sub SP, #12 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__float_request
 add SP, #12 ' CALL addrg
 mov r22, r0 ' CVI, CVU or LOAD
' C_mod_2 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export asin

 alignl ' align long
C_asin ' <symbol:asin>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##@C_mod_3_L000004
 rdlong r2, r2
 ' reg ARG INDIR ADDRG
 mov r3, r23 ' CVI, CVU or LOAD
 mov r4, #20 ' reg ARG coni
 mov r5, #4 ' reg ARG coni
 mov BC, #16 ' arg size, rpsize = 16, spsize = 16
 sub SP, #12 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__float_request
 add SP, #12 ' CALL addrg
 mov r22, r0 ' CVI, CVU or LOAD
' C_asin_5 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export acos

 alignl ' align long
C_acos ' <symbol:acos>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##@C_mod_3_L000004
 rdlong r2, r2
 ' reg ARG INDIR ADDRG
 mov r3, r23 ' CVI, CVU or LOAD
 mov r4, #21 ' reg ARG coni
 mov r5, #4 ' reg ARG coni
 mov BC, #16 ' arg size, rpsize = 16, spsize = 16
 sub SP, #12 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__float_request
 add SP, #12 ' CALL addrg
 mov r22, r0 ' CVI, CVU or LOAD
' C_acos_6 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export atan

 alignl ' align long
C_atan ' <symbol:atan>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##@C_mod_3_L000004
 rdlong r2, r2
 ' reg ARG INDIR ADDRG
 mov r3, r23 ' CVI, CVU or LOAD
 mov r4, #22 ' reg ARG coni
 mov r5, #4 ' reg ARG coni
 mov BC, #16 ' arg size, rpsize = 16, spsize = 16
 sub SP, #12 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__float_request
 add SP, #12 ' CALL addrg
 mov r22, r0 ' CVI, CVU or LOAD
' C_atan_7 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export atan2

 alignl ' align long
C_atan2 ' <symbol:atan2>
 calld PA,#NEWF
 calld PA,#PSHM
 long $e00000 ' save registers
 mov r23, r3 ' reg var <- reg arg
 mov r21, r2 ' reg var <- reg arg
 mov r2, r21 ' CVI, CVU or LOAD
 mov r3, r23 ' CVI, CVU or LOAD
 mov r4, #23 ' reg ARG coni
 mov r5, #4 ' reg ARG coni
 mov BC, #16 ' arg size, rpsize = 16, spsize = 16
 sub SP, #12 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__float_request
 add SP, #12 ' CALL addrg
 mov r22, r0 ' CVI, CVU or LOAD
' C_atan2_8 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export floor

 alignl ' align long
C_floor ' <symbol:floor>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##@C_mod_3_L000004
 rdlong r2, r2
 ' reg ARG INDIR ADDRG
 mov r3, r23 ' CVI, CVU or LOAD
 mov r4, #24 ' reg ARG coni
 mov r5, #4 ' reg ARG coni
 mov BC, #16 ' arg size, rpsize = 16, spsize = 16
 sub SP, #12 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__float_request
 add SP, #12 ' CALL addrg
 mov r22, r0 ' CVI, CVU or LOAD
' C_floor_9 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export ceil

 alignl ' align long
C_ceil ' <symbol:ceil>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##@C_mod_3_L000004
 rdlong r2, r2
 ' reg ARG INDIR ADDRG
 mov r3, r23 ' CVI, CVU or LOAD
 mov r4, #25 ' reg ARG coni
 mov r5, #4 ' reg ARG coni
 mov BC, #16 ' arg size, rpsize = 16, spsize = 16
 sub SP, #12 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__float_request
 add SP, #12 ' CALL addrg
 mov r22, r0 ' CVI, CVU or LOAD
' C_ceil_10 ' (symbol refcount = 0)
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Import _float_request

' Catalina Cnst

DAT ' const data segment

 alignl ' align long
C_mod_3_L000004 ' <symbol:3>
 long $0 ' float

' Catalina Code

DAT ' code segment
' end
