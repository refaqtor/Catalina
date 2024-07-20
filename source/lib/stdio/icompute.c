/*
 * icompute.c - compute an integer
 */
/* $Id: icompute.c,v 1.3 1994/06/24 11:50:33 ceriel Exp $ */

#include	"loc_incl.h"

/* This routine is used in doprnt.c as well as in tmpfile.c and tmpnam.c. */

char *
_i_compute(unsigned long val, int base, char *s, int nrdigits)
{
	int c;

	c= val % base ;
	val /= base ;
	if (val || nrdigits > 1)
		s = _i_compute(val, base, s, nrdigits - 1);
	*s++ = (c>9 ? c-10+'a' : c+'0');
	return s;
}
