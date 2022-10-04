{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

// This File is auto generated!
// Any change to this file should be made in the
// corresponding unit in the folder "intermediate"!

// Generation date: 07.09.2022 11:33:03

unit IdOpenSSLHeaders_conf;

interface

// Headers for OpenSSL 1.1.1
// conf.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_stack;

type
  CONF_parse_list_list_cb = function (const elem: PAnsiChar; len: TIdC_INT; usr: Pointer): TIdC_INT;

  CONF_VALUE = record
    section: PAnsiChar;
    name: PAnsiChar;
    value: PAnsiChar;
  end;
  PCONF_VALUE = ^CONF_VALUE;

//DEFINE_STACK_OF(CONF_VALUE)
  STACK_OF_CONF_VALUE = type of pointer;
  PSTACK_OF_CONF_VALUE = ^STACK_OF_CONF_VALUE;
  sk_CONF_VALUE_compfunc = function(const a: PCONF_VALUE; const b: PCONF_VALUE): TIdC_INT; cdecl;
  sk_CONF_VALUE_freefunc = procedure(a: PCONF_VALUE); cdecl;
  sk_CONF_VALUE_copyfunc = function(const a: PCONF_VALUE): PCONF_VALUE; cdecl;
//DEFINE_LHASH_OF(CONF_VALUE);

  conf_st = type Pointer;
  conf_method_st = type Pointer;
  CONF_METHOD = conf_method_st;
  PCONF_METHOD = ^conf_method_st;
  CONF = conf_st;
  PCONF = ^CONF;

  (*conf_method_st = record
    const char *name;
    CONF *(*create) (CONF_METHOD *meth);
    int (*init) (CONF *conf);
    int (*destroy) (CONF *conf);
    int (*destroy_data) (CONF *conf);
    int (*load_bio) (CONF *conf, BIO *bp, long *eline);
    int (*dump) (const CONF *conf, BIO *bp);
    int (*is_number) (const CONF *conf, char c);
    int (*to_int) (const CONF *conf, char c);
    int (*load) (CONF *conf, const char *name, long *eline);
  end; *)

//* Module definitions */

  conf_imodule_st = type Pointer;
  CONF_IMODULE = conf_imodule_st;
  PCONF_IMODULE = ^CONF_IMODULE;
  conf_module_st = type Pointer;
  CONF_MODULE = conf_module_st;
  PCONF_MODULE = ^CONF_MODULE;

//DEFINE_STACK_OF(CONF_MODULE)
  STACK_OF_CONF_MODULE = type of pointer;
  PSTACK_OF_CONF_MODULE = ^STACK_OF_CONF_MODULE;
  sk_CONF_MODULE_compfunc = function(const a: PCONF_MODULE; const b: PCONF_MODULE): TIdC_INT; cdecl;
  sk_CONF_MODULE_freefunc = procedure(a: PCONF_MODULE); cdecl;
  sk_CONF_MODULE_copyfunc = function(const a: PCONF_MODULE): PCONF_MODULE; cdecl;
//DEFINE_STACK_OF(CONF_IMODULE)
  STACK_OF_CONF_IMODULE = type of pointer;
  PSTACK_OF_CONF_IMODULE = ^STACK_OF_CONF_IMODULE;
  sk_CONF_IMODULE_compfunc = function(const a: PCONF_IMODULE; const b: PCONF_IMODULE): TIdC_INT; cdecl;
  sk_CONF_IMODULE_freefunc = procedure(a: PCONF_IMODULE); cdecl;
  sk_CONF_IMODULE_copyfunc = function(const a: PCONF_IMODULE): PCONF_IMODULE; cdecl;

//* DSO module function typedefs */
  conf_init_func = function(md: PCONF_IMODULE; const cnf: PCONF): TIdC_INT;
  conf_finish_func = procedure(md: PCONF_IMODULE);

const
  CONF_MFLAGS_IGNORE_ERRORS = $1;
  CONF_MFLAGS_IGNORE_RETURN_CODES = $2;
  CONF_MFLAGS_SILENT = $4;
  CONF_MFLAGS_NO_DSO = $8;
  CONF_MFLAGS_IGNORE_MISSING_FILE = $10;
  CONF_MFLAGS_DEFAULT_SECTION = $20;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  CONF_set_default_method: function(meth: PCONF_METHOD): TIdC_INT cdecl = nil;
//  (*
//  void CONF_set_nconf(CONF *conf, LHASH_OF(CONF_VALUE) *hash);
//  LHASH_OF(CONF_VALUE) *CONF_load(LHASH_OF(CONF_VALUE) *conf, const char *file, long *eline);
//  {$ifndef OPENSSL_NO_STDIO}
//  LHASH_OF(CONF_VALUE) *CONF_load_fp(LHASH_OF(CONF_VALUE) *conf, FILE *fp, long *eline);
//  {$endif}
//  LHASH_OF(CONF_VALUE) *CONF_load_bio(LHASH_OF(CONF_VALUE) *conf, BIO *bp,
//                                      long *eline);
//  STACK_OF(CONF_VALUE) *CONF_get_section(LHASH_OF(CONF_VALUE) *conf,
//                                         const char *section);
//  char *CONF_get_string(LHASH_OF(CONF_VALUE) *conf, const char *group,
//                        const char *name);
//  long CONF_get_number(LHASH_OF(CONF_VALUE) *conf, const char *group,
//                       const char *name);
//  void CONF_free(LHASH_OF(CONF_VALUE) *conf);
//  #ifndef OPENSSL_NO_STDIO
//  int CONF_dump_fp(LHASH_OF(CONF_VALUE) *conf, FILE *out);
//  #endif
//  int CONF_dump_bio(LHASH_OF(CONF_VALUE) *conf, BIO *out);
//
//  DEPRECATEDIN_1_1_0(void OPENSSL_config(const char *config_name))
//
//  #if OPENSSL_API_COMPAT < 0x10100000L
//  # define OPENSSL_no_config() \
//      OPENSSL_init_crypto(OPENSSL_INIT_NO_LOAD_CONFIG, NULL)
//  #endif
//  *)

  (*
   * New conf code.  The semantics are different from the functions above. If
   * that wasn't the case, the above functions would have been replaced
   *)

  //type     Doppelt???
  //  conf_st = record
  //    CONF_METHOD *meth;
  //    void *meth_data;
  //    LHASH_OF(CONF_VALUE) *data;
  //  end;

  NCONF_new: function(meth: PCONF_METHOD): PCONF cdecl = nil;
  NCONF_default: function: PCONF_METHOD cdecl = nil;
  NCONF_WIN32: function: PCONF_METHOD cdecl = nil;
  NCONF_free: procedure(conf: PCONF) cdecl = nil;
  NCONF_free_data: procedure(conf: PCONF) cdecl = nil;

  NCONF_load: function(conf: PCONF; const file_: PAnsiChar; eline: PIdC_LONG): TIdC_INT cdecl = nil;
  NCONF_load_bio: function(conf: PCONF; bp: PBIO; eline: PIdC_LONG): TIdC_INT cdecl = nil;
  //STACK_OF(CONF_VALUE) *NCONF_get_section(const CONF *conf,
  //                                        const char *section);
  NCONF_get_string: function(const conf: PCONF; const group: PAnsiChar; const name: PAnsiChar): PAnsiChar cdecl = nil;
  NCONF_get_number_e: function(const conf: PCONF; const group: PAnsiChar; const name: PAnsiChar; result: PIdC_LONG): TIdC_INT cdecl = nil;
  NCONF_dump_bio: function(const conf: PCONf; out: PBIO): TIdC_INT cdecl = nil;

  //#define NCONF_get_number(c,g,n,r) NCONF_get_number_e(c,g,n,r)

  //* Module functions */

  CONF_modules_load: function(const cnf: PCONF; const appname: PAnsiChar; flags: TIdC_ULONG): TIdC_INT cdecl = nil;
  CONF_modules_load_file: function(const filename: PAnsiChar; const appname: PAnsiChar; flags: TIdC_ULONG): TIdC_INT cdecl = nil;

  CONF_modules_unload: procedure(all: TIdC_INT) cdecl = nil;
  CONF_modules_finish: procedure cdecl = nil;
  CONF_module_add: function(const name: PAnsiChar; ifunc: conf_init_func; ffunc: conf_finish_func): TIdC_INT cdecl = nil;

  //const char *CONF_imodule_get_name(const CONF_IMODULE *md);
  //const char *CONF_imodule_get_value(const CONF_IMODULE *md);
  CONF_imodule_get_usr_data: function(const md: PCONF_IMODULE): Pointer cdecl = nil;
  CONF_imodule_set_usr_data: procedure(md: PCONF_IMODULE; usr_data: Pointer) cdecl = nil;
  CONF_imodule_get_module: function(const md: PCONF_IMODULE): PCONF_MODULE cdecl = nil;
  CONF_imodule_get_flags: function(const md: PCONF_IMODULE): TIdC_ULONG cdecl = nil;
  CONF_imodule_set_flags: procedure(md: PCONF_IMODULE; flags: TIdC_ULONG) cdecl = nil;
  CONF_module_get_usr_data: function(pmod: PCONF_MODULE): Pointer cdecl = nil;
  CONF_module_set_usr_data: procedure(pmod: PCONF_MODULE; usr_data: Pointer) cdecl = nil;

  CONF_get1_default_config_file: function: PAnsiChar cdecl = nil;
  CONF_parse_list: function(const list: PAnsiChar; sep: TIdC_INT; nospc: TIdC_INT; list_cb: CONF_parse_list_list_cb; arg: Pointer): TIdC_INT cdecl = nil;

  OPENSSL_load_builtin_modules: procedure cdecl = nil;

function sk_CONF_VALUE_num(const sk: PSTACK_OF_CONF_VALUE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_value(const sk: PSTACK_OF_CONF_VALUE; index: TIdC_INT): PCONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_new(compare: sk_CONF_VALUE_compfunc): PSTACK_OF_CONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_new_null(): PSTACK_OF_CONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_new_reserve(compare: sk_CONF_VALUE_compfunc; n: TIdC_INT): PSTACK_OF_CONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_reserve(sk: PSTACK_OF_CONF_VALUE; n: TIdC_INT): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_VALUE_free(sk: PSTACK_OF_CONF_VALUE);{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_VALUE_zero(sk: PSTACK_OF_CONF_VALUE);{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_delete(sk: PSTACK_OF_CONF_VALUE; i: TIdC_INT): PCONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_delete_ptr(sk: PSTACK_OF_CONF_VALUE; ptr: PCONF_VALUE): PCONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_push(sk: PSTACK_OF_CONF_VALUE; ptr: PCONF_VALUE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_unshift(sk: PSTACK_OF_CONF_VALUE; const ptr: PCONF_VALUE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_pop(sk: PSTACK_OF_CONF_VALUE): PCONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_shift(sk: PSTACK_OF_CONF_VALUE): PCONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_VALUE_pop_free(sk: PSTACK_OF_CONF_VALUE; freeFunc: sk_CONF_VALUE_freefunc);{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_insert(sk: PSTACK_OF_CONF_VALUE; const ptr: PCONF_VALUE; idx: TIdC_INT): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_set(sk: PSTACK_OF_CONF_VALUE; idx: TIdC_INT; const ptr: PCONF_VALUE): PCONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_find(sk: PSTACK_OF_CONF_VALUE; const ptr: PCONF_VALUE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_find_ex(sk: PSTACK_OF_CONF_VALUE; const ptr: PCONF_VALUE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_VALUE_sort(sk: PSTACK_OF_CONF_VALUE);{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_is_sorted(sk: PSTACK_OF_CONF_VALUE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_dup(const sk: PSTACK_OF_CONF_VALUE): PSTACK_OF_CONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_deep_copy(const sk: PSTACK_OF_CONF_VALUE; copyfunc: sk_CONF_VALUE_copyfunc; freefunc:sk_CONF_VALUE_freefunc): PSTACK_OF_CONF_VALUE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_VALUE_set_cmp_func(const sk: PSTACK_OF_CONF_VALUE; compare: sk_CONF_VALUE_compfunc): sk_CONF_VALUE_compfunc;{$ifdef USE_INLINE} inline;{$endif}

function sk_CONF_MODULE_num(const sk: PSTACK_OF_CONF_MODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_value(const sk: PSTACK_OF_CONF_MODULE; index: TIdC_INT): PCONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_new(compare: sk_CONF_MODULE_compfunc): PSTACK_OF_CONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_new_null(): PSTACK_OF_CONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_new_reserve(compare: sk_CONF_MODULE_compfunc; n: TIdC_INT): PSTACK_OF_CONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_reserve(sk: PSTACK_OF_CONF_MODULE; n: TIdC_INT): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_MODULE_free(sk: PSTACK_OF_CONF_MODULE);{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_MODULE_zero(sk: PSTACK_OF_CONF_MODULE);{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_delete(sk: PSTACK_OF_CONF_MODULE; i: TIdC_INT): PCONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_delete_ptr(sk: PSTACK_OF_CONF_MODULE; ptr: PCONF_MODULE): PCONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_push(sk: PSTACK_OF_CONF_MODULE; ptr: PCONF_MODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_unshift(sk: PSTACK_OF_CONF_MODULE; const ptr: PCONF_MODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_pop(sk: PSTACK_OF_CONF_MODULE): PCONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_shift(sk: PSTACK_OF_CONF_MODULE): PCONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_MODULE_pop_free(sk: PSTACK_OF_CONF_MODULE; freeFunc: sk_CONF_MODULE_freefunc);{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_insert(sk: PSTACK_OF_CONF_MODULE; const ptr: PCONF_MODULE; idx: TIdC_INT): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_set(sk: PSTACK_OF_CONF_MODULE; idx: TIdC_INT; const ptr: PCONF_MODULE): PCONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_find(sk: PSTACK_OF_CONF_MODULE; const ptr: PCONF_MODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_find_ex(sk: PSTACK_OF_CONF_MODULE; const ptr: PCONF_MODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_MODULE_sort(sk: PSTACK_OF_CONF_MODULE);{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_is_sorted(sk: PSTACK_OF_CONF_MODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_dup(const sk: PSTACK_OF_CONF_MODULE): PSTACK_OF_CONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_deep_copy(const sk: PSTACK_OF_CONF_MODULE; copyfunc: sk_CONF_MODULE_copyfunc; freefunc:sk_CONF_MODULE_freefunc): PSTACK_OF_CONF_MODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_MODULE_set_cmp_func(const sk: PSTACK_OF_CONF_MODULE; compare: sk_CONF_MODULE_compfunc): sk_CONF_MODULE_compfunc;{$ifdef USE_INLINE} inline;{$endif}

function sk_CONF_IMODULE_num(const sk: PSTACK_OF_CONF_IMODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_value(const sk: PSTACK_OF_CONF_IMODULE; index: TIdC_INT): PCONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_new(compare: sk_CONF_IMODULE_compfunc): PSTACK_OF_CONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_new_null(): PSTACK_OF_CONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_new_reserve(compare: sk_CONF_IMODULE_compfunc; n: TIdC_INT): PSTACK_OF_CONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_reserve(sk: PSTACK_OF_CONF_IMODULE; n: TIdC_INT): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_IMODULE_free(sk: PSTACK_OF_CONF_IMODULE);{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_IMODULE_zero(sk: PSTACK_OF_CONF_IMODULE);{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_delete(sk: PSTACK_OF_CONF_IMODULE; i: TIdC_INT): PCONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_delete_ptr(sk: PSTACK_OF_CONF_IMODULE; ptr: PCONF_IMODULE): PCONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_push(sk: PSTACK_OF_CONF_IMODULE; ptr: PCONF_IMODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_unshift(sk: PSTACK_OF_CONF_IMODULE; const ptr: PCONF_IMODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_pop(sk: PSTACK_OF_CONF_IMODULE): PCONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_shift(sk: PSTACK_OF_CONF_IMODULE): PCONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_IMODULE_pop_free(sk: PSTACK_OF_CONF_IMODULE; freeFunc: sk_CONF_IMODULE_freefunc);{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_insert(sk: PSTACK_OF_CONF_IMODULE; const ptr: PCONF_IMODULE; idx: TIdC_INT): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_set(sk: PSTACK_OF_CONF_IMODULE; idx: TIdC_INT; const ptr: PCONF_IMODULE): PCONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_find(sk: PSTACK_OF_CONF_IMODULE; const ptr: PCONF_IMODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_find_ex(sk: PSTACK_OF_CONF_IMODULE; const ptr: PCONF_IMODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
procedure sk_CONF_IMODULE_sort(sk: PSTACK_OF_CONF_IMODULE);{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_is_sorted(sk: PSTACK_OF_CONF_IMODULE): TIdC_INT;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_dup(const sk: PSTACK_OF_CONF_IMODULE): PSTACK_OF_CONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_deep_copy(const sk: PSTACK_OF_CONF_IMODULE; copyfunc: sk_CONF_IMODULE_copyfunc; freefunc:sk_CONF_IMODULE_freefunc): PSTACK_OF_CONF_IMODULE;{$ifdef USE_INLINE} inline;{$endif}
function sk_CONF_IMODULE_set_cmp_func(const sk: PSTACK_OF_CONF_IMODULE; compare: sk_CONF_IMODULE_compfunc): sk_CONF_IMODULE_compfunc;{$ifdef USE_INLINE} inline;{$endif}

implementation

{ DEFINE_STACK_OF(CONF_VALUE) Methoden }

function sk_CONF_VALUE_num(const sk: PSTACK_OF_CONF_VALUE): TIdC_INT;
begin
  result := OPENSSL_sk_num(POPENSSL_STACK(sk));
end;
function sk_CONF_VALUE_value(const sk: PSTACK_OF_CONF_VALUE; index: TIdC_INT): PCONF_VALUE;
begin
  result := PCONF_VALUE(OPENSSL_sk_value(POPENSSL_STACK(sk), index));
end;
function sk_CONF_VALUE_new(compare: sk_CONF_VALUE_compfunc): PSTACK_OF_CONF_VALUE;
begin
  result := PSTACK_OF_CONF_VALUE(OPENSSL_sk_new(OPENSSL_sk_compfunc(@compare)));
end;
function sk_CONF_VALUE_new_null(): PSTACK_OF_CONF_VALUE;
begin
  result := PSTACK_OF_CONF_VALUE(OPENSSL_sk_new_null());
end;
function sk_CONF_VALUE_new_reserve(compare: sk_CONF_VALUE_compfunc; n: TIdC_INT): PSTACK_OF_CONF_VALUE;
begin
  result := PSTACK_OF_CONF_VALUE(OPENSSL_sk_new_reserve(OPENSSL_sk_compfunc(@compare), n));
end;
function sk_CONF_VALUE_reserve(sk: PSTACK_OF_CONF_VALUE; n: TIdC_INT): TIdC_INT;
begin
  result := OPENSSL_sk_reserve(POPENSSL_STACK(sk), n);
end;
procedure sk_CONF_VALUE_free(sk: PSTACK_OF_CONF_VALUE);
begin
  OPENSSL_sk_free(POPENSSL_STACK(sk));
end;
procedure sk_CONF_VALUE_zero(sk: PSTACK_OF_CONF_VALUE);
begin
  OPENSSL_sk_zero(POPENSSL_STACK(sk));
end;
function sk_CONF_VALUE_delete(sk: PSTACK_OF_CONF_VALUE; i: TIdC_INT): PCONF_VALUE;
begin
  result := PCONF_VALUE(OPENSSL_sk_delete(POPENSSL_STACK(sk),i));
end;
function sk_CONF_VALUE_delete_ptr(sk: PSTACK_OF_CONF_VALUE; ptr: PCONF_VALUE): PCONF_VALUE;
begin
  result := PCONF_VALUE(OPENSSL_sk_delete_ptr(POPENSSL_STACK(sk),pointer(ptr)));
end;
function sk_CONF_VALUE_push(sk: PSTACK_OF_CONF_VALUE; ptr: PCONF_VALUE): TIdC_INT;
begin
  result := OPENSSL_sk_push(POPENSSL_STACK(sk),pointer(ptr));
end;
function sk_CONF_VALUE_unshift(sk: PSTACK_OF_CONF_VALUE; const ptr: PCONF_VALUE): TIdC_INT;
begin
  result := OPENSSL_sk_unshift(POPENSSL_STACK(sk),pointer(ptr));
end;
function sk_CONF_VALUE_pop(sk: PSTACK_OF_CONF_VALUE): PCONF_VALUE;
begin
  result := PCONF_VALUE(OPENSSL_sk_pop(POPENSSL_STACK(sk)));
end;
function sk_CONF_VALUE_shift(sk: PSTACK_OF_CONF_VALUE): PCONF_VALUE;
begin
  result := PCONF_VALUE(OPENSSL_sk_shift(POPENSSL_STACK(sk)));
end;
procedure sk_CONF_VALUE_pop_free(sk: PSTACK_OF_CONF_VALUE; freeFunc: sk_CONF_VALUE_freefunc);
begin
  OPENSSL_sk_pop_free(POPENSSL_STACK(sk), OPENSSL_sk_freefunc(@freeFunc) );
end;
function sk_CONF_VALUE_insert(sk: PSTACK_OF_CONF_VALUE; const ptr: PCONF_VALUE; idx: TIdC_INT): TIdC_INT;
begin
  result := OPENSSL_sk_insert(POPENSSL_STACK(sk), pointer(ptr), idx);
end;
function sk_CONF_VALUE_set(sk: PSTACK_OF_CONF_VALUE; idx: TIdC_INT; const ptr: PCONF_VALUE): PCONF_VALUE;
begin
  result := PCONF_VALUE(OPENSSL_sk_set(POPENSSL_STACK(sk), idx, pointer(ptr)));
end;
function sk_CONF_VALUE_find(sk: PSTACK_OF_CONF_VALUE; const ptr: PCONF_VALUE): TIdC_INT;
begin
  result := OPENSSL_sk_find(POPENSSL_STACK(sk), pointer(ptr));
end;
function sk_CONF_VALUE_find_ex(sk: PSTACK_OF_CONF_VALUE; const ptr: PCONF_VALUE): TIdC_INT;
begin
  result := OPENSSL_sk_find_ex(POPENSSL_STACK(sk), pointer(ptr));
end;
procedure sk_CONF_VALUE_sort(sk: PSTACK_OF_CONF_VALUE);
begin
  OPENSSL_sk_sort(POPENSSL_STACK(sk));
end;
function sk_CONF_VALUE_is_sorted(sk: PSTACK_OF_CONF_VALUE): TIdC_INT;
begin
  result:=OPENSSL_sk_is_sorted(POPENSSL_STACK(sk));
end;
function sk_CONF_VALUE_dup(const sk: PSTACK_OF_CONF_VALUE): PSTACK_OF_CONF_VALUE;
begin
  result:=PSTACK_OF_CONF_VALUE(OPENSSL_sk_dup(POPENSSL_STACK(sk)));
end;
function sk_CONF_VALUE_deep_copy(const sk: PSTACK_OF_CONF_VALUE; copyfunc: sk_CONF_VALUE_copyfunc; freefunc:sk_CONF_VALUE_freefunc): PSTACK_OF_CONF_VALUE;
begin
  result:=PSTACK_OF_CONF_VALUE(OPENSSL_sk_deep_copy(POPENSSL_STACK(sk),OPENSSL_sk_copyfunc(@copyfunc),OPENSSL_sk_freefunc(@freefunc)));
end;
function sk_CONF_VALUE_set_cmp_func(const sk: PSTACK_OF_CONF_VALUE; compare: sk_CONF_VALUE_compfunc): sk_CONF_VALUE_compfunc;
begin
  result:=sk_CONF_VALUE_compfunc(OPENSSL_sk_set_cmp_func(POPENSSL_STACK(sk), OPENSSL_sk_compfunc(@compare)));
end;

{ DEFINE_STACK_OF(CONF_MODULE) Methoden }

function sk_CONF_MODULE_num(const sk: PSTACK_OF_CONF_MODULE): TIdC_INT;
begin
  result := OPENSSL_sk_num(POPENSSL_STACK(sk));
end;
function sk_CONF_MODULE_value(const sk: PSTACK_OF_CONF_MODULE; index: TIdC_INT): PCONF_MODULE;
begin
  result := PCONF_MODULE(OPENSSL_sk_value(POPENSSL_STACK(sk), index));
end;
function sk_CONF_MODULE_new(compare: sk_CONF_MODULE_compfunc): PSTACK_OF_CONF_MODULE;
begin
  result := PSTACK_OF_CONF_MODULE(OPENSSL_sk_new(OPENSSL_sk_compfunc(@compare)));
end;
function sk_CONF_MODULE_new_null(): PSTACK_OF_CONF_MODULE;
begin
  result := PSTACK_OF_CONF_MODULE(OPENSSL_sk_new_null());
end;
function sk_CONF_MODULE_new_reserve(compare: sk_CONF_MODULE_compfunc; n: TIdC_INT): PSTACK_OF_CONF_MODULE;
begin
  result := PSTACK_OF_CONF_MODULE(OPENSSL_sk_new_reserve(OPENSSL_sk_compfunc(@compare), n));
end;
function sk_CONF_MODULE_reserve(sk: PSTACK_OF_CONF_MODULE; n: TIdC_INT): TIdC_INT;
begin
  result := OPENSSL_sk_reserve(POPENSSL_STACK(sk), n);
end;
procedure sk_CONF_MODULE_free(sk: PSTACK_OF_CONF_MODULE);
begin
  OPENSSL_sk_free(POPENSSL_STACK(sk));
end;
procedure sk_CONF_MODULE_zero(sk: PSTACK_OF_CONF_MODULE);
begin
  OPENSSL_sk_zero(POPENSSL_STACK(sk));
end;
function sk_CONF_MODULE_delete(sk: PSTACK_OF_CONF_MODULE; i: TIdC_INT): PCONF_MODULE;
begin
  result := PCONF_MODULE(OPENSSL_sk_delete(POPENSSL_STACK(sk),i));
end;
function sk_CONF_MODULE_delete_ptr(sk: PSTACK_OF_CONF_MODULE; ptr: PCONF_MODULE): PCONF_MODULE;
begin
  result := PCONF_MODULE(OPENSSL_sk_delete_ptr(POPENSSL_STACK(sk),pointer(ptr)));
end;
function sk_CONF_MODULE_push(sk: PSTACK_OF_CONF_MODULE; ptr: PCONF_MODULE): TIdC_INT;
begin
  result := OPENSSL_sk_push(POPENSSL_STACK(sk),pointer(ptr));
end;
function sk_CONF_MODULE_unshift(sk: PSTACK_OF_CONF_MODULE; const ptr: PCONF_MODULE): TIdC_INT;
begin
  result := OPENSSL_sk_unshift(POPENSSL_STACK(sk),pointer(ptr));
end;
function sk_CONF_MODULE_pop(sk: PSTACK_OF_CONF_MODULE): PCONF_MODULE;
begin
  result := PCONF_MODULE(OPENSSL_sk_pop(POPENSSL_STACK(sk)));
end;
function sk_CONF_MODULE_shift(sk: PSTACK_OF_CONF_MODULE): PCONF_MODULE;
begin
  result := PCONF_MODULE(OPENSSL_sk_shift(POPENSSL_STACK(sk)));
end;
procedure sk_CONF_MODULE_pop_free(sk: PSTACK_OF_CONF_MODULE; freeFunc: sk_CONF_MODULE_freefunc);
begin
  OPENSSL_sk_pop_free(POPENSSL_STACK(sk), OPENSSL_sk_freefunc(@freeFunc) );
end;
function sk_CONF_MODULE_insert(sk: PSTACK_OF_CONF_MODULE; const ptr: PCONF_MODULE; idx: TIdC_INT): TIdC_INT;
begin
  result := OPENSSL_sk_insert(POPENSSL_STACK(sk), pointer(ptr), idx);
end;
function sk_CONF_MODULE_set(sk: PSTACK_OF_CONF_MODULE; idx: TIdC_INT; const ptr: PCONF_MODULE): PCONF_MODULE;
begin
  result := PCONF_MODULE(OPENSSL_sk_set(POPENSSL_STACK(sk), idx, pointer(ptr)));
end;
function sk_CONF_MODULE_find(sk: PSTACK_OF_CONF_MODULE; const ptr: PCONF_MODULE): TIdC_INT;
begin
  result := OPENSSL_sk_find(POPENSSL_STACK(sk), pointer(ptr));
end;
function sk_CONF_MODULE_find_ex(sk: PSTACK_OF_CONF_MODULE; const ptr: PCONF_MODULE): TIdC_INT;
begin
  result := OPENSSL_sk_find_ex(POPENSSL_STACK(sk), pointer(ptr));
end;
procedure sk_CONF_MODULE_sort(sk: PSTACK_OF_CONF_MODULE);
begin
  OPENSSL_sk_sort(POPENSSL_STACK(sk));
end;
function sk_CONF_MODULE_is_sorted(sk: PSTACK_OF_CONF_MODULE): TIdC_INT;
begin
  result:=OPENSSL_sk_is_sorted(POPENSSL_STACK(sk));
end;
function sk_CONF_MODULE_dup(const sk: PSTACK_OF_CONF_MODULE): PSTACK_OF_CONF_MODULE;
begin
  result:=PSTACK_OF_CONF_MODULE(OPENSSL_sk_dup(POPENSSL_STACK(sk)));
end;
function sk_CONF_MODULE_deep_copy(const sk: PSTACK_OF_CONF_MODULE; copyfunc: sk_CONF_MODULE_copyfunc; freefunc:sk_CONF_MODULE_freefunc): PSTACK_OF_CONF_MODULE;
begin
  result:=PSTACK_OF_CONF_MODULE(OPENSSL_sk_deep_copy(POPENSSL_STACK(sk),OPENSSL_sk_copyfunc(@copyfunc),OPENSSL_sk_freefunc(@freefunc)));
end;
function sk_CONF_MODULE_set_cmp_func(const sk: PSTACK_OF_CONF_MODULE; compare: sk_CONF_MODULE_compfunc): sk_CONF_MODULE_compfunc;
begin
  result:=sk_CONF_MODULE_compfunc(OPENSSL_sk_set_cmp_func(POPENSSL_STACK(sk), OPENSSL_sk_compfunc(@compare)));
end;

{ DEFINE_STACK_OF(CONF_IMODULE) Methoden }

function sk_CONF_IMODULE_num(const sk: PSTACK_OF_CONF_IMODULE): TIdC_INT;
begin
  result := OPENSSL_sk_num(POPENSSL_STACK(sk));
end;
function sk_CONF_IMODULE_value(const sk: PSTACK_OF_CONF_IMODULE; index: TIdC_INT): PCONF_IMODULE;
begin
  result := PCONF_IMODULE(OPENSSL_sk_value(POPENSSL_STACK(sk), index));
end;
function sk_CONF_IMODULE_new(compare: sk_CONF_IMODULE_compfunc): PSTACK_OF_CONF_IMODULE;
begin
  result := PSTACK_OF_CONF_IMODULE(OPENSSL_sk_new(OPENSSL_sk_compfunc(@compare)));
end;
function sk_CONF_IMODULE_new_null(): PSTACK_OF_CONF_IMODULE;
begin
  result := PSTACK_OF_CONF_IMODULE(OPENSSL_sk_new_null());
end;
function sk_CONF_IMODULE_new_reserve(compare: sk_CONF_IMODULE_compfunc; n: TIdC_INT): PSTACK_OF_CONF_IMODULE;
begin
  result := PSTACK_OF_CONF_IMODULE(OPENSSL_sk_new_reserve(OPENSSL_sk_compfunc(@compare), n));
end;
function sk_CONF_IMODULE_reserve(sk: PSTACK_OF_CONF_IMODULE; n: TIdC_INT): TIdC_INT;
begin
  result := OPENSSL_sk_reserve(POPENSSL_STACK(sk), n);
end;
procedure sk_CONF_IMODULE_free(sk: PSTACK_OF_CONF_IMODULE);
begin
  OPENSSL_sk_free(POPENSSL_STACK(sk));
end;
procedure sk_CONF_IMODULE_zero(sk: PSTACK_OF_CONF_IMODULE);
begin
  OPENSSL_sk_zero(POPENSSL_STACK(sk));
end;
function sk_CONF_IMODULE_delete(sk: PSTACK_OF_CONF_IMODULE; i: TIdC_INT): PCONF_IMODULE;
begin
  result := PCONF_IMODULE(OPENSSL_sk_delete(POPENSSL_STACK(sk),i));
end;
function sk_CONF_IMODULE_delete_ptr(sk: PSTACK_OF_CONF_IMODULE; ptr: PCONF_IMODULE): PCONF_IMODULE;
begin
  result := PCONF_IMODULE(OPENSSL_sk_delete_ptr(POPENSSL_STACK(sk),pointer(ptr)));
end;
function sk_CONF_IMODULE_push(sk: PSTACK_OF_CONF_IMODULE; ptr: PCONF_IMODULE): TIdC_INT;
begin
  result := OPENSSL_sk_push(POPENSSL_STACK(sk),pointer(ptr));
end;
function sk_CONF_IMODULE_unshift(sk: PSTACK_OF_CONF_IMODULE; const ptr: PCONF_IMODULE): TIdC_INT;
begin
  result := OPENSSL_sk_unshift(POPENSSL_STACK(sk),pointer(ptr));
end;
function sk_CONF_IMODULE_pop(sk: PSTACK_OF_CONF_IMODULE): PCONF_IMODULE;
begin
  result := PCONF_IMODULE(OPENSSL_sk_pop(POPENSSL_STACK(sk)));
end;
function sk_CONF_IMODULE_shift(sk: PSTACK_OF_CONF_IMODULE): PCONF_IMODULE;
begin
  result := PCONF_IMODULE(OPENSSL_sk_shift(POPENSSL_STACK(sk)));
end;
procedure sk_CONF_IMODULE_pop_free(sk: PSTACK_OF_CONF_IMODULE; freeFunc: sk_CONF_IMODULE_freefunc);
begin
  OPENSSL_sk_pop_free(POPENSSL_STACK(sk), OPENSSL_sk_freefunc(@freeFunc) );
end;
function sk_CONF_IMODULE_insert(sk: PSTACK_OF_CONF_IMODULE; const ptr: PCONF_IMODULE; idx: TIdC_INT): TIdC_INT;
begin
  result := OPENSSL_sk_insert(POPENSSL_STACK(sk), pointer(ptr), idx);
end;
function sk_CONF_IMODULE_set(sk: PSTACK_OF_CONF_IMODULE; idx: TIdC_INT; const ptr: PCONF_IMODULE): PCONF_IMODULE;
begin
  result := PCONF_IMODULE(OPENSSL_sk_set(POPENSSL_STACK(sk), idx, pointer(ptr)));
end;
function sk_CONF_IMODULE_find(sk: PSTACK_OF_CONF_IMODULE; const ptr: PCONF_IMODULE): TIdC_INT;
begin
  result := OPENSSL_sk_find(POPENSSL_STACK(sk), pointer(ptr));
end;
function sk_CONF_IMODULE_find_ex(sk: PSTACK_OF_CONF_IMODULE; const ptr: PCONF_IMODULE): TIdC_INT;
begin
  result := OPENSSL_sk_find_ex(POPENSSL_STACK(sk), pointer(ptr));
end;
procedure sk_CONF_IMODULE_sort(sk: PSTACK_OF_CONF_IMODULE);
begin
  OPENSSL_sk_sort(POPENSSL_STACK(sk));
end;
function sk_CONF_IMODULE_is_sorted(sk: PSTACK_OF_CONF_IMODULE): TIdC_INT;
begin
  result:=OPENSSL_sk_is_sorted(POPENSSL_STACK(sk));
end;
function sk_CONF_IMODULE_dup(const sk: PSTACK_OF_CONF_IMODULE): PSTACK_OF_CONF_IMODULE;
begin
  result:=PSTACK_OF_CONF_IMODULE(OPENSSL_sk_dup(POPENSSL_STACK(sk)));
end;
function sk_CONF_IMODULE_deep_copy(const sk: PSTACK_OF_CONF_IMODULE; copyfunc: sk_CONF_IMODULE_copyfunc; freefunc:sk_CONF_IMODULE_freefunc): PSTACK_OF_CONF_IMODULE;
begin
  result:=PSTACK_OF_CONF_IMODULE(OPENSSL_sk_deep_copy(POPENSSL_STACK(sk),OPENSSL_sk_copyfunc(@copyfunc),OPENSSL_sk_freefunc(@freefunc)));
end;
function sk_CONF_IMODULE_set_cmp_func(const sk: PSTACK_OF_CONF_IMODULE; compare: sk_CONF_IMODULE_compfunc): sk_CONF_IMODULE_compfunc;
begin
  result:=sk_CONF_IMODULE_compfunc(OPENSSL_sk_set_cmp_func(POPENSSL_STACK(sk), OPENSSL_sk_compfunc(@compare)));
end;




procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  CONF_set_default_method := LoadFunction('CONF_set_default_method', AFailed);
  NCONF_new := LoadFunction('NCONF_new', AFailed);
  NCONF_default := LoadFunction('NCONF_default', AFailed);
  NCONF_WIN32 := LoadFunction('NCONF_WIN32', AFailed);
  NCONF_free := LoadFunction('NCONF_free', AFailed);
  NCONF_free_data := LoadFunction('NCONF_free_data', AFailed);
  NCONF_load := LoadFunction('NCONF_load', AFailed);
  NCONF_load_bio := LoadFunction('NCONF_load_bio', AFailed);
  NCONF_get_string := LoadFunction('NCONF_get_string', AFailed);
  NCONF_get_number_e := LoadFunction('NCONF_get_number_e', AFailed);
  NCONF_dump_bio := LoadFunction('NCONF_dump_bio', AFailed);
  CONF_modules_load := LoadFunction('CONF_modules_load', AFailed);
  CONF_modules_load_file := LoadFunction('CONF_modules_load_file', AFailed);
  CONF_modules_unload := LoadFunction('CONF_modules_unload', AFailed);
  CONF_modules_finish := LoadFunction('CONF_modules_finish', AFailed);
  CONF_module_add := LoadFunction('CONF_module_add', AFailed);
  CONF_imodule_get_usr_data := LoadFunction('CONF_imodule_get_usr_data', AFailed);
  CONF_imodule_set_usr_data := LoadFunction('CONF_imodule_set_usr_data', AFailed);
  CONF_imodule_get_module := LoadFunction('CONF_imodule_get_module', AFailed);
  CONF_imodule_get_flags := LoadFunction('CONF_imodule_get_flags', AFailed);
  CONF_imodule_set_flags := LoadFunction('CONF_imodule_set_flags', AFailed);
  CONF_module_get_usr_data := LoadFunction('CONF_module_get_usr_data', AFailed);
  CONF_module_set_usr_data := LoadFunction('CONF_module_set_usr_data', AFailed);
  CONF_get1_default_config_file := LoadFunction('CONF_get1_default_config_file', AFailed);
  CONF_parse_list := LoadFunction('CONF_parse_list', AFailed);
  OPENSSL_load_builtin_modules := LoadFunction('OPENSSL_load_builtin_modules', AFailed);
end;

procedure UnLoad;
begin
  CONF_set_default_method := nil;
  NCONF_new := nil;
  NCONF_default := nil;
  NCONF_WIN32 := nil;
  NCONF_free := nil;
  NCONF_free_data := nil;
  NCONF_load := nil;
  NCONF_load_bio := nil;
  NCONF_get_string := nil;
  NCONF_get_number_e := nil;
  NCONF_dump_bio := nil;
  CONF_modules_load := nil;
  CONF_modules_load_file := nil;
  CONF_modules_unload := nil;
  CONF_modules_finish := nil;
  CONF_module_add := nil;
  CONF_imodule_get_usr_data := nil;
  CONF_imodule_set_usr_data := nil;
  CONF_imodule_get_module := nil;
  CONF_imodule_get_flags := nil;
  CONF_imodule_set_flags := nil;
  CONF_module_get_usr_data := nil;
  CONF_module_set_usr_data := nil;
  CONF_get1_default_config_file := nil;
  CONF_parse_list := nil;
  OPENSSL_load_builtin_modules := nil;
end;
end.
