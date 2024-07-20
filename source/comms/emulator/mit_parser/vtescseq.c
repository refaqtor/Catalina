/*
 * This software is being provided to you, the LICENSEE, by the 
 * Massachusetts Institute of Technology (M.I.T.) under the following 
 * license.  By obtaining, using and/or copying this software, you agree 
 * that you have read, understood, and will comply with these terms and 
 * conditions:  
 * 
 * Permission to use, copy, modify and distribute this software and its 
 * documentation for any purpose and without fee or royalty is hereby 
 * granted, provided that you agree to comply with the following copyright 
 * notice and statements, including the disclaimer, and that the same 
 * appear on ALL copies of the software and documentation, including 
 * modifications that you make for internal use or for distribution:
 * 
 * Copyright 1995 by the Massachusetts Institute of Technology.  All rights 
 * reserved.  
 * 
 * THIS SOFTWARE IS PROVIDED "AS IS", AND M.I.T. MAKES NO REPRESENTATIONS 
 * OR WARRANTIES, EXPRESS OR IMPLIED.  By way of example, but not 
 * limitation, M.I.T. MAKES NO REPRESENTATIONS OR WARRANTIES OF 
 * MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE OR THAT THE USE OF 
 * THE LICENSED SOFTWARE OR DOCUMENTATION WILL NOT INFRINGE ANY THIRD PARTY 
 * PATENTS, COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS.   
 * 
 * The name of the Massachusetts Institute of Technology or M.I.T. may NOT 
 * be used in advertising or publicity pertaining to distribution of the 
 * software.  Title to copyright in this software and any associated 
 * documentation shall at all times remain with M.I.T., and USER agrees to 
 * preserve same.
 */

/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/

/* This file loads the tables from the corresponding .tbl files */

#include "vtparser.h"
#include "vtconst.h"
#include "vtdcs.h"

const struct ESC1tbl_rec ESC1tbl_vt52[] = {
#include "vte152.tbl"
};
const PA_SHORT ESC1tbl_vt52_count = sizeof ESC1tbl_vt52 / sizeof( struct ESC1tbl_rec );

const struct ESC1tbl_rec ESC1tbl_ansi[] = {
#include "vte1ansi.tbl"
};
const PA_SHORT ESC1tbl_ansi_count = sizeof ESC1tbl_ansi / sizeof( struct ESC1tbl_rec );

const struct ESC2tbl_rec ESC2tbl[] = {
#include "vte2.tbl"
};
const PA_SHORT ESC2tbl_count = sizeof ESC2tbl / sizeof( struct ESC2tbl_rec );

struct CSItbl_rec CSItbl[] = {
#include "vtcsi.tbl"
};
const PA_SHORT CSItbl_count = sizeof CSItbl / sizeof( struct CSItbl_rec );

const struct DCStbl_rec DCStbl[] = {
#include "vtdcs.tbl"
};
const PA_SHORT DCStbl_count = sizeof DCStbl / sizeof( struct DCStbl_rec );
