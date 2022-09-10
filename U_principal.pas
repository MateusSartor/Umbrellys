unit U_principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Maps,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Objects, FMX.Ani,
  System.Sensors, System.Sensors.Components,FMX.Layouts, FMX.WebBrowser,
  System.Permissions,FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList, FMX.StdActns;

type
  TForm1 = class(TForm)
    MapView1: TMapView;
    SpeedButton1: TSpeedButton;
    Rectangle1: TRectangle;
    SpeedButton2: TSpeedButton;
    Edit1: TEdit;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    RoundRect1: TRoundRect;
    Panel1: TPanel;
    Panel2: TPanel;
    btn_pedir: TButton;
    LocationSensor1: TLocationSensor;
    ActionList1: TActionList;
    ActPhotoCamera: TTakePhotoFromCameraAction;
    ActPhotoLibrary: TTakePhotoFromLibraryAction;
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure FormActivate(Sender: TObject);
    procedure btn_pedirClick(Sender: TObject);
  private
    { Private declarations }
      {$IFDEF ANDROID}
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage : string;
      {$ENDIF}

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
 Uses FMX.DialogService
  {$IFDEF ANDROID}
  ,Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
  {$ENDIF}

  ;

  procedure TakePicturePermissionRequestResult(
          Sender: TObject; const Apermission: TArray<string>;
          const AGrantResults: TArray<TPermissionStatus>);
  begin

  end;

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.Moto360.fmx ANDROID}
{$R *.SSW3.fmx ANDROID}
{$R *.iPad.fmx IOS}


procedure TForm1.btn_pedirClick(Sender: TObject);
begin
    begin
        {$IFDEF ANDROID}
        PermissionsService.RequestPermissions([PermissaoCamera,
                                               PermissaoReadStorage,
                                               PermissaoWriteStorage],
                                               TakePicturePermissionRequestResult,
                                               DisplayMessageCamera
                                               );
        {$ENDIF}

        {$IFDEF IOS}
        ActPhotoCamera.Execute;
        {$ENDIF}
end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    PermissaoCamera :=  JStringToString(TJManifest_permission.JavaClass.CAMERA);
    PermissaoReadStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
    PermissaoWriteStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
end;

procedure TForm1.FormCreate(Sender: TObject);
    {$IFDEF ANDROID}
    var
      posicao: TMapCoordinate;
      FpermissGPS:string;
     {$ENDIF}
begin


        MapView1.MapType := TMapType.normal;

        //Centralizar o mapa...
        posicao.Latitude  := -51.82471809573702;
        posicao.Longitude := -58.972377780386246;
        MapView1.Location := posicao;

        //Zoom
        Mapview1.Zoom := 11;
end;

procedure TForm1.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
    //Alteração da posição GPS


end;

end.
