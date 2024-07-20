'#line 1 "memlock.e"
' The use of PRIMITIVE allows the library source files to be (mostly)
' identical for both the P1 and 1 . We define it here appropriately
' and preprocess the files when building the library.












' Catalina Code






DAT ' code segment

' Catalina Export _memory_get_lock

 alignl ' align long

C__memory_get_lock




 jmp #LODL
 long MEM_LOCK
 rdlong r0,RI






 jmp #RETN

' end C__memory_get_lock


' Catalina Export _memory_set_lock

 alignl ' align long

C__memory_set_lock




 jmp #LODL
 long MEM_LOCK





 rdlong r0,RI
 wrlong r2,RI
 jmp #RETN

' end C__memory_set_lock


' Catalina Export _memory_lock

 alignl ' align long

C__memory_lock




 jmp #LODL
 long MEM_LOCK

 rdlong r2,RI
 cmps r2, #0 wc              ' C = 1 if no lock currently in use



 jmp #BR_B
 long @C__memory_lock_1      ' if no lock in use, just return

C__memory_lock_0
        bith    lockbits, r2 wcz   ' have we acquired ...
 if_nz  locktry r2 wc              ' ... both intra-cog and inter-cog locks?
 if_nc_and_nz  bitl lockbits, r2   ' true = if_c_and_nz, false = if_nc_or_z



 jmp #BRAE
 long @C__memory_lock_2            ' if we failed to get the lock try again
 jmp #BR_Z
 long @C__memory_lock_2            ' if we failed to get the lock try again
 jmp #JMPA
 long @C__memory_lock_1            ' if we got the lock just return

C__memory_lock_2














 jmp #JMPA
 long @C__memory_lock_0            ' keep trying






















C__memory_lock_1
 jmp #RETN

' end C__memory_lock


' Catalina Export _memory_unlock

 alignl ' align long

C__memory_unlock




 jmp #LODL
 long MEM_LOCK

 rdlong r2,RI wc             ' C = 1 if no lock currently in use



 jmp #BR_B
 long @C__memory_unlock_1    ' return if no lock in use

 lockrel r2                  ' if a lock is in use ...
 bitl lockbits, r2           ' ... unlock it









C__memory_unlock_1
 jmp #RETN

' end C__memory_unlock

