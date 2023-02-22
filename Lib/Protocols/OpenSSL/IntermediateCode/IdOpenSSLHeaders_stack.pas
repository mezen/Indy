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
{        Originally written by: André Weber                                    }
{                               WeberAndre@gmx.de                              }
{                                                                              }
{        Contributers:                                                         }
{                                                                              }
{                                                                              }
{******************************************************************************}

unit IdOpenSSLHeaders_stack;

interface

// Headers for OpenSSL 1.1.1
// stack.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

type
 OPENSSL_sk_freefunc = procedure(item: pointer); cdecl;
 OPENSSL_sk_compfunc = function(const a, b: pointer): TIdC_INT; cdecl;
 OPENSSL_sk_copyfunc = function(const a: pointer): pointer; cdecl;

 OPENSSL_STACK = type of pointer;
 POPENSSL_STACK = ^OPENSSL_STACK;

var
 function OPENSSL_sk_num(const sk: POPENSSL_STACK): TIdC_INT;
 function OPENSSL_sk_value(const sk: POPENSSL_STACK; index: TIdC_INT): pointer;
 function OPENSSL_sk_new_null(): POPENSSL_STACK;
 function OPENSSL_sk_new( compFunc: OPENSSL_sk_compfunc ): POPENSSL_STACK;
 function OPENSSL_sk_new_reserve(compare: OPENSSL_sk_compfunc; n: TIdC_INT): POPENSSL_STACK;
 function OPENSSL_sk_reserve( sk: POPENSSL_STACK; n: TIdC_INT): TIdC_INT;
 procedure OPENSSL_sk_pop_free(const sk: POPENSSL_STACK; freefunc: OPENSSL_sk_freefunc );
 function OPENSSL_sk_push(const sk: POPENSSL_STACK; new_item: pointer): TIdC_INT;
 procedure OPENSSL_sk_free(sk: POPENSSL_STACK);
 procedure OPENSSL_sk_zero(const sk: POPENSSL_STACK);
 function OPENSSL_sk_delete(sk: POPENSSL_STACK; i: TIdC_INT): pointer;
 function OPENSSL_sk_delete_ptr(sk: POPENSSL_STACK; ptr: pointer): pointer;
 function OPENSSL_sk_unshift(sk: POPENSSL_STACK; const ptr: pointer): TIdC_INT;
 function OPENSSL_sk_pop(sk: POPENSSL_STACK): pointer;
 function OPENSSL_sk_shift(sk: POPENSSL_STACK): pointer;
 function OPENSSL_sk_insert(sk: POPENSSL_STACK; const ptr: pointer; idx: TIdC_INT): TIdC_INT;
 function OPENSSL_sk_set(sk: POPENSSL_STACK; idx: TIdC_INT; const ptr: pointer): pointer;
 function OPENSSL_sk_find(sk: POPENSSL_STACK; const ptr: pointer): TIdC_INT;
 function OPENSSL_sk_find_ex(sk: POPENSSL_STACK; const ptr: pointer): TIdC_INT;
 procedure OPENSSL_sk_sort(sk: POPENSSL_STACK);
 function OPENSSL_sk_is_sorted(sk: POPENSSL_STACK): TIdC_INT;
 function OPENSSL_sk_dup(const sk: POPENSSL_STACK): POPENSSL_STACK;
 function OPENSSL_sk_deep_copy(const sk: POPENSSL_STACK; copyfunc: OPENSSL_sk_copyfunc; freefunc: OPENSSL_sk_freefunc): POPENSSL_STACK;
 function OPENSSL_sk_set_cmp_func(const sk:POPENSSL_STACK; compare: OPENSSL_sk_compfunc): OPENSSL_sk_compfunc;

implementation

end.
