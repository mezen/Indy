unit IdOpenSSLConsts;

interface

{$i IdCompilerDefines.inc}

const
  CLibCryptoRaw = 'libcrypto';
  CLibSSLRaw = 'libssl';

  SSLDLLVers: array [0..2] of string = ('', '.1.1', '.3.0');

{$IFDEF OPENSSL3}
  CLibCrypto =
    {$IFDEF CPU32}CLibCryptoRaw + '-3.dll'{$ENDIF}
    {$IFDEF CPU64}CLibCryptoRaw + '-3-x64.dll'{$ENDIF}
    ;
  CLibSSL =
    {$IFDEF CPU32}CLibSSLRaw + '-3.dll'{$ENDIF}
    {$IFDEF CPU64}CLibSSLRaw + '-3-x64.dll'{$ENDIF}
    ;
{$ELSE}
  CLibCrypto =
    {$IFDEF CPU32}CLibCryptoRaw + '-1_1.dll'{$ENDIF}
    {$IFDEF CPU64}CLibCryptoRaw + '-1_1-x64.dll'{$ENDIF}
    ;
  CLibSSL =
    {$IFDEF CPU32}CLibSSLRaw + '-1_1.dll'{$ENDIF}
    {$IFDEF CPU64}CLibSSLRaw + '-1_1-x64.dll'{$ENDIF}
    ;
{$ENDIF}

implementation

end.
