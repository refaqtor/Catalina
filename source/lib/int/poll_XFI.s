'#line 1 "poll_XFI.e"
' The use of PRIMITIVE allows the library source files to be (mostly)
' identical for both the P1 and 1 . We define it here appropriately
' and preprocess the files when building the library.












' Catalina Code

DAT ' code segment

' Catalina Export _poll_XFI

 alignl ' align long

C__poll_X_F_I_
   POLLXFI wc
 if_c mov r0, #1
 if_nc mov r0, #0
 calld PA,#RETN
' end

