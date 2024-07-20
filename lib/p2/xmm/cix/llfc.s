' Catalina Code

DAT ' code segment
'
' LCC 4.2 (LARGE) for Parallax Propeller
' (Catalina v2.5 Code Generator by Ross Higson)
'

' Catalina Export _malloc_link_free_chunk

 alignl ' align long
C__malloc_link_free_chunk ' <symbol:_malloc_link_free_chunk>
 jmp #PSHM
 long $f80000 ' save registers
 jmp #LODL
 long @C__malloc_free_list
 mov r23, RI ' reg <- addrg
 jmp #LODL
 long -8
 mov r22, RI ' reg <- con
 adds r22, r2 ' ADDI/P (2)
 mov RI, r22
 jmp #RLNG
 mov r22, BC ' reg <- INDIRU4 reg
 mov r21, r22
 sub r21, #8 ' SUBU4 coni
C__malloc_link_free_chunk_4
 shr r21, #1 ' RSHU4 coni
 adds r23, #4 ' ADDP4 coni
' C__malloc_link_free_chunk_5 ' (symbol refcount = 0)
 cmp r21,  #8 wz,wc 
 jmp #BRAE
 long @C__malloc_link_free_chunk_4 ' GEU4
 jmp #LODL
 long -4
 mov r22, RI ' reg <- con
 adds r22, r23 ' ADDI/P (2)
 mov r23, r22 ' CVI, CVU or LOAD
 mov RI, r22
 jmp #RLNG
 mov r19, BC ' reg <- INDIRP4 reg
 mov r22, r2
 adds r22, #4 ' ADDP4 coni
 jmp #LODL
 long 0
 mov r20, RI ' reg <- con
 mov RI, r22
 mov BC, r20
 jmp #WLNG ' ASGNP4 reg reg
 mov RI, r2
 mov BC, r19
 jmp #WLNG ' ASGNP4 reg reg
 mov r22, r19 ' CVI, CVU or LOAD
 cmp r22,  #0 wz
 jmp #BR_Z
 long @C__malloc_link_free_chunk_7 ' EQU4
 mov r22, r19
 adds r22, #4 ' ADDP4 coni
 mov RI, r22
 mov BC, r2
 jmp #WLNG ' ASGNP4 reg reg
C__malloc_link_free_chunk_7
 mov RI, r23
 mov BC, r2
 jmp #WLNG ' ASGNP4 reg reg
 mov r0, #0 ' reg <- coni
' C__malloc_link_free_chunk_3 ' (symbol refcount = 0)
 jmp #POPM ' restore registers
 jmp #RETN


' Catalina Import _malloc_free_list
' end
