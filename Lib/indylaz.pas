{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit indylaz;

interface

uses
  IdAboutVCL, IdAntiFreeze, IdCoreDsnRegister, IdDsnCoreResourceStrings, IdDsnPropEdBindingVCL, 
  IdDsnRegister, IdDsnResourceStrings, IdDsnSASLListEditorFormVCL, IdRegister, IdRegisterCore,
  IdRegisterOpenSSL, IdStreamVCL, IdStream, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('IdCoreDsnRegister', @IdCoreDsnRegister.Register);
  RegisterUnit('IdDsnRegister', @IdDsnRegister.Register);
  RegisterUnit('IdRegister', @IdRegister.Register);
  RegisterUnit('IdRegisterCore', @IdRegisterCore.Register);
  RegisterUnit('IdRegisterOpenSSL', @IdRegisterOpenSSL.Register);
end;

initialization
  RegisterPackage('indylaz', @Register);
end.
