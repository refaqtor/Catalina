' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export _write

 alignl ' align long
C__write ' <symbol:_write>
 alignl ' align long
 long I32_NEWF + 516<<S32
 alignl ' align long
 long I32_PSHM + $fa0000<<S32 ' save registers
 word I16A_MOV + (r23)<<D16A + (r4)<<S16A ' reg var <- reg arg
 word I16A_MOV + (r21)<<D16A + (r3)<<S16A ' reg var <- reg arg
 word I16A_MOV + (r19)<<D16A + (r2)<<S16A ' reg var <- reg arg
 word I16A_MOVI + (r17)<<D16A + (0)<<S16A ' reg <- coni
 word I16A_CMPSI + (r23)<<D16A + (1)<<S16A
 alignl ' align long
 long I32_BRNZ + (@C__write_3)<<S32 ' NEI4 reg coni
 word I16A_MOVI + (r17)<<D16A + (0)<<S16A ' reg <- coni
 alignl ' align long
 long I32_JMPA + (@C__write_8)<<S32 ' JUMPV addrg
 alignl ' align long
C__write_5
 word I16B_LODL + (r2)<<D16B
 alignl ' align long
 long @C___stdout ' reg ARG ADDRG
 word I16A_MOV + (r22)<<D16A + (r17)<<S16A ' ADDI/P
 word I16A_ADDS + (r22)<<D16A + (r21)<<S16A ' ADDI/P (3)
 word I16A_RDBYTE + (r22)<<D16A + (r22)<<S16A ' reg <- INDIRU1 reg
 word I16A_MOV + (r3)<<D16A + (r22)<<S16A ' CVUI
 word I16B_TRN1 + (r3)<<D16B ' zero extend
 word I16B_CPREP + 33<<S16B ' arg size, rpsize = 8, spsize = 8
 alignl ' align long
 long I32_CALA + (@C_catalina_putc)<<S32
 word I16A_ADDI + SP<<D16A + 4<<S16A ' CALL addrg
' C__write_6 ' (symbol refcount = 0)
 word I16A_ADDSI + (r17)<<D16A + (1)<<S16A ' ADDI4 reg coni
 alignl ' align long
C__write_8
 word I16A_CMPS + (r17)<<D16A + (r19)<<S16A
 alignl ' align long
 long I32_BR_B + (@C__write_5)<<S32 ' LTI4 reg reg
 word I16A_MOV + (r0)<<D16A + (r19)<<S16A ' CVI, CVU or LOAD
 alignl ' align long
 long I32_JMPA + (@C__write_2)<<S32 ' JUMPV addrg
 alignl ' align long
C__write_3
 word I16A_CMPSI + (r23)<<D16A + (2)<<S16A
 alignl ' align long
 long I32_BRNZ + (@C__write_9)<<S32 ' NEI4 reg coni
 word I16A_MOVI + (r17)<<D16A + (0)<<S16A ' reg <- coni
 alignl ' align long
 long I32_JMPA + (@C__write_14)<<S32 ' JUMPV addrg
 alignl ' align long
C__write_11
 word I16B_LODL + (r2)<<D16B
 alignl ' align long
 long @C___stderr ' reg ARG ADDRG
 word I16A_MOV + (r22)<<D16A + (r17)<<S16A ' ADDI/P
 word I16A_ADDS + (r22)<<D16A + (r21)<<S16A ' ADDI/P (3)
 word I16A_RDBYTE + (r22)<<D16A + (r22)<<S16A ' reg <- INDIRU1 reg
 word I16A_MOV + (r3)<<D16A + (r22)<<S16A ' CVUI
 word I16B_TRN1 + (r3)<<D16B ' zero extend
 word I16B_CPREP + 33<<S16B ' arg size, rpsize = 8, spsize = 8
 alignl ' align long
 long I32_CALA + (@C_catalina_putc)<<S32
 word I16A_ADDI + SP<<D16A + 4<<S16A ' CALL addrg
' C__write_12 ' (symbol refcount = 0)
 word I16A_ADDSI + (r17)<<D16A + (1)<<S16A ' ADDI4 reg coni
 alignl ' align long
C__write_14
 word I16A_CMPS + (r17)<<D16A + (r19)<<S16A
 alignl ' align long
 long I32_BR_B + (@C__write_11)<<S32 ' LTI4 reg reg
 word I16A_MOV + (r0)<<D16A + (r19)<<S16A ' CVI, CVU or LOAD
 alignl ' align long
 long I32_JMPA + (@C__write_2)<<S32 ' JUMPV addrg
 alignl ' align long
C__write_9
 word I16A_MOV + (r22)<<D16A + (r23)<<S16A
 word I16A_SHLI + (r22)<<D16A + (2)<<S16A ' SHLI4 reg coni
 word I16B_LODL + (r20)<<D16B
 alignl ' align long
 long @C___fdtab ' reg <- addrg
 word I16A_ADDS + (r22)<<D16A + (r20)<<S16A ' ADDI/P (1)
 word I16A_RDLONG + (r22)<<D16A + (r22)<<S16A ' reg <- INDIRP4 reg
 word I16A_CMPI + (r22)<<D16A + (0)<<S16A
 alignl ' align long
 long I32_BRNZ + (@C__write_15)<<S32 ' NEU4 reg coni
 alignl ' align long
 long I32_LODS + R0<<D32S + ((-1)&$7FFFF)<<S32 ' RET cons
 alignl ' align long
 long I32_JMPA + (@C__write_2)<<S32 ' JUMPV addrg
 alignl ' align long
C__write_15
 word I16A_MOV + (r2)<<D16A + (r19)<<S16A ' CVI, CVU or LOAD
 word I16B_LODF + ((-8)&$1FF)<<S16B
 word I16A_MOV + (r3)<<D16A + RI<<S16A ' reg ARG ADDRLi
 word I16A_MOV + (r4)<<D16A + (r21)<<S16A ' CVI, CVU or LOAD
 alignl ' align long
 long I32_LODF + ((-520)&$FFFFFF)<<S32 
 word I16A_MOV + (r5)<<D16A + RI<<S16A ' reg ARG ADDRL
 word I16A_MOV + (r22)<<D16A + (r23)<<S16A
 word I16A_SHLI + (r22)<<D16A + (2)<<S16A ' SHLI4 reg coni
 word I16B_LODL + (r20)<<D16B
 alignl ' align long
 long @C___fdtab ' reg <- addrg
 word I16A_ADDS + (r22)<<D16A + (r20)<<S16A ' ADDI/P (1)
 word I16A_RDLONG + (r22)<<D16A + (r22)<<S16A ' reg <- INDIRP4 reg
 word I16A_SUBI + SP<<D16A + 16<<S16A ' stack space for reg ARGs
 word I16A_MOV + RI<<D16A + (r22)<<S16A
 word I16B_PSHL ' stack ARG
 word I16A_MOVI + BC<<D16A + 20<<S16A ' arg size, rpsize = 0, spsize = 20
 word I16A_ADDI + SP<<D16A + 4<<S16A ' correct for new kernel !!! 
 alignl ' align long
 long I32_CALA + (@C_D_F_S__W_riteF_ile)<<S32
 word I16A_ADDI + SP<<D16A + 16<<S16A ' CALL addrg
 word I16B_LODF + ((-8)&$1FF)<<S16B
 word I16A_RDLONG + (r22)<<D16A + RI<<S16A ' reg <- INDIRU4 addrl16
 word I16A_MOV + (r0)<<D16A + (r22)<<S16A ' CVI, CVU or LOAD
 alignl ' align long
C__write_2
 word I16B_POPM + $180<<S16B ' restore registers, do not pop frame, do not return
 alignl ' align long
 long I32_RETF + 516<<S32
 alignl ' align long

' Catalina Import catalina_putc

' Catalina Import __fdtab

' Catalina Import DFS_WriteFile

' Catalina Import __stderr

' Catalina Import __stdout
' end
