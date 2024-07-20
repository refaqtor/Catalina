' The use of PRIMITIVE allows the library source files to be (mostly) 
' identical for both the P1 and P2. We define it here appropriately
' and preprocess the files when building the library.
#ifndef PRIMITIVE
#ifdef P2
#ifdef NATIVE
#define PRIMITIVE(op) calld PA, op
#else
#define PRIMITIVE(op) jmp op
#endif
#else
#define PRIMITIVE(op) jmp op
#endif
#endif

'
' Call the graphics plugin
' on entry:
'   r2 = parameter
'   r3 = command
'

' Catalina Import _cgi_cog

' Catalina Code

DAT ' code segment

' Catalina Export _setcommand

 alignl ' align long

C__setcommand
 shl r3, #16
 or  r2, r3
 PRIMITIVE(#LODI)
 long @C__cgi_cog
 mov r3, RI
 PRIMITIVE(#SYSP)
 PRIMITIVE(#RETN)
' end    C__setcommand

