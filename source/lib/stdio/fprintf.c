/*
 * fprintf - write output on a stream
 */
/* $Id: fprintf.c,v 1.4 1994/06/24 11:49:33 ceriel Exp $ */

#include	<stdio.h>
#include	<stdarg.h>
#include	"loc_incl.h"

int
fprintf(FILE *stream, const char *format, ...)
{
	va_list ap;
	int retval;
	
	va_start(ap, format);

	retval = _doprnt (format, ap, stream);

	va_end(ap);

	return retval;
}
