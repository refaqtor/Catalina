'#line 1 "lockret.e"
' The use of PRIMITIVE allows the library source files to be (mostly)
' identical for both the P1 and 1 . We define it here appropriately
' and preprocess the files when building the library.












' Catalina Code

DAT ' code segment

' Catalina Export _lockret

 alignl ' align long

C__lockret
 lockret r2
 jmp #RETN
' end

