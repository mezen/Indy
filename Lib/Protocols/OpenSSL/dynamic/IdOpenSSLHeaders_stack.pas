// 22.08.2022 [AW]
// 26.08.2022 [AW]
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

// This File is auto generated!
// Any change to this file should be made in the
// corresponding unit in the folder "intermediate"!

// Generation date: 07.09.2022 11:33:03

unit IdOpenSSLHeaders_stack;

interface

// Headers for OpenSSL 1.1.1
// stack.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

type
 OPENSSL_sk_freefunc = procedure(item: pointer); cdecl;
 OPENSSL_sk_compfunc = function(const a, b: pointer): TIdC_INT; cdecl;
 OPENSSL_sk_copyfunc = function(const a: pointer): pointer; cdecl;

 OPENSSL_STACK = type of pointer;
 POPENSSL_STACK = ^OPENSSL_STACK;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
 OPENSSL_sk_num: function(const sk: POPENSSL_STACK): TIdC_INT cdecl = nil;
 OPENSSL_sk_value: function(const sk: POPENSSL_STACK; index: TIdC_INT): pointer cdecl = nil;
 OPENSSL_sk_new_null: function(): POPENSSL_STACK cdecl = nil;
 OPENSSL_sk_new: function( compFunc: OPENSSL_sk_compfunc ): POPENSSL_STACK cdecl = nil;
 OPENSSL_sk_new_reserve: function(compare: OPENSSL_sk_compfunc; n: TIdC_INT): POPENSSL_STACK cdecl = nil;
 OPENSSL_sk_reserve: function( sk: POPENSSL_STACK; n: TIdC_INT): TIdC_INT cdecl = nil;
 OPENSSL_sk_pop_free: procedure(const sk: POPENSSL_STACK; freefunc: OPENSSL_sk_freefunc ) cdecl = nil;
 OPENSSL_sk_push: function(const sk: POPENSSL_STACK; new_item: pointer): TIdC_INT cdecl = nil;
 OPENSSL_sk_free: procedure(sk: POPENSSL_STACK) cdecl = nil;
 OPENSSL_sk_zero: procedure(const sk: POPENSSL_STACK) cdecl = nil;
 OPENSSL_sk_delete: function(sk: POPENSSL_STACK; i: TIdC_INT): pointer cdecl = nil;
 OPENSSL_sk_delete_ptr: function(sk: POPENSSL_STACK; ptr: pointer): pointer cdecl = nil;
 OPENSSL_sk_unshift: function(sk: POPENSSL_STACK; const ptr: pointer): TIdC_INT cdecl = nil;
 OPENSSL_sk_pop: function(sk: POPENSSL_STACK): pointer cdecl = nil;
 OPENSSL_sk_shift: function(sk: POPENSSL_STACK): pointer cdecl = nil;
 OPENSSL_sk_insert: function(sk: POPENSSL_STACK; const ptr: pointer; idx: TIdC_INT): TIdC_INT cdecl = nil;
 OPENSSL_sk_set: function(sk: POPENSSL_STACK; idx: TIdC_INT; const ptr: pointer): pointer cdecl = nil;
 OPENSSL_sk_find: function(sk: POPENSSL_STACK; const ptr: pointer): TIdC_INT cdecl = nil;
 OPENSSL_sk_find_ex: function(sk: POPENSSL_STACK; const ptr: pointer): TIdC_INT cdecl = nil;
 OPENSSL_sk_sort: procedure(sk: POPENSSL_STACK) cdecl = nil;
 OPENSSL_sk_is_sorted: function(sk: POPENSSL_STACK): TIdC_INT cdecl = nil;
 OPENSSL_sk_dup: function(const sk: POPENSSL_STACK): POPENSSL_STACK cdecl = nil;
 OPENSSL_sk_deep_copy: function(const sk: POPENSSL_STACK; copyfunc: OPENSSL_sk_copyfunc; freefunc: OPENSSL_sk_freefunc): POPENSSL_STACK cdecl = nil;
 OPENSSL_sk_set_cmp_func: function(const sk:POPENSSL_STACK; compare: OPENSSL_sk_compfunc): OPENSSL_sk_compfunc cdecl = nil;

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  OPENSSL_sk_num := LoadFunction('OPENSSL_sk_num', AFailed);
  OPENSSL_sk_value := LoadFunction('OPENSSL_sk_value', AFailed);
  OPENSSL_sk_new_null := LoadFunction('OPENSSL_sk_new_null', AFailed);
  OPENSSL_sk_new := LoadFunction('OPENSSL_sk_new', AFailed);
  OPENSSL_sk_new_reserve := LoadFunction('OPENSSL_sk_new_reserve', AFailed);
  OPENSSL_sk_reserve := LoadFunction('OPENSSL_sk_reserve', AFailed);
  OPENSSL_sk_pop_free := LoadFunction('OPENSSL_sk_pop_free', AFailed);
  OPENSSL_sk_push := LoadFunction('OPENSSL_sk_push', AFailed);
  OPENSSL_sk_free := LoadFunction('OPENSSL_sk_free', AFailed);
  OPENSSL_sk_zero := LoadFunction('OPENSSL_sk_zero', AFailed);
  OPENSSL_sk_delete := LoadFunction('OPENSSL_sk_delete', AFailed);
  OPENSSL_sk_delete_ptr := LoadFunction('OPENSSL_sk_delete_ptr', AFailed);
  OPENSSL_sk_unshift := LoadFunction('OPENSSL_sk_unshift', AFailed);
  OPENSSL_sk_pop := LoadFunction('OPENSSL_sk_pop', AFailed);
  OPENSSL_sk_shift := LoadFunction('OPENSSL_sk_shift', AFailed);
  OPENSSL_sk_insert := LoadFunction('OPENSSL_sk_insert', AFailed);
  OPENSSL_sk_set := LoadFunction('OPENSSL_sk_set', AFailed);
  OPENSSL_sk_find := LoadFunction('OPENSSL_sk_find', AFailed);
  OPENSSL_sk_find_ex := LoadFunction('OPENSSL_sk_find_ex', AFailed);
  OPENSSL_sk_sort := LoadFunction('OPENSSL_sk_sort', AFailed);
  OPENSSL_sk_is_sorted := LoadFunction('OPENSSL_sk_is_sorted', AFailed);
  OPENSSL_sk_dup := LoadFunction('OPENSSL_sk_dup', AFailed);
  OPENSSL_sk_deep_copy := LoadFunction('OPENSSL_sk_deep_copy', AFailed);
  OPENSSL_sk_set_cmp_func := LoadFunction('OPENSSL_sk_set_cmp_func', AFailed);
end;

procedure UnLoad;
begin
  OPENSSL_sk_num := nil;
  OPENSSL_sk_value := nil;
  OPENSSL_sk_new_null := nil;
  OPENSSL_sk_new := nil;
  OPENSSL_sk_new_reserve := nil;
  OPENSSL_sk_reserve := nil;
  OPENSSL_sk_pop_free := nil;
  OPENSSL_sk_push := nil;
  OPENSSL_sk_free := nil;
  OPENSSL_sk_zero := nil;
  OPENSSL_sk_delete := nil;
  OPENSSL_sk_delete_ptr := nil;
  OPENSSL_sk_unshift := nil;
  OPENSSL_sk_pop := nil;
  OPENSSL_sk_shift := nil;
  OPENSSL_sk_insert := nil;
  OPENSSL_sk_set := nil;
  OPENSSL_sk_find := nil;
  OPENSSL_sk_find_ex := nil;
  OPENSSL_sk_sort := nil;
  OPENSSL_sk_is_sorted := nil;
  OPENSSL_sk_dup := nil;
  OPENSSL_sk_deep_copy := nil;
  OPENSSL_sk_set_cmp_func := nil;
end;

end.
