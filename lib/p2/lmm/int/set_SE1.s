'#line 1 "set_SE1.e"
' The use of PRIMITIVE allows the library source files to be (mostly)
' identical for both the P1 and 1 . We define it here appropriately
' and preprocess the files when building the library.












' Catalina Code

DAT ' code segment

' Catalina Export _set_SE1

 alignl ' align long

C__set_S_E_1
   setse1 r2
 jmp #RETN
' end

