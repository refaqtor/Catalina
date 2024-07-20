' Catalina Code

DAT ' code segment

' Catalina Export _set_int_3

 alignl ' align long

C__set_int_3
  word I16B_EXEC
 alignl ' align long
   cogid   r0
   shl     r0, #2
   sub     r2, #30*4   ' top 30 longs of stack space are register save area
   jmp     #EXEC_STOP
   long I32_LODA + @C__set_int_3_stack<<S32
   word I16A_ADD + RI<<D16A + r0<<S16A
   word I16A_WRLONG + r2<<D16A + RI<<S16A
 alignl ' align long
   long I32_LODA + @C__set_int_3_function<<S32
   word I16A_ADD + RI<<D16A + r0<<S16A
   word I16A_WRLONG + r3<<D16A + RI<<S16A
 alignl ' align long
   long I32_LODA + @.call_isr_3<<S32
   long I32_MOV + ijmp3<<D32 + RI<<S32
   word I16B_PASM
 alignl ' align long
   setint3 r4
   long I32_JMPA + @.exit_set_3<<S32

.call_isr_3
   stalli
   cogid   t2
   shl     t2, #2
   add     t2, ##@C__set_int_3_stack
   rdlong  t2, t2
   mov     Save_PC, iret3 ' Save PC and flags
   setq    #30-1         ' save 30 registers ...
   wrlong  r0, t2         ' ... to register save area
   mov     SP, t2
   cogid   t2
   shl     t2, #2
   add     t2, ##@C__set_int_3_function
   rdlong  RI, t2
   allowi

   mov     PC, ##@.enter_CMM_isr_3
   jmp     #\read_next
.enter_CMM_isr_3
   word I16B_CALI
 alignl ' align long
   long I32_LODA + @.exit_CMM_isr_3<<S32
   word I16B_PASM
 alignl ' align long
   jmp     RI
.exit_CMM_isr_3

   stalli
   cogid   t2
   shl     t2, #2
   add     t2, ##@C__set_int_3_stack
   rdlong  t2, t2
   setq    #30-1         ' load 30 registers ...
   rdlong  r0, t2         ' ... from register save area
   mov     iret3, Save_PC ' restore PC and flags
   allowi
   reti3

.exit_set_3
   word I16B_RETN
' end

' Catalina Init

DAT ' initialized data segment
 alignl ' align long
C__set_int_3_stack    long 0[16]
C__set_int_3_function long 0[16]

