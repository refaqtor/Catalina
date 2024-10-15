'#line 1 "initlp.e"
' The use of PRIMITIVE allows the library source files to be (mostly)
' identical for both the P1 and 1 . We define it here appropriately
' and preprocess the files when building the library.












'
' LMM PASM implementations of fundamental multi-threading lock operations
'
' int _thread_init_lock_pool (void *pool, int size, int lock);
'    initialize a pool of locks
' on entry:
'    r2 = lock to use for this pool (0 .. 7 on P1, 0 .. 15 on 1)
'    r3 = size of this pool
'    r4 = pointer to pool (size + 5, long aligned) bytes of Hub RAM
' on exit:
'    r0 = 0 on success, -1 on failure
'
' Catalina Code

DAT ' code segment

' Catalina Import _thread_id

' Catalina Export _thread_init_lock_pool

 alignl ' align long

C__thread_init_lock_pool
 mov RI, r4             ' write size ...
 mov BC, r3



 wrlong BC, RI          ' ... to the pool

 add r4, #4
 mov RI, r4             ' write lock ...
 mov BC, r2



 wrbyte BC, RI          ' ... to the pool

:thr_pool_fill
 add r4, #1             ' initialize all pool locks ...
 sub r3, #1
 cmp r3, #0 wz

 if_z jmp #@:thr_pool_done




 mov RI, r4
 mov BC, #0



 wrbyte BC, RI


 jmp #@:thr_pool_fill   ' ... to zero (unallocated)




:thr_pool_done
 mov r0, #0
 calld PA,#RETN
' end
