' Catalina Code

DAT ' code segment
'
' LCC 4.2 (LARGE) for Parallax Propeller
' (Catalina v2.5 Code Generator by Ross Higson)
'

' Catalina Init

DAT ' initialized data segment

' Catalina Export __pstart

 alignl ' align long
C___pstart ' <symbol:__pstart>
 long $ffffffff

' Catalina Data

DAT ' uninitialized data segment

' Catalina Export __vi

 alignl ' align long
C___vi ' <symbol:__vi>
 byte 0[52]

' Catalina Export __fdtab

 alignl ' align long
C___fdtab ' <symbol:__fdtab>
 byte 0[256]

' Catalina Code

DAT ' code segment
' end
