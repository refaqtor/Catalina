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
a_VAR *done_awk = NULL;
a_VAR *u_awk = NULL;
a_VAR *i_awk = NULL;

struct gvar_struct *_gvar;

a_VAR **_lvar;
a_VAR *_litd0_awka=NULL, *_litd1_awka=NULL, *_litd2_awka=NULL, *_litd3_awka=NULL;
a_VAR *_lits0_awka=NULL, *_lits1_awka=NULL, *_lits2_awka=NULL, *_lits3_awka=NULL, *_lits4_awka=NULL, *_lits5_awka=NULL, *_lits6_awka=NULL, *_lits7_awka=NULL, *_lits8_awka=NULL, *_lits9_awka=NULL, *_lits10_awka=NULL, *_lits11_awka=NULL, *_lits12_awka=NULL, *_lits13_awka=NULL, *_lits14_awka=NULL, *_lits15_awka=NULL, *_lits16_awka=NULL, *_lits17_awka=NULL, *_lits18_awka=NULL, *_lits19_awka=NULL, *_lits20_awka=NULL, *_lits21_awka=NULL, *_lits22_awka=NULL, *_lits23_awka=NULL, *_lits24_awka=NULL, *_lits25_awka=NULL, *_lits26_awka=NULL, *_lits27_awka=NULL, *_lits28_awka=NULL;
a_VAR *_litr0_awka=NULL, *_litr1_awka=NULL, *_litr2_awka=NULL, *_litr3_awka=NULL, *_litr4_awka=NULL, *_litr5_awka=NULL, *_litr6_awka=NULL, *_litr7_awka=NULL, *_litr8_awka=NULL, *_litr9_awka=NULL, *_litr10_awka=NULL, *_litr11_awka=NULL;
void BEGIN();
void MAIN();
void END();

void
BEGIN()
{
  awka_vardblset(code_awk, 0);
  initialize_phase_12_fn(awka_arg0(a_TEMP));

}


void
END()
{
  finalize_phase_12_fn(awka_arg0(a_TEMP));

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
      goto nextrec;
    }
    if (awka_vartrue(awka_match(a_TEMP, FALSE, awka_dol0(0), _litr1_awka, NULL)))
    {
      awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
      while (strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "}"))
      {
        if (awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE)->dval <= 0)
        {
          break;
        }
      }
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
      awka_varcpy(f_awk, awka_doln(1, 0));
      if ((awka_vartrue(code_awk)) && awka_vartrue(known_function_fn(awka_arg1(a_TEMP, f_awk))))
      {
        awka_vardblset(done_awk, 0);
        awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
        while (done_awk->dval == 0)
        {
          if (!strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "{"))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr7_awka, NULL);
            do
            {
              if (awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE)->dval <= 0)
              {
                break;
              }
            } while (strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "}"));
            goto __796;
          }
          if (!strcmp(awka_gets(awka_left(a_TEMP, awka_doln(1, 0), _litd2_awka)), "C_"))
          {
            awka_varcpy(u_awk, awka_doln(1, 0));
            uses_FN_fn(awka_arg3(a_TEMP, f_awk, u_awk, code_awk));
            goto __796;
          }
          if ((((!strcmp(awka_gets(awka_doln(1, 0)), "jmp")) &&  ((!strcmp(awka_gets(awka_doln(2, 0)), "#RETF")) ||  !strcmp(awka_gets(awka_doln(2, 0)), "#RETN")))) || ((!strcmp(awka_gets(awka_doln(1, 0)), "calld")) &&  ((!strcmp(awka_gets(awka_doln(2, 0)), "PA,#RETF")) ||  !strcmp(awka_gets(awka_doln(2, 0)), "PA,#RETN"))))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr8_awka, NULL);
            awka_vardblset(done_awk, 1);
            goto __796;
          }
          if ((!strcmp(awka_gets(awka_doln(1, 0)), "'")) && !strcmp(awka_gets(awka_left(a_TEMP, awka_doln(2, 0), _litd3_awka)), "end"))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr8_awka, NULL);
            awka_vardblset(done_awk, 1);
            goto __796;
          }
          if ((((!strcmp(awka_gets(awka_doln(1, 0)), "jmp")) &&  !strcmp(awka_gets(awka_doln(2, 0)), "#CALA"))) || ((!strcmp(awka_gets(awka_doln(1, 0)), "calld")) &&  !strcmp(awka_gets(awka_doln(2, 0)), "PA,#CALA")))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr9_awka, NULL);
            awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
            awka_varcpy(u_awk, awka_right(a_TEMP, awka_doln(2, 0), awka_tmp_dbl2var((awka_length(awka_doln(2, 0)) - (1)))));
            uses_FN_fn(awka_arg3(a_TEMP, f_awk, u_awk, code_awk));
            goto __796;
          }
          if ((((!strcmp(awka_gets(awka_doln(1, 0)), "jmp")) &&  ((((((!strcmp(awka_gets(awka_doln(2, 0)), "#LODA")) ||  !strcmp(awka_gets(awka_doln(2, 0)), "#LODL"))) ||  !strcmp(awka_gets(awka_doln(2, 0)), "#LODI"))) ||  !strcmp(awka_gets(awka_doln(2, 0)), "#PSHA")))) || ((!strcmp(awka_gets(awka_doln(1, 0)), "calld")) &&  ((((((!strcmp(awka_gets(awka_doln(2, 0)), "PA,#LODA")) ||  !strcmp(awka_gets(awka_doln(2, 0)), "PA,#LODL"))) ||  !strcmp(awka_gets(awka_doln(2, 0)), "PA,#LODI"))) ||  !strcmp(awka_gets(awka_doln(2, 0)), "PA,#PSHA"))))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr10_awka, NULL);
            awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
            if (!strcmp(awka_gets(awka_left(a_TEMP, awka_doln(2, 0), _litd1_awka)), "@"))
            {
              awka_varcpy(u_awk, awka_right(a_TEMP, awka_doln(2, 0), awka_tmp_dbl2var((awka_length(awka_doln(2, 0)) - (1)))));
              if ((awka_vardblset(i_awk, awka_index(u_awk, _lits22_awka))) > awka_getd(_litd1_awka))
              {
                awka_varcpy(u_awk, awka_left(a_TEMP, u_awk, awka_tmp_dbl2var((i_awk->dval - 1))));
              }
              if ((awka_vardblset(i_awk, awka_index(u_awk, _lits23_awka))) > awka_getd(_litd1_awka))
              {
                awka_varcpy(u_awk, awka_left(a_TEMP, u_awk, awka_tmp_dbl2var((i_awk->dval - 1))));
              }
              uses_FN_fn(awka_arg3(a_TEMP, f_awk, u_awk, code_awk));
            }
            goto __796;
          }
          if (!strcmp(awka_gets(awka_left(a_TEMP, awka_doln(2, 0), _litd3_awka)), "##@"))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr10_awka, NULL);
            awka_varcpy(u_awk, awka_right(a_TEMP, awka_doln(2, 0), awka_tmp_dbl2var((awka_length(awka_doln(2, 0)) - (3)))));
            if ((awka_vardblset(i_awk, awka_index(u_awk, _lits22_awka))) > awka_getd(_litd1_awka))
            {
              awka_varcpy(u_awk, awka_left(a_TEMP, u_awk, awka_tmp_dbl2var((i_awk->dval - 1))));
            }
            if ((awka_vardblset(i_awk, awka_index(u_awk, _lits23_awka))) > awka_getd(_litd1_awka))
            {
              awka_varcpy(u_awk, awka_left(a_TEMP, u_awk, awka_tmp_dbl2var((i_awk->dval - 1))));
            }
            uses_FN_fn(awka_arg3(a_TEMP, f_awk, u_awk, code_awk));
            goto __796;
          }
          if (!strcmp(awka_gets(awka_left(a_TEMP, awka_doln(3, 0), _litd3_awka)), "##@"))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr10_awka, NULL);
            awka_varcpy(u_awk, awka_right(a_TEMP, awka_doln(3, 0), awka_tmp_dbl2var((awka_length(awka_doln(3, 0)) - (3)))));
            if ((awka_vardblset(i_awk, awka_index(u_awk, _lits22_awka))) > awka_getd(_litd1_awka))
            {
              awka_varcpy(u_awk, awka_left(a_TEMP, u_awk, awka_tmp_dbl2var((i_awk->dval - 1))));
            }
            if ((awka_vardblset(i_awk, awka_index(u_awk, _lits23_awka))) > awka_getd(_litd1_awka))
            {
              awka_varcpy(u_awk, awka_left(a_TEMP, u_awk, awka_tmp_dbl2var((i_awk->dval - 1))));
            }
            uses_FN_fn(awka_arg3(a_TEMP, f_awk, u_awk, code_awk));
            __796:;
          }
          if (awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE)->dval <= 0)
          {
            break;
          }
        }
        awka_strcpy(f_awk, "no function");
        goto __1094;
      }
      if ((!(awka_vartrue(code_awk))) && awka_vartrue(known_function_fn(awka_arg1(a_TEMP, f_awk))))
      {
        awka_vardblset(done_awk, 0);
        awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
        while (done_awk->dval == 0)
        {
          if (!strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "{"))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr7_awka, NULL);
            awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
            while (strcmp(awka_gets(awka_left(a_TEMP, awka_dol0(0), _litd1_awka)), "}"))
            {
              if (awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE)->dval <= 0)
              {
                break;
              }
            }
            awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
            goto __1087;
          }
          if ((((!strcmp(awka_gets(awka_doln(1, 0)), "'")) ||  !strcmp(awka_gets(awka_doln(1, 0)), "byte"))) || !strcmp(awka_gets(awka_doln(1, 0)), "word"))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr11_awka, NULL);
            awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
            goto __1087;
          }
          if ((!strcmp(awka_gets(awka_doln(1, 0)), "long")) && !strcmp(awka_gets(awka_left(a_TEMP, awka_doln(2, 0), _litd1_awka)), "@"))
          {
            awka_varcpy(u_awk, awka_ltrim(a_TEMP, awka_arg2(a_TEMP, awka_doln(2, 0), _lits21_awka)));
            if ((awka_vardblset(i_awk, awka_index(u_awk, _lits22_awka))) > awka_getd(_litd1_awka))
            {
              awka_varcpy(u_awk, awka_left(a_TEMP, u_awk, awka_tmp_dbl2var((i_awk->dval - 1))));
            }
            if ((awka_vardblset(i_awk, awka_index(u_awk, _lits23_awka))) > awka_getd(_litd1_awka))
            {
              awka_varcpy(u_awk, awka_left(a_TEMP, u_awk, awka_tmp_dbl2var((i_awk->dval - 1))));
            }
            uses_FN_fn(awka_arg3(a_TEMP, f_awk, u_awk, code_awk));
            awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
            goto __1087;
          }
          if (!strcmp(awka_gets(awka_doln(1, 0)), "long"))
          {
            awka_match(a_TEMP, FALSE, awka_dol0(0), _litr11_awka, NULL);
            awka_getline(a_TEMP, awka_dol0(2), awka_gets(a_bivar[a_FILENAME]), 0, TRUE);
            goto __1087;
          }
          awka_vardblset(done_awk, 1);
          __1087:;
        }
        __1094:;
      }
      goto nextrec;
    }
    nextrec:;
  }
}

int
main(int argc, char *argv[])
{
  _max_base_gc = 4;
  _max_fn_gc = 2;

  awka_varinit(code_awk);
  awka_varinit(f_awk);
  awka_varinit(done_awk);
  awka_varinit(u_awk);
  awka_varinit(i_awk);

  awka_varinit(_litd0_awka); awka_setd(_litd0_awka) = 0;
  awka_varinit(_litd1_awka); awka_setd(_litd1_awka) = 1;
  awka_varinit(_litd2_awka); awka_setd(_litd2_awka) = 2;
  awka_varinit(_litd3_awka); awka_setd(_litd3_awka) = 3;
  awka_varinit(_lits0_awka); awka_strcpy(_lits0_awka, "}");
  awka_varinit(_lits1_awka); awka_strcpy(_lits1_awka, "{");
  awka_varinit(_lits2_awka); awka_strcpy(_lits2_awka, "C_");
  awka_varinit(_lits3_awka); awka_strcpy(_lits3_awka, "jmp");
  awka_varinit(_lits4_awka); awka_strcpy(_lits4_awka, "#RETF");
  awka_varinit(_lits5_awka); awka_strcpy(_lits5_awka, "#RETN");
  awka_varinit(_lits6_awka); awka_strcpy(_lits6_awka, "calld");
  awka_varinit(_lits7_awka); awka_strcpy(_lits7_awka, "PA,#RETF");
  awka_varinit(_lits8_awka); awka_strcpy(_lits8_awka, "PA,#RETN");
  awka_varinit(_lits9_awka); awka_strcpy(_lits9_awka, "'");
  awka_varinit(_lits10_awka); awka_strcpy(_lits10_awka, "end");
  awka_varinit(_lits11_awka); awka_strcpy(_lits11_awka, "#CALA");
  awka_varinit(_lits12_awka); awka_strcpy(_lits12_awka, "PA,#CALA");
  awka_varinit(_lits13_awka); awka_strcpy(_lits13_awka, "#LODA");
  awka_varinit(_lits14_awka); awka_strcpy(_lits14_awka, "#LODL");
  awka_varinit(_lits15_awka); awka_strcpy(_lits15_awka, "#LODI");
  awka_varinit(_lits16_awka); awka_strcpy(_lits16_awka, "#PSHA");
  awka_varinit(_lits17_awka); awka_strcpy(_lits17_awka, "PA,#LODA");
  awka_varinit(_lits18_awka); awka_strcpy(_lits18_awka, "PA,#LODL");
  awka_varinit(_lits19_awka); awka_strcpy(_lits19_awka, "PA,#LODI");
  awka_varinit(_lits20_awka); awka_strcpy(_lits20_awka, "PA,#PSHA");
  awka_varinit(_lits21_awka); awka_strcpy(_lits21_awka, "@");
  awka_varinit(_lits22_awka); awka_strcpy(_lits22_awka, "+");
  awka_varinit(_lits23_awka); awka_strcpy(_lits23_awka, "-");
  awka_varinit(_lits24_awka); awka_strcpy(_lits24_awka, "##@");
  awka_varinit(_lits25_awka); awka_strcpy(_lits25_awka, "no function");
  awka_varinit(_lits26_awka); awka_strcpy(_lits26_awka, "byte");
  awka_varinit(_lits27_awka); awka_strcpy(_lits27_awka, "word");
  awka_varinit(_lits28_awka); awka_strcpy(_lits28_awka, "long");
  awka_varinit(_litr0_awka); awka_strcpy(_litr0_awka, "/^'/"); awka_getre(_litr0_awka);
  awka_varinit(_litr1_awka); awka_strcpy(_litr1_awka, "/^{/"); awka_getre(_litr1_awka);
  awka_varinit(_litr2_awka); awka_strcpy(_litr2_awka, "/^Catalina_Code/"); awka_getre(_litr2_awka);
  awka_varinit(_litr3_awka); awka_strcpy(_litr3_awka, "/^Catalina_Cnst/"); awka_getre(_litr3_awka);
  awka_varinit(_litr4_awka); awka_strcpy(_litr4_awka, "/^Catalina_Data/"); awka_getre(_litr4_awka);
  awka_varinit(_litr5_awka); awka_strcpy(_litr5_awka, "/^Catalina_Init/"); awka_getre(_litr5_awka);
  awka_varinit(_litr6_awka); awka_strcpy(_litr6_awka, "/^C_/"); awka_getre(_litr6_awka);
  awka_varinit(_litr7_awka); awka_strcpy(_litr7_awka, "/* skip code that is commented out */"); awka_getre(_litr7_awka);
  awka_varinit(_litr8_awka); awka_strcpy(_litr8_awka, "/* this terminates function */"); awka_getre(_litr8_awka);
  awka_varinit(_litr9_awka); awka_strcpy(_litr9_awka, "/* direct call */"); awka_getre(_litr9_awka);
  awka_varinit(_litr10_awka); awka_strcpy(_litr10_awka, "/* address being taken */"); awka_getre(_litr10_awka);
  awka_varinit(_litr11_awka); awka_strcpy(_litr11_awka, "/* ignore these */"); awka_getre(_litr11_awka);

  if (!_lvar) {
    malloc( &_lvar, 46 * sizeof(a_VAR *) );
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
    _lvar[19] = _lits15_awka;
    _lvar[20] = _lits16_awka;
    _lvar[21] = _lits17_awka;
    _lvar[22] = _lits18_awka;
    _lvar[23] = _lits19_awka;
    _lvar[24] = _lits20_awka;
    _lvar[25] = _lits21_awka;
    _lvar[26] = _lits22_awka;
    _lvar[27] = _lits23_awka;
    _lvar[28] = _lits24_awka;
    _lvar[29] = _lits25_awka;
    _lvar[30] = _lits26_awka;
    _lvar[31] = _lits27_awka;
    _lvar[32] = _lits28_awka;
    _lvar[33] = _litr0_awka;
    _lvar[34] = _litr1_awka;
    _lvar[35] = _litr2_awka;
    _lvar[36] = _litr3_awka;
    _lvar[37] = _litr4_awka;
    _lvar[38] = _litr5_awka;
    _lvar[39] = _litr6_awka;
    _lvar[40] = _litr7_awka;
    _lvar[41] = _litr8_awka;
    _lvar[42] = _litr9_awka;
    _lvar[43] = _litr10_awka;
    _lvar[44] = _litr11_awka;
    _lvar[45] = NULL;
  }

  malloc( &_gvar, 6 * sizeof(struct gvar_struct) );
  awka_initgvar(0, "code_awk", code_awk);
  awka_initgvar(1, "f_awk", f_awk);
  awka_initgvar(2, "done_awk", done_awk);
  awka_initgvar(3, "u_awk", u_awk);
  awka_initgvar(4, "i_awk", i_awk);
  _gvar[5].name = NULL;
  _gvar[5].var  = NULL;

  malloc( &_awkafn, 1 * sizeof(struct awka_fn_struct) );
  _awkafn[0].name = NULL;
  _awkafn[0].fn   = NULL;

  awka_init(argc, argv, "0.7.5", "12 July 2001");

  _split_max = 3;
  _split_req = 1;
  _dol0_used = 1;

  BEGIN();
  MAIN();
  END();

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
  free(_lits15_awka->ptr); free(_lits15_awka);
  free(_lits16_awka->ptr); free(_lits16_awka);
  free(_lits17_awka->ptr); free(_lits17_awka);
  free(_lits18_awka->ptr); free(_lits18_awka);
  free(_lits19_awka->ptr); free(_lits19_awka);
  free(_lits20_awka->ptr); free(_lits20_awka);
  free(_lits21_awka->ptr); free(_lits21_awka);
  free(_lits22_awka->ptr); free(_lits22_awka);
  free(_lits23_awka->ptr); free(_lits23_awka);
  free(_lits24_awka->ptr); free(_lits24_awka);
  free(_lits25_awka->ptr); free(_lits25_awka);
  free(_lits26_awka->ptr); free(_lits26_awka);
  free(_lits27_awka->ptr); free(_lits27_awka);
  free(_lits28_awka->ptr); free(_lits28_awka);
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
  awka_killvar(_litr11_awka); free(_litr11_awka);

  awka_exit(0);
}
