'#line 1 "phsb.e"
' The use of PRIMITIVE allows the library source files to be (mostly)
' identical for both the P1 and 1 . We define it here appropriately
' and preprocess the files when building the library.












' Catalina Code

DAT ' code segment

' Catalina Export _phsb

 alignl ' align long

C__phsb

 ERROR: "phsb not implemented on the P2"








 jmp #RETN
' end

