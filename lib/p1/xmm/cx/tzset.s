' Catalina Code

DAT ' code segment
'
' LCC 4.2 (LARGE) for Parallax Propeller
' (Catalina v2.5 Code Generator by Ross Higson)
'

' Catalina Export tzset

 alignl ' align long
C_tzset ' <symbol:tzset>
 jmp #NEWF
 mov BC, #0 ' arg size, rpsize = 0, spsize = 0
 jmp #CALA
 long @C__tzset ' CALL addrg
' C_tzset_1 ' (symbol refcount = 0)
 jmp #RETF


' Catalina Import _tzset
' end
