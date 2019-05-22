unit connDlgfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, ExtCtrls, Menus, ComCtrls, ToolWin;

const
   max_string = 1024;
type
  TConnectDlg = class(TForm)
    IdTCPClient1: TIdTCPClient;
    Memo1: TMemo;
    reportMenu: TMainMenu;
    Reports1: TMenuItem;
    ToolBar1: TToolBar;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Edit2: TEdit;
    Edit1: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    procedure HandleMenuClick( sender : TObject);
    procedure Updatemenus( s : string);
  end;

var
  ConnectDlg: TConnectDlg;
  procedure SplitString( ss : string; sep : char; var aList : TStringlist );

implementation

{$R *.dfm}

procedure TConnectDlg.IdTCPClient1Connected(Sender: TObject);
var
     tstr : string;
begin
        memo1.Lines.add('Connected');
        IdTCPClient1.WriteLn(edit1.text);
        tstr := IdTCPClient1.ReadLn;
        if pos( 'OK', tstr) = 1 then
        begin
             memo1.Lines.add('Accepted: ' + tstr);
             UpdateMenus( tstr );
        end
        else
             memo1.Lines.add('Not Accepted: ' + tstr);
end;

procedure TConnectDlg.Updatemenus( s : string);
var
    k : integer;
    repList : TStringlist;
    aItem : TMenuItem;
    repName : string;
begin
    repList := TStringlist.Create;
    splitString( s, ';', repList );
    for k := 1 to replist.Count-1 do
    begin
         aItem := TMenuItem.Create(reportMenu);
         aItem.Caption := repList[k];
         aItem.OnClick := HandleMenuClick;
         reportMenu.Items[0].Add(aItem);
    end;

end;

procedure TConnectDlg.SpeedButton1Click(Sender: TObject);
begin
      If self.IdTCPClient1.Connected then IdTCPClient1.disconnect;
      close;
end;

procedure TConnectDlg.SpeedButton2Click(Sender: TObject);
begin
     IdTCPClient1.Host := '127.0.0.1';
     //IdTCPClient1.Host := '82.69.72.93';
     IdTCPClient1.Port := 114;
     IdTCPClient1.Connect;
end;

procedure TConnectDlg.HandleMenuClick( sender : TObject);
var
    aItem : TMenuItem;
    repName : string;
begin
     aItem := TMenuItem(sender);
     repName := aItem.Caption;
     application.MessageBox( pansichar(@repName[1]), 'Selected', 0);
end;

procedure TConnectDlg.SpeedButton3Click(Sender: TObject);
begin
     IdTCPClient1.Disconnect;
end;

procedure SplitString( ss : string; sep : char; var aList : TStringlist );
var
    k : integer;
    defstr : string;
begin
      defstr := ss;
      aList.Clear;
      while length( defstr) > 0 do
      begin
         k := pos( sep, defstr );
         if k = 0 then
         begin
               if length( defstr) > 0 then
                           alist.add(defstr);
               defstr := '';
         end
         else if trim(copy( defstr, 1, k-1)) <> '' then
              alist.add(copy( defstr, 1, k-1));
         defstr := copy( defstr, k+1, MAX_STRING );
      end;
end;

end.
