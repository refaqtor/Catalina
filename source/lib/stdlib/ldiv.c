/*
 * (c) copyright 1987 by the Vrije Universiteit, Amsterdam, The Netherlands.
 * See the copyright notice in the ACK home directory, in the file "Copyright".
 */
/* $Id: ldiv.c,v 1.5 1994/06/24 11:53:48 ceriel Exp $ */

#include	<stdlib.h>

ldiv_t
ldiv(register long numer, register long denom)
{
	ldiv_t r;

	r.quot = numer / denom;		/* might trap if denom == 0 */
	r.rem = numer % denom;

	if (r.rem != 0 && (numer > 0) != (r.rem > 0)) {
		r.quot++;
		r.rem -= denom;
	}

	return r;
}
