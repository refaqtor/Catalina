10 REM ****
20 WIDTH 80
30 PRINT CHR$(27);"[0;0H";CHR$(27);"[2J"
40 RANDOMIZE RANDOM
50 PRINT CHR$(27);"[0;0H";CHR$(27);"[2J"
210 FOR XX = 1 TO 6 : PRINT : NEXT XX : PRINT TAB(20); "THE USS ENTERPRISE --- NCC-1701" : PRINT : FOR YY = 1 TO 40 STEP 2
220 PRINT CHR$(27);"[8;0H"
221 PRINT TAB(YY); "                  ,------*------,"
222 PRINT TAB(YY); "  ,-------------   '---  ------'"
223 PRINT TAB(YY); "   '-------- --'      / /"
224 PRINT TAB(YY); "       ,---' '-------/ /--,"
225 PRINT TAB(YY); "        '----------------'" : PRINT : PRINT : PRINT CHR$(27);"[8;0H" : NEXT ZZ : NEXT YY
227 PRINT : PRINT : PRINT : PRINT : PRINT
260 CLEAR 600
270 Z$="                         "
330 DIM G(8,8),C(9,2),K(3,3),N(3),Z(8,8),D(8)
370 T=INT(RND(1)*20+20)*100 : T0=T : T9=25+INT(RND(1)*10) : D0=0 : E=3000 : E0=E
440 P=10 : P0=P : S9=200 : S=0 : B9=0 : K9=0 : X$="" : X0$=" IS "
470 DEF FND(I)=SQR((K(I,1)-S1)^2+(K(I,2)-S2)^2)
475 DEF FNR(R)=INT(RND(R)*7.98+1.01)
490 Q1=FNR(1) : Q2=FNR(1) : S1=FNR(1) : S2=FNR(1)
530 FOR I=1 TO 9 : C(I,1)=0 : C(I,2)=0 : NEXT I
540 C(3,1)=-1 : C(2,1)=-1 : C(4,1)=-1 : C(4,2)=-1 : C(5,2)=-1 : C(6,2)=-1
600 C(1,2)=1 : C(2,2)=1 : C(6,1)=1 : C(7,1)=1 : C(8,1)=1 : C(8,2)=1 : C(9,2)=1
670 FOR I=1 TO 8 : D(I)=0 : NEXT I
710 A1$="NAVSRSLRSPHATORSHEDAMCOMXXX"
720 A2$="navsrslrsphatorshedamcomxxx"
820 FOR I=1 TO 8 : FOR J=1 TO 8 : K3=0 : Z(I,J)=0 : R1=RND(1)
850 IF R1>.98 THEN K3=3 : K9=K9+3 : GOTO 980
860 IF R1>.95 THEN K3=2 : K9=K9+2 : GOTO 980
870 IF R1>.8 THEN K3=1 : K9=K9+1
980 B3=0 : IF RND(1)>.96 THEN B3=1 : B9=B9+1
1040 G(I,J)=K3*100+B3*10+FNR(1) : NEXT J : NEXT I : IF K9>T9 THEN T9=K9+1
1100 IF B9<>0 THEN 1200
1150 IF G(Q1,Q2)<200 THEN G(Q1,Q2)=G(Q1,Q2)+100 : K9=K9+1
1160 B9=1 : G(Q1,Q2)=G(Q1,Q2)+10 : Q1=FNR(1) : Q2=FNR(1)
1200 K7=K9 : IF B9<>1 THEN X$="S" : X0$=" ARE "
1230 PRINT "YOUR ORDERS ARE AS FOLLOWS : "
1235 PRINT "--------------------------"
1240 PRINT "   DESTROY THE";K9;"KLINGON WARSHIPS WHICH HAVE INVADED"
1250 PRINT "   THE GALAXY BEFORE THEY CAN ATTACK FEDERATION HEADQUARTERS"
1260 PRINT "   ON STARDATE";T0+T9;CHR$(8); ". THIS GIVES YOU";T9;"DAYS. THERE";X0$
1270 PRINT "  ";B9;"STARBASE";X$;" IN THE GALAXY FOR RESUPPLYING YOUR SHIP."
1280 PRINT : PRINT "ARE YOU READY TO ACCEPT COMMAND ('N' FOR INSTRUCTIONS)";
1300 INPUT I5$ : IF LEFT$(I5$,1)="N" OR LEFT$(I5$,1)="n" THEN GOSUB 10000 ELSE IF LEFT$(I5$,1)="Y" OR LEFT$(I5$,1)="y" THEN 1320 ELSE 1280
1320 Z4=Q1 : Z5=Q2 : K3=0 : B3=0 : S3=0 : G5=0 : D4=.5*RND(1) : Z(Q1,Q2)=G(Q1,Q2)
1390 IF Q1<1 OR Q1>8 OR Q2<1 OR Q2>8 THEN 1600
1430 GOSUB 9030 : PRINT : IF T0<>T THEN 1490
1460 PRINT "YOUR MISSION BEGINS WITH YOUR STARSHIP LOCATED"
1470 PRINT "IN THE GALACTIC QUADRANT, '";G2$;"'." : GOTO 1500
1490 PRINT "NOW ENTERING ";G2$;" QUADRANT . . ."
1500 PRINT : K3=INT(G(Q1,Q2)*.01) : B3=INT(G(Q1,Q2)*.1)-10*K3
1540 S3=G(Q1,Q2)-100*K3-10*B3 : IF K3=0 THEN 1590
1560 PRINT TAB(3);CHR$(22);"  COMBAT AREA      CONDITION RED  ";CHR$(22) : IF S>200 THEN PRINT : GOTO 1590
1580 PRINT TAB(3);CHR$(22);"      SHIELDS DANGEROUSLY LOW     ";CHR$(22) : PRINT
1590 FOR I=1 TO 3 : K(I,1)=0 : K(I,2)=0 : NEXT I
1600 FOR I=1 TO 3 : K(I,3)=0 : NEXT I : Q$=Z$+Z$+Z$+Z$+Z$+Z$+Z$+LEFT$(Z$,17)
1680 A$="<E>" : Z1=S1 : Z2=S2 : GOSUB 8670 : IF K3<1 THEN 1820
1720 FOR I=1 TO K3 : GOSUB 8590 : A$="+K+" : Z1=R1 : Z2=R2
1780 GOSUB 8670 : K(I,1)=R1 : K(I,2)=R2 : K(I,3)=S9*(.5+RND(1)) : NEXT I
1820 IF B3<1 THEN 1910
1880 GOSUB 8590 : A$=">B<" : Z1=R1 : B4=R1 : Z2=R2 : B5=R2 : GOSUB 8670
1910 FOR I=1 TO S3 : GOSUB 8590 : A$=" * " : Z1=R1 : Z2=R2 : GOSUB 8670 : NEXT I
1980 GOSUB 6430
1990 IF S+E>10 THEN IF E>10 OR D(7)=0 THEN 2060
2020 PRINT : PRINT TAB(10);CHR$(22);"** FATAL ERROR **";CHR$(22) : PRINT "YOU'VE JUST STRANDED YOUR SHIP IN SPACE."
2030 PRINT "YOU HAVE INSUFFICIENT MANEUVERING ENERGY,"
2040 PRINT "AND SHIELD CONTROL IS PRESENTLY INCAPABLE OF"
2050 PRINT "CROSS-CIRCUITING TO ENGINE ROOM!!" : PRINT : GOTO 6220
2060 PRINT : INPUT "COMMAND";A$ : PRINT
2080 FOR I=1 TO 9 : IF LEFT$(A$,3)=MID$(A1$,3*I-2,3)THEN 2140
2090 IF LEFT$(A$,3)<>MID$(A2$,3*I-2,3)THEN 2160
2140 ON I GOTO 2300,1980,4000,4260,4700,5530,5690,7290,6270
2160 NEXT I : PRINT "ENTER ONE OF THE FOLLOWING : "
2170 PRINT "--------------------------"
2180 PRINT "  NAV  (TO SET COURSE)"
2190 PRINT "  SRS  (FOR SHORT RANGE SENSOR SCAN)"
2200 PRINT "  LRS  (FOR LONG RANGE SENSOR SCAN)"
2210 PRINT "  PHA  (TO FIRE PHASERS)"
2220 PRINT "  TOR  (TO FIRE PHOTON TORPEDOES)"
2230 PRINT "  SHE  (TO RAISE OR LOWER SHIELDS)"
2240 PRINT "  DAM  (FOR DAMAGE CONTROL REPORTS)"
2250 PRINT "  COM  (TO CALL ON LIBRARY-COMPUTER)"
2260 PRINT "  XXX  (TO RESIGN YOUR COMMAND)" : PRINT : GOTO 1990
2300 INPUT "COURSE (0-9)";C1 : IF C1=9 THEN C1=1
2310 IF C1>=1 AND C1<9 THEN 2350
2330 PRINT "   LT. SULU :  'INCORRECT COURSE DATA, SIR!'" : GOTO 1990
2350 X$="8" : IF D(1)<0 THEN X$="0.2"
2360 PRINT "WARP FACTOR (0-";X$;")"; : INPUT W1 : PRINT : IF D(1)<0 AND W1>.2 THEN 2470
2380 IF W1>0 AND W1<=8 THEN 2490
2390 IF W1=0 THEN 1990
2420 PRINT "   CHIEF ENGINEER SCOTT :  'THE ENGINES WON'T TAKE";
2430 PRINT " WARP";W1;CHR$(8);"!'" : GOTO 1990
2470 PRINT "WARP ENGINES ARE DAMAGED.  MAXIUM SPEED = WARP 0.2" : GOTO 1990
2490 N=INT(W1*8+.5) : IF E-N>=0 THEN 2590
2500 PRINT "ENGINEERING :   'INSUFFICIENT ENERGY AVAILABLE"
2510 PRINT "               FOR MANEUVERING AT WARP";W1;CHR$(8);"!'"
2530 IF S<N-E OR D(7)<0 THEN 1990
2550 PRINT "DEFLECTOR CONTROL ROOM :   ";S;"UNITS OF ENERGY"
2560 PRINT "                          PRESENTLY DEPLOYED TO SHIELDS."
2570 GOTO 1990
2590 FOR I=1 TO K3 
2591 IF K(I,3)=0 THEN 2700
2610 A$="   " : Z1=K(I,1) : Z2=K(I,2) : GOSUB 8670 : GOSUB 8590
2660 K(I,1)=Z1 : K(I,2)=Z2 : A$="+K+" : GOSUB 8670
2700 NEXT I : GOSUB 6000 : D1=0 : D6=W1 : IF W1>=1 THEN D6=1
2770 FOR I=1 TO 8 : IF D(I)>=0 THEN 2880
2790 D(I)=D(I)+D6 : IF D(I)>-.1 AND D(I)<0 THEN D(I)=-.1 : GOTO 2880
2800 IF D(I)<0 THEN 2880
2810 IF D1<>1 THEN D1=1 : PRINT "DAMAGE CONTROL REPORT :   ";
2840 PRINT TAB(8); : R1=I : GOSUB 8790 : PRINT G2$;" REPAIR COMPLETED."
2880 NEXT I : IF RND(1)>.2 THEN 3070
2910 R1=FNR(1) : IF RND(1)>=.6 THEN 3000
2930 D(R1)=D(R1)-(RND(1)*5+1) : PRINT "DAMAGE CONTROL REPORT :   ";
2960 GOSUB 8790 : PRINT G2$;" DAMAGED" : PRINT : GOTO 3070
3000 D(R1)=D(R1)+RND(1)*3+1 : PRINT "DAMAGE CONTROL REPORT :   ";
3030 GOSUB 8790 : PRINT G2$;" STATE OF REPAIR IMPROVED" : PRINT
3070 A$="   " : Z1=INT(S1) : Z2=INT(S2) : GOSUB 8670
3110 X1=C(INT(C1),1)+(C(INT(C1)+1,1)-C(INT(C1),1))*(C1-INT(C1)) : X=S1 : Y=S2
3140 X2=C(INT(C1),2)+(C(INT(C1)+1,2)-C(INT(C1),2))*(C1-INT(C1)) : Q4=Q1 : Q5=Q2
3170 FOR I=1 TO N : S1=S1+X1 : S2=S2+X2 : IF S1<1 OR S1>=9 OR S2<1 OR S2>=9 THEN 3500
3240 S8=INT(S1)*24+INT(S2)*3-26 : IF MID$(Q$,S8,2)="  "THEN 3360
3320 S1=INT(S1-X1) : S2=INT(S2-X2) : PRINT "WARP ENGINES SHUT DOWN AT ";
3350 PRINT "SECTOR";S1;CHR$(8);",";S2;"DUE TO BAD NAVAGATION" : GOTO 3370
3360 NEXT I : S1=INT(S1) : S2=INT(S2)
3370 A$="<E>" : Z1=INT(S1) : Z2=INT(S2) : GOSUB 8670 : GOSUB 3910 : T8=1
3430 IF W1<1 THEN T8=.1*INT(10*W1)
3450 T=T+T8 : IF T>T0+T9 THEN 6220
3480 GOTO 1980
3500 X=8*Q1+X+N*X1 : Y=8*Q2+Y+N*X2 : Q1=INT(X/8) : Q2=INT(Y/8) : S1=INT(X-Q1*8)
3550 S2=INT(Y-Q2*8) : IF S1=0 THEN Q1=Q1-1 : S1=8
3590 IF S2=0 THEN Q2=Q2-1 : S2=8
3620 X5=0 : IF Q1<1 THEN X5=1 : Q1=1 : S1=1
3670 IF Q1>8 THEN X5=1 : Q1=8 : S1=8
3710 IF Q2<1 THEN X5=1 : Q2=1 : S2=1
3750 IF Q2>8 THEN X5=1 : Q2=8 : S2=8
3790 IF X5=0 THEN 3860
3800 PRINT "LT. UHURA :  MESSAGE FROM STARFLEET COMMAND --"
3810 PRINT "  'PERMISSION TO ATTEMPT CROSSING OF GALACTIC PERIMETER"
3820 PRINT "  IS HEREBY *DENIED*.  SHUT DOWN YOUR ENGINES.'"
3830 PRINT "CHIEF ENGINEER SCOTT :   'WARP ENGINES SHUT DOWN"
3840 PRINT "  AT SECTOR";S1;CHR$(8);",";S2;"OF QUADRANT"; Q1;CHR$(8);",";Q2;CHR$(8);".'"
3850 IF T>T0+T9 THEN 6220
3860 print q1,q2,q4,q5 :IF 8*Q1+Q2=8*Q4+Q5 THEN 3370
3870 T=T+1 : GOSUB 3910 : GOTO 1320
3910 E=E-N-10 : IF E>=0 THEN RETURN
3930 PRINT "SHIELD CONTROL SUPPLIES ENERGY TO COMPLETE THE MANEUVER."
3940 S=S+E : E=0 : IF S<=0 THEN S=0
3980 RETURN
4000 IF D(3)<0 THEN PRINT "LONG RANGE SENSORS ARE INOPERABLE." : GOTO 1990
4030 PRINT "LONG RANGE SCAN FOR QUADRANT";Q1;CHR$(8);",";Q2 : PRINT
4040 O1$="-------------------" : PRINT O1$
4060 FOR I=Q1-1 TO Q1+1 : N(1)=-1 : N(2)=-2 : N(3)=-3 : FOR J=Q2-1 TO Q2+1
4120 IF I>0 AND I<9 AND J>0 AND J<9 THEN N(J-Q2+2)=G(I,J) : Z(I,J)=G(I,J)
4180 NEXT J : FOR L=1 TO 3 : PRINT "| "; : IF N(L)<0 THEN PRINT "*** "; : GOTO 4230
4210 PRINT RIGHT$(STR$(N(L)+1000),3);" ";
4230 NEXT L : PRINT "|" : PRINT O1$ : NEXT I : GOTO 1990
4260 IF D(4)<0 THEN PRINT "PHASERS INOPERATIVE." : GOTO 1990
4265 IF K3>0 THEN 4330
4270 PRINT "SCIENCE OFFICER SPOCK :   'SENSORS SHOW NO ENEMY SHIPS"
4280 PRINT "                         IN THIS QUADRANT'" : GOTO 1990
4330 IF D(8)<0 THEN PRINT "COMPUTER FAILURE HAMPERS ACCURACY."
4350 PRINT "PHASERS LOCKED ON TARGET;  ";
4360 PRINT "ENERGY AVAILABLE =";E;"UNITS"
4370 INPUT "NUMBER OF UNITS TO FIRE";X : IF X<=0 THEN 1990
4400 IF E-X<0 THEN 4360
4410 E=E-X : IF D(7)<0 THEN X=X*RND(1)
4450 H1=INT(X/K3) : FOR I=1 TO 3 : IF K(I,3)<=0 THEN 4670
4480 H=INT((H1/FND(I))*(RND(1)+2)) : IF H>.15*K(I,3)THEN 4530
4500 PRINT "SENSORS SHOW NO DAMAGE TO ENEMY AT";K(I,1);CHR$(8);","; K(I,2);CHR$(8);"." : GOTO 4670
4530 K(I,3)=K(I,3)-H : PRINT H;"UNIT HIT ON KLINGON AT SECTOR";K(I,1);CHR$(8);",";
4550 PRINT K(I,2);CHR$(8);"." : IF K(I,3)<=0 THEN PRINT : PRINT CHR$(22);"*** KLINGON DESTROYED ***";CHR$(22) : PRINT : GOTO 4580
4560 PRINT " (SENSORS SHOW";K(I,3);"UNITS REMAINING)" : GOTO 4670
4580 K3=K3-1 : K9=K9-1 : Z1=K(I,1) : Z2=K(I,2) : A$="   " : GOSUB 8670
4650 K(I,3)=0 : G(Q1,Q2)=G(Q1,Q2)-100 : Z(Q1,Q2)=G(Q1,Q2) : IF K9<=0 THEN 6370
4670 NEXT I : GOSUB 6000 : GOTO 1990
4700 IF P<=0 THEN PRINT "ALL PHOTON TORPEDOES EXPENDED." : GOTO 1990
4730 IF D(5)<0 THEN PRINT "PHOTON TUBES ARE NOT OPERATIONAL." : GOTO 1990
4760 INPUT "PHOTON TORPEDO COURSE (1-9)";C1 : IF C1=9 THEN C1=1
4780 IF C1>=1 AND C1<9 THEN 4850
4790 PRINT "ENSIGN CHEKOV :   'INCORRECT COURSE DATA, SIR!'"
4800 GOTO 1990
4850 X1=C(INT(C1),1)+(C(INT(C1)+1,1)-C(INT(C1),1))*(C1-INT(C1)) : E=E-2 : P=P-1
4860 X2=C(INT(C1),2)+(C(INT(C1)+1,2)-C(INT(C1),2))*(C1-INT(C1)) : X=S1 : Y=S2
4910 PRINT "TORPEDO TRACK : "
4920 X=X+X1 : Y=Y+X2 : X3=INT(X+.5) : Y3=INT(Y+.5)
4960 IF X3<1 OR X3>8 OR Y3<1 OR Y3>8 THEN 5490
5000 PRINT "               ";X3;CHR$(8);",";Y3 : A$="   " : Z1=X : Z2=Y : GOSUB 8830
5050 IF Z3<>0 THEN 4920
5060 A$="+K+" : Z1=X : Z2=Y : GOSUB 8830 : IF Z3=0 THEN 5210
5110 PRINT : PRINT CHR$(22);"*** KLINGON DESTROYED ***";CHR$(22) : PRINT : K3=K3-1 : K9=K9-1 : IF K9<=0 THEN 6370
5150 FOR I=1 TO 3 : IF X3=K(I,1)AND Y3=K(I,2)THEN 5190
5180 NEXT I : I=3
5190 K(I,3)=0 : GOTO 5430
5210 A$=" * " : Z1=X : Z2=Y : GOSUB 8830 : IF Z3=0 THEN 5280
5260 PRINT "STAR AT";X3;",";Y3;"ABSORBED TORPEDO ENERGY." : GOSUB 6000 : GOTO 1990
5280 A$=">!<" : Z1=X : Z2=Y : GOSUB 8830 : IF Z3=0 THEN 4760
5330 PRINT CHR$(22);"*** STARBASE DESTROYED ***";CHR$(22) : B3=B3-1 : B9=B9-1
5360 IF B9>0 OR K9>T-T0-T9 THEN 5400
5370 PRINT "THAT DOES IT, CAPTAIN!!  YOU ARE HEREBY RELIEVED OF COMMAND"
5380 PRINT "AND SENTENCED TO 99 STARDATES AT HARD LABOR ON CYGNUS 12!!"
5390 GOTO 6270
5400 PRINT "STARFLEET COMMAND REVIEWING YOUR RECORD TO CONSIDER"
5410 PRINT "COURT MARTIAL!" : D0=0
5430 Z1=X : Z2=Y : A$="   " : GOSUB 8670
5470 G(Q1,Q2)=K3*100+B3*10+S3 : Z(Q1,Q2)=G(Q1,Q2) : GOSUB 6000 : GOTO 1990
5490 PRINT "TORPEDO MISSED." : PRINT : GOSUB 6000 : GOTO 1990
5530 IF D(7)<0 THEN PRINT "SHIELD CONTROL INOPERABLE." : GOTO 1990
5560 PRINT "ENERGY AVAILABLE =";E+S; : INPUT "NUMBER OF UNITS TO SHIELDS";X
5580 IF X<0 OR S=X THEN PRINT "<SHIELDS UNCHANGED>" : GOTO 1990
5590 IF X<=E+S THEN 5630
5600 PRINT "SHIELD CONTROL :   'THIS IS NOT THE FEDERATION TREASURY.'" 
5610 PRINT "<SHIELDS UNCHANGED>" : GOTO 1990
5630 E=E+S-X : S=X : PRINT "DEFLECTOR CONTROL ROOM : "
5660 PRINT "  'SHIELDS NOW AT";INT(S);"UNITS PER YOUR COMMAND.'" : GOTO 1990
5690 IF D(6)>=0 THEN 5910
5700 PRINT "DAMAGE CONTROL REPORT NOT AVAILABLE." : IF D0=0 THEN 1990
5720 D3=0 : FOR I=1 TO 8 : IF D(I)<0 THEN D3=D3+.1
5760 NEXT I : IF D3=0 THEN 1990
5780 PRINT : D3=D3+D4 : IF D3>=1 THEN D3=.9
5810 PRINT "TECHNICIANS STANDING BY TO EFFECT REPAIRS TO YOUR SHIP;"
5820 PRINT "ESTIMATED TIME TO REPAIR : ";.01*INT(100*D3);"STARDATES."
5840 INPUT "WILL YOU AUTHORIZE THE REPAIR ORDER (Y/N)";A$
5860 IF LEFT$(A$,1)<>"Y" AND LEFT$(A$,1)<>"y" THEN 1990
5870 FOR I=1 TO 8 : IF D(I)<0 THEN D(I)=0
5890 NEXT I : T=T+D3+.1
5910 PRINT : PRINT "DEVICE             STATE OF REPAIR" : PRINT "------             ---------------" : FOR R1=1 TO 8
5920 GOSUB 8790 : PRINT G2$;LEFT$(Z$,25-LEN(G2$));INT(D(R1)*100)*.01
5950 NEXT R1 : PRINT : IF D0<>0 THEN 5720
5980 GOTO 1990
6000 IF K3<=0 THEN RETURN
6010 IF D0<>0 THEN PRINT "STARBASE SHIELDS PROTECT THE ENTERPRISE." : RETURN
6040 FOR I=1 TO 3 : IF K(I,3)<=0 THEN 6200
6060 H=INT((K(I,3)/FND(I))*(2+RND(1))) : S=S-H : K(I,3)=K(I,3)/(3+RND(0))
6080 PRINT : PRINT H;"UNIT HIT ON ENTERPRISE FROM SECTOR";K(I,1);CHR$(8); ",";K(I,2);CHR$(8);"."
6090 IF S<=0 THEN 6240
6100 PRINT "      <SHIELDS DOWN TO";S;"UNITS>" : IF H<20 THEN 6200
6120 IF RND(1)>.6 OR H/S<=.02 THEN 6200
6140 R1=FNR(1) : D(R1)=D(R1)-H/S-.5*RND(1) : GOSUB 8790
6170 PRINT "DAMAGE CONTROL :  '";G2$;" DAMAGED BY THE HIT'"
6200 NEXT I : RETURN
6220 PRINT : PRINT "IT IS STARDATE";T;CHR$(8);"." : PRINT : GOTO 6270
6240 PRINT : PRINT "THE ENTERPRISE HAS BEEN DESTROYED.  THE FEDERATION ";
6250 PRINT "WILL BE CONQUERED." : GOTO 6220
6270 PRINT "THERE WERE";K9;"KLINGON BATTLE CRUISERS LEFT AT"
6280 PRINT "THE END OF YOUR MISSION."
6290 PRINT : PRINT : IF B9=0 THEN 6360
6310 PRINT "THE FEDERATION IS IN NEED OF A NEW STARSHIP COMMANDER"
6320 PRINT "FOR A SIMILAR MISSION -- IF THERE IS A VOLUNTEER,"
6330 INPUT "LET HIM STEP FORWARD AND ENTER 'AYE'";A$ : PRINT A$ : IF A$="AYE" OR A$="aye" THEN 10
6360 end rem RUN "MENU"
6370 PRINT "CONGRATULATIONS, CAPTAIN!  THE LAST KLINGON BATTLE CRUISER"
6380 PRINT "MENACING THE FEDERATION HAS BEEN DESTROYED." : PRINT
6400 IF T = T0 GOTO 6290 : PRINT "YOUR EFFICIENCY RATING IS";1000*(K7/(T-T0))^2 : GOTO 6290
6430 FOR I=S1-1 TO S1+1 : FOR J=S2-1 TO S2+1
6450 IF INT(I+.5)<1 OR INT(I+.5)>8 OR INT(J+.5)<1 OR INT(J+.5)>8 THEN 6540
6490 A$=">B<" : Z1=I : Z2=J : GOSUB 8830 : IF Z3=1 THEN 6580
6540 NEXT J : NEXT I : D0=0 : GOTO 6650
6580 D0=1 : C$="DOCKED" : E=E0 : P=P0
6620 PRINT "SHIELDS DROPPED FOR DOCKING PURPOSES." : S=0 : GOTO 6720
6650 IF K3>0 THEN C$="*RED*" : GOTO 6720
6660 C$="GREEN" : IF E<E0*.1 THEN C$="YELLOW"
6720 IF D(2)>=0 THEN 6770
6730 PRINT : PRINT "*** SHORT RANGE SENSORS ARE OUT ***" : PRINT : RETURN
6770 O1$="   +--1---2---3---4---5---6---7---8-+" : PRINT O1$ : FOR I=1 TO 8 : PRINT I;"|";
6820 FOR J=(I-1)*24+1 TO(I-1)*24+22 STEP 3 : PRINT " ";MID$(Q$,J,3); : NEXT J : PRINT "| ";I;
6830 ON I GOTO 6850,6900,6960,7020,7070,7120,7180,7240
6850 PRINT "        STARDATE          "; : PRINT USING "####.#";INT(T*10)*.1 : GOTO 7260
6900 PRINT "        CONDITION          "; : IF C$="*RED*" THEN PRINT CHR$(22);"*RED*";CHR$(22) ELSE IF C$="DOCKED" THEN PRINT CHR$(22);"DOCKED";CHR$(22) ELSE PRINT C$
6902 GOTO 7260
6960 PRINT "        QUADRANT           ";Q1;CHR$(8);",";Q2;CHR$(8) : GOTO 7260
7020 PRINT "        SECTOR             ";S1;CHR$(8);",";S2;CHR$(8) : GOTO 7260
7070 PRINT "        PHOTON TORPEDOES  "; : PRINT USING "######";INT(P) : GOTO 7260
7120 PRINT "        TOTAL ENERGY      "; : PRINT USING "######";INT(E+S) : GOTO 7260
7180 PRINT "        SHIELDS           "; : PRINT USING "######";INT(S) : GOTO 7260
7240 PRINT "        KLINGONS REMAINING"; : PRINT USING "######";INT(K9)
7260 NEXT I : PRINT O1$ : RETURN
7290 IF D(8)<0 THEN PRINT "COMPUTER DISABLED." : GOTO 1990
7320 INPUT "COMPUTER ACTIVE AND AWAITING COMMAND";A : IF A<0 THEN 1990
7350 PRINT : H8=1 : ON A+1 GOTO 7540,7900,8070,8500,8150,7400
7360 PRINT "FUNCTIONS AVAILABLE FROM LIBRARY-COMPUTER : "
7365 PRINT "-----------------------------------------" : PRINT
7370 PRINT "   0 = CUMULATIVE GALTIC RECORD"
7372 PRINT "   1 = STATUS REPORT"
7374 PRINT "   2 = PHOTON TORPEDO DATA"
7376 PRINT "   3 = STARBASE NAV DATA"
7378 PRINT "   4 = DIRECTION/DISTANCE CALCULATOR"
7380 PRINT "   5 = GALAXY 'REGION NAME' MAP" : PRINT : GOTO 7320
7400 H8=0 : G5=1 : PRINT "                        THE GALAXY" : GOTO 7550
7540 REM
7542 REM
7543 PRINT : PRINT "       ";
7544 PRINT "COMPUTER RECORD OF GALAXY FOR QUADRANT";Q1;CHR$(8);",";Q2
7546 PRINT
7550 PRINT "       1     2     3     4     5     6     7     8"
7560 O1$="    +-----+-----+-----+-----+-----+-----+-----+-----+"
7570 PRINT O1$ : FOR I=1 TO 8 : PRINT I;" "; : IF H8=0 THEN 7740
7630 FOR J=1 TO 8 : PRINT "| "; : IF Z(I,J)=0 THEN PRINT "*** "; : GOTO 7720
7700 PRINT RIGHT$(STR$(Z(I,J)+1000),3);" ";
7720 IF J=8 THEN PRINT "|"
7721 NEXT J : GOTO 7850
7740 Z4=I : Z5=1 : GOSUB 9030 : J0=INT(15-.5*LEN(G2$)) : PRINT TAB(J0);G2$;
7800 Z5=5 : GOSUB 9030 : J0=INT(39-.5*LEN(G2$)) : PRINT TAB(J0);G2$
7850 PRINT O1$ : NEXT I : PRINT : GOTO 1990
7900 PRINT "   STATUS REPORT : " : PRINT "   -------------" : X$="" : IF K9>1 THEN X$="S"
7940 PRINT K9;"KLINGON";X$;" LEFT."
7960 PRINT " MISSION MUST BE COMPLETED IN";.1*INT((T0+T9-T)*10);"STARDATES."
7970 X$="S" : IF B9<2 THEN X$="" : IF B9<1 THEN 8010
7980 PRINT " THE FEDERATION IS MAINTAINING";B9;"STARBASE";X$;" IN THE GALAXY."
7990 GOTO 5690
8010 PRINT "YOUR STUPIDITY HAS LEFT YOU ON YOUR OWN IN"
8020 PRINT "  THE GALAXY -- YOU HAVE NO STARBASES LEFT!" : GOTO 5690
8070 IF K3<=0 THEN 4270
8080 X$="" : IF K3>1 THEN X$="S"
8090 PRINT "FROM ENTERPRISE TO KLINGON BATTLE CRUSER";X$
8100 H8=0 : FOR I=1 TO 3 : IF K(I,3)<=0 THEN 8480
8110 W1=K(I,1) : X=K(I,2)
8120 C1=S1 : A=S2 : GOTO 8220
8150 PRINT "DIRECTION/DISTANCE CALCULATOR : "
8160 PRINT "YOU ARE AT QUADRANT ";Q1;CHR$(8);",";Q2; " SECTOR ";S1;CHR$(8);",";S2;CHR$(8);"."
8170 INPUT "PLEASE ENTER INITIAL COORDINATES (X,Y)";C1,A
8200 INPUT "FINAL COORDINATES (X,Y)";W1,X
8220 X=X-A : A=C1-W1 : IF X<0 THEN 8350
8250 IF A<0 THEN 8410
8260 IF X>0 THEN 8280
8270 IF A=0 THEN C1=5 : GOTO 8290
8280 C1=1
8290 IF ABS(A)<=ABS(X)THEN 8330
8310 PRINT "DIRECTION =";C1+(((ABS(A)-ABS(X))+ABS(A))/ABS(A)) : GOTO 8460
8330 PRINT "DIRECTION =";C1+(ABS(A)/ABS(X)) : GOTO 8460
8350 IF A>0 THEN C1=3 : GOTO 8420
8360 IF X<>0 THEN C1=5 : GOTO 8290
8410 C1=7
8420 IF ABS(A)>=ABS(X)THEN 8450
8430 PRINT "DIRECTION =";C1+(((ABS(X)-ABS(A))+ABS(X))/ABS(X)) : GOTO 8460
8450 PRINT "DIRECTION =";C1+(ABS(X)/ABS(A))
8460 PRINT "DISTANCE =";SQR(X^2+A^2) : IF H8=1 THEN 1990
8480 NEXT I : GOTO 1990
8500 IF B3<>0 THEN PRINT "FROM ENTERPRISE TO STARBASE : " : W1=B4 : X=B5 : GOTO 8120
8510 PRINT "MR. SPOCK :   'SENSORS SHOW NO STARBASES IN THIS QUADRANT.'";
8520 GOTO 1990
8590 R1=FNR(1) : R2=FNR(1) : A$="   " : Z1=R1 : Z2=R2 : GOSUB 8830 : IF Z3=0 THEN 8590
8600 RETURN
8670 S8=INT(Z2-.5)*3+INT(Z1-.5)*24+1
8675 IF LEN(A$)<>3 THEN PRINT "ERROR" : STOP
8680 IF S8=1 THEN Q$=A$+RIGHT$(Q$,189) : RETURN
8690 IF S8=190 THEN Q$=LEFT$(Q$,189)+A$ : RETURN
8700 Q$=LEFT$(Q$,S8-1)+A$+RIGHT$(Q$,190-S8) : RETURN
8790 ON R1 GOTO 8792,8794,8796,8798,8800,8802,8804,8806
8792 G2$="WARP ENGINES" : RETURN
8794 G2$="SHORT RANGE SENSORS" : RETURN
8796 G2$="LONG RANGE SENSORS" : RETURN
8798 G2$="PHASER CONTROL" : RETURN
8800 G2$="PHOTON TUBES" : RETURN
8802 G2$="DAMAGE CONTROL" : RETURN
8804 G2$="SHIELD CONTROL" : RETURN
8806 G2$="LIBRARY-COMPUTER" : RETURN
8830 Z1=INT(Z1+.5) : Z2=INT(Z2+.5) : S8=(Z2-1)*3+(Z1-1)*24+1 : Z3=0
8890 IF MID$(Q$,S8,3)<>A$THEN RETURN
8900 Z3=1 : RETURN
9030 IF Z5<=4 THEN ON Z4 GOTO 9040,9050,9060,9070,9080,9090,9100,9110
9035 GOTO 9120
9040 G2$="ANTARES" : GOTO 9210
9050 G2$="RIGEL" : GOTO 9210
9060 G2$="PROCYON" : GOTO 9210
9070 G2$="VEGA" : GOTO 9210
9080 G2$="CANOPUS" : GOTO 9210
9090 G2$="ALTAIR" : GOTO 9210
9100 G2$="SAGITTARIUS" : GOTO 9210
9110 G2$="POLLUX" : GOTO 9210
9120 ON Z4 GOTO 9130,9140,9150,9160,9170,9180,9190,9200
9130 G2$="SIRIUS" : GOTO 9210
9140 G2$="DENEB" : GOTO 9210
9150 G2$="CAPELLA" : GOTO 9210
9160 G2$="BETELGEUSE" : GOTO 9210
9170 G2$="ALDEBARAN" : GOTO 9210
9180 G2$="REGULUS" : GOTO 9210
9190 G2$="ARCTURUS" : GOTO 9210
9200 G2$="SPICA"
9210 IF G5<>1 THEN ON Z5 GOTO 9230,9240,9250,9260,9230,9240,9250,9260
9220 RETURN
9230 G2$=G2$+" I" : RETURN
9240 G2$=G2$+" II" : RETURN
9250 G2$=G2$+" III" : RETURN
9260 G2$=G2$+" IV" : RETURN
9999 END


10000 print "Super Star Trek Instructions"
print "  When you see 'Command?', enter"
print "  one of the nine legal commands:"
print "     NAV, SRS, LRS, PHA, TOR, "
print "     SHE, DAM, COM or XXX"
print "  If you type in an illegal command,"
print "  you'll get a short list of legal "
print "  commands printed out."
print "  Some commands require you to enter "
print "  data (for example, the 'NAV' command"
print "  comes back with 'Course(1-9) ?'"
print "  If you type in illegal data (like"
print "  negative numbers), that command will"
print "  be aborted."
print "Hit any key to continue:" : input kz$
print "The Galaxy"
print "  The galaxy is divided into an 8 x 8 "
print "  quadrant grid, and each quadrant"
print "  is further divided into an 8 x 8 "
print "  sector grid."
print "  You will be assigned a starting point"
print "  somewhere in the galaxy to begin a "
print "  tour of duty as commander of the "
print "  starship Enterprise; Your mission:"
print "  to seek out and destroy the fleet of "
print "  Klingon warships which are menacing"
print "  the United Federation of Planets."
print "Commands"
print "  You have the following nine commands"
print "  available to you as Captain of the"
print "  Starship Enterprise:"
print "     NAV, SRS, LRS, PHA, TOR, "
print "     SHE, DAM, COM or XXX"   
print "  Each command is explained below."
print "Hit any key to continue:" : input kz$
print "NAV = Warp Engine Control"
print "  Course is in a circular numerical"
print "  vector arrangement: "
print "      4    3    2     Integer and"
print "        .  .  .       real values"
print "          ...         may be used -"
print "      5 ---*--- 1     thus course"
print "          ...         1.5 is halfway"
print "        .  .  .       between 1 and 2"
print "      6    7    8"
print "      -  COURSE -"
print "  Values may approach 9.0, which itself"
print "  is equivalent to 1.0."
print "  One warp factor is the size of one"
print "  quadrant. Therefore, to get from"
print "  quadrant 6,5 to 5,5 you would use"
print "  course 3, warp factor 1."
print "Hit any key to continue:" : input kz$
print "SRS = Short Range Sensor Scan"
print "  Shows you a scan of your present "
print "  quadrant."
print "  Symbology on your sensor screen is "
print "  as follows:"
print "    <*> = Your starship's position"
print "    +K+ = Klingon battlecruiser"
print "    >!< = Federation starbase "
print "          (Refuel/Repair/Re-Arm here)"
print "     *  = Star"
print "  A condensed 'Status Report' will also"
print "  be presented."
print "Hit any key to continue:" : input kz$
print "LRS = Long Range Sensor Scan"
print "  Shows conditions in space for one "
print "  quadrant on each side of the "
print "  Enterprise (which is in the middle of"
print "  the scan). The scan is coded in the "
print "  form ### where the units digit is the"
print "  number of stars, the tens digit is "
print "  the number of starbases, and the "
print "  hundreds digit is the number of "
print "  Klingons."
print "  Example - 207 = 2 Klingons, "
print "                  No Starbases,"
print "                  & 7 stars."
print "Hit any key to continue:" : input kz$
print "PHA = Phaser Control."
print "  Allows you to destroy the Klingon "
print "  Battle Cruisers by zapping them with"
print "  suitably large units of energy to "
print "  deplete their shield power. "
print "  (Remember, Klingons have phasers, "
print "   too!)"
print "TOR = Photon Torpedo Control"
print "  Torpedo course is the same as used in"
print "  warp engine control. If you hit the "
print "  Klingon vessel, he is destroyed and "
print "  cannot fire back at you. If you miss,"
print "  you are subject to the phaser fire of"
print "  all other Klingons in the quadrant."
print "  The Library-Computer (COM command)"
print "  has an option to compute torpedo"
print "  trajectory for you (option 2)."
print "Hit any key to continue:" : input kz$
print "SHE = Shield Control"
print "  Defines the number of energy units to"
print "  be assigned to the shields. Energy"
print "  is taken from total ship's energy. "
print "  Note that the status display total"
print "  energy includes shield energy."
print "DAM = Damage Control report"
print "  Gives the state of repair of all "
print "  devices. Where a negative 'State of "
print "  Repair' shows that the device is "
print "  temporarily damaged."
print "Hit any key to continue:" : input kz$
print "COM = Library-Computer"
print "  The Library-Computer contains six "
print "  options:"
print "  0 = Cumulative Galactic Record"
print "    This option shows computer memory "
print "    of the results of all previous"
print "    short and long range sensor scans."
print "  1 = Status Report"
print "    This option shows the number of "
print "    Klingons, stardates, and starbases"
print "    remaining in the game."
print "  2 = Photon Torpedo Data"
print "    Which gives directions and distance"
print "    from Enterprise to all Klingons"
print "    in your quadrant."
print "Hit any key to continue:" : input kz$
print "  3 = Starbase Nav Data"
print "    This option gives direction and "
print "    distance to any starbase in your"
print "    quadrant."
print "  4 = Direction/Distance Calculator"
print "    This option allows you to enter "
print "    coordinates for direction/distance"
print "    calculations."
print "  5 = Galactic 'Region Name' Map"
print "    This option prints the names of "
print "    the sixteen major galactic regions"
print "    referred to in the game."
print "XXX = Exit the Game"
print "  Resign your commission and exit."
print "Hit any key to continue:" : input kz$
return

