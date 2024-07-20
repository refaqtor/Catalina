/*
 * (c) copyright 1987 by the Vrije Universiteit, Amsterdam, The Netherlands.
 * See the copyright notice in the ACK home directory, in the file "Copyright".
 */
/* $Id: strstr.c,v 1.4 1994/06/24 11:57:20 ceriel Exp $ */

#include	<string.h>

char *
strstr(register const char *s, register const char *wanted)
{
	register const int len = strlen(wanted);

	if (len == 0) return (char *)s;
	while (*s != *wanted || strncmp(s, wanted, len))
		if (*s++ == '\0')
			return (char *)NULL;
	return (char *)s;
}
