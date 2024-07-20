{{
CON
''********************************************
''*  Full-Duplex Serial 2-Port Driver v1.3   *
''*  Author: Michael Sommer (MSrobots)       *
''*  Inspired heavily by Eric Smith          *
''********************************************

''
'' Modified by Ross Higson for use with Catalina
'' (simply by commenting out all Spin functions)
''

{-----------------REVISION HISTORY-----------------
 
 v1.0 - 3/3/2019 first official release.
	mode bit 0 = invert rx			- supported
	mode bit 1 = invert tx			- supported
	mode bit 2 = open-drain/source tx 	- not supported yet
	mode bit 3 = ignore tx echo on rx 	- not supported yet
 v1.1 - 06/29/2019 added writehex to output a block of longs as hex
 v1.2 - 07/02/2019 added start parameter as VAR not procedure parameter addresss
 v1.3 - 07/22/2019 added echo for string input
}
'=======================================================================
'
' buffered smart pin serial object buffering rx/tx in the Cog
'
' supporting 2 full-duplex connections
' using one onnection you have 1024 bytes buffer for each RX and TX
' using two onnections you have 512 bytes buffer for each RX and TX
'
'=======================================================================
'
CON
  _tx_mode_default    = %0000_0000_000_0000000000000_01_11110_0 				'async tx mode, true output, output enabled for smart output
  _rx_mode_default    = %0000_0000_000_0000000000000_00_11111_0 				'async rx mode, true input, input  enabled for smart input
  _tx_mode_inverted   = %1000_0000_000_0000000000000_01_11110_0 				'async tx mode, iverted output, output enabled for smart output
  _rx_mode_inverted   = %1000_0000_000_0000000000000_00_11111_0 				'async rx mode, inverted input, input  enabled for smart input
'
'=======================================================================
'
VAR
  long cog											'cog id of this instance
  long rx1cmd, rx1param, tx1cmd, tx1param, rx2cmd, rx2param, tx2cmd, tx2param			'mailbox of this instance 8 longs
'-----------------------------------------------------------------------			'the rest just needed for start parameters
  long hmailboxaddress
  long hrxpin1, hrxbitrate1, hrxmode1, hrxlutstart1, hrxlutsize1
  long htxpin1, htxbitrate1, htxmode1, htxlutstart1, htxlutsize1
  long hrxpin2, hrxbitrate2, hrxmode2, hrxlutstart2, hrxlutsize2
  long htxpin2, htxbitrate2, htxmode2, htxlutstart2, htxlutsize2
  long htxclocks
'
'=======================================================================
'
'-----------------------------------------------------------------------
'stop pasm cog if already running
'-----------------------------------------------------------------------
'
PUB stop
  if cog
    cogstop(cog-1)
    cog := 0
'
'-----------------------------------------------------------------------
'return parameter address of instance
'-----------------------------------------------------------------------
'
PUB mailboxaddress
RETURN @rx1_cmd
'
'-----------------------------------------------------------------------
' start with default serial pins and mode
'-----------------------------------------------------------------------
'
PUB start_default(baudrate)
  return start(63, 62, 0, baudrate)
'
'-----------------------------------------------------------------------
'use this to start a 1 port driver with 1024 bytes buffer each channel
'-----------------------------------------------------------------------
'
PUB start(rxpin = 63, txpin = 62, mode = 0, baudrate = 230_400)  | bitrate,rxmode1,txmode1
'' mode bit 0 = invert rx
'' mode bit 1 = invert tx
'' mode bit 2 = open-drain/source tx - not supported yet
'' mode bit 3 = ignore tx echo on rx - not supported yet
  bitrate := 7 + ((CLKFREQ / baudrate) << 16)
  rxmode1 := _rx_mode_default
  txmode1 := _tx_mode_default
  if (mode > -1)
    if (mode & %1) > 0
      rxmode1 := _rx_mode_inverted
    if (mode & %10) > 0
      txmode1 := _tx_mode_inverted
RETURN startpasm(@rx1cmd, rxpin, bitrate, rxmode1, 0, $3FF, txpin, bitrate, txmode1, $100, $3FF, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 100)
'
'-----------------------------------------------------------------------
'use this to start a 2 port driver with 512 bytes buffer each channel
'-----------------------------------------------------------------------
'
PUB start2(rxpin1, txpin1, mode1, baudrate1, rxpin2, txpin2, mode2, baudrate2) | bitrate1, bitrate2,rxmode1,rxmode2,txmode1,txmode2
'' mode bit 0 = invert rx
'' mode bit 1 = invert tx
'' mode bit 2 = open-drain/source tx - not supported yet
'' mode bit 3 = ignore tx echo on rx - not supported yet
  bitrate1 := 7 + ((CLKFREQ / baudrate1) << 16)
  bitrate2 := 7 + ((CLKFREQ / baudrate2) << 16)
  rxmode1 := _rx_mode_default
  txmode1 := _tx_mode_default
  if (mode1 > -1) 
    if (mode1 & %1) > 0
      rxmode1 := _rx_mode_inverted
    if (mode1 & %10) > 0
      txmode1 := _tx_mode_inverted

  rxmode2 := _rx_mode_default
  txmode2 := _tx_mode_default
  if (mode2 > -1)
    if (mode2 & %1) > 0
      rxmode2 := _rx_mode_inverted
    if (mode2 & %10) > 0
      txmode2 := _tx_mode_inverted

RETURN startpasm(@rx1cmd, rxpin1, bitrate1, rxmode1, 0, $1FF, txpin1, bitrate1, txmode1, $80, $1FF, rxpin2, bitrate2, rxmode2, $100, $1FF, txpin2, bitrate2, txmode2, $180, $1FF, 100)
'
'-----------------------------------------------------------------------
'use this to start whatever combination you want
'-----------------------------------------------------------------------
'
PUB startExt(rxpin1, txpin1, rxbaudrate1, txbaudrate1, rxconfig1, txconfig1, rxlutstart1, rxlutsize1, txlutstart1, txlutsize1, rxpin2, txpin2, rxbaudrate2, txbaudrate2, rxconfig2, txconfig2, rxlutstart2, rxlutsize2, txlutstart2, txlutsize2, txclocks)  | rxmode1, txmode1, rxmode2, txmode2, rxbitrate1, txbitrate1, rxbitrate2, txbitrate2 
'' 
'' WARNING
'' =======
'' HERE RXMODE AND TXMODE ARE THE SMARTPIN CONFIGURATION, NOT THE FULLDUPLEX SERIAL MODE
'' 
  if rxconfig1 == -1
    rxmode1 := _rx_mode_default
  else 
    rxmode1 := rxconfig1
  if txconfig1 == -1
    txmode1 := _tx_mode_default
  else 
    txmode1 := txconfig1
  if rxconfig2 == -1
    rxmode2 := _rx_mode_default
  else 
    rxmode2 := rxconfig2
  if txconfig2 == -1
    txmode2 := _tx_mode_default
  else 
    txmode2 := txconfig2
  rxbitrate1 := 7 + ((CLKFREQ / rxbaudrate1) << 16)
  txbitrate1 := 7 + ((CLKFREQ / txbaudrate1) << 16)
  rxbitrate2 := 7 + ((CLKFREQ / rxbaudrate2) << 16)
  txbitrate2 := 7 + ((CLKFREQ / txbaudrate2) << 16)
  RETURN startpasm(@rx1cmd, rxpin1, rxbitrate1, rxmode1, rxlutstart1, rxlutsize1, txpin1, txbitrate1, txmode1, txlutstart1, txlutsize1, rxpin2, rxbitrate2, rxmode2, rxlutstart2, rxlutsize2, txpin2, txbitrate2, txmode2, txlutstart2, txlutsize2, txclocks)
'
'-----------------------------------------------------------------------
'this provides the parameter array needed to start the pasm cog on the stack
'-----------------------------------------------------------------------
'
PRI startpasm(mailboxaddress, rxpin1, rxbitrate1, rxmode1, rxlutstart1, rxlutsize1, txpin1, txbitrate1, txmode1, txlutstart1, txlutsize1, rxpin2, rxbitrate2, rxmode2, rxlutstart2, rxlutsize2, txpin2, txbitrate2, txmode2, txlutstart2, txlutsize2, txclocks)
  stop	

  hmailboxaddress	:= mailboxaddress	
  hrxpin1		:= rxpin1
  hrxbitrate1		:= rxbitrate1
  hrxmode1		:= rxmode1
  hrxlutstart1		:= rxlutstart1
  hrxlutsize1		:= rxlutsize1
  htxpin1		:= txpin1
  htxbitrate1		:= txbitrate1
  htxmode1		:= txmode1
  htxlutstart1		:= txlutstart1
  htxlutsize1		:= txlutsize1
  hrxpin2		:= rxpin2
  hrxbitrate2		:= rxbitrate2
  hrxmode2		:= rxmode2
  hrxlutstart2		:= rxlutstart2
  hrxlutsize2		:= rxlutsize2
  htxpin2		:= txpin2 
  htxbitrate2		:= txbitrate2
  htxmode2		:= txmode2
  htxlutstart2		:= txlutstart2
  htxlutsize2		:= txlutsize2 
  htxclocks		:= txclocks
												'Mailbox. So now I use long[long[]] to access the first long in the later used mailbox as Flag
  long[long[@hmailboxaddress]] := 0								'set flag (0) to know if the started cog has read its parameters
  cog := cognew(@cogserial_init,@hmailboxaddress) + 1
  if cog											'if I was able to start the COG
    repeat until long[long[@hmailboxaddress]] == -1						'I wait until Flag states cog is done reading parameter and ready to roll  (-1)
    RESULT := 1											'now start done
RETURN 
'
'=======================================================================
'All of these routines need a port value, 0 for rx1 and tx1, 1 for rx2 and tx2 
'if you don't provide a port value fastspin will use 0 using rx1 and tx1 
'=======================================================================
'
'=======================================================================
'
'Basic I/O
'
'================================ RX ===================================
'
'-----------------------------------------------------------------------
' returns nothing flushes rx buffer (waits until buffer completely empty)
'-----------------------------------------------------------------------
'
PUB rxflush(port=0) 
  repeat while rxcheck(port) => 0
'
'-----------------------------------------------------------------------
' check if byte received (never waits)
' returns -1 if no byte, otherwise received byte
'-----------------------------------------------------------------------
'
PUB rxcheck(port=0) 
RETURN read(0, -2, port)
'
'-----------------------------------------------------------------------
' find out if a byte is ready to receive
' returns 0 if none ready
'-----------------------------------------------------------------------
'
PUB rxready(port=0)
RETURN rxcount(port)
'
'-----------------------------------------------------------------------
' Wait ms milliseconds for a byte to be received
' returns -1 if no byte received, $00..$FF if byte
'-----------------------------------------------------------------------
'
PUB rxtime(ms) : rxbyte | t
  t := cnt
  repeat until (rxbyte := rxcheck) => 0 or (cnt - t) / (clkfreq / 1000) > ms
'
'-----------------------------------------------------------------------
' receive a byte (waits until done)
' returns received byte
'-----------------------------------------------------------------------
'
PUB rx(port=0)
  read(@RESULT, 1, port)
'
'-----------------------------------------------------------------------
' receive a string ending with CR or NL or max size (waits until done)
'-----------------------------------------------------------------------
'
PUB strin(hubaddress, size, echo=1, port=0)
  strin_async(hubaddress, size, echo, port)
RETURN wait_rxready(port, -1)
'
'-----------------------------------------------------------------------
' receive a block from serial to memory of given size in bytes (waits until done)
'-----------------------------------------------------------------------
'
PUB read(hubaddress, size, port=0)
  read_async(hubaddress, size, port)
RETURN wait_rxready(port, -1)
'
'================================ TX ===================================
'
'-----------------------------------------------------------------------
' Flush transmit buffer (waits until buffer completely send)
'-----------------------------------------------------------------------
'
PUB txflush(port=0) | bsize
  bsize := txsize(port)
  repeat while txcount(port) < bsize
'
'-----------------------------------------------------------------------
' check if byte can be send (never waits)
' returns -1 if no space in buffer otherwise number of bytes free in send buffer
'-----------------------------------------------------------------------
'
PUB txcheck(port=0)  
RETURN write(0, -2, port)
'
'-----------------------------------------------------------------------
' transmit a byte (waits until done)
'-----------------------------------------------------------------------
'
PUB tx(val, port=0)
  write(-1,val, port)
'
'-----------------------------------------------------------------------
' transmit a string (waits until done)
'-----------------------------------------------------------------------
'
PUB str(s = string(""), port=0) 
  write(s, -5, port)

'
'-----------------------------------------------------------------------
' transmit a block from memory to serial of given size in bytes (waits until done)
'-----------------------------------------------------------------------
'
PUB writehex(hubaddress, size, port=0) | tmp, count
  tmp:=hubaddress
  count:=size/4
  repeat count
    hex(long[tmp], 8, port)
    tmp:=tmp+4
RETURN wait_txready(port)
'
'-----------------------------------------------------------------------
' transmit a block from memory to serial of given size in bytes (waits until done)
'-----------------------------------------------------------------------
'
PUB write(hubaddress, size, port=0)
  write_async(hubaddress, size, port)
RETURN wait_txready(port)
'
'=======================================================================
'
' adapted for two ports and bluntly stolen from Spin2gui / fastspin (thanks Eric!)
'
'=======================================================================

{
   standard routines for dealing with text
   these are intended to extend any class with a "tx" method
   with the following additional methods

   str(s) : print a string; note that unlike standard Spin the string()
      wrapper is not required for string literals, because we have defaulted
      the parameter s to be a string
   dec(d) : print a signed decimal number
   decuns(d) : print an unsigned decimal number
   hex(d, n): print a hex number with n digits (n defaults to 8)
   bin(d, n): print a binary number with n digits (n defaults to 32)
   nl : print a carriage return and newline
   printf(s, ...) : like C printf
}

''
'' print an number with a given base
'' we do this by finding the remainder repeatedly
'' this gives us the digits in reverse order
'' so we store them in a buffer; the worst case
'' buffer size needed is 32 (for base 2)
''
''
'' signflag indicates how to handle the sign of the
'' number:
''   0 == treat number as unsigned
''   1 == print nothing before positive numbers
''   anything else: print before positive numbers
'' for signed negative numbers we always print a "-"
''
'' we will print at least prec digits
''
'-----------------------------------------------------------------------
VAR
  byte buf[32]
'-----------------------------------------------------------------------
PUB Num(val, base, signflag, digitsNeeded, port=0) | i, digit, r1, q1

  '' if signflag is nonzero, it indicates we should treat
  '' val as signed; if it is > 1, it is a character we should
  '' print for positive numbers (typically "+")
  
  if (signflag)
      if (val < 0)
        signflag := "-"
	val := -val
	
  '' make sure we will not overflow our buffer
  if (digitsNeeded > 32)
    digitsNeeded := 32

  '' accumulate the digits
  i := 0
  repeat
    if (val < 0)
      ' synthesize unsigned division from signed
      ' basically shift val right by 2 to make it positive
      ' then adjust the result afterwards by the bit we
      ' shifted out
      r1 := val&1  ' capture low bit
      q1 := val>>1 ' divide val by 2
      digit := r1 + 2*(q1 // base)
      val := 2*(q1 / base)
      if (digit => base)
        val++
	digit -= base
    else
      digit := val // base
      val := val / base

    if (digit => 0 and digit =< 9)
       digit += "0"
    else
       digit := (digit - 10) + "A"
    buf[i++] := digit
    --digitsNeeded
  while (val <> 0 or digitsNeeded > 0) and (i < 32)
  if (signflag > 1)
    tx(signflag)
'' now print the digits in reverse order
  repeat while (i > 0)
    tx(buf[--i], port)
'
'-----------------------------------------------------------------------
' print a signed decimal number
'-----------------------------------------------------------------------
'
PUB dec(val, port=0)
  num(val, 10, 1, 0, port)
'
'-----------------------------------------------------------------------
' print an unsigned decimal number with the specified
' number of digits; 0 means just use as many as we need
'-----------------------------------------------------------------------
'
PUB decuns(val, digits = 0, port=0)
  num(val, 10, 0, digits, port)
'
'-----------------------------------------------------------------------
' print a hex number with the specified number
' of digits; 0 means just use as many as we need
'-----------------------------------------------------------------------
'
PUB hex(val, digits = 8, port=0) | mask
  if digits > 0 and digits < 8
    mask := (|< (4*digits)) - 1
    val &= mask
  num(val, 16, 0, digits, port)
'
'-----------------------------------------------------------------------
' print a number in binary form
'-----------------------------------------------------------------------
'
PUB bin(val, digits = 32, port=0) | mask
  if digits > 0 and digits < 32
    mask := (|< digits) - 1
    val &= mask
  num(val, 2, 0, digits, port) 
'
'-----------------------------------------------------------------------
' print a newline
'-----------------------------------------------------------------------
'
PUB nl(port=0)
  tx(13, port)
  tx(10, port)
'
'-----------------------------------------------------------------------
' C like formatted print
'-----------------------------------------------------------------------
'
PUB printf(fmt = string(""), an=0, bn=0, cn=0, dn=0, en=0, fn=0)
RETURN printfex(0, fmt, an, bn, cn, dn, en, fn)

PUB printfex(port, fmt = string(""), an=0, bn=0, cn=0, dn=0, en=0, fn=0) | c, valptr, val
  valptr := @an
  repeat
    c := byte[fmt++]
    if (c == 0)
      quit
    if c == "%"
      c := byte[fmt++]
      if (c == 0)
        quit
      if (c == "%")
        tx(c, port)
        next
      val := long[valptr]
      valptr += 4
      case c
	"d": dec(val, port)
	"u": decuns(val, port)
	"x": hex(val, port)
	"s": str(val, port)
        "c": tx(val, port)
    elseif c == $5C ' backslash
      c := byte[fmt++]
      if c == 0
        quit
      case c
        "n": nl( port)
        "r": tx(13, port)
        "t": tx(8, port)
        other: tx(c, port)
    else
      tx(c, port)
'
'=======================================================================
'
'Status
'
'================================ RX ===================================
'
'-----------------------------------------------------------------------
' returns size of receive buffer in bytes
'-----------------------------------------------------------------------
'
PUB rxsize(port=0) 
RETURN read(0, -4, port)
'
'-----------------------------------------------------------------------
' returns number of bytes waiting in receive buffer
'-----------------------------------------------------------------------
'
PUB rxcount(port=0) 
RETURN read(0, -3, port)
'
'
'================================ TX ===================================
'
'-----------------------------------------------------------------------
' returns size of send buffer in bytes
'-----------------------------------------------------------------------
'
PUB txsize(port=0) 
RETURN write(0, -4, port)
'
'-----------------------------------------------------------------------
' returns number of bytes free in send buffer
'-----------------------------------------------------------------------
'
PUB txcount(port=0) 
RETURN write(0, -3, port)
'
'=======================================================================
'
'Async I/O
'
'================================ RX ===================================
'
'-----------------------------------------------------------------------
' checks if rx port cmd = -1, signaling completion of last cmd or being ready for next cmd
'-----------------------------------------------------------------------
'
PUB check_rxready(port=0)
  if port
    RESULT := rx2cmd
  else
    RESULT := rx1cmd 
'
'-----------------------------------------------------------------------
' waits until rx port cmd = -1, signaling completion of last cmd or being ready for next cmd
'-----------------------------------------------------------------------
'
PUB wait_rxready(port=0, timeout=-1)
  RESULT := -2
  if port
    if timeout > 0
      repeat
         timeout--
         if rx2cmd == -1
            RESULT := rx2param
	    timeout := -10
      until timeout < 0
      if timeout > -10
         rx2cmd := -1
         rx2param := -1
    else
      repeat until rx2cmd == -1
      RESULT := rx2param
  else
    if timeout > 0
      repeat
         timeout--
         if rx1_cmd == -1
            RESULT := rx1param
	    timeout := -10
      until timeout < 0
      if timeout > -10
         rx1cmd := -1
         rx1param := -1
    else
      repeat until rx1cmd == -1 
      RESULT := rx1param 
'
'-----------------------------------------------------------------------
' receive a string (does not wait for completion - you may need to check rx_cmd if done or not later in your code)
'-----------------------------------------------------------------------
'
PUB strin_async(hubaddress, size, echo=1, port=0) | stringflag
  if echo
    stringflag := $2000000
  else
    stringflag := $1000000
  read_async(hubaddress, size+stringflag, port)
'
'-----------------------------------------------------------------------
' receive a block from serial to memory of given size in bytes (does not wait for completion - you may need to check rxX_cmd for -1 [done] or not later in your code)
'-----------------------------------------------------------------------
'
PUB read_async(hubaddress, size, port=0)
  wait_rxready(port, -1)
  if port
    rx2param := hubaddress
    rx2cmd := size 
  else
    rx1param := hubaddress
    rx1cmd := size 
'
'================================ TX ===================================
'
'-----------------------------------------------------------------------
' checks if tx port cmd = -1, signaling completion of last cmd or being ready for next cmd
'-----------------------------------------------------------------------
'
PUB check_txready(port=0)
  if port
    RESULT := tx2cmd
  else
    RESULT := tx1cmd 
'
'-----------------------------------------------------------------------
' waits until tx port cmd = -1, signaling completion of last cmd or being ready for next cmd
'-----------------------------------------------------------------------
'
PUB wait_txready(port=0)
  if port
    repeat until tx2cmd == -1
    RESULT := tx2param
  else
    repeat until tx1cmd == -1 
    RESULT := tx1param 
'
'-----------------------------------------------------------------------
' sends a byte (does not wait for completion - you may need to check tx1_cmd if done or not later in your code)
'-----------------------------------------------------------------------
'
PUB tx_async(val, port=0)
  write_async(-1,val, port)
'
'-----------------------------------------------------------------------
' transmit a string (does not wait for completion - you may need to check tx1_cmd if done or not later in your code)
'-----------------------------------------------------------------------
'
PUB str_async(hubaddress, port=0) 
  write_async(hubaddress, -5, port)
'
'-----------------------------------------------------------------------
' sends a block from memory to serial of given size in bytes (does not wait for completion - you may need to check tx1_cmd if done or not later in your code)
'-----------------------------------------------------------------------
'
PUB write_async(hubaddress, size, port=0)
  wait_txready(port)
  if port
    tx2param := hubaddress
    tx2cmd := size
  else
    tx1param := hubaddress
    tx1cmd := size
}}

'
'=======================================================================
'
' Now the PASM code
'
' I am reusing most of the initialisation code space for later needed Variables.
'
' Just ignore the labels on the left until the command loop
'
'=======================================================================
'
DAT
		org	0
'
cogserial_init
'
'-----------------------------------------------------------------------
'
'loading parameters and reusing init code space for variables
'
'-----------------------------------------------------------------------
rx1_mailbox_ptr	rdlong	rx1_mailbox_ptr,	ptra++			'pointer to mailbox in hub and rx1 mailbox hub address
rx1_pin		rdlong	rx1_pin,		ptra++			'serial1 rxpin1
rx1_bitperiod	rdlong	rx1_bitperiod,		ptra++			'bitperiod := 7 + ((CLKFREQ / baudrate) << 16)
rx1_mode	rdlong	rx1_mode,		ptra++			'configure rx1_pin for asynchronous receive, always input
rx1_lut_buff	rdlong	rx1_lut_buff,		ptra++			'lut rx1 receive buffer address in lut
rx1_lut_btop	rdlong	rx1_lut_btop,		ptra++			'lut rx1 receive buffer top address in lut (size for rx1)
tx1_pin		rdlong	tx1_pin,		ptra++			'serial1 txpin
tx1_bitperiod	rdlong	tx1_bitperiod,		ptra++			'bitperiod := 7 + ((CLKFREQ / baudrate) << 16)
tx1_mode	rdlong	tx1_mode,		ptra++			'configure tx1_pin for asynchronous transmit, always output
tx1_lut_buff	rdlong	tx1_lut_buff,		ptra++			'lut tx1 send buffer address in lut
tx1_lut_btop	rdlong	tx1_lut_btop,		ptra++			'lut tx1 send buffer top address in lut (size for tx1)
rx2_pin		rdlong	rx2_pin,		ptra++			'serial1 rx2pin
rx2_bitperiod	rdlong	rx2_bitperiod,		ptra++			'bitperiod := 7 + ((CLKFREQ / baudrate) << 16)
rx2_mode	rdlong	rx2_mode,		ptra++			'configure rx2_pin for asynchronous receive, always input
rx2_lut_buff	rdlong	rx2_lut_buff,		ptra++			'lut rx2 receive buffer address in lut
rx2_lut_btop	rdlong	rx2_lut_btop,		ptra++			'lut rx2 receive buffer top address in lut (size for rx2)
tx2_pin		rdlong	tx2_pin,		ptra++			'serial1 tx2pin
tx2_bitperiod	rdlong	tx2_bitperiod,		ptra++			'bitperiod := 7 + ((CLKFREQ / baudrate) << 16)
tx2_mode	rdlong	tx2_mode,		ptra++			'configure tx2_pin for asynchronous transmit, always output
tx2_lut_buff	rdlong	tx2_lut_buff,		ptra++			'lut tx2 send buffer address in lut
tx2_lut_btop	rdlong	tx2_lut_btop,		ptra++			'lut tx2 send buffer top address in lut (size for tx2)
tx_i_ct1wait	rdlong	tx_i_ct1wait,		ptra++			'sysclocks to wait between calls to tx interrupt
'-----------------------------------------------------------------------
'
' calculate mailbox pointers for later use
'
'-----------------------------------------------------------------------
rx1_param_ptr	mov	rx1_param_ptr,  	rx1_mailbox_ptr		'rx1 param hub address
rx1_head	add	rx1_param_ptr,		#4			'rx1 head position
tx1_mailbox_ptr	mov	tx1_mailbox_ptr,	rx1_param_ptr		'tx1 mailbox hub address
rx1_tail	add	tx1_mailbox_ptr,	#4			'rx1 tail position
tx1_param_ptr	mov	tx1_param_ptr,		tx1_mailbox_ptr		'tx1 param hub address
rx1_i_char	add	tx1_param_ptr,		#4			'tmp char for rx1_isr
rx2_mailbox_ptr	mov	rx2_mailbox_ptr,	tx1_param_ptr		'rx2 mailbox hub address
rx1_i_address	add	rx2_mailbox_ptr,	#4			'tmp address for rx1_isr
rx2_param_ptr	mov	rx2_param_ptr,  	rx2_mailbox_ptr		'rx2 param hub address
tx1_head	add	rx2_param_ptr,		#4			'tx1 head position
tx2_mailbox_ptr	mov	tx2_mailbox_ptr,	rx2_param_ptr		'tx2 mailbox hub address
tx1_tail	add	tx2_mailbox_ptr,	#4			'tx1 tail position
tx2_param_ptr	mov	tx2_param_ptr,		tx2_mailbox_ptr		'tx2 param hub address
tx_i_test	add	tx2_param_ptr,		#4			'tmp char for tx1_send
'-----------------------------------------------------------------------
'
' clear mailboxes
'
'-----------------------------------------------------------------------
tx_i_char	wrlong	minusOne,		tx2_param_ptr		'tmp address for tx1_send
tx_i_byteindex	wrlong	minusOne,		tx2_mailbox_ptr		'rx2 head position
tx_i_ct1	wrlong	minusOne,		rx2_param_ptr		'rx2 tail position
rx2_i_char	wrlong	minusOne,		rx2_mailbox_ptr		'tmp char for rx2_isr		
rx2_i_address	wrlong	minusOne,		tx1_param_ptr		'tmp address for rx2_isr
tx2_head	wrlong	minusOne,		tx1_mailbox_ptr		'tx2 head position
tx2_tail	wrlong	minusOne,		rx1_param_ptr		'tx2 tail position
'-----------------------------------------------------------------------
'
' Reset rx1 clear buffer pointers enable pin and int1
'
'-----------------------------------------------------------------------
		mov	rx1_head,		#0								'reset serial buffer pointers
		mov	rx1_tail,		#0				
rx1_i_lut_value	cmp	rx1_pin,		minusOne	wz	'tmp address for tx2_send		'if rx1_pin == -1 		
tx_i_tail if_z	jmp	#end_rx1_reset					'tmp cmd used for HEX and DEC out	'  skip RX1 setting smart pin	
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		setint1	#0											'disable int1			
		dirl	rx1_pin											'disable receiver
		mov	rx1_i_char,		#%110<<6			
		add	rx1_i_char, 		rx1_pin 			
		wrpin	rx1_mode, 		rx1_pin								'configure rx_pin for asynchronous receive, always input
		wxpin	rx1_bitperiod, 		rx1_pin				
		setse1	rx1_i_char										'set se1 to trigger on rx1_pin (rx1_pin high)
		mov	ijmp1,			#rx1_isr							'set int1 jump vector to rx1 ISR
		setint1	#4											'set int1 to trigger on se1	 
rx1_i_byte_index dirh	rx1_pin											'enable receiver		
end_rx1_reset
'-----------------------------------------------------------------------
'
' Reset tx1 set tx1_mode and tx1_bitperiod, enable pin 
'
'-----------------------------------------------------------------------
tx1_param	mov	tx1_head,		#0			'tmp parameter for tx1 cmd		'reset serial buffer pointers
lutvalue	mov	tx1_tail,		#0			
rx2_i_byte_index cmp	tx1_pin,		minusOne	wz						'if tx1_pin == -1			
tx_i_lutbuf if_z jmp	#end_tx1_reset					'value used in command loop		'  skip setting TX1 smart pin	
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
byteindex	dirl	tx1_pin						'tmp parameter for rx1 cmd		'disable transmitter
rx2_i_lut_value	wrpin	tx1_mode,		tx1_pin								'configure tx1_pin for asynchronous transmit, always output
cmd		wxpin	tx1_bitperiod, 		tx1_pin			'tmp parameter for rx2 cmd
tx2_param	dirh	tx1_pin						'tmp parameter for tx2 cmd		'enable transmitter
end_tx1_reset
'-----------------------------------------------------------------------
'
' Reset rx2 clear buffer pointers enable pin and int2
'
'-----------------------------------------------------------------------
rx2_head	mov	rx2_head,		#0			'tx_i_ct1 used in tx_isr		'reset serial buffer pointers
rx2_tail	mov	rx2_tail,		#0			'tx_i_ct1wait used in tx_isr	
lutaddress	cmp	rx2_pin,		minusOne	wz	'lutaddress used in command loop	'if rx2_pin == -1
value	if_z	jmp	#end_rx2_reset					'value used in command loop		'  skip RX2 setting smart pin
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
txblock		setint2	#0						'tmp parameter for tx2 cmd		'disable int2
pxtail		dirl	rx2_pin						'pointer to current TXtail		'disable receiver
tx_i_address	mov	rx2_i_char,		#%110<<6		'txdec used by HEX/DEC
tx_i_lutvalue	add	rx2_i_char, 		rx2_pin			'pointer for output of HX/DEC 
txcogptr	wrpin	rx2_mode, 		rx2_pin			'pointer for output of HX/DEC		'configure rx_pin for asynchronous receive, always input
txloopctr	wxpin	rx2_bitperiod, 		rx2_pin
lutbuff		setse2	rx2_i_char										'set se1 to trigger on rx1_pin (rx1_pin high)
pxdonewritepar	mov	ijmp2,			#rx2_isr							'set int2 jump vector to rx2 ISR
pxdone		setint2	#5						'pointer to current TX donewritepar	'set int2 to trigger on se2 
lutbtop		dirh	rx2_pin											'enable receiver
end_rx2_reset
'-----------------------------------------------------------------------
'
' Reset tx2 set tx2_mode and tx2_bitperiod, enable pin 
'
'-----------------------------------------------------------------------	
pxcmd		mov	tx2_head,		#0								'reset serial buffer pointers
pxparam		mov	tx2_tail,		#0
head		cmp	tx2_pin,		minusOne	wz						'if tx2_pin == -1		
tail	if_z	jmp	#end_tx2_reset										'  skip setting TX2 smart pin	
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
pxhead		dirl	tx2_pin											'disable transmitter
tx1_address	wrpin	tx2_mode,		tx2_pin								'configure tx2_pin for asynchronous transmit, always output
rx1_param	wxpin	tx2_bitperiod, 		tx2_pin			'tmp parameter for rx1 cmd
cmdparam	dirh	tx2_pin											'enable transmitter
end_tx2_reset
'-----------------------------------------------------------------------
'
' Enable int3 for TX
'
'-----------------------------------------------------------------------
tx2_address	mov     ijmp3,			#tx_isr								'set int3 vector - later sysclocks to wait for in tx_isr
rx2_param	setint3 #1               				'tmp parameter for rx2 cmd		'set int3 for ct-passed-ct1 event later decimal num to send
rxstring	getct   tx_i_ct1              									'set initial tx_i_ct1 target 
txmailboxpointer addct1  tx_i_ct1,		tx_i_ct1wait
'-----------------------------------------------------------------------
'
' this tells calling cog we got the parameters and are ready to roll
'
'-----------------------------------------------------------------------
pxgetchar	wrlong	minusOne,		rx1_mailbox_ptr							'write -1 into rx1_mailbox_ptr in the HUB, now cogstart finished
'=======================================================================
'
'command loop - calls R1/TX1/RX2/TX2 routines to check the mailboxes and to do HUB/LUT LUT/HUB buffer transfer
'	      - first check if pin used (<>-1) then check if last command still running (<>-1)
'	      - if not get new one, else resume old one
'	      - do this for each channel.
'
'=======================================================================
rx1_cmd_check	cmp	rx1_pin,		minusOne	wz	'RX1 pin active?			'gone 8
	if_z	jmp 	#tx1_cmd_check					'no - check TX1 next
		cmp	rx1_cmd,		minusOne	wz	'old cmd finished?		
	if_z	rdlong	rx1_cmd,		rx1_mailbox_ptr		'yes - new cmd from rx1 mailbox
	if_z	rdlong	rx1_param,		rx1_param_ptr		'yes - new param from rx1 mailbox	
		cmp	rx1_cmd,		minusOne	wz	'do we have a active command running?
	if_z	jmp 	#tx1_cmd_check					'no - check TX1 next
		mov	pxdonewritepar,		#rx1_donewritepar	'set up pointers and values for RX1	
		mov	pxdone,			#rx1_done		'to use a common rxdocmd
		mov	pxgetchar,		#rx1_get_value	
		mov	pxparam,		#rx1_param
		mov	pxcmd,			#rx1_cmd
		mov	pxtail,			#rx1_tail
		mov	txmailboxpointer,	tx1_mailbox_ptr
		mov	lutbuff,		rx1_lut_buff
		mov	lutbtop,		rx1_lut_btop
		mov	head,			rx1_head
		mov	tail,			rx1_tail
		mov	cmd,			rx1_cmd						
		call	#rxdocmd					'and call the common rxdocmd
tx1_cmd_check	cmp	tx1_pin,		minusOne	wz	'TX1 pin active?
	if_z	jmp 	#rx2_cmd_check					'no - check RX2 next
		cmp	tx1_cmd,		minusOne	wz	'old cmd finished?		
	if_z	rdlong	tx1_cmd,		tx1_mailbox_ptr		'yes - new cmd from tx1 mailbox	
	if_z	rdlong	tx1_param,		tx1_param_ptr		'yes - new param from tx1 mailbox	
		cmp	tx1_cmd,		minusOne	wz	'do we have a active command running?
	if_z	jmp 	#rx2_cmd_check					'no - check RX2 next
		mov	pxdonewritepar,		#tx1_donewritepar	'set up pointers and values for TX1	
		mov	pxdone,			#tx1_done		'to use a common txdocmd
		mov	pxparam,		#tx1_param
		mov	pxcmd,			#tx1_cmd
		mov	pxhead,			#tx1_head
		mov	pxtail,			#tx1_tail
		mov	lutbtop,		tx1_lut_btop
		mov	lutbuff,		tx1_lut_buff
		mov	head,			tx1_head
		mov	tail,			tx1_tail
		mov	cmd,			tx1_cmd				
		call	#txdocmd					'and call the common txdocmd
rx2_cmd_check	cmp	rx2_pin,		minusOne	wz	'RX2 pin active?
	if_z	jmp 	#tx2_cmd_check					'no - check TX2 next
		cmp	rx2_cmd,		minusOne	wz	'old cmd finished?		
	if_z	rdlong	rx2_cmd,		rx2_mailbox_ptr		'yes - new cmd from rx2 mailbox
	if_z	rdlong	rx2_param,		rx2_param_ptr		'yes - new param from rx2 mailbox	
		cmp	rx2_cmd,		minusOne	wz	'do we have a active command running?
	if_z	jmp 	#tx2_cmd_check					'no - check TX2 next
		mov	pxdonewritepar,		#rx2_donewritepar	'set up pointers and values for RX2	
		mov	pxdone,			#rx2_done		'to use a common rxdocmd
		mov	pxgetchar,		#rx2_get_value	
		mov	pxparam,		#rx2_param
		mov	pxcmd,			#rx2_cmd
		mov	pxtail,			#rx2_tail
		mov	txmailboxpointer,	tx2_mailbox_ptr
		mov	lutbuff,		rx2_lut_buff
		mov	lutbtop,		rx2_lut_btop
		mov	head,			rx2_head
		mov	tail,			rx2_tail
		mov	cmd,			rx2_cmd						
		call	#rxdocmd					'and call the common rxdocmd
tx2_cmd_check	cmp	tx2_pin,		minusOne	wz	'TX2 pin active?
	if_z	jmp 	#rx1_cmd_check					'no - check RX1 next -- loop
		cmp	tx2_cmd,		minusOne	wz	'old cmd finished?		
	if_z	rdlong	tx2_cmd,		tx2_mailbox_ptr		'yes - new cmd from tx2 mailbox	
	if_z	rdlong	tx2_param,		tx2_param_ptr		'yes - new param from tx2 mailbox	
		cmp	tx2_cmd,		minusOne	wz	'do we have a active command running?
	if_z	jmp 	#rx1_cmd_check					'no - check RX1 next -- loop
		mov	pxdonewritepar,		#tx2_donewritepar	'set up pointers and values for TX2
		mov	pxdone,			#tx2_done		'to use a common xdocmd
		mov	pxparam,		#tx2_param
		mov	pxcmd,			#tx2_cmd
		mov	pxhead,			#tx2_head
		mov	pxtail,			#tx2_tail
		mov	lutbtop,		tx2_lut_btop
		mov	lutbuff,		tx2_lut_buff
		mov	head,			tx2_head
		mov	tail,			tx2_tail
		mov	cmd,			tx2_cmd			
		call	#txdocmd					'and call the common txdocmd
		jmp	#rx1_cmd_check					' -- loop
'=======================================================================
'
' INT 1 - rx1 read interrupt writes byte in lut buffer, runs if pin receives a char
' 
'=======================================================================
rx1_isr		rdpin	rx1_i_char,		rx1_pin			'get received char
		shr	rx1_i_char,		#32-8			'shift char to lsb justify
		mov	rx1_i_address,		rx1_head		'do I have space in my buffer?
		incmod	rx1_i_address, 		rx1_lut_btop		'rx1_i_char = head+1
		cmp	rx1_i_address, 		rx1_tail 	wz	'hitting tail is bad
	if_z	reti1							'and return if buffer full - we lost a char - exit
		mov	rx1_i_byte_index,	rx1_head		'take last two bits of head
		and	rx1_i_byte_index, 	#%11			'now index 0 to 3
		mov	rx1_i_address,		rx1_head		'adjust address to buffer start (I need the long containing the byte)
		shr	rx1_i_address,		#2			'adjust address to buffer start
		add	rx1_i_address,		rx1_lut_buff 		'by adding rx1_lut_buff
		rdlut	rx1_i_lut_value,	rx1_i_address		'get correct LUT long
		altsb 	rx1_i_byte_index, 	#rx1_i_lut_value	'patch the index
  		setbyte 0,			rx1_i_char, #0-0	'change the needed byte
		wrlut	rx1_i_lut_value, 	rx1_i_address		'write long back to circular buffer in lut
		incmod	rx1_head, 		rx1_lut_btop		'increment buffer head
		reti1
'=======================================================================
'
' INT 2 - rx2 read interrupt writes byte in lut buffer, runs if pin receives a char
' 
'=======================================================================
rx2_isr		rdpin	rx2_i_char,		rx2_pin			'get received chr
		shr	rx2_i_char,		#32-8			'shift char to lsb justify
		mov	rx2_i_address,		rx2_head		'do I have space in my buffer?
		incmod	rx2_i_address, 		rx2_lut_btop		'rx2_i_char = head+1 mod 
		cmp	rx2_i_address, 		rx2_tail 	wz	'hitting tail is bad
	if_z	reti2							'and return if buffer full - we lost a char - exit
'		shr	rx2_i_char,		#32-8			'shift char to lsb justify
  		mov	rx2_i_byte_index, 	rx2_head		'take last two bits of head
		and	rx2_i_byte_index, 	#%11			'now index 0 to 3
		mov	rx2_i_address,		rx2_head		'adjust to buffer start (I need the long containing the byte)
		shr	rx2_i_address,		#2			'adjust address to buffer start
		add	rx2_i_address,		rx2_lut_buff 		'by adding rx2_lut_buff
		rdlut	rx2_i_lut_value,	rx2_i_address		'get correct LUT long
		altsb 	rx2_i_byte_index,	#rx2_i_lut_value	'patch the index
		setbyte 0,			rx2_i_char, #0-0	'change the needed byte
		wrlut	rx2_i_lut_value,	rx2_i_address		'write long back to circular buffer in lut
		incmod	rx2_head, 		rx2_lut_btop		'increment buffer head
		reti2
'=======================================================================
'
' INT 3 - tx write interrupt, reads bytes from lut buffer , runs once every tx_i_ct1wait clocks
'
'=======================================================================
tx_isr		cmp	tx1_pin,		minusOne	wz	'tx1 active?							
	if_z	jmp	#.tx2_send					'no - check tx2	
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		cmp	tx1_head, 		tx1_tail 	wz	'tx1 byte to send?
	if_z	jmp	#.tx2_send					'no - wait for next time
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		rdpin	tx_i_test,		tx1_pin		wc	'wait for pin ready?
	if_c	jmp	#.tx2_send					'no - wait for next time	
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		mov	tx_i_tail,		tx1_tail		'adjust to buffer start
		mov	tx_i_lutbuf, 		tx1_lut_buff 		'by adding tx1_lut_buff
		call	#.txgetlutchar					'get the needed byte
		incmod	tx1_tail,		tx1_lut_btop		'increment buffer tail
		wypin	tx_i_char,		tx1_pin			'send the byte
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
.tx2_send	cmp	tx2_pin,		minusOne	wz	'tx2 active?							
	if_z	jmp	#.end_isr					'no - done	
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		cmp	tx2_head, 		tx2_tail 	wz	'tx2 byte to send?
	if_z	jmp	#.end_isr					'no - wait for next time
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		rdpin	tx_i_test,		tx2_pin		wc	'wait for pin ready?
	if_c	jmp	#.end_isr					'no - wait for next time		
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		mov	tx_i_tail,		tx2_tail		'adjust to buffer start
		mov	tx_i_lutbuf, 		tx2_lut_buff 		'by adding tx2_lut_buff
		call	#.txgetlutchar					'get the needed byte
		incmod	tx2_tail,		tx2_lut_btop		'increment buffer tail
		wypin	tx_i_char,		tx2_pin			'send the byte
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
.end_isr       	addct1  tx_i_ct1,		tx_i_ct1wait   		'update txct1 target
        	reti3 							'return to main program
'-----------------------------------------------------------------------
.txgetlutchar	mov	tx_i_byteindex,		tx_i_tail		'take last two bits of tail
		and	tx_i_byteindex,		#%11			'now index 0 to 3
		mov	tx_i_address,		tx_i_tail		'adjust to buffer start (I need the long containing the byte)
		shr	tx_i_address,		#2			'adjust address to buffer start
		add	tx_i_address,		tx_i_lutbuf 		'by adding txX_lut_buff		
		rdlut	tx_i_lutvalue, 		tx_i_address		'get correct LUT long
		altgb 	tx_i_byteindex,		#tx_i_lutvalue		'patch the index
  	_ret_	getbyte tx_i_char,		tx_i_lutvalue, #0	'get the needed byte
'=======================================================================
'
' used for both RX and both TX ports
'
'=======================================================================
getbufused	mov	value,			head			'returns count of bytes used in given buffe in value
		cmps	head,			tail		wcz	'if head<tail
	if_b	add	value,			lutbtop			'add size to head
	if_b	add	value,			#1
	_ret_	sub	value,			tail			'subtract tail	
'-----------------------------------------------------------------------
fixindexaddress	and	byteindex,		#%11
		shr	lutaddress,		#2
	_ret_	add	lutaddress,		lutbuff 		'by adding txX_lut_buff
'=======================================================================
'
' handle rx mailboxes
'
'=======================================================================
rx1_get_value	call	#rxgetrxchar
	_ret_	incmod	rx1_tail,		rx1_lut_btop		'increment buffer tail
'-----------------------------------------------------------------------
rx2_get_value	call	#rxgetrxchar
	_ret_	incmod	rx2_tail,		rx2_lut_btop		'increment buffer tail
'-----------------------------------------------------------------------
rxgetrxchar	mov	byteindex,		tail
		mov	lutaddress, 		tail			'adjust to buffer start
		call	#fixindexaddress
		rdlut	lutvalue, 		lutaddress		'get byte from circular buffer in lut
		altgb 	byteindex,		#lutvalue
  	_ret_	getbyte value,			lutvalue, 	#0
'-----------------------------------------------------------------------
rx1_donewritepar wrlong	value, 			rx1_param_ptr		'write rx1 parameter back in HUB
rx1_done	mov	rx1_cmd,		minusOne		
	_ret_	wrlong  rx1_cmd, 		rx1_mailbox_ptr		'rx1 command finished
'-----------------------------------------------------------------------
rx2_donewritepar wrlong	value, 			rx2_param_ptr		'rx2 parameter back in HUB
rx2_done	mov	rx2_cmd,		minusOne
	_ret_	wrlong  rx2_cmd, 		rx2_mailbox_ptr		'rx2 command finished
'= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
'
'used for both RX ports
'
'= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
rxdocmd		cmps	cmd,			#0		wcz	'#rx_block also string
	if_ge	jmp	#.blockread
		cmp	cmd,			minusTwo 	wz	'#rx_check 
	if_nz	jmp	#.negcmd
		mov	value, 			minusOne		'#value
		cmp	head,			tail		wz	'byte received?
	if_nz	call	pxgetchar+0
		jmp	pxdonewritepar+0
.negcmd		neg	cmd
		mov	cmdparam,		cmd
		shr	cmdparam,		#8
		and	cmd,			#$FF
		cmp	cmd,			#3	 	wz	'get count of bytes in rx buffer
	if_z	jmp	#.count
		cmp	cmd,			#4	 	wz	'get size of rx buffer
	if_z	mov	value,			lutbtop
	if_z	jmp	pxdonewritepar+0				'returns size of receive buffer
		jmp	pxdone+0
'-----------------------------------------------------------------------
.count		call	#getbufused					'returns count of bytes in receive buffer RXx in value
		jmp	pxdonewritepar+0					
'-----------------------------------------------------------------------
.blockread	mov	rxstring,		#0
		cmps	cmd,			##$1000000	wcz
	if_ge	mov	rxstring,		#1
		cmps	cmd,			##$2000000	wcz
	if_ge	mov	rxstring,		#2
		and	cmd,			##$FFFFFF
		cmp	cmd,			#0 		wz	'need more bytes?
	if_z 	jmp	pxdone+0					'no - clear rx_mailbox - rxblock finished				
		cmps	head, 			tail		wcz	'byte received?
	if_b	mov	byteindex,		lutbtop			'Head less then tail, add buffer size
	if_b	add	byteindex,		#1			'
	if_g	mov	byteindex,		#0			'Head pointer bigger then tail all OK
	if_z	ret						wz	'no - buffer empty - try again don't block the rest
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		call	pxgetchar+0
		cmp	rxstring,		#1		wz	'string input without echo?	
	if_z	jmp	#.isstring
		cmp	rxstring,		#2		wz	'string input with echo?	
	if_z	jmp	#.isstring
		jmp	#.nostring
.isstring	cmp	cmd,			#1		wz	'if max string len
	if_z	jmp	#.writezero					'terminate string and command
		cmp	value,			#13		wz	'if CR
	if_z	jmp	#.writezero					'terminate string and command
		cmp	value,			#10		wz	'if LF
	if_z	jmp	#.writezero					'terminate string and command
		cmp	rxstring,		#1		wz	'string input without echo?	
	if_z	jmp	#.nostring
		cmp	pxdone,			#rx1_done	wz	'port1?
	if_nz	jmp	#.echo2
		stalli							'string input with echo	1
.waitecho1	rdpin	tx_i_test,		tx1_pin		wc	'wait for pin ready
	if_c	jmp	#.waitecho1					
		wypin	value,			tx1_pin			'send the byte
		allowi
		jmp	#.nostring					'terminate string and command			
.echo2		stalli							'string input with echo	2
.waitecho2	rdpin	tx_i_test,		tx2_pin		wc	'wait for pin ready
	if_c	jmp	#.waitecho2
		wypin	value,			tx2_pin			'send the byte				
		allowi
		jmp	#.nostring					'terminate string and command
.writezero	mov	value,			#0			'end of string input - terminate string and command
		call	#.nostring					'add zero to buffer to end string
		jmp	pxdone+0					'clear rx_mailbox - rx_block (string) finished
.nostring	alts	pxparam
		wrbyte  value, 			0-0			'write byte to Block
		altd	pxparam
		add	0-0,	 		#1			'adjust Block address
		altd	pxcmd
	_ret_	sub	0-0,			#1			'adjust count - try again don't block the rest
'=======================================================================
'
' handle tx mailboxes
'
'=======================================================================
tx1_donewritepar wrlong	value, 			tx1_param_ptr		'return tx1 result
tx1_done	mov	tx1_cmd,		minusOne
	_ret_	wrlong  tx1_cmd,		tx1_mailbox_ptr		'clear tx1_mailbox - tx1_cmd finished
'-----------------------------------------------------------------------
tx2_donewritepar wrlong	value, 			tx2_param_ptr		'return tx2 result
tx2_done	mov	tx2_cmd,		minusOne
	_ret_	wrlong  tx2_cmd,		tx2_mailbox_ptr		'clear tx2_mailbox - tx2_cmd finished
'= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
'
'used by both TX ports
'
'= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
txdocmd		cmps	cmd,			#0		wcz	'#txX_block 
	if_ge	jmp	#.blockwrite
		neg	cmd
		mov	cmdparam,		cmd
		shr	cmdparam,		#8
		and	cmd,			#$FF
		cmp	cmd,			#2	 	wz	'get count of free bytes in tx buffer or -1 if full
	if_z	jmp	#.check
		cmp	cmd,			#3	 	wz	'get count of free bytes in tx buffer
	if_z	jmp	#.count
		cmp	cmd,			#4	 	wz	'get size of tx buffer
	if_z	mov	value,			lutbtop
	if_z	jmp	pxdonewritepar+0
		cmp	cmd,			#5	 	wz	'output str on tx1
	if_nz 	jmp	pxdone+0					'clear tx_mailbox - done
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
.blockwrite	mov	lutaddress, 		head			'returns tx_head+1
		incmod	lutaddress, 		lutbtop			'in lutaddress
		cmp	lutaddress, 		tail 		wz	'space in buffer?
	if_z	ret							'no - buffer full - try again don't block the rest
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		altd	pxparam
		cmp	0-0,			minusOne	wz	'if param == -1 just single char
	if_nz	jmp	#.notsinglechar
		mov	value,			cmd			'send it and done
		call	#.putlutchar
		jmp	pxdone+0
.notsinglechar	cmps	cmd,			#0 		wcz 	'more bytes?
	if_le 	jmp	pxdone+0					'no - clear tx_mailbox - txblock finished
		mov	value,			#0
		alts	pxparam
		rdbyte	value,			0-0			'get next char
		altd	pxcmd
		cmp	0-0,			minusFive	wz	'string output?
	if_nz	altd	pxcmd
	if_nz	sub	0-0,			#1			'no - adjust count of bytes to send
	if_z	cmp	value,			#0 		wz	'yes - more bytes?
	if_z	jmp	pxdone+0					'no - clear tx1_mailbox - tx1_block (string) finished
		call	#.putlutchar
		altd	pxparam						'Hubaddress Neilbox Parameter current TX
	_ret_	add	0-0,			#1			'adjust buffer address
'-----------------------------------------------------------------------
.putlutchar	mov	lutaddress,		lutbuff
		shl	lutaddress,		#2
		add	lutaddress,		head
		mov	byteindex,		lutaddress
		and	byteindex,		#%11
		shr	lutaddress,		#2
		rdlut	lutvalue,		lutaddress		
		altsb 	byteindex,		#lutvalue
  		setbyte 0,			value, #0
		wrlut	lutvalue,		lutaddress	
		altd	pxhead
	_ret_	incmod	0-0,	 		lutbtop			'increment buffer head
'-----------------------------------------------------------------------
.check		mov	value, 			minusOne		'returns -1 or count of bytes in transmit buffer for tx1
		mov	lutaddress, 		head			'returns tx_head+1
		incmod	lutaddress, 		lutbtop			'in lutaddress
		cmp	lutaddress, 		tail		wz
	if_z	jmp	pxdonewritepar+0				'return buffer full else return tx1_count
'- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
.count		call	#.countvalue
		jmp	pxdonewritepar+0				'return tx buffer count (bytes current free in buffer)
'-----------------------------------------------------------------------
.countvalue	call	#getbufused
		neg	value						'bytes used
		add	value,			lutbtop			'bytes free
	_ret_	add	value,			#1
'-----------------------------------------------------------------------
minusOne	long	-1
minusTwo	long	-2
minusFive	long	-5
rx1_cmd		long	-1
tx1_cmd		long	-1
rx2_cmd		long	-1
tx2_cmd		long	-1
'-----------------------------------------------------------------------
'fit 0'410
'-----------------------------------------------------------------------
