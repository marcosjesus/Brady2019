{===============================================================
   unit QRXBrowser
   Preview a QRX file, based on QuickReport standard preview.

   (C) 2007 QBS Software
================================================================}

//{$I QRDEFS.INC}

unit QRXBrowser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, qrxdocument,
  ExtCtrls, StdCtrls, Buttons, ComCtrls, ToolWin, Menus , ImgList, Grids, printers, qrprntr,
  qr5const;

type
  TQRXStandardViewer = class(TForm)
    StatusBar: TStatusBar;
    ToolBar1: TToolBar;
    ZoomFit: TToolButton;
    Zoom100: TToolButton;
    ZoomToWidth: TToolButton;
    FirstPage: TToolButton;
    PreviousPage: TToolButton;
    nextpage: TToolButton;
    LastPage: TToolButton;
    PrintSetup: TToolButton;
    Print: TToolButton;
    SaveReport: TToolButton;
    LoadReport: TToolButton;
    Images: TImageList;
    ToolButton1: TToolButton;
    ExitButton: TSpeedButton;
    Splitter1: TSplitter;
    Spacer2: TToolButton;
    Tabs: TPageControl;
    TabThumbs: TTabSheet;
    TabSearchResult: TTabSheet;
    Splitter2: TSplitter;
    GroupBox1: TGroupBox;
    SearchResultBox: TListBox;
    SearchTextLabel: TLabel;
    ThumbGrid: TDrawGrid;
    Spacer3: TToolButton;
    Spacer4: TToolButton;
    FindButton: TToolButton;
    Spacer1: TToolButton;
    GotoPageButton: TToolButton;
    Spacer5: TToolButton;
    PrintDialog1: TPrintDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    copybutton: TToolButton;
    cancelbutton: TToolButton;
    Open1: TOpenDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZoomToFitClick(Sender: TObject);
    procedure ZoomTo100Click(Sender: TObject);
    procedure ZoomToWidthClick(Sender: TObject);
    procedure FirstPageClick(Sender: TObject);
    procedure PrevPageClick(Sender: TObject);
    procedure NextPageClick(Sender: TObject);
    procedure LastPageClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SaveClick(Sender: TObject);
    procedure PrintSetupClick(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
    procedure QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ThumbGridDrawCell(Sender: TObject; ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
    procedure ThumbGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure FindButtonClick(Sender: TObject);
    procedure GotoPageButtonClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Splitter2Moved(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure SearchResultBoxClick(Sender: TObject);
    procedure copybuttonClick(Sender: TObject);
  private
    FQRXDocument : TQRXDocument;
    FZoomState : TQRZoomState;
    FReportOrientation : TPrinterOrientation;
    Gauge : TProgressBar;
    LastProgress : integer;
    ThumbFontHeight,
    ThumbDrawHeight,
    ThumbDrawWidth,
    ThumbTopMargin,
    ThumbLeftMargin : integer;
    ShowThumbs, ShowSearch : boolean;
    FTitle : string;
  public
    PageNumber : integer;
    constructor CreatePreview(AOwner : TComponent); virtual;
    procedure Show;
    procedure UpdateInfo;
    procedure SelectPage(aPageNumber : integer);
    procedure ResizeThumb(Sender : TObject);
    function GetTextSearch(var MatchCase : boolean; var AText : string) : boolean;
    procedure SetDocument( aDoc : TQRXDocument );
  end;

  TResizeGrid = class(TDrawGrid)
  public
    property OnResize;
  end;

implementation
uses QRXSearchfrm, quickrpt, clipbrd;
   var
      ThumbUpdating : boolean;
//  QRSearch;
{$R *.DFM}

procedure TQRXStandardViewer.FormCreate(Sender: TObject);
begin
   HorzScrollbar.Tracking := true;
   VertScrollbar.Tracking := true;
   pageNumber := 1;
   ThumbGrid.Row := 0;
   TResizeGrid(ThumbGrid).OnResize := ResizeThumb;
  // set captions
  tabs.Pages[0].Caption := sqrThumbNails;
  tabs.Pages[1].Caption := sqrSearchResults;
  groupbox1.Caption := sqrSearchText;
  zoomfit.Hint := SqrZoomToFit;
  zoomTowidth.Hint := sqrZoomTowidth;
  zoom100.Hint := sqrZoom100;
  firstpage.Hint := sqrFirstPage;
  nextpage.Hint := sqrNextPage;
  previouspage.Hint := sqrPrevPage;
  lastpage.Hint := sqrLastPage;
  gotoPagebutton.Hint := sqrPageSelect;
  findButton.Hint := sqrFindCaption;
  printSetup.Hint := sqrPrinterSetup;
  print.Hint := sqrPrint;
  saveReport.Hint := sqrSaveReport;
  loadReport.Hint := sqrLoadReport;
  exitButton.Hint := sqrClosePreview;
  caption := sqrPreviewWindowCaption;
  exitbutton.caption := sqrExitButtonCaption;
  cancelbutton.Enabled := false;

  cancelbutton.Hint := sqrCancelButtonHint;
  copybutton.Hint := sqrcopyButtonHint;
end;

constructor TQRXStandardViewer.CreatePreview(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Gauge := TProgressBar.Create(Self);
  Gauge.Top := 2;
  Gauge.Left := 2;
  Gauge.Height := 10;
  Gauge.Width := 100;
  LastProgress := 0;
  pageNumber := 1;
end;

procedure TQRXStandardViewer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ThumbGrid.Row := 0; // this avoids an awful bug. If the selected page is not 1,
                       // the app crashes when the report is run a second time.
    Action := caFree;
    screen.cursor := crDefault;
end;

procedure TQRXStandardViewer.SetDocument( aDoc : TQRXDocument );
begin
     FQRXDocument := aDoc;
     showThumbs := aDoc.Showthumbs;
     showSearch := aDoc.ShowSearch;
     Tabs.Visible := ShowThumbs or ShowSearch;
     try
       if Tabs.Visible and (FQRXDocument.PageCount > 0) then
           ThumbGrid.RowCount := FQRXDocument.PageCount;

       ThumbGrid.Row := 0;

        if Tabs.Visible then TabThumbs.TabVisible := ShowThumbs;
        if not ShowSearch and Tabs.Visible then
        begin
          TabSearchResult.TabVisible := false;
          findButton.Visible := false;
        end;
     except
         
     end;
     if showSearch then
         FQRXDocument.MakeTextIndex;
     FTitle := FQRXDocument.reportTitle;
     Caption := FTitle;
     self.ToolBar1.Visible := FQRXDocument.ShowToolbar;
     self.Print.Visible := FQRXDocument.showPrintbuttons;
     self.PrintSetup.Visible := FQRXDocument.showPrintbuttons;
     loadReport.Visible := FQRXDocument.ShowLoadButton;
     saveReport.Visible := FQRXDocument.ShowSaveButton;
     // do positions
     self.left := FQRXDocument.InitViewerLeft;
     self.top := FQRXDocument.InitViewerTop;
     self.width := FQRXDocument.InitViewerWidth;
     self.height := FQRXDocument.InitViewerHeight;
     findButton.Visible := FQRXDocument.ShowSearch;
     windowState := FQRXDocument.InitViewerState;
     pageNumber := 1;
     if FQRXDocument.InitViewerZoomState = qrZoomToFit then
                 ZoomToFitClick( self)
     else if FQRXDocument.InitViewerZoomState = qrZoomToWidth then
                 ZoomToWidthClick( self)
     else if FQRXDocument.InitViewerZoomState = qrZoom100 then
                 ZoomTo100Click( self);

     Resizethumb( self );
     UpdateInfo;
end;

procedure TQRXStandardViewer.UpdateInfo;
begin
    StatusBar.Panels[1].Text := format( 'Page: %-d of %-d', [pageNumber, FQRXDocument.pagecount ]);
    StatusBar.Panels[2].Text := FTitle;
    StatusBar.Panels[0].Text := format( 'Zoom: %-4.0f %%', [FQRXDocument.zoomFactor]);
  end;

procedure TQRXStandardViewer.ZoomToFitClick(Sender: TObject);
var
    reqWidth : extended;
begin
     //reqWidth := self.ClientHeight;
     reqWidth := self.scrollbox1.Height-30;
     FQRXDocument.ZoomToHeight( reqWidth);
     FZoomState := qrZoomToFit;
     UpdateInfo;
     Application.ProcessMessages;
end;

procedure TQRXStandardViewer.ZoomTo100Click(Sender: TObject);
begin
     FQRXDocument.SetZoomFactor( 100.0);
     UpdateInfo;
     FZoomState := qrZoom100;
     Application.ProcessMessages;
end;

procedure TQRXStandardViewer.ZoomToWidthClick(Sender: TObject);
var
    reqWidth : extended;
begin
     reqWidth := self.ScrollBox1.width - 25;
     FQRXDocument.ZoomToWidth( reqWidth);
     FZoomState := qrZoomToWidth;
     UpdateInfo;
     Application.ProcessMessages;
end;

procedure TQRXStandardViewer.SelectPage(aPageNumber : integer);
begin
     FQRXDocument.CurrentPage := aPagenumber-1;
     pageNumber := aPageNumber;
     UpdateInfo;
     // set thumb row
     if (aPagenumber > 0) and ( aPagenumber <= FQRXDocument.PageCount) then
     begin
       ThumbUpdating := true;
       ThumbGrid.Row := APageNumber-1;
       ThumbUpdating := false;
     end;
end;

procedure TQRXStandardViewer.FirstPageClick(Sender: TObject);
begin
    SelectPage(1)
end;

procedure TQRXStandardViewer.PrevPageClick(Sender: TObject);
begin
     dec( pageNumber );
     if pageNumber < 1 then pageNumber := 1;
     SelectPage(PageNumber);
end;

procedure TQRXStandardViewer.NextPageClick(Sender: TObject);
begin
    if pageNumber = 0 then pageNumber := 1;
    inc(pageNumber);
    if pageNumber > FQRXDocument.Pagecount then
          pageNumber := FQRXDocument.Pagecount;
    SelectPage(PageNumber);
end;

procedure TQRXStandardViewer.LastPageClick(Sender: TObject);
begin
     Pagenumber := FQRXDocument.PageCount;
     SelectPage(Pagenumber);
end;

procedure TQRXStandardViewer.ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TQRXStandardViewer.FormResize(Sender: TObject);
begin
    case FZoomstate of
        qrZoom100, qrZoomOther : ;
        qrZoomToWidth: ZoomToWidthClick( self);
        qrZoomToFit : ZoomToFitClick( self);
    end;
end;

procedure TQRXStandardViewer.Show;
begin
  inherited Show;
  UpdateInfo;
end;

procedure TQRXStandardViewer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_Next : if Shift = [ssCtrl] then
                LastPageClick(Self)
              else
                NextPageClick(Self);
    VK_Prior : if Shift = [ssCtrl] then
                 FirstPageClick(Self)
               else
                 PrevPageClick(Self);
    VK_Home : FirstPageClick(Self);
    VK_End : LastPageClick(Self);
    VK_Escape : ExitClick(self)
  end;
end;

procedure TQRXStandardViewer.SaveClick(Sender: TObject);
begin
     FQRXDocument.FireEvent( etSaveButton, '', '', 0);
end;

procedure TQRXStandardViewer.PrintSetupClick(Sender: TObject);
begin
      FQRXDocument.FireEvent( etPrintSetup, '', '', 0);
end;

procedure TQRXStandardViewer.LoadClick(Sender: TObject);
begin
      //FQRXDocument.FireEvent( etLoadButton, '', '', 0);
      open1.Filter := 'XML and QRX files|*.xml;*.qrx';
      if not open1.Execute then exit;
      FQRXDocument.LoadFromFile(open1.FileName);
      setDocument( FQRXDocument);
end;

procedure TQRXStandardViewer.QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
begin
///
end;

procedure TQRXStandardViewer.QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
begin
  if Progress >= LastProgress + 5 then
  begin
    StatusBar.Panels[0].Text := IntToStr(Progress)+'%';
    LastProgress := Progress;
  end;
  if (Progress = 0) or (Progress = 100) then StatusBar.Panels[0].Text := '';
end;

procedure TQRXStandardViewer.ResizeThumb(Sender: TObject);
begin
  if not FQRXDocument.DocumentLoaded then exit;
  ThumbFontHeight := ThumbGrid.Canvas.TextHeight('P');
  ThumbGrid.DefaultColWidth := ThumbGrid.Width - 4;
  if FReportOrientation = poPortrait then
  begin
      ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
      ThumbDrawHeight := Round((ThumbDrawWidth / FQRXDocument.pageWidth) * FQRXDocument.pageheight);
  end
  else
  begin
      ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
      ThumbDrawHeight := Round((ThumbDrawWidth / FQRXDocument.pageheight) * FQRXDocument.pageWidth );
  end;

  ThumbGrid.DefaultRowHeight := ThumbDrawHeight;
  ThumbLeftMargin := Round((ThumbGrid.DefaultColWidth - ThumbDrawWidth) / 2);
  ThumbTopMargin := Round((ThumbGrid.DefaultRowHeight - ThumbDrawHeight) / 2);

    case FZoomstate of
        qrZoom100, qrZoomOther : SelectPage(pageNumber);
        qrZoomToWidth: ZoomToWidthClick( self);
        qrZoomToFit : ZoomToFitClick( self);
    end;
end;

procedure TQRXStandardViewer.ThumbGridDrawCell(Sender: TObject; ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
var
  pageMap : TBitmap;
  uRect : TRect;
begin
    uRect.Left := ARect.Left;
    uRect.Top := ARect.top;
    uRect.Right := ARect.Right-10;
    uRect.Bottom := ARect.Bottom-10;
    pageMap := FQRXDocument.RenderThumbnail( aRow, uRect);
    ThumbGrid.Canvas.Draw( ARect.Left+5, ARect.Top+5, pageMap);
    pageMap.Free;
end;

procedure TQRXStandardViewer.ThumbGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
     if ThumbUpdating then exit;
     PageNumber := ARow + 1;
     SelectPage( pageNumber );
     UpdateInfo;
end;

procedure TQRXStandardViewer.copybuttonClick(Sender: TObject);
var
  pmap : TBitmap;
begin
      pmap := TBitmap.Create;
      FQRXDocument.RenderPageToBM(pmap, pagenumber-1);
      Clipboard.Assign(pmap);
      pmap.Free;
end;

function TQRXStandardViewer.GetTextSearch(var MatchCase : boolean; var AText : string) :  boolean;
var
    SrchDlg : TQRXSearchDlg;
begin
  AText := '';
  Result := false;
  SrchDlg := TQRXSearchDlg.Create( self);
  srchDlg.ShowModal;
  if srchDlg.cancel then
  begin
       SrchDlg.Free;
       exit;
  end;
  Result := true;
  srchDlg.GetText( AText );
  MatchCase := srchDlg.GetCase;
  SrchDlg.Free;
end;

procedure TQRXStandardViewer.FindButtonClick(Sender: TObject);
var
  FindStr : string;
  MatchCase : boolean;
begin
  if GetTextSearch(MatchCase, FindStr) then
  begin
    SearchResultBox.Enabled := true;
    SearchTextLabel.Caption := FindStr;
    SearchResultBox.Items.Clear;
    FQRXDocument.SetSearchText( findStr);
    FQRXDocument.FindText( FindStr, matchCase, SearchResultBox.Items);
    if SearchResultBox.Items.Count = 0 then
    begin
      SearchResultBox.Items.Add('No matching text');
      SearchResultBox.Enabled := false;
    end
    else
    begin
       SearchResultBox.ItemIndex := 0;
       SearchResultBoxClick(self);
    end;
    FQRXDocument.SetZoomFactor( FQRXDocument.ZoomFactor);
    Thumbgrid.Invalidate;
  end;
end;

procedure TQRXStandardViewer.GotoPageButtonClick(Sender: TObject);
var
  Pnum, K : integer;
  PNStr : string;
  CaptionStr : string;
begin
  CaptionStr := format('Select Page', [FQRXDocument.PageCount]);
  PNStr := format( '%d', [PageNumber]);
  InputQuery(CaptionStr, 'Go to page >>', PNStr );
  val(PNStr, Pnum, K );
  if (Pnum < 1) or (Pnum > FQRXDocument.PageCount) then
     Pnum := 1;
  SelectPage(Pnum );
end;

procedure TQRXStandardViewer.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   cname, ctext : string;
   rec : integer;
begin
     cname := FQRXDocument.GetControlFromPosition( x, y, cText, rec );
     if (trim(cname) <> '') then
     begin
          FQRXDocument.FireEvent( etControlClick, cName, cText, rec+1);
          exit;
     end;
     cname := FQRXDocument.GetBandFromPosition( x, y, cText, rec );
     if (trim(cname) <> '') then
          FQRXDocument.FireEvent( etBandClick, cName, cText, rec);

end;

procedure TQRXStandardViewer.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   cname, ctext : string;
   rec : integer;
begin
     cname := FQRXDocument.GetControlFromPosition( x, y, cText, rec );
     if (trim(cname) <> '') then
     begin
          statusbar.Panels[3].Text := FQRXDocument.gethint(cName);
          FQRXDocument.FireEvent( etMouseOver, cName, cText, rec+1);
     end
     else
     begin
         statusbar.Panels[3].Text := '';
         FQRXDocument.FireEvent( etMouseOut, cName, cText, rec);
     end;
end;

procedure TQRXStandardViewer.Splitter2Moved(Sender: TObject);
begin
{
    case FZoomstate of
        zs100, zsOther : SelectPage(pageNumber);
        zsToWidth: ZoomToWidthClick( self);
        zsToHeight : ZoomToFitClick( self);
    end;
    }
end;

procedure TQRXStandardViewer.FormActivate(Sender: TObject);
begin
     //self.left := FQRXDocument.InitViewerLeft;
     //self.top := FQRXDocument.InitViewerTop;
end;

procedure TQRXStandardViewer.PrintClick(Sender: TObject);
begin
     FQRXDocument.FireEvent( etPrintButton, '', '', 0);
end;

procedure TQRXStandardViewer.SearchResultBoxClick(Sender: TObject);
var
    k, Y, pageht, screenht, scrollPercent : integer;
    zoom : extended;
    pItem : TPageitem;
begin
     k := self.SearchResultBox.ItemIndex;
     if k >= 0 then
     begin
         pItem := TPageitem( SearchResultBox.items.objects[k]);
         zoom := FQRXDocument.GetZoom;
         Y := round( mmToPix * pItem.ypos *  zoom / 100.0);
         pageht := round( mmToPix * FQRXDocument.pageheight *  zoom / 100.0);
         screenht := scrollbox1.Height;
         selectPage( pItem.DBRecord + 1 );
         scrollPercent := round( 150.0 * (Y - screenht)/pageht);
         if scrollPercent > 1 then
         begin
             self.ScrollBox1.VertScrollBar.Position := scrollPercent;
         end;
     end;
end;

end.



