' Catalina Code

DAT ' code segment

' Catalina Export _rqpin

 alignl ' align long

C__rqpin
 word I16B_EXEC
 alignl ' align long
 rqpin r0, r2 wc
 bitc r0, #31
 jmp #EXEC_STOP
' end

