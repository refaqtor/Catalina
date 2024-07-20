/*
 * (c) copyright 1987 by the Vrije Universiteit, Amsterdam, The Netherlands.
 * See the copyright notice in the ACK home directory, in the file "Copyright".
 */
/* $Id: mbstowcs.c,v 1.3 1994/06/24 11:53:55 ceriel Exp $ */

#include	<stdlib.h>

size_t
mbstowcs(register wchar_t *pwcs, register const char *s, size_t n)
{
	register int i = n;

	while (--i >= 0) {
		if (!(*pwcs++ = *s++))
			return n - i - 1;
	}
	return n - i;
}

