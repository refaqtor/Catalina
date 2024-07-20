; Copyright (c) 1990,1991,1992,1993 Chris and John Downey

;***
;
; program name:
;	xvi
; function:
;	Portable version of UNIX "vi" editor, with extensions.
; module name:
;	ibmpc_a.asm
; module function:
;	Assembly language part of terminal interface module for IBM PC
;	compatibles running MS-DOS.
;
;	This code has been assembled with Microsoft's Macro Assembler
;	(MASM) version 5.1, & is compatible with code generated by
;	MS-DOS C compilers using the normal large memory model calling
;	conventions. This includes the Microsoft & Zortech compilers.
;
;	If we're running on a mono system, or one with an EGA or VGA,
;	& we were started in a text mode, we can achieve much faster
;	display output by writing directly to the frame buffer; we can
;	also save the previous screen contents & restore them when we
;	exit or run a sub-shell, which can be useful. If we have a
;	CGA, or we were started in a graphics mode, we just use the
;	functions supplied by the PC BIOS, which are slower, but good
;	enough for most purposes. On a modern 80386-based system, the
;	difference in speed is hardly noticeable.
; history:
;
;	STEVIE - ST Editor for VI Enthusiasts, Version 3.10
;	Originally by Tim Thompson (twitch!tjt)
;	Extensive modifications by Tony Andrews (onecom!wldrdg!tony)
;	Heavily modified by Chris & John Downey
;	Modified by Martin Guy <martinwguy@gmail.com>

include 8086mm.inc

;
; If SWAPSCREEN is defined, we attempt to save the previous screen
; image & restore it when we exit or run another process. If you don't
; want this to happen, just comment out the line below.
;
SWAPSCREEN	equ	1

;
; If you don't want mouse input handling, comment out the line below.
;
MOUSE		equ	1

	C_extern _malloc
	C_extern _cparams

	public	_alert
	public	_erase_display
	public	_erase_line
	public	_flush_output
	public	_hidemouse
	public	_mousestatus
	public	_outchar
	public	_outstr
	public	_scroll_up
	public	_scroll_down
	public	_set_colour
	public	_showmouse
	public	_tty_endv
	public	_tty_goto
	public	_tty_open
	public	_tty_startv

;
; Segment addresses for PC text mode frame buffer.
;
VMONOSEG	=	0b000h	; Mono frame buffer.
VCOLOURSEG	=	0b800h	; Colour frame buffer.

;
; BIOS video functions.
;
vbios		macro	ahval, alval
	ifnb	<ahval>
	    ifnb <alval>
		mov	ax, (ahval shl 8) + alval
	    else
		mov	ah, ahval
	    endif
	endif
		int	10h
		endm
;
; BIOS video function numbers.
;
B_MOVECURSOR	=	2	; Move cursor.
B_UPSCROLL	=	6	; Scroll window up.
B_DOWNSCROLL	=	7	; Scroll window down.
B_WRITECHAR	=	9	; Write character & attribute at
				; current position.
B_TTYWRITE	=	0eh	; Teletype-style write.
B_GETMODE	=	0fh	; Get video mode.
B_SETPALETTE	=	10h	; Set palette registers.
B_EGACGEN	=	11h	; EGA character generator.
B_VCONFIG	=	12h	; Video subsystem configuration.

;
; Subfunction (of function 10h) for setting overscan register.
;
B_OVERSCAN	=	1

;
; Subfunctions for EGA character generator.
;
B_EGATEST	=	30h
B_8X8FONT	=	12h
B_8X14FONT	=	11h

;
; BIOS function to use alternate print screen routine.
;
altpscreen	macro
		mov	bl, 20h
		vbios	B_VCONFIG
		endm

;
; BIOS function to get equipment list.
;
biosequip	macro
		int	11h
		endm
;
; Value returned by biosequip (in ax) to indicate a mono display.
;
EQUIP_MONO	=	30h

;
; Default number of rows in text modes.
;
DEF_T_ROWS	=	25

;
; Video modes.
;
BWT25X80	=	2	; 25 x 80 black & white (CGA) text.
CT25X80		=	3	; 25 x 80 colour text.
MT25X80		=	7	; 25 x 80 monochrome (MDA) text.

;
; I/O ports.
;
TIMER_2		=	42h	; Timer channel 2.
TIMER_3		=	43h	; Timer channel 3.
PORT_B		=	61h	; 8255 port B.

;
; Interrupt used by Microsoft mouse driver.
;
MSMINT		=	33h

;
; Call mouse driver.
;
msmouse		macro	funcnum
	ifnb	<funcnum>
		mov	ax, funcnum
	endif
		int	MSMINT
		endm
;
; Mouse driver function numbers.
;
MSM_SHOW	=	1
MSM_HIDE	=	2
MSM_GETSTATUS	=	3
MSM_SETYLIMITS	=	8

;
; Values for mouseflag.
;
MF_NOMOUSE	=	-1
MF_INITIAL	=	0
MF_OK		=	1
MF_VISIBLE	=	2

;
; Segment containing interrupt vector table.
;
INTVECTAB	segment at 0
		;
		; Vector used by Microsoft mouse driver.
		;
		org (MSMINT * 4)
msvecoff	dw	?
msvecseg	dw	?
INTVECTAB	ends

;
; BIOS variable data segment.
;
BVSEG		=	40h

BIOSDATA	segment at BVSEG
		;
		; Low word of timer variable.
		;
		org	6ch
b_timer_low	dw	?
		;
		; Variable giving number of screen rows - 1.
		;
		org	84h
b_rowsvar	db	?
BIOSDATA	ends

_TEXT		segment word public 'CODE'
		assume	nothing
		assume	cs: _TEXT

		even
	ifdef	SWAPSCREEN
saveptr		label	dword	; Pointer to saved screen image.
svboff		dw	0
svbseg		dw	0
scrwords	dw	?	; Number of 2-byte words in saved
				; screen image.
	endif	; SWAPSCREEN
vbase		dw	0	; Segment address of frame buffer. If
				; this is 0, we don't access the frame
				; buffer directly.
vcolumn		label	byte
vpos		dw	?	; Virtual screen position.
scrsize		label	word	; Screen dimensions.
ncolumns	db	?	; Low byte of scrsize.
nrows		db	?	; High byte of scrsize.
writemethod	dw	offset bioswrite
				; Pointer to function we use for
				; outputting characters to the screen.
startmode	db	?
ega		db	0	; Flag indicating presence of EGA/VGA.
vcolour		db	?	; Virtual colour.
	ifdef	MOUSE
mouseflag	db	MF_INITIAL
				; This is changed by _tty_startv to
				; MF_OK if we have a mouse driver
				; installed, or MF_NOMOUSE if we
				; haven't.
	else	; MOUSE
mouseflag	db	MF_NOMOUSE
	endif	; MOUSE

	ifdef	SWAPSCREEN
	;
	; These routines deal with saving the previous screen image &
	; restoring it.
	;
savescreen:
		cmp	vbase, 0
		je	dontcopy
		push	si
		push	di
		push	ds
		les	di, saveptr
		mov	ax, es
		or	ax, di
		jz	cps_pop
		mov	ds, vbase
		clear	si
		jmp short copyscreen

restorescreen	proc	near
		cmp	vbase, 0
		je	dontcopy
		push	si
		push	di
		push	ds
		mov	es, vbase
		clear	di
		lds	si, saveptr
		mov	ax, ds
		or	ax, si
		jz	cps_pop
copyscreen:
		mov	cx, scrwords
		cld
		rep	movsw
cps_pop:
		pop	ds
		pop	di
		pop	si
dontcopy:
		ret
restorescreen	endp
	endif	; SWAPSCREEN

		even
_flush_output:
		;
		; void flush_output(void);
		;
		; Update real cursor position.
		;
		push	bp
		mov	dx, vpos
		clear	bh		; Display page 0.
		vbios	B_MOVECURSOR
		pop	bp
		C_ret

		even
_erase_line:
		;
		; void erase_line(void);
		;
		; Erase to end of line.
		;
		; Don't update cursor position.
		;
		mov	cl, ncolumns	; Get width of screen.
		mov	al, vcolumn	; Get current column.
		sub	cl, al		; Number of spaces to write ...
		jz	noerase		; ... except if it's 0 ...
		clear	ch
		mov	al, ' '
		cld
		call	[writemethod]
noerase:
		C_ret

_erase_display:
		;
		; void erase_display(void);
		;
		; Erase entire display by using BIOS scroll screen
		; function to scroll all the lines in the display.
		;
		; Don't update cursor position.
		;
		call	_cparams	; This is in ibmpc_c.c.
		mov	bh, al		; Get colour for blank screen.
		push	bp
		clear	cx		; Top left row & column (0).
		mov	al, nrows	; Number of lines (0).
		mov	dx, scrsize
		dec	dh		; Bottom right row.
		dec	dl		; Bottom right column.
		vbios	B_UPSCROLL
		pop	bp
		C_ret

		even
_showmouse:
		;
		; void showmouse(void);
		;
		; Show mouse cursor.
		;
		; If we don't seem to have a mouse driver, or we think
		; the cursor is already visible, don't do anything.
		;
		cmp	mouseflag, MF_OK
		jne	m_invalid
		mov	ax, MSM_SHOW
		mov	mouseflag, MF_VISIBLE
m_valid:
		msmouse
m_invalid:
		C_ret

		even
_hidemouse:
		;
		; void hidemouse(void);
		;
		; Hide mouse cursor.
		;
		; If we don't seem to have a mouse driver, or we don't
		; think the cursor is visible, don't do anything.
		;
		cmp	mouseflag, MF_VISIBLE
		jne	m_invalid
		mov	ax, MSM_HIDE
		mov	mouseflag, MF_OK
		jmp short m_valid

_mousestatus:
		;
		; unsigned mousestatus(unsigned *xpos, unsigned *ypos);
		;
		; Return mouse button status, with current mouse
		; co-ordinates in *xpos & *ypos.
		;
		push	bp
		mov	bp, sp
		cmp	mouseflag, MF_OK
		jge	getstatus	; if it's MF_OK or MF_VISIBLE
		clear	ax		; Button status = 0.
		cwd			; y co-ordinate = 0.
		mov	cx, ax		; x co-ordinate = 0.
		jmp short ms_finish
getstatus:
		msmouse MSM_GETSTATUS
		mov	ax, bx		; Return button status in ax.
ms_finish:
		;
		; Stack frame:
		;
		;   bp + CPTRSIZE + DPTRSIZE + 2
		;		ypos pointer
		;
		;   bp + CPTRSIZE + 2
		;		xpos pointer
		;
		;   bp + 2	return address
		;
		;   bp		caller's bp
		;
	if DPTRSIZE eq 4
		push	ds
	endif
		ptrasg	<[bp + CPTRSIZE + 2]>, cx
				; x co-ordinate.
		assume	ds: nothing
		ptrasg	<[bp + CPTRSIZE + DPTRSIZE + 2]>, dx
				; y co-ordinate.
	if DPTRSIZE eq 4
		pop	ds
	endif
		pop	bp
		C_ret

_tty_open:
		;
		; void tty_open(unsigned int *prows, unsigned int *pcolumns);
		;
		; Initialize display. Parameters point to variables in
		; caller's default data segment giving dimensions of
		; screen. We also maintain our own record of these
		; values in scrsize, in this segment.
		;
		push	bp
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume	ds: _TEXT
		clear	dx
		mov	bx, dx
		vbios	B_EGACGEN, B_EGATEST	; Do we have an EGA/VGA?
		tst	dl
		jz	notega
		inc	dl		; Yes: dl is number of rows - 1.
		inc	ega
		jmp short testmode
notega:
		mov	dl, DEF_T_ROWS	; No: assume 25 rows.
testmode:
		vbios	B_GETMODE
		mov	bp, sp
		mov	cx, cs
		;
		; Register usage at this point:
		;
		;	al	current display mode
		;	ah	number of text columns
		;	cx	our code segment
		;	dl	number of text rows
		;	bp	pointer (relative to ss) to stack frame
		;
		; Stack frame:
		;
		;   bp + CPTRSIZE + DPTRSIZE + 4
		;		pointer to screen columns variable
		;
		;   bp + CPTRSIZE + 4
		;		pointer to screen rows variable
		;
		;   bp + 4	return address
		;
		;   bp + 2	caller's bp
		;
		;   bp		caller's ds
		;
		mov	ncolumns, ah
		mov	nrows, dl
	if DPTRSIZE eq 2
		mov	ds, [bp]
		assume	ds: nothing
	endif
		clear	dh		; Clear high byte of rows.
		ptrasg	<[bp + CPTRSIZE + 4]>, dx
					; Return rows to caller.
		assume	ds: nothing
		mov	dl, ah
		ptrasg	<[bp + CPTRSIZE + DPTRSIZE + 4]>, dx
		mov	ds, cx		; Point ds to our code segment again.
		assume	ds: _TEXT
		mov	startmode, al
		cmp	al, MT25X80	; Mono text mode?
		jne	notmda
		biosequip
		and	ax, EQUIP_MONO	; Is it a real mono system?
		cmp	ax, EQUIP_MONO
		jne	notmda		; No.
		mov	vbase, VMONOSEG
		jmp short directvideo
notmda:
		cmp	al, CT25X80	; Is it a graphics mode?
		ja	o_finish	; Yes.
		cmp	ega, 0		; Do we have an EGA or VGA?
		je	o_finish	; No.
		mov	vbase, VCOLOURSEG
directvideo:
		mov	writemethod, offset fastwrite
	ifdef	SWAPSCREEN
		mov	ax, scrsize
		dec	ah		; (number of rows - 1) ...
		mul	ah		; times (number of columns) ...
		mov	scrwords, ax	; = number of screen
					; characters to save ...
		shl	ax, 1		; times 2 = number of bytes to save.
		mov	ds, [bp]	; Restore ds for C library.
		assume	ds: nothing
		push	ax
		call	_malloc
		inc	sp
		inc	sp
	if DPTRSIZE eq 2
		cwd			; if (ax == 0) dx = 0;
		tst	ax		; if (malloc() returned NULL) ...
		jz	dxok		; ... dx should also be 0.
		mov	dx, ds		; ds now points to C data segment,
					; not our code segment.
dxok:
	endif	; DPTRSIZE eq 2
		mov	svboff, ax
		mov	svbseg, dx
	endif	; SWAPSCREEN
o_finish:
		pop	ds
		assume	ds: nothing
		pop	bp
		C_ret

_tty_startv:
		;
		; void tty_startv();
		;
		; If we've run a child process, & the mode has
		; changed, we do our level best to restore it to what
		; it was before: otherwise we're in trouble because
		; the screen dimensions have probably changed.
		;
		push	bp
		push	ds
		mov	ax, cs
		mov	ds, ax
		assume	ds: _TEXT
		vbios	B_GETMODE
		mov	dx, scrsize
		cmp	al, startmode	; Has mode changed since we started?
		jne	changemode
		cmp	ah, dl		; Current number of columns is
					; in ah; check that it hasn't
					; changed.
		je	modeok		; It hasn't.
changemode:
		mov	al, startmode
		clear	ah		; Function 0 (set mode).
		vbios
		mov	al, startmode
modeok:
		cmp	ega, 0
		je	sv_save
		;
		; If we have an EGA/VGA, the number of rows may have
		; changed even though the mode hasn't, because
		; fonts with different sizes can be loaded.
		;
		cmp	al, BWT25X80
		je	checkrows
		cmp	al, CT25X80
		je	checkrows
		cmp	al, MT25X80
		jne	sv_save
checkrows:				; Check number of rows.
		mov	ax, BVSEG
		mov	es, ax
		assume	es: BIOSDATA
		mov	al, b_rowsvar
		inc	al
		cmp	al, dh
		jae	sv_save
		altpscreen
		assume	es: nothing
		mov	ax, (B_EGACGEN shl 8) + B_8X14FONT
					; Use default EGA font.
		cmp	dh, DEF_T_ROWS
		jbe	setegafont
		mov	ax, (B_EGACGEN shl 8) + B_8X8FONT
					; Use small font.
setegafont:
		clear	bl		; Table 0 in character generator RAM.
		vbios
sv_save:
	ifdef	SWAPSCREEN
		call	savescreen
	endif	; SWAPSCREEN
	ifdef	MOUSE
		cmp	mouseflag, MF_INITIAL
		js	sv_finish	; MF_NOMOUSE?
		jne	mousereset	; MF_OK or MF_VISIBLE?
		clear	ax
		mov	es, ax
		assume	es: INTVECTAB
		mov	ax, msvecoff	; Check the actual interrupt
		or	ax, msvecseg	; vector for the mouse driver.
		jz	sv_nomouse	; If it's 0, we can't call it.
mousereset:
		assume	es: nothing
		clear	ax		; Function 0 (initialize mouse
		msmouse			; driver).
		tst	ax
		jz	sv_nomouse		; Failure.
		mov	mouseflag, MF_OK	; Success.
		;
		; Set vertical limits for mouse movement according to
		; the number of screen rows; apparently the Microsoft
		; driver sometimes gets this wrong.
		;
		mov	dl, nrows	; Let dx = (nrows - 1) * 8.
		dec	dl
		clear	dh
		mov	cl, 3
		shl	dx, cl
		clear	cx
		msmouse MSM_SETYLIMITS
		jmp short sv_finish
sv_nomouse:
		mov	mouseflag, MF_NOMOUSE
	endif	; MOUSE
sv_finish:
		pop	ds
		assume	ds: nothing
		pop	bp
		C_ret

_tty_endv:
		;
		; void tty_endv();
		;
		; We're about to exit or run another process. Restore
		; previous screen if appropriate, update real cursor
		; position & reset mouse driver to its default state
		; if required.
		;
	ifdef	SWAPSCREEN
		;
		; At this stage, sys_endv() should have just gone to
		; the bottom line, set the colour to
		; Pn(P_systemcolour) & cleared the line. We shouldn't
		; disturb its work, so restorescreen just restores the
		; top (nrows - 1) lines. This is controlled by the
		; scrwords variable.
		;
		call	restorescreen
	endif	; SWAPSCREEN
		Cn_call _flush_output
		cmp	mouseflag, MF_INITIAL
		jle	ev_finish
		clear	ax
		msmouse
ev_finish:
		C_ret

		even
_tty_goto:
		;
		; void tty_goto(int row, int column);
		;
		; Change virtual screen position.
		;
		mov	bx, sp
		mov	ah, byte ptr ss:[bx + CPTRSIZE]
		mov	al, byte ptr ss:[bx + CPTRSIZE + 2]
		mov	vpos, ax
		C_ret

_set_colour:
		;
		; void set_colour(int colour);
		;
		; Change virtual screen colour.
		;
		mov	bx, sp
		mov	al, byte ptr ss:[bx + CPTRSIZE]
		mov	vcolour, al
		C_ret

;
; These two routines are functionally equivalent; they are only called
; by indirection through the "writemethod" pointer.
;
		even
fastwrite	proc	near
		;
		; Write single character, or a number of repetitions
		; of the same character, to the screen. Character is
		; in al, number of repetitions in cx.
		;
		; This writes directly to the text mode frame buffer.
		;
		; Note that:
		;
		;	- the direction flag must be clear.
		;
		;	- cx is destroyed.
		;
		push	di
		mov	es, vbase
		mov	dx, vpos	; Get offset into frame buffer.
		mov	bl, ncolumns
		xchg	ax, bx		; al is now number of columns;
					; bl is character to write ...
		mul	dh		; ax is now (current row *
					;	     number of columns) ...
		clear	dh
		add	ax, dx		; Add current column (dl).
		shl	ax, 1		; Multiply by 2 to get word offset.
		mov	di, ax
		mov	al, bl		; Retrieve character to write.
		mov	ah, vcolour
		rep	stosw		; Do the actual copying.
		pop	di
		ret
fastwrite	endp

		even
bioswrite	proc	near
		;
		; Write single character, or a number of repetitions
		; of the same character, to the screen. Character is
		; in al, number of repetitions in cx.
		;
		; This uses the BIOS B_WRITECHAR function.
		;
		push	bp
		clear	bh		; Display page 0.
		mov	dx, vpos
		push	ax
		vbios	B_MOVECURSOR
		pop	ax
		mov	bl, vcolour
		vbios	B_WRITECHAR
		pop	bp
		ret
bioswrite	endp

		even
vpadjust	proc	near
		;
		; Adjust virtual cursor position.
		;
		mov	ax, scrsize
		mov	dx, vpos
		inc	dl		; Increment column.
		cmp	dl, al
		jb	adjust
		clear	dl		; Wrap round to next line.
		inc	dh
		cmp	dh, ah
		jnb	vpa_finish
adjust:
		mov	vpos, dx
vpa_finish:
		ret
vpadjust	endp

		even
_outchar:
		;
		; void outchar(int character);
		;
		; Display one character.
		;
		mov	bx, sp
		mov	al, byte ptr ss:[bx + CPTRSIZE]
		mov	cx, 1
		cld
		call	[writemethod]
		call	vpadjust
		C_ret

		even
_outstr:
		;
		; void outstr(char *string);
		;
		; Display C string.
		;
		mov	bx, sp
		push	si

	if DPTRSIZE eq 4
		push	ds
		lds	si, ss:[bx + CPTRSIZE]
		assume	ds: nothing
	else
		mov	si, [bx + CPTRSIZE]
	endif
		cld
getnextc:
		lodsb			; Get next character in al.
		tst	al		; Are we at the terminating '\0'?
		jz	endstring
		mov	cx, 1
		call	[writemethod]
		call	vpadjust
		jmp	getnextc
		even
endstring:
	if DPTRSIZE eq 4
		pop	ds
	endif
		pop	si
		C_ret

scrollah:
		;
		; void scroll_up(unsigned startline,
		;		 unsigned endline,
		;		 unsigned nlines);
		;
		; void scroll_down(unsigned startline,
		;		   unsigned endline,
		;		   unsigned nlines);
		;
		push	bp
		mov	bp, sp
		mov	al, byte ptr [bp + CPTRSIZE + 6]
						; Number of lines.
		tst	al			; If 0 lines ...
		jz	noscroll		; ... do nothing.
		clear	cl			; Top left column (0).
		mov	ch, byte ptr [bp + CPTRSIZE + 2]
						; Top left row.
		mov	dl, ncolumns		; Bottom right column.
		dec	dl
		mov	dh, byte ptr [bp + CPTRSIZE + 4]
						; Bottom right row.
		mov	bh, vcolour		; Colour for blank lines.
		vbios
noscroll:
		pop	bp
		C_ret

_scroll_up:
		;
		; Scroll region of screen up.
		;
		mov	ah, B_UPSCROLL
		jmp	scrollah

_scroll_down:
		;
		; Scroll region of screen down.
		;
		mov	ah, B_DOWNSCROLL
		jmp	scrollah

_alert:
		;
		; void alert(void);
		;
		call	_cparams
		;
		; cparams() gives us the current text colour in al,
		; the status line colour in ah & a visual bell flag in
		; dx; if this is non-zero, we use a visual bell
		; instead of an audible bell.
		;
		push	bp
		tst	dx
		pushf		; Save processor flags on stack.
				; Zero flag means use audible bell.
		jz	ab_on
		;
		; Visual bell. Set overscan colour to the background
		; component of the current text colour (or, if this is
		; black, the background component of the current
		; status line colour) temporarily.
		;
		; To get the backround component, we have to shift the
		; value right 4 bits.
		;
		mov	cl, 4
		shr	al, cl		; Get text background colour.
		mov	bh, al
		tst	al
		jnz	gotcolour	; Text background colour isn't black.
		shr	ah, cl		; Get status line background colour.
		mov	bh, ah
gotcolour:
		vbios	B_SETPALETTE, B_OVERSCAN
		jmp short asdelay
ab_on:
		;
		; Audible bell. Make speaker sound by programming the
		; timer chip & the 8255 directly.
		;
		cli
		mov	dx, TIMER_3
		mov	al, 0b6h
		out	dx, al		; Select timer channel 2 mode.
		dec	dx
		;
		; Send frequency data to timer. This gives us a
		; frequency of about 2 kHz.
		;
		mov	al, 99h		; Low byte of timer interval.
		out	dx, al
		mov	al, 2		; High byte of timer interval.
		out	dx, al
		mov	dx, PORT_B
		in	al, dx		; Get status of port B.
		mov	ah, al		; Store it in ah.
		or	al, 3
		out	dx, al		; Turn speaker on.
		sti
		;
		; Delay for 3 clock ticks (about 1/9 - 1/6 sec.).
		;
		; Don't change ah or dx.
		;
asdelay:
		mov	cx, 3
		mov	bx, BVSEG
		mov	es, bx
		assume	es: BIOSDATA
tloop:
		mov	bx, b_timer_low
waittick:
		cmp	bx, b_timer_low
		je	waittick
		loop	tloop
		;
		; Delay loop has now finished.
		;
		popf			; Retrieve flags from stack.
		jz	ab_off		; Zero flag means use audible bell.
		clear	bh		; Set border colour to black.
		vbios	B_SETPALETTE, B_OVERSCAN
		jmp short ab_finish
ab_off:
		mov	al, ah		; Previous status of port B.
		and	al, not 3
		out	dx, al		; Turn speaker off.
ab_finish:
		pop	bp
		assume	es: nothing
		C_ret

_TEXT		ends
		end
