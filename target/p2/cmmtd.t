{{
'------------------------------------------------------------------------------
' Catalina_CMM_threaded_dynamic - Implements a dynamically loadable 
'                                 multi-threaded Compact Memory Model 
'                                 intended for use by the Catalina Code 
'                                 Generator backend for LCC 
'
' Version 3.7  - initial version - by Ross Higson
' Version 3.13 - combine floating point operations, and add relative jumps
' Version 3.15 - Modified for P2.
'
'------------------------------------------------------------------------------
'
'    Copyright 2012 Ross Higson
'
'    This file is part of the Catalina Target Package.
'
'    The Catalina Target Package is free software: you can redistribute 
'    it and/or modify it under the terms of the GNU Lesser General Public 
'    License as published by the Free Software Foundation, either version 
'    3 of the License, or (at your option) any later version.
'
'    The Catalina Target Package is distributed in the hope that it will
'    be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
'    of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
'    See the GNU Lesser General Public License for more details.
'
'    You should have received a copy of the GNU Lesser General Public 
'    License along with the Catalina Target Package.  If not, see 
'    <http://www.gnu.org/licenses/>.
'
'------------------------------------------------------------------------------
}}

'--------------------- Start of CMM Kernel ------------------------------------

CON

#include <constant.inc>

' The symbol FCACHE_PRIMITIVE adds code to implement FCACHE - this can be done
' outside the kernel, but including it in the kenel is more efficient - but it
' adds 9 longs to the kernel:

#define FCACHE_PRIMITIVE

' The symbol UNROLL_LMM_LOOP does just what it says - but it adds extra 
' longs to the CMM kernel. The default is to unroll 2 times if this is not
' defined, or to unroll 4 times if it is defined:

'#define UNROLL_LMM_LOOP

' The symbol EXTERNAL_FLT_CMP forces the flt_cmp operation to the external
' FLOAT32_A plugin. This is because the CMM kernel is slightly too large to
' fit it in (until we manage to save 5 or so longs):

#define EXTERNAL_FLT_CMP

#ifdef BLACKBOX
#error : THREADED KERNEL DOES NOT CURRENTLY SUPPORT THE BLACKBOX DEBUGGER
#endif

' instruction operand shifts

' NOTE: these must match compact.inc ...
S16A = 1  ' must match compact.inc
D16A = 6  ' must match compact.inc
S16B = 2  ' must match compact.inc
D16B = 2  ' must match compact.inc
S32  = 2  ' must match compact.inc
D32  = 11 ' must match compact.inc
D32S = 21 ' must match compact.inc

' NO_INTERRUPTS - if defined, we can the use SKIPF because this code will not  
'                 be used in an interrupt service routine. Can be defined here 
'                 or on the command-line (i.e. -C NO_INTERRUPTS)

'#ifndef NO_INTERRUPTS
'#define NO_INTERRUPTS
'#endif

'--------------------- Start of CMM Kernel ------------------------------------

DAT 
         org     0
KERNEL_START

' the first $52 longs must be in the same place in all CMM kernels, to 
' allow for the separate compilation of code that uses these locations

r0       jmp     #cmm_init      '$00
r1       long    0              '$01
r2       long    0              '$02
r3       long    0              '$03

_Thread_init
r4       rdlong  r3,PTRA++      '$04 load argc
r5       rdlong  r2,PTRA++      '$05 load argv
r6       rdlong  r1,PTRA++      '$06 load return address
r7       sub     SP,#8          '$07 reserve space ...
r8       mov     xfer,SP        '$08 ... for xfer block at top of stack
r9       sub     SP,#(THREAD_BLOCK_SIZE-THREAD_EXT_OFF)*4 '$09  write -1 ...
r10      neg     t1,#1          '$0a ... to extended information ...
r11      wrlong  t1,SP          '$0b ... (i.e. we are not a pthread!)
r12      sub     SP,#(THREAD_EXT_OFF-THREAD_AFF_OFF)*4 '$0c set up ...
r13      cogid   t1             '$0d ... affinity ...
r14      shl     t1,#8          '$0e ... flags ...
r15      wrlong  t1,SP          '$0f ... and set ticks to zero
r16      sub     SP,#THREAD_AFF_OFF*4 '$10 point to begining of thread block
r17      wrlong  SP,SP          '$11 make thread block point to itself
r18      mov     TP,SP          '$12 make thread block the current thread
r19      sub     SP,#12         '$13 allow space for spilled arguments
r20      wrlong  r1,SP          '$14 set up return address
r21      ret                    '$15
r22      long    0              '$16
r23      long    0              '$17

PC       long    0              '$18 ' set up during initialization
SP       long    0              '$19 ' set up during initialization
FP       long    0              '$1a
RI       long    0              '$1b
BC       long    0              '$1c
Save_PC  long    0              '$1d

DBG1     long    0              '$1e ' Debugger opAddr
DBG2     long    0              '$1f ' Debugger temp

low8     long   $0000_00FF      '$20
low16    long   $0000_FFFF      '$21
top8     long   $FF00_0000      '$22
low18    long   $0003_FFFF      '$23
sd_mask  long   %000000_0000_0000_000011111_000011111 '$24
INST_OFF                        ' must match INST_OFF in compact.inc
inst     long   $0000_0000      '$25
dlsb     long   1<<9            '$26

' NOTE - the initial values below are used only during kernel initialization

t1       long   $0000_0000      '$27
t2       long   $0000_0000      '$28
t3       long   $0000_0000      '$29
t4       long   $0000_0000      '$2a
                          
t5       long   $0000_0000      '$2b
t6       long   $0000_0000      '$2c

xfer     long   $0000_0000      '$2d set up during initialization
                             
ct1     long  0                 '$2e
ct2     long  0                 '$2f
ct3     long  0                 '$30

table_16a
X16A_NOP     nop                '$31 
X16A_MOV     mov    0,0         '$32 
X16A_RDBYTE  rdbyte 0,0         '$33   
X16A_RDWORD  rdword 0,0         '$34   
X16A_RDLONG  rdlong 0,0         '$35   
X16A_WRBYTE  wrbyte 0,0         '$36      
X16A_WRWORD  wrword 0,0         '$37      
X16A_WRLONG  wrlong 0,0         '$38      
X16A_ADD     add    0,0         '$39      
X16A_ADDS    adds   0,0         '$3a      
X16A_AND     and    0,0         '$3b      
X16A_OR      or     0,0         '$3c      
X16A_XOR     xor    0,0         '$3d      
X16A_SUB     sub    0,0         '$3e      
X16A_SUBS    subs   0,0         '$3f      
X16A_CMP     cmp    0,0 wcz     '$41 
X16A_CMPS    cmps   0,0 wcz     '$40 
X16A_NEG     neg    0,0         '$42      
X16A_SHL     shl    0,0         '$43   
X16A_SHR     shr    0,0         '$44   
X16A_SAR     sar    0,0         '$45   
X16A_SHLI    shl    0,#0        '$46   
X16A_SHRI    shr    0,#0        '$47 
X16A_SARI    sar    0,#0        '$48   
X16A_ADDI    add    0,#0        '$49  
X16A_SUBI    sub    0,#0        '$4a  
X16A_MOVI    mov    0,#0        '$4b 
X16A_ADDSI   adds   0,#0        '$4c  
X16A_SUBSI   subs   0,#0        '$4d  
X16A_CMPI    cmp    0,#0 wcz    '$4e 
X16A_CMPSI   cmps   0,#0 wcz    '$4f
X16A_NEGI    neg    0,#0        '$50

immi_bit long   %0000_0000000_001_000000000_000000000 '$51
bit31    long   $8000_0000      '$52
all_1s   long   $FFFF_FFFF      '$53

req      long   0               '$54 ' request block address
reg      long   0               '$55 ' registry address

X16B_BRKP                       ' execute break (when debug overlay loaded)
FC_START                        ' must match FC_START in compact.inc

' cmm_init : initialize VM - note that this code may be overlaid by 
'            debug code or FCACHE code once initialization is complete.
'            It must be kept the same length as the main kernel.

DEBUG_OVERLAY
cmm_init
        rdlong  reg,PTRA++      '$56  1 load registry address (used later)   
        cogid   r2              '$57  2 register ...
        shl     r2,#2           '$58  3 ... ourselves ...
        add     r2,reg          '$59  4 ... as ...
        rdlong  req,r2          '$5a  5 ... a ...
        andn    req,top8        '$5b  6 ... new ...
        wrlong  req,r2          '$5c  7  kernel
        rdlong  PC,PTRA++       '$5d  8 load initial PC
        rdlong  SP,PTRA++       '$5e  9 load initial SP
        rdlong  r0,PTRA++       '$5f 10 load initial LUT library size (-1)
        rdlong  r1,PTRA++       '$60 11 load initial LUT library address
        setq2   r0              '$61 12 copy lut library ...
        rdlong  $100,r1         '$62 13 ... to LUT RAM, starting at $100
        mov     r0,#0           '$63 14 zero ...
        wrlong  r0,req          '$64 14 ... our request block  
        call    #_Thread_init   '$65 16 set up initial thread
        jmp     #read_next      '$66 17 we can now start executing CMM code
        nop                     '$67 18 
        nop                     '$68 19 
        nop                     '$69 20 
        nop                     '$6a 21 
        nop                     '$6b 22 
        nop                     '$6c 23 
        nop                     '$6d 24 
        nop                     '$6e 25

pasm_16 
         long   0-0             '$6f execute generated instruction 
done_16
         shr    inst,#16        '$70 decode ...
         tjnz   inst,#decode    '$71 ... another instruction ?

FC_INLINE                       ' must match FC_INLINE in compact.inc
done_32
         allowi                 '$72
         add    PC,#4           '$73 no - increment PC

EXEC_STOP                       ' must match EXEC_STOP in compact.inc
'
' check whether we should context switch (and switch if so)
'
read_next
         stalli                 '$74
         djnz   ticks,#no_swap  ' if ticks not yet zero, don't context switch
         call   #\context_switch
no_swap
         rdlong inst,PC         ' fall through to ...
decode
         mov    t1,inst         ' test ...
         and    t1,#1           ' ... instruction ...
         tjz    t1,#decode_16a  ' ... type ...
         mov    t1,inst         ' ... to ...
         and    t1,#2           ' ... determine ...
         tjz    t1,#decode_16b  ' ... how to decode
decode_32
         mov    t1,inst         ' extract ...
         shr    t1,#26          ' ... 6 bit opcode
         add    t1,#table_32
         mov    t2,inst         ' extract ...
         shr    t2,#S32         ' ... 24 bits ...
         andn   t2,top8         ' ... of src (or src & dst)
         jmp    t1
table_32
         jmp    #X32_JMPA
         jmp    #X32_CALA
         jmp    #X32_LODI
         jmp    #X32_PSHA
         jmp    #X32_PSHF
         jmp    #X32_PSHM
         jmp    #X32_BR_Z
         jmp    #X32_BRNZ
         jmp    #X32_BRAE
         jmp    #X32_BR_A
         jmp    #X32_BRBE
         jmp    #X32_BR_B
         jmp    #X32_PSHB
         jmp    #X32_CPYB
         jmp    #X32_LODA
         jmp    #X32_NEWF
         jmp    #X32_RETF
         jmp    #X32_LODF
         jmp    #X32_MOV
         jmp    #X32_MOVI
         jmp    #X32_SPILL
         jmp    #X32_CPREP
         jmp    #X32_LODS

pasm_32  long   %1111_0000000_000_000000000_000000000
         jmp    #done_32


' decode 16 bit instruction (set a)
                               
decode_16a
         mov    t2,inst         ' from instruction ....
         shr    t2,#S16A        ' ... extract ...
         sets   pasm_16,t2      ' ... src
         shr    t2,#D16A-S16A   ' ... and ...
         setd   pasm_16,t2      ' ... dst
         shr    t2,#11-D16A     ' extract 5 bits ...
         and    t2,#$1F         ' ... of op code
         add    t2,#table_16a   ' calculate addr of instruction template
         sets   set_inst,t2     ' put addr in setup instruction
         and    pasm_16,sd_mask ' mask src & dst to 5 bits each         
	 nop                    ' P2 requires this!!!
set_inst or     pasm_16,0-0     ' put instruction in place
         jmp    #pasm_16        ' execute instruction


' decode 16 bit instructions (set b)

decode_16b
         mov    t1,inst         ' extract ...
         shr    t1,#11          ' ... 5 bits ... 
         and    t1,#$1f         ' ... of op code
         add    t1,#table_16b   ' calculate jump
         jmp    t1              ' execute primitive
table_16b
         jmp    #X16B_LODF      '
         jmp    #X16B_RETF      '
         jmp    #X16B_RETN      '
         jmp    #X16B_POPM      '
         jmp    #X16B_JMPI      '
         jmp    #X16B_CALI      '
         jmp    #X16B_PSHL      '
         jmp    #X16B_DIVS      '
         jmp    #X16B_DIVU      '
         jmp    #X16B_MULT      '
         jmp    #X16B_FLTP      ' was #X16B_FADD      '
         jmp    #X16B_RJ_Z      ' was #X16B_FSUB      '
         jmp    #X16B_RJNZ      ' was #X16B_FMUL      '
         jmp    #X16B_RJAE      ' was #X16B_FDIV      '
         jmp    #X16B_RJ_A      ' was #X16B_FCMP      '
         jmp    #X16B_RJBE      ' was #X16B_FLIN      '
         jmp    #X16B_RJ_B      ' was #X16B_INFL      '
         jmp    #X16B_SYSP      '
         jmp    #X16B_EXEC      '
         jmp    #X16B_SIGN      ' 
         jmp    #X16B_CPL       ' 
         jmp    #X16B_TRN1      ' 
         jmp    #X16B_TRN2      ' 
         jmp    #X16B_LODL      ' 
         jmp    #X16B_BRKP      '
         jmp    #X16B_FCACHE    '
         jmp    #X16B_PASM      '
         jmp    #X16B_CPREP     '
         jmp    #X16B_JMPR      '

X16B_POPM     
         rdlong RI,SP           ' load ...
         add    SP,#4           ' ... register specification to pop
         mov    t2,#r23         ' start with ...
         shl    RI,#(32-24)     ' ... r23         
pop_nxt
         shl    RI,#1 wcz       ' load rX?
   if_c  altd   t2 
   if_c  rdlong 0-0,SP          ' ... load ...
   if_c  add    SP,#4           ' ... the register
   if_z  jmp   #pop_done
         sub    t2,#1           ' point to previous register
         jmp    #pop_nxt        ' continue till all registers popped
pop_done mov    t2,inst         ' extract ...
         and    t2,#$1FC wz     ' ... frame size (7 bits, multiple of 4)
         test   inst,frm_bit wz ' pop frame ?
   if_z  jmp    #X32_RETF       ' yes - pop frame (and execute implied return)
         test   inst,ret_bit wz ' no - return ?
   if_z  jmp    #X16B_RETN      ' yes
         jmp    #done_16        ' no - just carry on executing instructions

frm_bit  long   1<<(7+S16B)     ' bit to test for frame pop (pop if zero)
ret_bit  long   1<<(8+S16B)     ' bit to test for return (return if zero)

X16B_PSHL        
         sub    SP,#4           ' decrement SP
         wrlong RI,SP           ' save value on stack
         jmp    #done_16
X16B_JMPI        
         mov    PC,RI
         jmp    #read_next

'X16B_DIVS - Signed 32 bit division
'        Divisor  : r1
'        Dividend : r0
'        Result   :
'           Quotient in r0
'           Remainder in r1

X16B_DIVS
         call   #\signed_d32     ' perform signed division
         jmp    #done_16

'X16B_DIVU - unsigned 32 bit division 
'        Divisor  : r1
'        Dividend : r0
'        Result   :
'           Quotient in r0
'           Remainder in r1

X16B_DIVU
        call    #\unsigned_d32   ' perform unsigned division
        jmp     #done_16

' X16B_MULT - multiplication
'        r0 : 1st operand (32 bit)
'        r1 : 2nd operand (32 bit)
'        Result :
'           Product in r0 (<= 32 bit)

X16B_MULT
         qmul   r0,r1
         getqx  r0
         jmp    #done_16
'
'
' X16B_SYSP - call a plugin
' On entry:
'        R3 = code:
'            - cog id if >= 128 (i.e. $80 + cog id)
'            - plugin type if < 128 (i.e. 0 .. 127)
'            - service id if < 0
'        R2 = data (optional pointer)
' 
' NOTES: Locks are currently only supported when invoking via a service id.
'        When using service id, the data should only use the lower 24 bits.
'
' On exit:
'        R0 = result
'
X16B_SYSP
         call    #\do_plugin    ' do_plugin does all the work
         jmp     #done_16

'
' X16B_PASM - Execute one long (starting at next long boundary) as an instruction.
'
X16B_PASM
         andn   PC,#3           ' align PC to long
         add    PC,#4           ' point to next long
         rdlong exec1a,PC       ' fetch the instruction
         add    PC,#4           ' point to next long
	 nop                    ' P2 requires this!!!
exec1a   long   0-0
         jmp    #\EXEC_STOP      ' done
'
' X16B_EXEC - Execute multiple longs (starting at next long boundary) as instructions.
'            To exit, execute the instruction "jmp #EXEC_STOP"
X16B_EXEC
         andn   PC,#3           ' align PC to long
         add    PC,#4           ' point to next long
exec_loop
         rdlong exec1b,PC
         add    PC,#4           ' point to next long
	 nop                    ' P2 requires this!!!
exec1b   long   0-0
#ifdef UNROLL_LMM_LOOP
         rdlong exec2,PC
         add    PC,#4           ' point to next long
	 nop                    ' P2 requires this!!!
exec2    long   0-0
         rdlong exec3,PC
         add    PC,#4           ' point to next long
	 nop                    ' P2 requires this!!!
exec3    long   0-0
         rdlong exec4,PC
         add    PC,#4           ' point to next long
	 nop                    ' P2 requires this!!!
exec4    long   0-0
#endif
         jmp    #exec_loop
'
'------------------------------------------------------------------------------
' Float32 Assembly language routines
'------------------------------------------------------------------------------
'
'------------------------------------------------------------------------------
' X16B_FLTP - invoke the floating point plugin
'
' input:   t1          service to request
'          r0          32-bit floating point value
'          r1          32-bit floating point value 
' output:  r0          32-bit floating point result
'------------------------------------------------------------------------------
'
X16B_FLTP
         mov     t5,r2          ' save r2
         mov     t6,r3          ' save r3
         mov     r3,inst        ' get floating point ...
         shr     r3,#S16B       ' ... operation ...
         and     r3,#$1f        ' ... code
#ifndef EXTERNAL_FLT_CMP
         cmp     r3,#SVC_FLOAT_CMP wz
   if_z  jmp     #X16B_FCMP
#endif
         neg     r3,r3          ' negate it (to call a service)
#ifndef DEBUG
         mov     r2,xfer        ' r2 = data is address of xfer block
         mov     t1,xfer        ' write ...
         wrlong  r0,t1          ' ... first argument to xfer block
         add     t1,#4          ' write ...
         wrlong  r1,t1          ' ... second argument to xfer block
         call    #\do_plugin    ' request the service
         mov     r2,t5          ' restore r2
         mov     r3,t6          ' restore r3
         cmps    r0,#0 wcz      ' set C & Z flags according to result
         jmp     #done_16
#endif
'       
#ifndef EXTERNAL_FLT_CMP
X16B_FCMP        
         mov     t1, r0         ' compare signs
         xor     t1, r1
         and     t1, Bit31 wz
  if_z   jmp     #cmp1          ' same, then compare magnitude

         mov     t1, r0         ' check for +0 or -0
         or      t1, r1
         andn    t1, Bit31 wcz
  if_z   jmp     #done_16

         test    r0, Bit31 wc   ' compare signs
         jmp     #done_16

cmp1     test    r0, Bit31 wz   ' check signs
  if_nz  jmp     #cmp2
         cmp     r0, r1 wcz
         jmp     #done_16
cmp2     cmp     r1, r0 wcz   ' reverse test if negative
         jmp     #done_16
#endif
'
' X32_CPYB - copy a structure (size in bytes at the PC)
'           from the address in R1 to the address in R0
'
X32_CPYB
         mov    t1,r1           ' source is in r1
         mov    t4,r0           ' destination is in r0
                                ' fall through to ...
copy_bytes
         tjz    t2,#done_32     ' no more to copy
         rdbyte t3,t1           ' read from src to t3
         wrbyte t3,t4           ' write t3 to dst
         add    t1,#1           ' increment source
         add    t4,#1           ' increment destination
         sub    t2,#1           ' decrement count ...
         jmp    #copy_bytes     ' ... and keep copying
'
X16B_LODL  
         add    PC,#4           ' point to next long
         rdlong RI,PC           ' read the long
         andn   PC,#3           ' align PC to long boundary
         mov    pasm_16,X16A_MOV ' set up 'mov' instruction
         mov    t3,#RI          ' set up src
X16B_set_src_dst
         mov    t2,inst         ' set up ...
         shr    t2,#D16B        ' ...
'         and    t2,#$1FF        ' ... 
         setd   pasm_16,t2      ' ... dst ...
         sets   pasm_16,t3      ' and src 
         jmp    #pasm_16       
X16B_TRN1        
         mov    t3,#low8
         jmp    #X16B_set_and
X16B_TRN2        
         mov    t3,#low16
X16B_set_and 
         mov    pasm_16,X16A_AND ' set up 'and' instruction
         jmp    #X16B_set_src_dst
X16B_SIGN        
         mov    t3,#bit31
         jmp    #X16B_set_xor
X16B_CPL        
         mov    t3,#all_1s
X16B_set_xor
         mov    pasm_16,X16A_XOR ' set up 'xor' instruction
         jmp    #X16B_set_src_dst
'
X16B_LODF
         mov    t2,inst         ' 9 bit src
         shl    t2,#(32-S16B-9) ' sign ...
         sar    t2,#(32-9)      ' ... extend
         mov    RI,FP
         adds   RI,t2    
         jmp    #done_16
'
X16B_FCACHE
#ifdef FCACHE_PRIMITIVE
         mov    t1,inst         ' set up ...
         shr    t1,#S16B        ' ... instruction count ...
         and    t1,#$1FF        ' ... in t1
         setd   finst,#FC_START ' start at FCACHE cog addr
	 nop                    ' P2 requires this!!!
floop
         add    PC,#4           ' point to next long
finst
         rdlong 0-0,PC          ' load inst to FCACHE
         add    finst,dlsb      ' next cog addr
         djnz   t1,#floop       ' continue until all inst loaded
         jmp    #FC_START       ' start execution of FCACHE
#endif
'
X16B_CPREP
         mov    BC,inst         ' put ...
         shr    BC,#4-(S16B-2)  ' ... upper 5 bits of src ...
         and    BC,#$7C         ' ... (multiplied by 4) into BC
         mov    t2,inst         ' subtract lower 4 bits of src ...
'         shr    t2,#S16B-2     ' ... (eliminating shift - not required!) ...
         and    t2,#$3C         ' ... (mutltiplied by 4) ... 
         sub    SP,t2           ' ... from SP
         jmp    #done_16

X16B_CALI
         mov    t2,RI           ' fall through to ...
X32_CALA
         add    PC,#4           ' increment PC (this is return address)
         sub    SP,#8           ' save ...
         wrlong PC,SP           ' ... PC 
                                ' fall through to ...
X32_JMPA
         mov    PC,t2     
         jmp    #read_next
X32_LODI  
         rdlong RI,t2   
         jmp    #done_32
X32_PSHF     
         shl    t2,#8           ' sign ...
         sar    t2,#8           ' ... extend
         adds   t2,FP
                                ' fall through to ...
X32_PSHA  
         rdlong RI,t2
         sub    SP,#4
         wrlong RI,SP   
         jmp    #done_32
X32_PSHM     
         mov    t1,t2           ' save register specification for later
         mov    t3, #r6         ' start with ...
         shr    t2,#6           ' ... r6 
push_nxt
         shr    t2,#1 wcz       ' save rX?
   if_c  sub    SP,#4           ' yes - save ...
   if_c  altd   t3
   if_c  wrlong 0-0,SP          ' ... register
         add    t3,#1           ' point to next register
   if_nz jmp    #push_nxt       ' continue till all registers checked
         sub    SP,#4           ' save ...
         wrlong t1,SP           ' .... register specification
         jmp    #done_32
'
X32_BRNZ     
   if_nz jmp    #X32_JMPA
         jmp    #done_32
X32_BR_Z  
   if_z  jmp    #X32_JMPA
         jmp    #done_32
X32_BRAE     
   if_ae jmp    #X32_JMPA
X32_BR_A     
   if_a  jmp    #X32_JMPA
         jmp    #done_32
X32_BRBE     
   if_be jmp    #X32_JMPA
X32_BR_B     
   if_b  jmp    #X32_JMPA
         jmp    #done_32
'
X16B_RJNZ
   if_nz jmp    #X16B_JMPR
         jmp    #done_16
X16B_RJ_Z
   if_z  jmp    #X16B_JMPR
         jmp    #done_16
X16B_RJAE
   if_ae jmp    #X16B_JMPR
X16B_RJ_A
   if_a  jmp    #X16B_JMPR
         jmp    #done_16
X16B_RJBE
   if_be jmp    #X16B_JMPR
X16B_RJ_B
   if_ae jmp    #done_16
X16B_JMPR
         shl    inst,#(32-S16B-9) ' sign ...
         sar    inst,#(32-9)      ' ... extend
         add    PC,inst         ' add relative jump to PC
         jmp    #read_next
'
' X32_PSHB - push a structure (size in bytes at the PC) pointed to by R0
'          onto the stack, decrementing the SP
'
X32_PSHB
         mov    t3,t2           ' round up the count ...
         add    t3,#3           ' ... to be ...
         andn   t3,#3           ' ... a multiple of 4
         sub    SP,t3           ' decrement SP by rounded up size
         mov    t1,r0           ' source is in r0
         mov    t4,SP           ' destination is SP
         jmp    #copy_bytes     ' do the copy
'
X32_MOV     
         andn   pasm_32,immi_bit ' clear immediate bit
         jmp    #X32_MOVx
X32_MOVI
         or     pasm_32,immi_bit ' set immediate bit
X32_MOVx
         setr   pasm_32,#%0110000_00 ' mov
X32_SD
         andn   pasm_32,low18   ' clear out old src & dst
         or     pasm_32,t2      ' include 9 bits src and 9 bits dst
         jmp    #pasm_32
X32_SPILL
         sub    BC,#4
         cmp    BC,RI wcz  
   if_b  jmp    #done_32
         andn   pasm_32,immi_bit ' clear immediate bit
         or     t2,#BC          ' set src to BC (dst is ok, src should be zero)
         setr   pasm_32,#%1100011_00 ' wrlong
         jmp    #X32_SD
X32_CPREP
         mov    BC,t2           ' put upper 9 bits of src (i.e. dst)
         shr    BC,#9           ' ... in BC
         and    t2,#$1FF        ' subtract lower 9 bits of src ...
         jmp    #X32_SUBSP      ' ... from SP
X32_LODA  
         mov    RI,t2
         jmp    #done_32
X32_LODS
         mov    t1,t2           ' set ...
         shr    t1,#19          ' ... dst register ...
         setd   X32_LODd,t1     ' ... in move instruction
         shl    t2,#13          ' extract ...
         sar    t2,#13          ' src (sign extended immediate)
X32_LODd mov    0-0,t2          ' mov src to dst
         jmp    #done_32
X32_NEWF        
         sub    SP,#4           ' decrement the stack pointer
         wrlong FP,SP           ' save FP to stack
         mov    FP,SP           ' set up new FP
         add    BC,#8           ' calculate what SP was ...
         add    BC,FP           ' ... before arguments were pushed
X32_SUBSP
         sub    SP,#4           ' allow for alloca
         wrlong Bit31,SP        ' initialize pre-alloca SP (to a known value)
         sub    SP,t2           ' allocate frame
         jmp    #done_32
X16B_RETF  
         mov    t2,inst         ' extract 9 bit ...
         shr    t2,#S16B        ' ...
         and    t2,#$1FF        ' ... src, and fall through to X32_RETF
X32_RETF  
         add    SP,t2           ' deallocate frame      
         add    SP,#4           ' allow for alloca
         rdlong FP,SP           ' restore previous FP
         add    SP,#4           ' increment the SP
FC_RETURN                       ' must match FC_RETURN in compact.inc
X16B_RETN                     
         rdlong PC,SP           ' read the PC
         add    SP,#8           ' increment the SP
         jmp    #read_next
X32_LODF
         shl    t2,#8           ' sign ...
         sar    t2,#8           ' ... extend
         mov    RI,FP
         adds   RI,t2    
         jmp    #done_32

'-------------------------- Multi-Threading Support ----------------------------

' These must be in the same place in all the threaded kernels of the 
' same 'flavor' (i.e. CMM, LMM, NMM etc). 

         fit    $1e4
         orgf   $1e4

ticks    long   100             ' time till next thread swap (~10 milliseconds)
flags    long   0               ' used for storing flags
TP       long   0               ' current thread pointer
lock     long   -1              ' lock to use for context switching

'-------------------------- end Multi-Threading Support ------------------------
          
' initcog & lockbits must be in the same place in all CMM kernels

         fit    $1e8                  
         orgf   $1e8

' initcog (cannot be executed using CMM because rdlongs interrupt the setq)
'    r4 points to data block (REGISTRY, PC, SP)
'    r0 contains cog id (or ANY_COG)
'    r3 contains pointer to code to load into cog

initcog
         setq r4                ' this will end up in PTRA of new cog
  _ret_  coginit r0,r3 wc

lockbits long   0               ' lockbits used to simulate P1-style locks

' The last 5 longs are reserved for debug overlay vectors (or debug LED)

         fit    $1eb                  
         orgf   $1eb
DEBUG_VECTORS
#ifdef DEBUG_LED
led_mask
         long   |< (_DEBUG_PIN-32)    
hex_value
         long   $10203040
hex_count
         long   $0
flash_count
         long   $0
         long   $0
#else
         long   DEBUG_BREAK
         long   DEBUG_ADDR
         long   DEBUG_OUT
         long   DEBUG_IN
         long   DEBUG_FLAG
#endif
         fit    $1f0

'------------------------- END OF KERNEL --------------------------------------

         org $300

' Common Kernel library functions. This code is included only to get the LUT
' offsets correct in the dynamically loaded kernel. The actual LUT code is 
' loaded into LUT from elsewhere. There must be a better way to do this, but I
' can't think of one at the moment :(

#include "klib.inc"

#include "cmmklib.inc"

#include "thlib.inc"

