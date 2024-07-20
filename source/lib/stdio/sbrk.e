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

' Catalina Code

DAT ' code segment

' Catalina Export _sbrk

 alignl ' align long

'
' WARNING - The following code only supports memory models where
'           the heap is in Hub RAM.
'           See sbrk_large.e for a large memory model version
'
C__sbrk
#ifdef P2
#ifdef NATIVE
 rdlong r0, ##@sbrkval  ' r0 <- sbrkval
 mov r1, r2 ' r1 <- amount
 cmps r1, #0 wcz
 if_a add r1, #3
 andn r1, #3 ' r1 <- amount rounded to long
 rdlong r3, ##@sbrkval ' r3 <- sbrkval 
 adds r1, r3 ' r1 <- sbrkval + amount
 rdlong r3, ##@sbrkbeg ' r3 <- sbrkbeg
 cmp r1, r3 wcz
 if_b jmp #C__sbrk_L1 ' <- err if sbrkval + amount < sbrkbeg
 ' we cannot do this check because in a multi-threaded 
 ' program our stack may be allocated on the heap!
 ' cmp r1, PTRA wcz
 ' if_a jmp #C__sbrk_L1 ' err if sbrkval + amount > SP
 wrlong r1, ##@sbrkval ' sbrkval <- sbrkval + amount
 jmp #C__sbrk_L2
C__sbrk_L1
 rdlong r0, ##@sbrkerr
C__sbrk_L2
 PRIMITIVE(#RETN)
#else
 PRIMITIVE(#LODL)
 long @sbrkval
 rdlong r0, RI ' r0 <- sbrkval
 'add r0, BA
 mov r1, r2 ' r1 <- amount
 cmps r1, #0 wcz
 if_a add r1, #3
 andn r1, #3 ' r1 <- amount rounded to long
 PRIMITIVE(#LODL)
 long @sbrkval
 rdlong r3, RI ' r3 <- sbrkval 
 'add r3, BA 
 adds r1, r3 ' r1 <- sbrkval + amount 
 PRIMITIVE(#LODL)
 long @sbrkbeg
 rdlong r3, RI  ' r3 <- sbrkbeg
 'add r3, BA 
 cmp r1, r3 wcz 
 PRIMITIVE(#BR_B) ' <- err if sbrkval + amount < sbrkbeg
 long @C__sbrk_L1
 ' we cannot do this check because in a multi-threaded 
 ' program our stack may be allocated on the heap!
 ' cmp r1, SP wcz
 ' PRIMITIVE(#BR_A) ' err if sbrkval + amount > SP
 ' long @C__sbrk_L1
 PRIMITIVE(#LODL)
 long @sbrkval
 'sub r1, BA 
 wrlong r1, RI ' sbrkval <- sbrkval + amount
 PRIMITIVE(#JMPA)
 long @C__sbrk_L2
C__sbrk_L1
 PRIMITIVE(#LODL)
 long @sbrkerr
 rdlong r0, RI
C__sbrk_L2
 PRIMITIVE(#RETN)
#endif
#else
 PRIMITIVE(#LODL)
 long @sbrkval
 rdlong r0, RI ' r0 <- sbrkval
 'add r0, BA
 mov r1, r2 ' r1 <- amount
 cmps r1, #0 wz,wc
 if_a add r1, #3
 andn r1, #3 ' r1 <- amount rounded to long
 PRIMITIVE(#LODL)
 long @sbrkval
 rdlong r3, RI ' r3 <- sbrkval 
 'add r3, BA 
 adds r1, r3 ' r1 <- sbrkval + amount 
 PRIMITIVE(#LODL)
 long @sbrkbeg
 rdlong r3, RI  ' r3 <- sbrkbeg
 'add r3, BA 
 cmp r1, r3 wz,wc 
 PRIMITIVE(#BR_B) ' <- err if sbrkval + amount < sbrkbeg
 long @C__sbrk_L1
 ' we cannot do this check because in a multi-threaded 
 ' program our stack may be allocated on the heap!
 ' cmp r1, SP wz,wc
 ' PRIMITIVE(#BR_A) ' err if sbrkval + amount > SP
 ' long @C__sbrk_L1
 PRIMITIVE(#LODL)
 long @sbrkval
 'sub r1, BA 
 wrlong r1, RI ' sbrkval <- sbrkval + amount
 PRIMITIVE(#JMPA)
 long @C__sbrk_L2
C__sbrk_L1
 PRIMITIVE(#LODL)
 long @sbrkerr
 rdlong r0, RI
C__sbrk_L2
 PRIMITIVE(#RETN)
#endif

' Catalina Init

DAT ' initialized data segment
 alignl ' align long
sbrkbeg long @sbrkinit
sbrkval long @sbrkinit
sbrkerr long -1

' end C__sbrk

' Catalina Code

DAT ' code segment

' Catalina Export sbrk

' Catalina Import _memory_lock

' Catalina Import _memory_unlock

 alignl ' align long

C_sbrk
 mov r3,r2                 ' save parameter for _sbrk()
 PRIMITIVE(#CALA)
 long @C__memory_lock      ' (assuming _memory_lock() does not use r3)
 mov r2,r3                 ' restore parameter
 PRIMITIVE(#CALA)
 long @C__sbrk             ' call _sbrk()
 mov r3,r0                 ' save result of _sbrk()
 PRIMITIVE(#CALA)
 long @C__memory_unlock    ' (assuming _memory_unlock() does not use r3)
 mov r0,r3                 ' return result of _sbrk()
 PRIMITIVE(#RETN)

' end C_sbrk

