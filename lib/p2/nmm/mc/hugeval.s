' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export __huge_val

 alignl ' align long
C___huge_val ' <symbol:__huge_val>
 mov r0, ##@C___huge_val_2_L000003
 rdlong r0, r0 ' reg <- INDIRF4 addrg
' C___huge_val_1 ' (symbol refcount = 0)
 calld PA,#RETN


' Catalina Cnst

DAT ' const data segment

 alignl ' align long
C___huge_val_2_L000003 ' <symbol:2>
 long $7f800000 ' float

' Catalina Code

DAT ' code segment
' end
