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
{                               WeberAndre@gmx.de (German & English)           }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}
unit GenerateStack;

interface

uses
  System.Classes, System.SysUtils;

{ expands DEFINE_STACK_OF(...) C macro to delphi wrapper functions}
procedure GenerateStackCode(const DataType: string;
                            StringListFile: TStringList; var StringListIndex: integer;
                            Prototypes: TStringList;
                            Code: TStringList);

implementation

const
  useInLine = '{$ifdef USE_INLINE} inline;{$endif}';

procedure GenerateStackCode(const DataType: string;
                            StringListFile: TStringList; var StringListIndex: integer;
                            Prototypes: TStringList;
                            Code: TStringList);

  procedure InsertLine(const line: string);
  begin
    StringListFile.Insert(StringListIndex, '  '+line);
    inc(StringListIndex);
  end;
  var
    LCodeLine: string;
begin
  inc(StringListIndex); // I = DEFINE_STACK_OF(...)
  Writeln('-> DEFINE_STACK_OF(', dataType ,')');

  Code.Add( format('{ DEFINE_STACK_OF(%s) Methoden }',[dataType] ));
  Code.Add('');

  InsertLine( format('STACK_OF_%0:s = type of pointer;',[DataType]) );
  InsertLine( format('PSTACK_OF_%0:s = ^STACK_OF_%0:s;',[DataType]) );

  // typedef int (*sk_##t1##_compfunc)(const t3 * const *a, const t3 *const *b); \
  InsertLine( format('sk_%0:s_compfunc = function(const a: P%0:s; const b: P%0:s): TIdC_INT; cdecl;',[DataType]) );
  // typedef void (*sk_##t1##_freefunc)(t3 *a); \
  InsertLine( format('sk_%0:s_freefunc = procedure(a: P%0:s); cdecl;',[DataType]) );
  // typedef t3 * (*sk_##t1##_copyfunc)(const t3 *a); \
  InsertLine( format('sk_%0:s_copyfunc = function(const a: P%0:s): P%0:s; cdecl;',[DataType]) );

  // function OPENSSL_sk_num(const stack:PStack_st): TIdC_INT;
  LCodeLine := format('function sk_%0:s_num(const sk: PSTACK_OF_%0:s): TIdC_INT;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add('  result := OPENSSL_sk_num(POPENSSL_STACK(sk));');
  Code.Add('end;');

  // function OPENSSL_sk_value(const stack: PStack_st; index: TIdC_INT): pointer;
  LCodeLine := format('function sk_%0:s_value(const sk: PSTACK_OF_%0:s; index: TIdC_INT): P%0:s;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := P%0:s(OPENSSL_sk_value(POPENSSL_STACK(sk), index));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_new( compFunc: TPENSSL_sk_compfunc ): PStack_st;
  LCodeLine := format('function sk_%0:s_new(compare: sk_%0:s_compfunc): PSTACK_OF_%0:s;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := PSTACK_OF_%0:s(OPENSSL_sk_new(OPENSSL_sk_compfunc(@compare)));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_new_null(): PStack_st
  LCodeLine := format('function sk_%0:s_new_null(): PSTACK_OF_%0:s;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := PSTACK_OF_%0:s(OPENSSL_sk_new_null());',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_new_reserve(compare: OPENSSL_sk_compfunc; n:TIdC_INT): PStack_st;
  LCodeLine := format('function sk_%0:s_new_reserve(compare: sk_%0:s_compfunc; n: TIdC_INT): PSTACK_OF_%0:s;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := PSTACK_OF_%0:s(OPENSSL_sk_new_reserve(OPENSSL_sk_compfunc(@compare), n));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_reserve( stack: PStack_st; n: TIdC_INT): TIdC_INT;
  LCodeLine := format('function sk_%0:s_reserve(sk: PSTACK_OF_%0:s; n: TIdC_INT): TIdC_INT;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := OPENSSL_sk_reserve(POPENSSL_STACK(sk), n);',[DataType]));
  Code.Add('end;');

  // procedure OPENSSL_sk_free(const stack:PStack_st);
  LCodeLine := format('procedure sk_%0:s_free(sk: PSTACK_OF_%0:s);',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add('  OPENSSL_sk_free(POPENSSL_STACK(sk));');
  Code.Add('end;');

  // procedure OPENSSL_sk_zero(const stack:PStack_st);
  LCodeLine := format('procedure sk_%0:s_zero(sk: PSTACK_OF_%0:s);',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add('  OPENSSL_sk_zero(POPENSSL_STACK(sk));');
  Code.Add('end;');

  // function OPENSSL_sk_delete(sk: POPENSSL_STACK; i: TIdC_INT): pointer;
  LCodeLine := format('function sk_%0:s_delete(sk: PSTACK_OF_%0:s; i: TIdC_INT): P%0:s;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := P%0:s(OPENSSL_sk_delete(POPENSSL_STACK(sk),i));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_delete_ptr(sk: POPENSSL_STACK; ptr: pointer): pointer;
  LCodeLine := format('function sk_%0:s_delete_ptr(sk: PSTACK_OF_%0:s; ptr: P%0:s): P%0:s;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := P%0:s(OPENSSL_sk_delete_ptr(POPENSSL_STACK(sk),pointer(ptr)));',[DataType]));
  Code.Add('end;');

  //  function OPENSSL_sk_push(const sk:POPENSSL_STACK; new_item: pointer): TIdC_INT;
  LCodeLine := format('function sk_%0:s_push(sk: PSTACK_OF_%0:s; ptr: P%0:s): TIdC_INT;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := OPENSSL_sk_push(POPENSSL_STACK(sk),pointer(ptr));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_unshift(sk: POPENSSL_STACK; const ptr: pointer): TIdC_INT;
  LCodeLine := format('function sk_%0:s_unshift(sk: PSTACK_OF_%0:s; const ptr: P%0:s): TIdC_INT;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := OPENSSL_sk_unshift(POPENSSL_STACK(sk),pointer(ptr));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_pop(sk: POPENSSL_STACK): pointer;
  LCodeLine := format('function sk_%0:s_pop(sk: PSTACK_OF_%0:s): P%0:s;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := P%0:s(OPENSSL_sk_pop(POPENSSL_STACK(sk)));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_shift(sk: POPENSSL_STACK): pointer;
  LCodeLine := format('function sk_%0:s_shift(sk: PSTACK_OF_%0:s): P%0:s;',[DataType]);
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := P%0:s(OPENSSL_sk_shift(POPENSSL_STACK(sk)));',[DataType]));
  Code.Add('end;');

  // procedure OPENSSL_sk_pop_free(const stack:PStack_st; freefunc: OPENSSL_sk_freefunc );
  LCodeLine := format('procedure sk_%0:s_pop_free(sk: PSTACK_OF_%0:s; freeFunc: sk_%0:s_freefunc);',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add('  OPENSSL_sk_pop_free(POPENSSL_STACK(sk), OPENSSL_sk_freefunc(@freeFunc) );');
  Code.Add('end;');

  // function OPENSSL_sk_insert(sk: POPENSSL_STACK; const ptr: pointer; idx: TIdC_INT): TIdC_INT;
  LCodeLine := format('function sk_%0:s_insert(sk: PSTACK_OF_%0:s; const ptr: P%0:s; idx: TIdC_INT): TIdC_INT;',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add('  result := OPENSSL_sk_insert(POPENSSL_STACK(sk), pointer(ptr), idx);');
  Code.Add('end;');

  // function OPENSSL_sk_set(sk: POPENSSL_STACK; idx: TIdC_INT; const ptr: pointer): pointer;
  LCodeLine := format('function sk_%0:s_set(sk: PSTACK_OF_%0:s; idx: TIdC_INT; const ptr: P%0:s): P%0:s;',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result := P%0:s(OPENSSL_sk_set(POPENSSL_STACK(sk), idx, pointer(ptr)));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_find(sk: POPENSSL_STACK; const ptr: pointer): TIdC_INT;
  LCodeLine := format('function sk_%0:s_find(sk: PSTACK_OF_%0:s; const ptr: P%0:s): TIdC_INT;',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add('  result := OPENSSL_sk_find(POPENSSL_STACK(sk), pointer(ptr));');
  Code.Add('end;');

  // function OPENSSL_sk_find_ex(sk: POPENSSL_STACK; const ptr: pointer): TIdC_INT;
  LCodeLine := format('function sk_%0:s_find_ex(sk: PSTACK_OF_%0:s; const ptr: P%0:s): TIdC_INT;',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add('  result := OPENSSL_sk_find_ex(POPENSSL_STACK(sk), pointer(ptr));');
  Code.Add('end;');

  // procedure OPENSSL_sk_sort(sk: POPENSSL_STACK);
  LCodeLine := format('procedure sk_%0:s_sort(sk: PSTACK_OF_%0:s);',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add('  OPENSSL_sk_sort(POPENSSL_STACK(sk));');
  Code.Add('end;');

  // function OPENSSL_sk_is_sorted(sk: POPENSSL_STACK): TIdC_INT;
  LCodeLine := format('function sk_%0:s_is_sorted(sk: PSTACK_OF_%0:s): TIdC_INT;',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add('  result:=OPENSSL_sk_is_sorted(POPENSSL_STACK(sk));');
  Code.Add('end;');

  // function OPENSSL_sk_dup(const sk:POPENSSL_STACK): POPENSSL_STACK;
  LCodeLine := format('function sk_%0:s_dup(const sk: PSTACK_OF_%0:s): PSTACK_OF_%0:s;',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result:=PSTACK_OF_%0:s(OPENSSL_sk_dup(POPENSSL_STACK(sk)));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_deep_copy(const sk:POPENSSL_STACK; copyfunc:OPENSSL_sk_copyfunc: freefunc:OPENSSL_sk_freefunc): POPENSSL_STACK;
  LCodeLine := format('function sk_%0:s_deep_copy(const sk: PSTACK_OF_%0:s; copyfunc: sk_%0:s_copyfunc; freefunc:sk_%0:s_freefunc): PSTACK_OF_%0:s;',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result:=PSTACK_OF_%0:s(OPENSSL_sk_deep_copy(POPENSSL_STACK(sk),OPENSSL_sk_copyfunc(@copyfunc),OPENSSL_sk_freefunc(@freefunc)));',[DataType]));
  Code.Add('end;');

  // function OPENSSL_sk_set_cmp_func(const sk:POPENSSL_STACK; compare: OPENSSL_sk_compfunc): OPENSSL_sk_compfunc;
  LCodeLine := format('function sk_%0:s_set_cmp_func(const sk: PSTACK_OF_%0:s; compare: sk_%0:s_compfunc): sk_%0:s_compfunc;',[DataType]) ;
  Prototypes.Add( LCodeLine + useInLine );
  Code.Add( LCodeLine );
  Code.Add('begin');
  Code.Add(format('  result:=sk_%0:s_compfunc(OPENSSL_sk_set_cmp_func(POPENSSL_STACK(sk), OPENSSL_sk_compfunc(@compare)));',[DataType]));
  Code.Add('end;');
  Code.Add('');

  Prototypes.add('');
  Writeln('done');
end;


end.
