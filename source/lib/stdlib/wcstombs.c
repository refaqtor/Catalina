/*
 * (c) copyright 1987 by the Vrije Universiteit, Amsterdam, The Netherlands.
 * See the copyright notice in the ACK home directory, in the file "Copyright".
 */
/* $Id: wcstombs.c,v 1.4 1994/06/24 11:54:25 ceriel Exp $ */

#include	<stdlib.h>
#include	<locale.h>
#include	<limits.h>

size_t
wcstombs(register char *s, register const wchar_t *pwcs, size_t n)
{
	register int i = n;

	while (--i >= 0) {
		if (!(*s++ = *pwcs++))
			break;
	}
	return n - i - 1;
}
