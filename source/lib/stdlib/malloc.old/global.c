/* $Id: global.c,v 1.2 1994/06/24 11:55:18 ceriel Exp $ */
/*
 * (c) copyright 1987 by the Vrije Universiteit, Amsterdam, The Netherlands.
 * See the copyright notice in the ACK home directory, in the file "Copyright".
 */
#include	"param.h"
#include	"impl.h"

/*	The only global data item:
*/
mallink *ml_last;		/* link to the world */
