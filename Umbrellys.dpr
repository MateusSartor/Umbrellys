program Umbrellys;

uses
  System.StartUpCopy,
  FMX.Forms,
  U_principal in 'U_principal.pas' {Form1},
  u99Permissions in 'u99Permissions.pas',
  U_camera in 'U_camera.pas' {frm_camera};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tfrm_camera, frm_camera);
  Application.Run;
end.

