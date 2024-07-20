/*
 * (c) copyright 1987 by the Vrije Universiteit, Amsterdam, The Netherlands.
 * See the copyright notice in the ACK home directory, in the file "Copyright".
 */
/* $Id: atoi.c,v 1.6 1994/06/24 11:53:19 ceriel Exp $ */

#include	<ctype.h>

/* We do not use strtol here for backwards compatibility in behaviour on
   overflow.
*/
int
atoi(register const char *nptr)
{
	int total = 0;
	int minus = 0;

	while (isspace(*nptr)) nptr++;
	if (*nptr == '+') nptr++;
	else if (*nptr == '-') {
		minus = 1;
		nptr++;
	}
	while (isdigit(*nptr)) {
		total *= 10;
		total += (*nptr++ - '0');
	}
	return minus ? -total : total;
}
