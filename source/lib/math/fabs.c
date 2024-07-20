/*
 * (c) copyright 1988 by the Vrije Universiteit, Amsterdam, The Netherlands.
 * See the copyright notice in the ACK home directory, in the file "Copyright".
 *
 * Author: Ceriel J.H. Jacobs
 */
/* $Id: fabs.c,v 1.2 1994/06/24 11:43:30 ceriel Exp $ */

double
fabs(double x)
{
	return  x < 0 ? -x : x;
}
