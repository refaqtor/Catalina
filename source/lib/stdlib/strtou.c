/*
 * Modified for Catalina by Ross Higson
 */

/* Project:     OSLib
 * Description: The OS Construction Kit
 * Date:                1.6.2000
 * Idea by:             Luca Abeni & Gerardo Lamastra
 *
 * OSLib is an SO project aimed at developing a common, easy-to-use
 * low-level infrastructure for developing OS kernels and Embedded
 * Applications; it partially derives from the HARTIK project but it
 * currently is independently developed.
 *
 * OSLib is distributed under GPL License, and some of its code has
 * been derived from the Linux kernel source; also some important
 * ideas come from studying the DJGPP go32 extender.
 *
 * We acknowledge the Linux Community, Free Software Foundation,
 * D.J. Delorie and all the other developers who believe in the
 * freedom of software and ideas.
 *
 * For legalese, check out the included GPL license.
 */

#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <stdarg.h>
#include <ctype.h>

long unsigned _strtou(const char *s, char **scan_end, int base)
{
   int value, overflow = 0;
   long unsigned result = 0, oldresult;

   /* Skip trailing zeros */
   while (*s == '0') 
      s++;
   if (*s == 'x' && base == 16) {
      s++;
      while (*s == '0') {
         s++;
      }
   }
   /* Convert number */
   while (isnumber(*s,base)) {
      value = tonumber(*s++);
      if (value > base || value < 0) 
         return(0);
      oldresult = result;
      result *= base;
      result += value;
      /* Detect overflow */
      if (oldresult > result) 
         overflow = 1;
   }
   if (scan_end != 0L) 
      *scan_end = (char *)s;
   if (overflow) 
      result = INT_MAX;

   return(result);
}

