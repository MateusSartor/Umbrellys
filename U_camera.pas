unit U_camera;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Media,
  FMX.StdCtrls, FMX.Objects,FMX.Platform.Android, ZXing.ScanManager, ZXing.ReadResult, ZXing.BarcodeFormat,
  FMX.Controls.Presentation;

type
  Tfrm_camera = class(TForm)
    CameraComponent: TCameraComponent;
    img_camera: TImage;
    lb_error: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CameraComponentSampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
      FScanManager :  TScanManager;
      FScanInProgress : boolean;
      FFrameTake : integer;
      procedure processarimagem;
    { Private declarations }
  public
    { Public declarations }
    codigo : string;
  end;

var
  frm_camera: Tfrm_camera;

implementation

{$R *.fmx}

uses U_principal, u99Permissions;
procedure Tfrm_camera.CameraComponentSampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
begin
      ProcessarImagem;
end;

procedure Tfrm_camera.FormCreate(Sender: TObject);
begin
     FScanManager :=  TScanManager.Create(TBarcodeFormat.Auto, nil);

end;

procedure Tfrm_camera.FormDestroy(Sender: TObject);
begin
     FScanManager.DisposeOf;
end;

procedure Tfrm_camera.FormShow(Sender: TObject);
begin
    FFrameTake := 0;
    CameraComponent.Active := false;
    CameraComponent.Kind := TCamerakind.BackCamera;
    CameraComponent.FocusMode := TFocusMode.ContinuousAutoFocus;
    CameraComponent.Quality := TVideoCaptureQuality.MediumQuality;
    CameraComponent.Active := true;
end;

procedure  Tfrm_camera.processarimagem;
        var
          bmp: TBitMap;
          ReadResult : TReadResult;
  begin
      CameraComponent.SampleBufferToBitmap(img_camera.Bitmap, true);
      if FScanInProgress then
        exit;

      inc(FFrameTake);

      if (FFrameTake mod 4 <> 0) then
        exit;

      bmp := TBitMap.Create;
      bmp.Assign(img_camera.Bitmap);

      ReadResult := nil;

      try
        FScanInProgress := true;
            try
                    ReadResult := FScanManager.Scan(bmp);

                      if ReadResult <> nil then
                      begin
                          CameraComponent.Active := false;
                          codigo := ReadResult.text;
                          close;
                      end;

            except on ex:exception do
                    lb_error.text := ex.Message;
            end;
      finally

         bmp.DisposeOf;
         readresult.DisposeOf;
         FScanInProgress := false;
      end;

  end;
end.
