' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export _unmount

 alignl ' align long
C__unmount ' <symbol:_unmount>
 mov r0, #0 ' reg <- coni
' C__unmount_2 ' (symbol refcount = 0)
 calld PA,#RETN

' end
