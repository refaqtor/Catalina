' Catalina Code

DAT ' code segment
'
' LCC 4.2 for Parallax Propeller
' (Catalina v3.15 Code Generator by Ross Higson)
'

' Catalina Export isalpha

 alignl ' align long
C_isalpha ' <symbol:isalpha>
 alignl ' align long
 long I32_PSHM + $500000<<S32 ' save registers
 word I16B_LODL + (r22)<<D16B
 alignl ' align long
 long @C___ctype+1 ' reg <- addrg
 word I16A_ADDS + (r22)<<D16A + (r2)<<S16A ' ADDI/P (2)
 word I16A_RDBYTE + (r22)<<D16A + (r22)<<S16A ' reg <- INDIRU1 reg
 word I16B_TRN1 + (r22)<<D16B ' zero extend
 word I16A_MOVI + (r20)<<D16A + (3)<<S16A ' reg <- coni
 word I16A_MOV + (r0)<<D16A + (r22)<<S16A ' BANDI/U
 word I16A_AND + (r0)<<D16A + (r20)<<S16A ' BANDI/U (3)
' C_isalpha_1 ' (symbol refcount = 0)
 word I16B_POPM + $80<<S16B ' restore registers, do not pop frame, do return
 alignl ' align long

' Catalina Import __ctype
' end
