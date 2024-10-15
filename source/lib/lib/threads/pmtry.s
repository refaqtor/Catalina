' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export pthread_mutex_trylock

 alignl ' align long
C_pthread_mutex_trylock ' <symbol:pthread_mutex_trylock>
 calld PA,#NEWF
 calld PA,#PSHM
 long $f80000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r22, r23 ' CVI, CVU or LOAD
 cmp r22,  #0 wz
 if_nz jmp #\C_pthread_mutex_trylock_3  ' NEU4
 mov r22, #22 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_3
 mov BC, #0 ' arg size, rpsize = 0, spsize = 0
 calld PA,#CALA
 long @C__thread_stall ' CALL addrg
 mov r22, r23
 adds r22, #12 ' ADDP4 coni
 rdlong r22, r22 ' reg <- INDIRI4 reg
 cmps r22,  #0 wcz
 if_a jmp #\C_pthread_mutex_trylock_5 ' GTI4
 mov r2, ##@C__P_thread_P_ool ' reg ARG ADDRG
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C__thread_locknew ' CALL addrg
 mov r20, r23
 adds r20, #12 ' ADDP4 coni
 wrlong r0, r20 ' ASGNI4 reg reg
C_pthread_mutex_trylock_5
 mov BC, #0 ' arg size, rpsize = 0, spsize = 0
 calld PA,#CALA
 long @C__thread_allow ' CALL addrg
 mov r22, r23
 adds r22, #12 ' ADDP4 coni
 rdlong r22, r22 ' reg <- INDIRI4 reg
 mov r20, ##-1 ' reg <- con
 cmps r22, r20 wz
 if_nz jmp #\C_pthread_mutex_trylock_7 ' NEI4
 mov r22, #12 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_7
 rdlong r22, r23 ' reg <- INDIRI4 reg
 cmps r22,  #1 wz
 if_nz jmp #\C_pthread_mutex_trylock_9 ' NEI4
 mov r22, r23
 adds r22, #4 ' ADDP4 coni
 rdlong r22, r22 ' reg <- INDIRP4 reg
 cmp r22,  #0 wz
 if_z jmp #\C_pthread_mutex_trylock_11 ' EQU4
 mov r22, #16 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_11
 mov BC, #0 ' arg size, rpsize = 0, spsize = 0
 calld PA,#CALA
 long @C_pthread_self ' CALL addrg
 mov r20, r23
 adds r20, #4 ' ADDP4 coni
 rdlong r20, r20 ' reg <- INDIRP4 reg
 mov r22, r0 ' CVI, CVU or LOAD
 cmp r20, r22 wz
 if_nz jmp #\C_pthread_mutex_trylock_13  ' NEU4
 mov r22, #45 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_13
C_pthread_mutex_trylock_9
 mov BC, #0 ' arg size, rpsize = 0, spsize = 0
 calld PA,#CALA
 long @C_pthread_self ' CALL addrg
 mov r21, r0 ' CVI, CVU or LOAD
 rdlong r22, r23 ' reg <- INDIRI4 reg
 cmps r22,  #2 wz
 if_nz jmp #\C_pthread_mutex_trylock_15 ' NEI4
 mov r22, r23
 adds r22, #4 ' ADDP4 coni
 rdlong r22, r22 ' reg <- INDIRP4 reg
 cmp r22,  #0 wz
 if_nz jmp #\C_pthread_mutex_trylock_17  ' NEU4
 mov r22, r23
 adds r22, #12 ' ADDP4 coni
 rdlong r2, r22 ' reg <- INDIRI4 reg
 mov r3, ##@C__P_thread_P_ool ' reg ARG ADDRG
 mov BC, #8 ' arg size, rpsize = 8, spsize = 8
 sub SP, #4 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__thread_lockset
 add SP, #4 ' CALL addrg
 mov r19, r0 ' CVI, CVU or LOAD
 cmps r19,  #0 wz
 if_z jmp #\C_pthread_mutex_trylock_19 ' EQI4
 mov r22, r23
 adds r22, #4 ' ADDP4 coni
 wrlong r21, r22 ' ASGNP4 reg reg
 mov r0, #0 ' reg <- coni
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_19
 mov r22, #16 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_17
 mov r22, r23
 adds r22, #4 ' ADDP4 coni
 rdlong r22, r22 ' reg <- INDIRP4 reg
 mov r20, r21 ' CVI, CVU or LOAD
 cmp r22, r20 wz
 if_nz jmp #\C_pthread_mutex_trylock_21  ' NEU4
 mov r22, r23
 adds r22, #8 ' ADDP4 coni
 rdlong r22, r22 ' reg <- INDIRU4 reg
 mov r20, ##$7fffffff ' reg <- con
 cmp r22, r20 wcz 
 if_ae jmp #\C_pthread_mutex_trylock_23 ' GEU4
 mov r22, r23
 adds r22, #8 ' ADDP4 coni
 rdlong r20, r22 ' reg <- INDIRU4 reg
 add r20, #1 ' ADDU4 coni
 wrlong r20, r22 ' ASGNU4 reg reg
 jmp #\@C_pthread_mutex_trylock_22 ' JUMPV addrg
C_pthread_mutex_trylock_23
 mov r22, #11 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_21
 mov r22, #16 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_22
 mov r0, #0 ' reg <- coni
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_15
 mov r22, r23
 adds r22, #12 ' ADDP4 coni
 rdlong r2, r22 ' reg <- INDIRI4 reg
 mov r3, ##@C__P_thread_P_ool ' reg ARG ADDRG
 mov BC, #8 ' arg size, rpsize = 8, spsize = 8
 sub SP, #4 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__thread_lockset
 add SP, #4 ' CALL addrg
 mov r19, r0 ' CVI, CVU or LOAD
 cmps r19,  #0 wz
 if_z jmp #\C_pthread_mutex_trylock_25 ' EQI4
 mov r22, r23
 adds r22, #4 ' ADDP4 coni
 rdlong r22, r22 ' reg <- INDIRP4 reg
 mov r20, r21 ' CVI, CVU or LOAD
 cmp r22, r20 wz
 if_nz jmp #\C_pthread_mutex_trylock_27  ' NEU4
 mov r22, #16 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_27
 mov r22, r23
 adds r22, #4 ' ADDP4 coni
 wrlong r21, r22 ' ASGNP4 reg reg
 mov r0, #0 ' reg <- coni
 jmp #\@C_pthread_mutex_trylock_2 ' JUMPV addrg
C_pthread_mutex_trylock_25
 mov r22, #16 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
C_pthread_mutex_trylock_2
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Import _thread_stall

' Catalina Import _Pthread_Pool

' Catalina Import pthread_self

' Catalina Import errno

' Catalina Import _thread_allow

' Catalina Import _thread_lockset

' Catalina Import _thread_locknew
' end
