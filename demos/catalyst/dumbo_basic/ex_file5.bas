10 OPEN "R",#1,"INFOFILE.DAT",32
20 FIELD #1, 20 AS N$, 4 AS A$, 8 AS P$
30 INPUT "RECORD NUM (0 TO FINISH)";REC%
35 IF REC% <= 0 THEN CLOSE #1 : STOP
40 GET #1, REC%
50 PRINT N$
60 PRINT USING "$$###.##";CVS(A$)
70 PRINT P$:PRINT
80 GOTO 30
