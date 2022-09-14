unit U_principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Maps,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Objects, FMX.Ani,
  System.Sensors, System.Sensors.Components,FMX.Layouts, FMX.WebBrowser,
  System.Permissions,FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.Media, u99Permissions;

type
  TForm1 = class(TForm)
    MapView1: TMapView;
    Rectangle1: TRectangle;
    btn_busca: TSpeedButton;
    txt_busca: TEdit;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Panel1: TPanel;
    LocationSensor1: TLocationSensor;
    btn_guard: TSpeedButton;
    btn_opc: TSpeedButton;
    Panel2: TPanel;
    Rectangle2: TRectangle;
    RoundRect1: TRoundRect;
    lb_result: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure FormActivate(Sender: TObject);
    procedure btn_guardClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_buscaClick(Sender: TObject);
  private
    { Private declarations }
      {$IFDEF ANDROID}
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage : string;
      {$ENDIF}

  public
    { Public declarations }
      permissao : T99permissions;
  end;

var
  Form1: TForm1;

implementation
 Uses FMX.DialogService
  {$IFDEF ANDROID}
  ,Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
  {$ENDIF}

  , U_camera;



{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.Moto360.fmx ANDROID}
{$R *.SSW3.fmx ANDROID}
{$R *.iPad.fmx IOS}




procedure TForm1.btn_buscaClick(Sender: TObject);
begin
      txt_busca.Visible := true;
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
        //MapaView

        MapView1.MapType := TMapType.normal;

        //Centralizar o mapa...
        posicao.Latitude  := -51.82471809573702;
        posicao.Longitude := -58.972377780386246;
        MapView1.Location := posicao;

        //Zoom
        Mapview1.Zoom := 11;














        //Camera
          permissao := T99permissions.Create;






          txt_busca.Visible := false;
  end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
        permissao.DisposeOf;
end;

procedure TForm1.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
    //Alteração da posição GPS


end;

procedure TForm1.btn_guardClick(Sender: TObject);
begin
      if not permissao.VerifyCameraAccess then
        permissao.Camera(nil, nil)
      else
        begin
          //Abrir camera
            Frm_Camera.showmodal(procedure(ModalResult: TModalResult)
            begin
                 lb_result.Text := Frm_Camera.codigo;
            end);
        end;
end;


end.
