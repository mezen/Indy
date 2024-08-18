unit IdRegisterOpenSSL;

interface

{$i IdCompilerDefines.inc}

procedure Register;

implementation

uses
  IdOpenSSLOptionsClient,
  IdOpenSSLOptions,
  IdOpenSSLOptionsServer,
  IdOpenSSLConsts,
  IdOpenSSLPersistent,
  IdOpenSSLContextClient,
  IdOpenSSLSocketClient,
  IdOpenSSLContext,                   
  IdOpenSSLSocket,
  IdOpenSSLContextServer,             
  IdOpenSSLSocketServer,
  IdOpenSSLExceptionResourcestrings,
  IdOpenSSLTypes,
  IdOpenSSLExceptions,
  IdOpenSSLUtils,
  IdOpenSSLIOHandlerClientBase,
  IdOpenSSLVersion,
  IdOpenSSLIOHandlerClient,          
  IdOpenSSLX509,
  IdOpenSSLIOHandlerClientServer,
  IdOpenSSLIOHandlerServer,
  IdOpenSSLLoader;

procedure Register;
begin
  // TODO:
end;

end.
