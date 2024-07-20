/* 
 * Parallelizer functions to process propeller pragmas
 *
 * Compiled with AWKA 0.7.5
 *
 * Copyright (c) 2020 Ross Higson
 *
 * +----------------------------------------------------------------------------------------------------------------------+
 * |                                             TERMS OF USE: MIT License                                                |
 * +----------------------------------------------------------------------------------------------------------------------+
 * |Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated          |
 * |documentation files (the "Software"), to deal in the Software without restriction, including without limitation the   |
 * |rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit|
 * |persons to whom the Software is furnished to do so, subject to the following conditions:                              |
 * |                                                                                                                      |
 * |The above copyright notice and this permission notice shall be included in all copies or substantial portions of the  |
 * |Software.                                                                                                             |
 * |                                                                                                                      |
 * |THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE  |
 * |WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR |
 * |COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR      |
 * |OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.      |
 * +----------------------------------------------------------------------------------------------------------------------+
 */

void initialize_pragma_fn( a_VARARG *va );
void finalize_pragma_fn( a_VARARG *va );

void insert_worker(int i);
void insert_worker_fn( a_VARARG *va );
a_VAR * known_worker_fn( a_VARARG *va );
a_VAR * known_factory_fn( a_VARARG *va );
a_VAR * known_exclusion_fn( a_VARARG *va );
a_VAR * define_worker_fn( a_VARARG *va );
a_VAR * define_factory_fn( a_VARARG *va );
a_VAR * define_exclusion_fn( a_VARARG *va );
a_VAR * set_memory_management_fn( a_VARARG *va );
void add_line_to_worker_fn( a_VARARG *va );

