' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export pthread_spin_init

 alignl ' align long
C_pthread_spin_init ' <symbol:pthread_spin_init>
 calld PA,#NEWF
 calld PA,#PSHM
 long $e00000 ' save registers
 mov r23, r3 ' reg var <- reg arg
 mov r21, r2 ' reg var <- reg arg
 mov r22, r23 ' CVI, CVU or LOAD
 cmp r22,  #0 wz
 if_nz jmp #\C_pthread_spin_init_3  ' NEU4
 mov r22, #22 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_spin_init_2 ' JUMPV addrg
C_pthread_spin_init_3
 mov r2, r23 ' CVI, CVU or LOAD
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C__pthread_init_lock_pool ' CALL addrg
 rdlong r22, r23 ' reg <- INDIRI4 reg
 cmps r22,  #0 wcz
 if_a jmp #\C_pthread_spin_init_5 ' GTI4
 mov r22, #11 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_spin_init_2 ' JUMPV addrg
C_pthread_spin_init_5
 mov r0, #0 ' reg <- coni
C_pthread_spin_init_2
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export pthread_spin_lock

 alignl ' align long
C_pthread_spin_lock ' <symbol:pthread_spin_lock>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##0 ' reg ARG con
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C__pthread_init_lock_pool ' CALL addrg
 mov r22, r23 ' CVI, CVU or LOAD
 cmp r22,  #0 wz
 if_z jmp #\C_pthread_spin_lock_10 ' EQU4
 rdlong r22, r23 ' reg <- INDIRI4 reg
 cmps r22,  #0 wcz
 if_a jmp #\C_pthread_spin_lock_12 ' GTI4
C_pthread_spin_lock_10
 mov r22, #22 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_spin_lock_7 ' JUMPV addrg
C_pthread_spin_lock_11
 mov BC, #0 ' arg size, rpsize = 0, spsize = 0
 calld PA,#CALA
 long @C__thread_yield ' CALL addrg
C_pthread_spin_lock_12
 rdlong r2, r23 ' reg <- INDIRI4 reg
 mov r3, ##@C__P_thread_P_ool ' reg ARG ADDRG
 mov BC, #8 ' arg size, rpsize = 8, spsize = 8
 sub SP, #4 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__thread_lockset
 add SP, #4 ' CALL addrg
 cmps r0,  #0 wz
 if_z jmp #\C_pthread_spin_lock_11 ' EQI4
 mov r0, #0 ' reg <- coni
C_pthread_spin_lock_7
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export pthread_spin_trylock

 alignl ' align long
C_pthread_spin_trylock ' <symbol:pthread_spin_trylock>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##0 ' reg ARG con
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C__pthread_init_lock_pool ' CALL addrg
 mov r22, r23 ' CVI, CVU or LOAD
 cmp r22,  #0 wz
 if_z jmp #\C_pthread_spin_trylock_17 ' EQU4
 rdlong r22, r23 ' reg <- INDIRI4 reg
 cmps r22,  #0 wcz
 if_a jmp #\C_pthread_spin_trylock_15 ' GTI4
C_pthread_spin_trylock_17
 mov r22, #22 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_spin_trylock_14 ' JUMPV addrg
C_pthread_spin_trylock_15
 rdlong r2, r23 ' reg <- INDIRI4 reg
 mov r3, ##@C__P_thread_P_ool ' reg ARG ADDRG
 mov BC, #8 ' arg size, rpsize = 8, spsize = 8
 sub SP, #4 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__thread_lockset
 add SP, #4 ' CALL addrg
 cmps r0,  #0 wz
 if_nz jmp #\C_pthread_spin_trylock_18 ' NEI4
 mov r22, #16 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_spin_trylock_14 ' JUMPV addrg
C_pthread_spin_trylock_18
 mov r0, #0 ' reg <- coni
C_pthread_spin_trylock_14
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export pthread_spin_unlock

 alignl ' align long
C_pthread_spin_unlock ' <symbol:pthread_spin_unlock>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##0 ' reg ARG con
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C__pthread_init_lock_pool ' CALL addrg
 mov r22, r23 ' CVI, CVU or LOAD
 cmp r22,  #0 wz
 if_z jmp #\C_pthread_spin_unlock_23 ' EQU4
 rdlong r22, r23 ' reg <- INDIRI4 reg
 cmps r22,  #0 wcz
 if_a jmp #\C_pthread_spin_unlock_21 ' GTI4
C_pthread_spin_unlock_23
 mov r22, #22 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_spin_unlock_20 ' JUMPV addrg
C_pthread_spin_unlock_21
 rdlong r2, r23 ' reg <- INDIRI4 reg
 mov r3, ##@C__P_thread_P_ool ' reg ARG ADDRG
 mov BC, #8 ' arg size, rpsize = 8, spsize = 8
 sub SP, #4 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__thread_lockclr
 add SP, #4 ' CALL addrg
 mov r0, #0 ' reg <- coni
C_pthread_spin_unlock_20
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Export pthread_spin_destroy

 alignl ' align long
C_pthread_spin_destroy ' <symbol:pthread_spin_destroy>
 calld PA,#NEWF
 calld PA,#PSHM
 long $c00000 ' save registers
 mov r23, r2 ' reg var <- reg arg
 mov r2, ##0 ' reg ARG con
 mov BC, #4 ' arg size, rpsize = 4, spsize = 4
 calld PA,#CALA
 long @C__pthread_init_lock_pool ' CALL addrg
 mov r22, r23 ' CVI, CVU or LOAD
 cmp r22,  #0 wz
 if_nz jmp #\C_pthread_spin_destroy_25  ' NEU4
 mov r22, #22 ' reg <- coni
 wrlong r22, ##@C_errno ' ASGNI4 addrg reg
 mov r0, r22 ' CVI, CVU or LOAD
 jmp #\@C_pthread_spin_destroy_24 ' JUMPV addrg
C_pthread_spin_destroy_25
 rdlong r22, r23 ' reg <- INDIRI4 reg
 cmps r22,  #0 wcz
 if_be jmp #\C_pthread_spin_destroy_27 ' LEI4
 rdlong r2, r23 ' reg <- INDIRI4 reg
 mov r3, ##@C__P_thread_P_ool ' reg ARG ADDRG
 mov BC, #8 ' arg size, rpsize = 8, spsize = 8
 sub SP, #4 ' stack space for reg ARGs
 calld PA,#CALA
 long @C__thread_lockret
 add SP, #4 ' CALL addrg
C_pthread_spin_destroy_27
 mov r22, ##-1 ' reg <- con
 wrlong r22, r23 ' ASGNI4 reg reg
 mov r0, #0 ' reg <- coni
C_pthread_spin_destroy_24
 calld PA,#POPM ' restore registers
 calld PA,#RETF


' Catalina Import _pthread_init_lock_pool

' Catalina Import _Pthread_Pool

' Catalina Import errno

' Catalina Import _thread_lockset

' Catalina Import _thread_lockclr

' Catalina Import _thread_lockret

' Catalina Import _thread_yield
' end
