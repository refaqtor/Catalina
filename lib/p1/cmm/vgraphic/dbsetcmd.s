'
' Call the graphics plugin
' on entry:
'   r2 = parameter
'   r3 = command
'

' Catalina Import _vdb_cog

' Catalina Code

DAT ' code segment

' Catalina Export _db_setcommand

 alignl ' align long

C__db_setcommand
 word I16A_SHLI + r3<<D16A + 16<<S16A
 word I16A_OR + r2<<D16A + r3<<S16A
 alignl ' align long
 long I32_LODI + @C__vdb_cog<<S32
 word I16A_MOV + r3<<D16A + RI<<S16A
 word I16B_SYSP
 word I16B_RETN

' end    C__db_setcommand

