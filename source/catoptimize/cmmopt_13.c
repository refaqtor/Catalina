/* This file generated by AWKA */

#include <libawka.h>
#include <setjmp.h>
#include <cat_functions.h>

int _split_req = 0, _split_max = INT_MAX;

extern int _dol0_used;
extern char _dol0_only;
extern char _env_used;
extern int _max_base_gc, _max_fn_gc;
extern struct awka_fn_struct *_awkafn;
jmp_buf context;
a_VAR *code_awk = NULL;
a_VAR *f_awk = NULL;

struct gvar_struct *_gvar;

a_VAR **_lvar;
a_VAR *_litd0_awka=NULL, *_litd1_awka=NULL, *_litd2_awka=NULL, *_litd3_awka=NULL;
a_VAR *_lits0_awka=NULL, *_lits1_awka=NULL, *_lits2_awka=NULL, *_lits3_awka=NULL, *_lits4_awka=NULL, *_lits5_awka=NULL, *_lits6_awka=NULL, *_lits7_awka=NULL, *_lits8_awka=NULL, *_lits9_awka=NULL, *_lits10_awka=NULL, *_lits11_awka=NULL, *_lits12_awka=NULL, *_lits13_awka=NULL, *_lits14_awka=NULL;
a_VAR *_litr0_awka=NULL, *_litr1_awka=NULL, *_litr2_awka=NULL, *_litr3_awka=NULL, *_litr4_awka=NULL, *_litr5_awka=NULL, *_litr6_awka=NULL, *_litr7_awka=NULL, *_litr8_awka=NULL, *_litr9_awka=NULL, *_litr10_awka=NULL;
void BEGIN();
void MAIN();

void
BEGIN()
{
  awka_vardblset(code_awk, 0);
  initialize_phase_13_fn(awka_arg0(a_TEMP));

}


void
MAIN()
{
  int i, _curfile;
  if (*(awka_gets(a_bivar[a_FILENAME])) == '\0')
    awka_strcpy(a_bivar[a_FILENAME], "");
  i = setjmp(context);
  while (awka_getline(a_TEMP, awka_dol0(0), awka_gets(a_bivar[a_FILENAME]), FALSE, TRUE)->dval > 0 && awka_setNF())
  {
    if (awka_vartrue(awka_match(a_TEMP, FALSE, awka_dol0(0), _litr0_awka, NULL)))
    {
      awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
      goto nextrec;
    }
    if (awka_vartrue(awka_match(a_TEMP, FALSE, awka_dol0(0), _litr1_awka, NULL)))
    {
      awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
      awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
      while (strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "}"))
      {
        awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
        if (awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE)->dval <= 0)
        {
          break;
        }
      }
      awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
      goto nextrec;
    }
    if (awka_vartrue(awka_match(a_TEMP, FALSE, awka_dol0(0), _litr2_awka, NULL)))
    {
      awka_vardblset(code_awk, 1);
    }
    if (awka_vartrue(awka_match(a_TEMP, FALSE, awka_dol0(0), _litr3_awka, NULL)))
    {
      awka_vardblset(code_awk, 0);
    }
    if (awka_vartrue(awka_match(a_TEMP, FALSE, awka_dol0(0), _litr4_awka, NULL)))
    {
      awka_vardblset(code_awk, 0);
    }
    if (awka_vartrue(awka_match(a_TEMP, FALSE, awka_dol0(0), _litr5_awka, NULL)))
    {
      awka_vardblset(code_awk, 0);
    }
    if (awka_vartrue(awka_match(a_TEMP, FALSE, awka_dol0(0), _litr6_awka, NULL)))
    {
      if (awka_vartrue(code_awk))
      {
        awka_varcpy(f_awk, awka_doln(1, 0));
        if (!(awka_vartrue(required_function_fn(awka_arg1(a_TEMP, f_awk)))))
        {
          awka_match(a_TEMP, FALSE, awka_dol0(0), _litr7_awka, NULL);
          awka_printf(NULL, 0, 0, awka_vararg(a_TEMP, _lits1_awka, f_awk, NULL));
          awka_print(NULL, 0, 0, awka_arg2(a_TEMP, _lits2_awka, awka_dol0(0)));
          awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
          while (1)
          {
            if (!strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "{"))
            {
              awka_match(a_TEMP, FALSE, awka_dol0(0), _litr8_awka, NULL);
              awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
              do
              {
                if (awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE)->dval <= 0)
                {
                  break;
                }
                awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
              } while (strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "}"));
              goto __312;
            }
            if ((((((!strcmp(awka_gets(awka_doln(2, 0)), "I16B_RETF")) ||  !strcmp(awka_gets(awka_doln(2, 0)), "I32_RETF"))) ||  !strcmp(awka_gets(awka_doln(2, 0)), "I16B_RETN"))) || ((!strcmp(awka_gets(awka_doln(2, 0)), "I16B_POPM")) &&  strcmp(awka_gets(awka_left(a_TEMP, awka_doln(4, 0), _litd2_awka)), "$180")))
            {
              awka_print(NULL, 0, 0, awka_arg2(a_TEMP, _lits2_awka, awka_dol0(0)));
              break;
              goto __312;
            }
            if ((!strcmp(awka_gets(awka_doln(1, 0)), "'")) && !strcmp(awka_gets(awka_left(a_TEMP, awka_doln(2, 0), _litd3_awka)), "end"))
            {
              awka_print(NULL, 0, 0, awka_arg2(a_TEMP, _lits2_awka, awka_dol0(0)));
              break;
              goto __312;
            }
            awka_print(NULL, 0, 0, awka_arg2(a_TEMP, _lits2_awka, awka_dol0(0)));
            __312:;
            if (awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE)->dval <= 0)
            {
              break;
          } }
          goto __341;
        }
        awka_match(a_TEMP, FALSE, awka_dol0(0), _litr9_awka, NULL);
        awka_match(a_TEMP, FALSE, awka_dol0(0), _litr10_awka, NULL);
        awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
        __341:;
        goto nextrec;
        goto __528;
      }
      awka_varcpy(f_awk, awka_doln(1, 0));
      if (!(awka_vartrue(required_function_fn(awka_arg1(a_TEMP, f_awk)))))
      {
        awka_printf(NULL, 0, 0, awka_vararg(a_TEMP, _lits1_awka, f_awk, NULL));
        awka_print(NULL, 0, 0, awka_arg2(a_TEMP, _lits2_awka, awka_dol0(0)));
        awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
        while (1)
        {
          if (!strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "{"))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr8_awka, NULL);
            awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
            do
            {
              if (awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE)->dval <= 0)
              {
                break;
              }
              awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
            } while (strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "}"));
            goto __504;
          }
          if ((!strcmp(awka_gets(awka_doln(1, 0)), "")) || ((((((strcmp(awka_gets(awka_doln(1, 0)), "'")) &&  strcmp(awka_gets(awka_doln(1, 0)), "byte"))) &&  strcmp(awka_gets(awka_doln(1, 0)), "word"))) &&  strcmp(awka_gets(awka_doln(1, 0)), "long")))
          {
            awka_print(NULL, 0, 0, awka_arg2(a_TEMP, _lits2_awka, awka_dol0(0)));
            break;
            goto __504;
          }
          awka_print(NULL, 0, 0, awka_arg2(a_TEMP, _lits2_awka, awka_dol0(0)));
          __504:;
          if (awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE)->dval <= 0)
          {
            break;
        } }
        goto __527;
      }
      awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
      __527:;
      goto nextrec;
      __528:;
    }
    awka_print(NULL, 0, 0, awka_arg1(a_TEMP, awka_dol0(0)));
    nextrec:;
  }
}

int
main(int argc, char *argv[])
{
  _max_base_gc = 3;
  _max_fn_gc = 2;

  awka_varinit(code_awk);
  awka_varinit(f_awk);

  awka_varinit(_litd0_awka); awka_setd(_litd0_awka) = 0;
  awka_varinit(_litd1_awka); awka_setd(_litd1_awka) = 1;
  awka_varinit(_litd2_awka); awka_setd(_litd2_awka) = 4;
  awka_varinit(_litd3_awka); awka_setd(_litd3_awka) = 3;
  awka_varinit(_lits0_awka); awka_strcpy(_lits0_awka, "}");
  awka_varinit(_lits1_awka); awka_strcpy(_lits1_awka, "' Catalina Optimizer - %s removed (Not Required)\n");
  awka_varinit(_lits2_awka); awka_strcpy(_lits2_awka, "' ");
  awka_varinit(_lits3_awka); awka_strcpy(_lits3_awka, "{");
  awka_varinit(_lits4_awka); awka_strcpy(_lits4_awka, "I16B_RETF");
  awka_varinit(_lits5_awka); awka_strcpy(_lits5_awka, "I32_RETF");
  awka_varinit(_lits6_awka); awka_strcpy(_lits6_awka, "I16B_RETN");
  awka_varinit(_lits7_awka); awka_strcpy(_lits7_awka, "I16B_POPM");
  awka_varinit(_lits8_awka); awka_strcpy(_lits8_awka, "$180");
  awka_varinit(_lits9_awka); awka_strcpy(_lits9_awka, "'");
  awka_varinit(_lits10_awka); awka_strcpy(_lits10_awka, "end");
  awka_varinit(_lits11_awka); awka_strcpy(_lits11_awka, "");
  awka_varinit(_lits12_awka); awka_strcpy(_lits12_awka, "byte");
  awka_varinit(_lits13_awka); awka_strcpy(_lits13_awka, "word");
  awka_varinit(_lits14_awka); awka_strcpy(_lits14_awka, "long");
  awka_varinit(_litr0_awka); awka_strcpy(_litr0_awka, "/^'/"); awka_getre(_litr0_awka);
  awka_varinit(_litr1_awka); awka_strcpy(_litr1_awka, "/^{/"); awka_getre(_litr1_awka);
  awka_varinit(_litr2_awka); awka_strcpy(_litr2_awka, "/^Catalina_Code/"); awka_getre(_litr2_awka);
  awka_varinit(_litr3_awka); awka_strcpy(_litr3_awka, "/^Catalina_Cnst/"); awka_getre(_litr3_awka);
  awka_varinit(_litr4_awka); awka_strcpy(_litr4_awka, "/^Catalina_Data/"); awka_getre(_litr4_awka);
  awka_varinit(_litr5_awka); awka_strcpy(_litr5_awka, "/^Catalina_Init/"); awka_getre(_litr5_awka);
  awka_varinit(_litr6_awka); awka_strcpy(_litr6_awka, "/^C_/"); awka_getre(_litr6_awka);
  awka_varinit(_litr7_awka); awka_strcpy(_litr7_awka, "/* remove the function */"); awka_getre(_litr7_awka);
  awka_varinit(_litr8_awka); awka_strcpy(_litr8_awka, "/* skip code that is commented out */"); awka_getre(_litr8_awka);
  awka_varinit(_litr9_awka); awka_strcpy(_litr9_awka, "/* printf \"' Catalina Optimizer - %s not removed (Required)\n\", f */"); awka_getre(_litr9_awka);
  awka_varinit(_litr10_awka); awka_strcpy(_litr10_awka, "/* not removable - reconstruct original line */"); awka_getre(_litr10_awka);

  if (!_lvar) {
    malloc( &_lvar, 31 * sizeof(a_VAR *) );
    _lvar[0] = _litd0_awka;
    _lvar[1] = _litd1_awka;
    _lvar[2] = _litd2_awka;
    _lvar[3] = _litd3_awka;
    _lvar[4] = _lits0_awka;
    _lvar[5] = _lits1_awka;
    _lvar[6] = _lits2_awka;
    _lvar[7] = _lits3_awka;
    _lvar[8] = _lits4_awka;
    _lvar[9] = _lits5_awka;
    _lvar[10] = _lits6_awka;
    _lvar[11] = _lits7_awka;
    _lvar[12] = _lits8_awka;
    _lvar[13] = _lits9_awka;
    _lvar[14] = _lits10_awka;
    _lvar[15] = _lits11_awka;
    _lvar[16] = _lits12_awka;
    _lvar[17] = _lits13_awka;
    _lvar[18] = _lits14_awka;
    _lvar[19] = _litr0_awka;
    _lvar[20] = _litr1_awka;
    _lvar[21] = _litr2_awka;
    _lvar[22] = _litr3_awka;
    _lvar[23] = _litr4_awka;
    _lvar[24] = _litr5_awka;
    _lvar[25] = _litr6_awka;
    _lvar[26] = _litr7_awka;
    _lvar[27] = _litr8_awka;
    _lvar[28] = _litr9_awka;
    _lvar[29] = _litr10_awka;
    _lvar[30] = NULL;
  }

  malloc( &_gvar, 3 * sizeof(struct gvar_struct) );
  awka_initgvar(0, "code_awk", code_awk);
  awka_initgvar(1, "f_awk", f_awk);
  _gvar[2].name = NULL;
  _gvar[2].var  = NULL;

  malloc( &_awkafn, 1 * sizeof(struct awka_fn_struct) );
  _awkafn[0].name = NULL;
  _awkafn[0].fn   = NULL;

  awka_init(argc, argv, "0.7.5", "12 July 2001");

  _split_max = 4;
  _split_req = 1;
  _dol0_used = 1;

  BEGIN();
  MAIN();

  free(_litd0_awka);
  free(_litd1_awka);
  free(_litd2_awka);
  free(_litd3_awka);
  free(_lits0_awka->ptr); free(_lits0_awka);
  free(_lits1_awka->ptr); free(_lits1_awka);
  free(_lits2_awka->ptr); free(_lits2_awka);
  free(_lits3_awka->ptr); free(_lits3_awka);
  free(_lits4_awka->ptr); free(_lits4_awka);
  free(_lits5_awka->ptr); free(_lits5_awka);
  free(_lits6_awka->ptr); free(_lits6_awka);
  free(_lits7_awka->ptr); free(_lits7_awka);
  free(_lits8_awka->ptr); free(_lits8_awka);
  free(_lits9_awka->ptr); free(_lits9_awka);
  free(_lits10_awka->ptr); free(_lits10_awka);
  free(_lits11_awka->ptr); free(_lits11_awka);
  free(_lits12_awka->ptr); free(_lits12_awka);
  free(_lits13_awka->ptr); free(_lits13_awka);
  free(_lits14_awka->ptr); free(_lits14_awka);
  awka_killvar(_litr0_awka); free(_litr0_awka);
  awka_killvar(_litr1_awka); free(_litr1_awka);
  awka_killvar(_litr2_awka); free(_litr2_awka);
  awka_killvar(_litr3_awka); free(_litr3_awka);
  awka_killvar(_litr4_awka); free(_litr4_awka);
  awka_killvar(_litr5_awka); free(_litr5_awka);
  awka_killvar(_litr6_awka); free(_litr6_awka);
  awka_killvar(_litr7_awka); free(_litr7_awka);
  awka_killvar(_litr8_awka); free(_litr8_awka);
  awka_killvar(_litr9_awka); free(_litr9_awka);
  awka_killvar(_litr10_awka); free(_litr10_awka);

  awka_exit(0);
}
