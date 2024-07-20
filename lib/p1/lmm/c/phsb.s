'#line 1 "phsb.e"
' The use of PRIMITIVE allows the library source files to be (mostly)
' identical for both the P1 and P2. We define it here appropriately
' and preprocess the files when building the library.












' Catalina Code

DAT ' code segment

' Catalina Export _phsb

 alignl ' align long

C__phsb



 mov r0, PHSB
 andn r0, r3
 and r2, r3
 or r2, r0
 mov r0, PHSB
 mov PHSB, r2

 jmp #RETN
' end

