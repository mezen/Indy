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
{                               André Weber (WeberAndre@gmx.de)                }
{                                                                              }
{******************************************************************************}

program GenerateCode;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.Classes,
  System.IOUtils,
  System.StrUtils,
  System.SysUtils,
  System.Types,
  Winapi.Windows,
  GenerateStack;

type
  TGenerateMode = (gmDynamic, gmStatic);

function ExpandEnvironmentVariables(const AValue: string): string;
const
  MAX_LENGTH = 32767;
begin
  SetLength(Result, MAX_LENGTH);
  SetLength(Result, ExpandEnvironmentStrings(@AValue[1], @Result[1], MAX_LENGTH)-1);
end;

function ReplaceStatic(const ALine: string; const AShouldUseLibSSL: Boolean): string;
const
  CSemicolon: string = ';';
var
  i: Integer;
begin
  Result := ALine;
  i := Result.LastIndexOf(CSemicolon);
  if i = -1 then
    Exit;
  Result := Result.Remove(i, CSemicolon.Length);
  Result := Result.Insert(i, Format(' cdecl; external %s;', [IfThen(AShouldUseLibSSL, 'CLibSSL', 'CLibCrypto')]));
end;

function ReplaceDynamic(const ALine: string; const AMethodList: TStringList): string;
var
  i: Integer;
  LMethodPrefix: string;
  LMethod: string;
begin
  Result := ALine;

  if not Result.TrimLeft.StartsWith('function') and not Result.TrimLeft.StartsWith('procedure') then
    Exit;

  LMethodPrefix := 'function';
  i := Result.IndexOf(LMethodPrefix);
  if i = -1 then
  begin
    LMethodPrefix := 'procedure';
    i := Result.IndexOf(LMethodPrefix);
    if i = -1 then
      Exit;
  end;

  // Remove LMethodPrefix
  Result := Result.Remove(i, LMethodPrefix.Length + string(' ').Length);
  // Keep Result for method name extracting later
  LMethod := Result.TrimLeft();
  // Add LMethodPrefix after parameters
  if Result.Contains(')') then
    Result := Result.Replace('(', ': ' + LMethodPrefix + '(')
  // No Params? Add LMethodPrefix after before return type
  else if Result.Contains(': ') then
    Result := Result.Replace(': ', ': ' + LMethodPrefix + ': ')
  // Also no return type? Add LMethodPrefix before semi colon
  else
    Result := Result.Replace(';', ': ' + LMethodPrefix + ';');

  if Result[Result.Length] = ';' then
    Result := Result.Remove(Result.Length-1) + ' cdecl = nil;';

  // Ignore comments
  i := LMethod.IndexOf('}');
  if i > -1 then
    // +1 for including } and Trim for removing whitespace of intendation
    LMethod := LMethod.Substring(i + 1{, LMethod.Length - i}).TrimLeft;
  i := LMethod.IndexOf(';');
  if i > -1 then
    LMethod := LMethod.Remove(i);
  i := LMethod.IndexOf(' ');
  if i > -1 then
    LMethod := LMethod.Remove(i);
  i := LMethod.IndexOf(':');
  if i > -1 then
    LMethod := LMethod.Remove(i);
  i := LMethod.IndexOf('(');
  if i > -1 then
    LMethod := LMethod.Remove(i);
  AMethodList.Add(LMethod);
end;

procedure AddDynamicLoadingMethods(
  const AFile: TStringList;
  const AMethods: TStringList;
  const AUsesIndex: Integer;
  const AVarIndex: Integer;
  const AImplementationIndex: Integer);

  procedure Insert(const AList: TStringList; const s: string; var Index: Integer);
  begin
    AList.Insert(Index, s);
    Inc(Index);
  end;

  function Find(const AList: TStringList; const s: string; var Index: Integer; const AOffset: Integer = 0): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := AOffset to AList.Count - 1 do
    begin
      if AList[i].Contains(s) then
      begin
        Index := i;
        Exit(True);
      end;
    end;
  end;

var
  LOffset: Integer;
  LMethod: string;
begin
  if AImplementationIndex = -1 then
    Exit;

  // some intermediate files, don't generate dyn. loaded methods
  if AMethods.Count = 0 then exit;
  LOffset := AImplementationIndex + 1;

  if Find(AFile, 'uses', LOffset, LOffset) then
    if Find(AFile, ';', LOffset, LOffset) then
      Inc(LOffset);

  Insert(AFile, '', LOffset);
  Insert(AFile, 'procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);', LOffset);
  Insert(AFile, '', LOffset);
  Insert(AFile, '  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;', LOffset);
  Insert(AFile, '  begin', LOffset);
  Insert(AFile, '    Result := LoadLibFunction(ADllHandle, AMethodName);', LOffset);
  Insert(AFile, '    if not Assigned(Result) then', LOffset);
  Insert(AFile, '      AFailed.Add(AMethodName);', LOffset);
  Insert(AFile, '  end;', LOffset);
  Insert(AFile, '', LOffset);
  Insert(AFile, 'begin', LOffset);
  for LMethod in AMethods do
    Insert(AFile, Format('  %0:s := LoadFunction(''%0:s'', AFailed);', [LMethod]), LOffset);
  Insert(AFile, 'end;', LOffset);
  Insert(AFile, '', LOffset);


  Insert(AFile, 'procedure UnLoad;', LOffset);
  Insert(AFile, 'begin', LOffset);
  for LMethod in AMethods do
    Insert(AFile, Format('  %s := nil;', [LMethod]), LOffset);
  Insert(AFile, 'end;', LOffset);

  if AVarIndex = -1 then
    Exit;
  LOffSet := Pred(AVarIndex);
  Insert(AFile, '', LOffSet);
  Insert(AFile, 'procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);', LOffSet);
  Insert(AFile, 'procedure UnLoad;', LOffSet);

  LOffSet := Succ(AUsesIndex);
  Insert(AFile, '  Classes,', LOffset);
//  AFile.Insert(Pred(AVarIndex), 'function Load(const ADllHandle: THandle): TArray<string>;');
end;

function ShouldSkipLine(ALine: string): Boolean;
begin
  ALine := ALine.Trim;
  Result := ALine.IsEmpty;
  Result := Result or ALine.StartsWith('//');
  Result := Result or ALine.StartsWith('(*');
  Result := Result or ALine.StartsWith('*');
end;

function ReadParameters(out ASource: string; out ATarget: string; out AMode: TGenerateMode): Boolean;
var
  LMode: string;
begin
  Result := True;
  if not FindCmdLineSwitch('Source', ASource) then
  begin
    Writeln('No source folder!');
    Exit(False);
  end;
  ASource := ExpandEnvironmentVariables(ASource);

  if not FindCmdLineSwitch('Target', ATarget) then
  begin
    Writeln('No target folder!');
    Exit(False);
  end;
  ATarget := ExpandEnvironmentVariables(ATarget);

  if not FindCmdLineSwitch('Mode', LMode) then
  begin
    Writeln('No mode!');
    Exit(False);
  end;

  if LMode = 'dynamic' then
    AMode := gmDynamic
  else if LMode = 'static' then
    AMode := gmStatic
  else
  begin
    Writeln('Invalid mode! Use "dynamic" or "static"!');
    Exit(False);
  end;
end;

procedure AddGeneratedHeader(const AFile: TStringList);

  function Find(const AList: TStringList; const s: string; var Index: Integer): Boolean;
  var
    i: Integer;
  begin
    Index := -1;
    Result := False;
    for i := 0 to AList.Count-1 do
      if AList[i].Contains(s) then
      begin
        Index := i;
        Exit(True);
      end;
  end;

const
  CHeader: array[0..4] of string =
  (
   '',
   '// This File is auto generated!',
   '// Any change to this file should be made in the',
   '// corresponding unit in the folder "intermediate"!',
   ''
  );
var
  i: Integer;
  LOffset: Integer;
begin
  if not Find(AFile, 'unit ', LOffset) then
    Exit;
  // Keep a empty line before "unit"
  Dec(LOffset);
  for i := Low(CHeader) to High(CHeader) do
    AFile.Insert(i + LOffset, CHeader[i]);
  // this makes comparing - merging - more complicated as it must be ;)
  // AFile.Insert(Length(CHeader) + LOffset, '// Generation date: ' + DateTimeToStr(Now()));
end;

procedure Main;
var
  LFile: string;
  LStringListFile: TStringList;
  j, i: Integer;
  LVarIndex: Integer;
  LUsesIndex: Integer;
  LImplementationIndex: Integer;
  LSource: string;
  LTarget: string;
  LMode: TGenerateMode;
  LStringListMethods: TStringList;
  LFileName: string;
  LLine, LCodeLine: string;
  LDefine, LStackType: string;
  LStackPrototypes: TStringList;
  LStackCode: TStringList;
  LShouldUseLibSSL: Boolean;

  procedure InsertLine(const line: string);
  begin
    LStringListFile.Insert(i, '  '+line);
    inc(i);
  end;

begin
  if not ReadParameters(LSource, LTarget, LMode) then
  begin
    Readln;
    Exit;
  end;

  for LFile in TDirectory.GetFiles(LSource, '*.pas') do
  begin
    Writeln('Converting ' + LFile);
    LFileName := TPath.GetFileName(LFile);
    LStackCode := TStringList.Create();
    LStackPrototypes := TStringList.Create();
    LStringListFile := TStringList.Create();
    LStringListMethods := TStringList.Create();
    try
      LStringListFile.LoadFromFile(LFile);
      LUsesIndex := -1;
      LVarIndex := -1;
      LImplementationIndex := -1;
      LShouldUseLibSSL := MatchText(LFileName,
        ['IdOpenSSLHeaders_ssl.pas', 'IdOpenSSLHeaders_sslerr.pas', 'IdOpenSSLHeaders_tls1.pas']);


      i := 0;
      while i < LStringListFile.Count do
      begin
        LLine := LStringListFile[i];
        // Find first uses
        if (LVarIndex = -1) and (LUsesIndex = -1) then
          if LLine.StartsWith('uses') then
            LUsesIndex := i;

        if ShouldSkipLine(LLine) and (LVarIndex = -1) then
        begin
          LDefine := LLine.Trim;
          // //DEFINE_STACK_OF(X509)
          if LDefine.StartsWith('//') then
             LDefine := copy(LDefine,3,length(LDefine))
          else
          if (LDefine.StartsWith('{') and LDefine.EndsWith('}')) then
             LDefine := copy(LDefine,2,length(LLine)-2)
          else
          if (LDefine.StartsWith('(*') and LDefine.EndsWith('*)')) then
             LDefine := copy(LDefine,3,length(LDefine)-4)
          else
             LDefine := '';
          LDefine := LDefine.Trim;

          if LDefine.StartsWith('typedef ') and LDefine.EndsWith(';') then
          begin
            // typedef STACK_OF(POLICY_MAPPING) POLICY_MAPPINGS;
            delete( LDefine, 1, 8);
            LDefine := LDefine.Trim;
            // STACK_OF(POLICY_MAPPING) POLICY_MAPPINGS;
            if LDefine.StartsWith('STACK_OF(') then
            begin
              delete( LDefine, 1, 9);
              LDefine := LDefine.Trim;
              // POLICY_MAPPING) POLICY_MAPPINGS;
              j := pos(')',LDefine);
              if j > 0 then
              begin
                LStackType := Copy(LDefine, 1, j - 1);
                Delete(LDefine, 1, j);
                LDefine := LDefine.Trim;
                // POLICY_MAPPINGS;
                if length(LDefine) > 0 then
                begin
                  if LDefine[length(LDefine)] = ';' then delete(LDefine,length(LDefine),1);
                  LDefine := LDefine.Trim;
                  // POLICY_MAPPINGS
                  inc(i);
                  InsertLine(format('%s = STACK_OF_%s;',[LDefine, LStackType]));
                  InsertLine(format('P%s = PSTACK_OF_%s;',[LDefine, LStackType]));
                  continue;
                end;
              end;
            end;
          end else
          if LDefine.StartsWith('DEFINE_STACK_OF(') and LDefine.EndsWith(')') then
          begin

            LStackType := Copy(LDefine, 17, MAXINT);
            j := pos(')',LStackType);
            if j > 0 then
            begin
              delete(LStackType, j, MAXINT);
              LStackType := LStackType.Trim;
              if LStackType <> '' then
              begin
                GenerateStackCode( LStackType, LStringListFile, i, LStackPrototypes, LStackCode );
                continue;
              end;
            end;
          end;
        end;

        // var block found?
        if (LVarIndex = -1) and LLine.StartsWith('var') then
          LVarIndex := i;

        // No need to go further than "implementation"
        if LLine = 'implementation' then
        begin
          LImplementationIndex := i;
          Break;
        end;

        // Skip until we find the var block
        if (LVarIndex = -1) or ShouldSkipLine(LLine) then
        begin
          inc(i);
          Continue;
        end;
        // No need to go further than "implementation"
        // if LLine = 'implementation' then
        // begin
        //   LImplementationIndex := i;
        //   Break;
        // end;

        case LMode of
          gmDynamic:
            LStringListFile[i] := ReplaceDynamic(LStringListFile[i], LStringListMethods);
          gmStatic:
            LStringListFile[i] := ReplaceStatic(LStringListFile[i], LShouldUseLibSSL);
        end;
        inc(i);
      end;

      if LStackCode.Count > 0 then
      begin
        // insert function prototype before implementation ...
        for i := 0 to LStackPrototypes.Count - 1 do
        begin
          LStringListFile.Insert(LImplementationIndex, LStackPrototypes[i]);
          inc(LImplementationIndex);
        end;
        inc(LImplementationIndex); // skip <implementation>
        LStringListFile.Insert(LImplementationIndex,''); inc(LImplementationIndex);
        for i := 0 to LStackCode.Count - 1 do
        begin
          LStringListFile.Insert(LImplementationIndex,LStackCode[i]);
          inc(LImplementationIndex);
        end;

        LStringListFile.Insert(LImplementationIndex,'');
        inc(LImplementationIndex);
      end;

      case LMode of
        gmDynamic:
          AddDynamicLoadingMethods(LStringListFile, LStringListMethods, LUsesIndex, LVarIndex, LImplementationIndex);
        gmStatic:
          if LVarIndex > -1 then
            LStringListFile.Delete(LVarIndex);
      end;

      AddGeneratedHeader(LStringListFile);

      LStringListFile.SaveToFile(TPath.Combine(LTarget, LFileName));
    finally
      LStringListMethods.Free();
      LStringListFile.Free();
      LStackCode.Free();
      LStackPrototypes.Free();
    end;
  end;
end;

begin
  try
    Main;
    Writeln('done');
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
    end;
  end;
//  Readln;
end.
