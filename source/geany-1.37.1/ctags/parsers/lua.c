/*
*   Copyright (c) 2000-2001, Max Ischenko <mfi@ukr.net>.
*
*   This source code is released for free distribution under the terms of the
*   GNU General Public License version 2 or (at your option) any later version.
*
*   This module contains functions for generating tags for Lua language.
*/

/*
*   INCLUDE FILES
*/
#include "general.h"  /* must always come first */

#include <string.h>

#include "parse.h"
#include "read.h"
#include "routines.h"
#include "vstring.h"

/*
*   DATA DEFINITIONS
*/
typedef enum {
	K_FUNCTION
} luaKind;

static kindDefinition LuaKinds [] = {
	{ true, 'f', "function", "functions" }
};

/*
*   FUNCTION DEFINITIONS
*/

/*
 * Helper function.
 * Returns 1 if line looks like a line of Lua code.
 *
 * TODO: Recognize UNIX bang notation.
 * (Lua treat first line as a comment if it starts with #!)
 *
 */
static bool is_a_code_line (const unsigned char *line)
{
	bool result;
	const unsigned char *p = line;
	while (isspace ((int) *p))
		p++;
	if (p [0] == '\0')
		result = false;
	else if (p [0] == '-' && p [1] == '-')
		result = false;
	else
		result = true;
	return result;
}

static void extract_name (const char *begin, const char *end, vString *name)
{
	if (begin != NULL  &&  end != NULL  &&  begin < end)
	{
		const char *cp;

		while (isspace ((int) *begin))
			begin++;
		while (isspace ((int) *end))
			end--;
		if (begin < end)
		{
			for (cp = begin ; cp != end; cp++)
				vStringPut (name, (int) *cp);

			makeSimpleTag (name, K_FUNCTION);
			vStringClear (name);
		}
	}
}

static void findLuaTags (void)
{
	vString *name = vStringNew ();
	const unsigned char *line;

	while ((line = readLineFromInputFile ()) != NULL)
	{
		const char *p, *q;

		if (! is_a_code_line (line))
			continue;

		p = (const char*) strstr ((const char*) line, "function");
		if (p == NULL)
			continue;

		q = strchr ((const char*) line, '=');

		if (q == NULL) {
			p = p + 9;  /* skip the `function' word */
			q = strchr ((const char*) p, '(');
			extract_name (p, q, name);
		} else if (*(q+1) != '=') { /* ignore `if type(v) == "function" then ...' */
			p = (const char*) &line[0];
			extract_name (p, q, name);
		}
	}
	vStringDelete (name);
}

extern parserDefinition* LuaParser (void)
{
	static const char* const extensions [] = { "lua", NULL };
	parserDefinition* def = parserNew ("Lua");
	def->kindTable  = LuaKinds;
	def->kindCount  = ARRAY_SIZE (LuaKinds);
	def->extensions = extensions;
	def->parser     = findLuaTags;
	return def;
}
