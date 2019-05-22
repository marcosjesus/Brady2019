{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::                                               
  ::                                                         ::
  :: QRPREV.PAS - QUICKREPORT STANDARD PREVIEW FORM          ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: http://www.quickreport.co.uk                            ::
  :: 5/12/2003  new preview for 4                            ::
  :: 24/03/2005  duplex fixed when PrintMetafileFrom= true   ::
  :: 3/8/05   added page jump to search tab                  ::
  :: 6/9/05   restored AfterPrint event for metafile print   ::
  :: 24/04/07 Initialzoom/windowstate fixed                  ::
  :: 24/04/07 Loaded qrp orientation bugs/thumbs/printing    ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}

unit QRPrev;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, QRPrntr, QR5const, QRExtra, ComCtrls, ToolWin,
  Menus, ImgList, Grids, printers;

type
  TQRStandardPreview = class(TForm)
    StatusBar: TStatusBar;
    ToolBar1: TToolBar;
    ZoomFit: TToolButton;
    Zoom100: TToolButton;
    ZoomToWidth: TToolButton;
    FirstPage: TToolButton;
    PreviousPage: TToolButton;
    nextPage: TToolButton;
    LastPage: TToolButton;
    PrintSetup: TToolButton;
    Print: TToolButton;
    SaveReport: TToolButton;
    LoadReport: TToolButton;
    Images: TImageList;
    ExitButton: TSpeedButton;
    QRPreview: TQRPreview;
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
    FindButton: TToolButton;
    Spacer1: TToolButton;
    GotoPageButton: TToolButton;
    Spacer5: TToolButton;
    PrintDialog1: TPrintDialog;
    CancelButton: TToolButton;
    copybutton: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZoomToFitClick(Sender: TObject);
    procedure ZoomTo100Click(Sender: TObject);
    procedure ZoomToWidthClick(Sender: TObject);
    procedure FirstPageClick(Sender: TObject);
    procedure PrevPageClick(Sender: TObject);
    procedure NextPageClick(Sender: TObject);
    procedure LastPageClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SaveClick(Sender: TObject);
    procedure PrintSetupClick(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
    procedure QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
    procedure FormCreate(Sender: TObject);
    procedure QRPreviewHyperlink(Sender: TObject; EventType: TQRHyperlinkEventType; Link: String; var Handled: Boolean);
    procedure ThumbGridDrawCell(Sender: TObject; ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
    procedure ThumbGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure FindButtonClick(Sender: TObject);
    procedure GotoPageButtonClick(Sender: TObject);
    procedure SearchResultBoxClick(Sender: TObject);
    procedure QRPreviewMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure CancelButtonClick(Sender: TObject);
    procedure copybuttonClick(Sender: TObject);
  protected
    procedure WndProc( var Message : TMessage ); override;
  private
    FQRPrinter : TQRPrinter;
    FReportOrientation : TPrinterOrientation;
    Gauge : TProgressBar;
    LastProgress : integer;
    ThumbFontHeight,
    ThumbDrawHeight,
    ThumbDrawWidth,
    ThumbTopMargin,
    ThumbLeftMargin : integer;
    ShowThumbs, ShowSearch : boolean;
    InitZoom : TQRZoomstate;
  public
    constructor CreatePreview(AOwner : TComponent; aQRPrinter : TQRPrinter); virtual;
    procedure Show;
    procedure UpdateInfo;
    procedure SelectPage(aPageNumber : integer);
    procedure ResizeThumb(Sender : TObject);
    function GetTextSearch(var MatchCase : boolean; var AText : string) : boolean;
    property QRPrinter : TQRPrinter read FQRPrinter write FQRPrinter;
  end;

  TResizeGrid = class(TDrawGrid)
  public
    property OnResize;
  end;

implementation

uses qrsearchdlg, quickrpt, Clipbrd;

   var
      ThumbUpdating, ThumbSelecting : boolean;
      ReportTitle : string;
      FParentReport : TCustomQuickrep;
      eventHandled : boolean;
{$R *.DFM}

procedure TQRStandardPreview.WndProc( var Message : TMessage );
var
   i : smallint;
begin
   if Message.Msg = WM_MOUSEWHEEL then
   begin
     Message.Msg := WM_KEYDOWN;
     Message.lParam := 0;
     try
       i := Message.wParam div $1000;
       if i > 0 then
         Message.wParam := VK_UP
       else
         Message.wParam := VK_DOWN;
     except
         Message.wParam := VK_DOWN;
     end;
   end;
   inherited WndProc( message );
end;

// amended procedure - if initZoom is Other, then the zoom factor is
// set to the quickreps design Zoom property.
constructor TQRStandardPreview.CreatePreview(AOwner : TComponent; aQRPrinter : TQRPrinter);
var
     localZoom : integer;//ZOOM FIX
begin
  inherited Create(AOwner);
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

  QRPrinter := aQRPrinter;
  // qr5 Tiburon this line moved up from below because of resize failure.
  QRPreview.QRPrinter := aQRPrinter;
  if qrprinter.parentreport is TCustomquickrep then
  begin
     FParentReport := TCustomquickrep(qrprinter.ParentReport);
     FormStyle := TCustomquickrep(qrprinter.ParentReport).PrevFormstyle;
     width := TCustomquickrep(qrprinter.ParentReport).PreviewWidth;
     height := TCustomquickrep(qrprinter.ParentReport).Previewheight;
     ShowThumbs := TCustomquickrep(qrprinter.ParentReport).PrevShowThumbs;
     ShowSearch := TCustomquickrep(qrprinter.ParentReport).PrevShowSearch;
     InitZoom := TCustomquickrep(qrprinter.ParentReport).PrevInitialZoom;
     localZoom := TCustomquickrep(qrprinter.ParentReport).zoom; // ZOOM FIX
     reportTitle := TCustomquickrep(qrprinter.ParentReport).ReportTitle;
     QRPrinter.Title := reportTitle;
     FReportOrientation := TCustomquickrep(qrprinter.ParentReport).Page.Orientation;
     WindowState := TCustomquickrep(qrprinter.ParentReport).PreviewInitialState;
     eventHandled := false;
     if assigned(FParentReport.OnStandPrevEvent) then
                 FParentReport.OnStandPrevEvent( self, spOpen, '',eventHandled);
  end
  else
  begin // this should never happen
     WindowState := wsMaximized;
     ShowThumbs := true;
     ShowSearch := true;
     localZoom := 100; // ZOOM FIX
     FParentReport := nil;
  end;
  QRPreview.QRPrinter.Orientation := FReportOrientation;
  if (QRPrinter <> nil) and (QRPrinter.Title <> '') then Caption := sqrPreviewWindowCaption + QRPrinter.Title;
  Gauge := TProgressBar.Create(Self);
  Gauge.Top := 2;
  Gauge.Left := 2;
  Gauge.Height := 10;
  Gauge.Width := 100;
  LastProgress := 0;
  // qrprinter.load -> qrprinter.preview grid bug fix
  ThumbGrid.RowCount := 1; // ******************
  Tabs.Visible := ShowThumbs or ShowSearch;
  try
     if Tabs.Visible and (QRPrinter.PageCount > 0) then
         ThumbGrid.RowCount := QRPrinter.PageCount;

     if Tabs.Visible then TabThumbs.TabVisible := ShowThumbs;
     findButton.visible := ShowSearch;
     if not ShowSearch and Tabs.Visible then
     begin
        TabSearchResult.TabVisible := false;
        findButton.Visible := false;
     end;
  except

  end;
  if InitZoom = QRZoomtofit then
  begin
      QRPreview.ZoomToFit ;
      ZoomFit.Down := true;
  end
  else if InitZoom = QRZoomtowidth then
  begin
      QRPreview.ZoomToWidth;
      ZoomToWidth.Down := true;
  end
  else
  begin
      QRPreview.Zoom := localZoom;// ZOOM FIX
      QRPreview.UpdateZoom;
      Zoom100.Down := true;
  end;
  if qrprinter.status = mpFinished then
    Print.Enabled := true;
end;

procedure TQRStandardPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if qrprinter.Status = mpBusy then
  begin
       Action := caNone;
       exit;
  end;
  QRPrinter.ClosePreview(Self);
  application.ProcessMessages;
  Action := caFree;
end;

procedure TQRStandardPreview.UpdateInfo;
begin
  StatusBar.Panels[1].Text := SqrPage + ' ' + IntToStr(QRPreview.PageNumber) + ' ' +
    SqrOf + ' ' + IntToStr(QRPreview.QRPrinter.PageCount);

  StatusBar.Panels[2].Text := ReportTitle;

end;

procedure TQRStandardPreview.ZoomToFitClick(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.ZoomToFit;
end;

procedure TQRStandardPreview.ZoomTo100Click(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.Zoom := 100;
  QRPreview.UpdateZoom;
end;

procedure TQRStandardPreview.ZoomToWidthClick(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.ZoomToWidth;
end;

procedure TQRStandardPreview.SelectPage(aPageNumber : integer);
begin
 try
  QRPreview.PageNumber := APageNumber;
  UpdateInfo;
  // set thumb row
  if ((aPagenumber > 0) and ( aPagenumber <= QRPrinter.PageCount) and (aPagenumber <= ThumbGrid.RowCount)) then
  begin
     ThumbUpdating := true;
     ThumbGrid.Row := APageNumber-1;
     ThumbUpdating := false;
  end;
 except
 end;
end;

procedure TQRStandardPreview.FirstPageClick(Sender: TObject);
begin
  SelectPage(1)
end;

procedure TQRStandardPreview.PrevPageClick(Sender: TObject);
begin
  SelectPage(QRPreview.PageNumber - 1);
end;

procedure TQRStandardPreview.NextPageClick(Sender: TObject);
begin
  SelectPage(QRPreview.PageNumber + 1);
end;

procedure TQRStandardPreview.LastPageClick(Sender: TObject);
begin
  if (qrprinter.status = mpFinished) then    
  begin
     SelectPage(QRPrinter.PageCount);
  end
  else
  begin
     SelectPage(QRPrinter.PageCount - 1);
  end
end;

procedure TQRStandardPreview.PrintClick(Sender: TObject);
begin
     eventHandled := false;
     if assigned(FParentReport.OnStandPrevEvent) then
                 FParentReport.OnStandPrevEvent( self, spPrint, 'Print',eventHandled);
     if eventHandled then exit;

      if PrintMetafileFromPreview or ( not (qrprinter.ParentReport is TQuickRep)) then
           QRPrinter.Print
      else
           FParentReport.print;
end;

procedure TQRStandardPreview.ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TQRStandardPreview.FormResize(Sender: TObject);
begin
  QRPreview.UpdateZoom;
end;

procedure TQRStandardPreview.Show;
begin
  inherited Show;
  UpdateInfo;
end;

procedure TQRStandardPreview.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    prevpage : integer;
begin
 try
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
    VK_Escape : ExitClick(self);
    vk_down :
    begin
      if ((QRPreview.VertScrollBar.Position + QRPreview.VertScrollBar.Increment)<(QRPreview.VertScrollBar.Range - QRPreview.Height)) then
        QRPreview.VertScrollBar.Position := QRPreview.VertScrollBar.Position + QRPreview.VertScrollBar.Increment
      else
      begin
        ThumbSelecting := true;
        NextPageClick(Self);
        ThumbSelecting := false;
      end;
    end;
    vk_up :
    begin
      if (QRPreview.VertScrollBar.Position-QRPreview.VertScrollBar.Increment)>0 then
      begin
        QRPreview.VertScrollBar.Position := QRPreview.VertScrollBar.Position - QRPreview.VertScrollBar.Increment;
      end
      else
      begin
        ThumbSelecting := true;
        prevpage := QRPreview.PageNumber;
        PrevPageClick(Self);
        ThumbSelecting := false;
        if prevpage > 1 then
           QRPreview.VertScrollBar.Position := (QRPreview.VertScrollBar.Range - QRPreview.Height) - QRPreview.VertScrollBar.Increment
        else
           QRPreview.VertScrollBar.Position := 0;
      end;
    end;
  end;
 except
     // something wrong with mouse wheel ?
 end;
end;

function GetExtension( fstr : string ) : string;
var
   k : integer;
begin
   result := '';
   for k := length(fstr) downto 1 do
      if fstr[k]='.' then
         break
      else
         result := fstr[k] + result;
end;

// NEW QR5 code
procedure TQRStandardPreview.SaveClick(Sender: TObject);
var
  aExportFilter : TQRExportFilter;
  filtLibEntry : TQRExportFilterLibraryEntry;
  sdialog : TSaveDialog;
  sext, savefile : string;
  findx : integer;
begin
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
                 FParentReport.OnStandPrevEvent( self, spSave, 'Save',eventHandled);
  if eventHandled then exit;

  aExportFilter := nil;
  sdialog := TSaveDialog.Create(Application);
  try
    sdialog.Title := SqrSaveReport;
    sdialog.Filter := QRSaveExtensions[FParentreport.PreviewDefaultSaveType]+'|*'
                                   + QRSaveExtensions[FParentreport.PreviewDefaultSaveType]+'|'
                                   + QRExportFilterLibrary.SaveDialogFilterString;
    //sdialog.DefaultExt := QRSaveExtensions[FParentreport.PreviewDefaultSaveType];
    sdialog.Filename := '*'+ QRSaveExtensions[FParentreport.PreviewDefaultSaveType];
    if not sdialog.Execute then exit;
    sext := ExtractFileExt( sdialog.FileName);
    savefile := sdialog.FileName;
    sext := upperCase( sext);
    // enforce an extension
    if sext = '' then
    begin
        findx := sdialog.FilterIndex-1;
        if findx = 0 then
           sext := QRSaveExtensions[FParentreport.PreviewDefaultSaveType]
        else if findx = 1 then
           sext := 'QRP'
        else
        begin
         try
           sext := TQRExportFilterLibraryEntry( QRExportFilterLibrary.Filters[findx - 2]).Extension;
         except
           sext := QRSaveExtensions[FParentreport.PreviewDefaultSaveType]
         end;
        end;
        if sext[1] = '.' then sext := copy( sext, 2, 3 );
        savefile := savefile + '.' + sext;
    end;
    if sext[1] = '.' then sext := copy( sext, 2, 3 );
    if sext='QRP' then
    begin
        QRPrinter.Save(savefile);
        exit;
    end;
    filtLibEntry := QRExportFilterLibrary.GetFilterByExtension(sext);
    if filtLibEntry=nil then exit;
    try
      aExportFilter := filtLibEntry.ExportFilterClass.Create(savefile);
      if FParentreport.ParentComposite <> nil then
         TQRCompositeReport( FParentreport.ParentComposite).ExportToFilter(aExportFilter)
      else
         FParentreport.ExportToFilter(aExportFilter);
    finally
      aExportFilter.Free
    end
  finally
    sdialog.Free;
  end;
end;

procedure StandardSetup;
begin
end;

procedure TQRStandardPreview.PrintSetupClick(Sender: TObject);
var
   prep : TCustomquickrep;
   tagval : integer;
begin
  //tagval := 1; // default to cancel
  //prep := nil;
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
                 FParentReport.OnStandPrevEvent( self, spPrintSetup, 'PrintSetup',eventHandled);
  if eventHandled then exit;
 try
  printer.Refresh;
  if TCustomquickrep( qrprinter.ParentReport).ParentComposite <> nil then
  begin
       prep := TCustomquickrep( qrprinter.ParentReport);
       TCustomQuickrep(QRPrinter.ParentReport).PrinterSetup;
       tagval := TCustomQuickrep(QRPrinter.ParentReport).tag;
       if tagval <> 0 then exit;
       qrprinter.PrinterIndex := prep.PrinterSettings.printerindex;
       // 8/02/05
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.PrinterIndex := prep.UserPrinterSettings.PrinterIndex;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.FirstPage :=
                                                    prep.UserPrinterSettings.FirstPage;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.LastPage :=
                                                    prep.UserPrinterSettings.LastPage;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.Collate := prep.UserPrinterSettings.Collate;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.Copies := prep.UserPrinterSettings.Copies;
       TQRCompositeReport( prep.ParentComposite).printerSettings.Duplex := prep.UserPrinterSettings.ExtendedDuplex = 1;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.UseCustomBinCode := prep.PrinterSettings.UseCustomBinCode;
       TQRCompositeReport( prep.ParentComposite).PrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
       QRPrinter.aPrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
       QRPrinter.aPrinterSettings.Collate := prep.UserPrinterSettings.Collate;
       QRPrinter.aPrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
       QRPrinter.aPrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
       QRPrinter.aPrinterSettings.Copies := prep.UserPrinterSettings.Copies;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.ExtendedDuplex = 1;
       QRPrinter.aPrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
       QRPrinter.aPrinterSettings.UseCustomBinCode := prep.PrinterSettings.UseCustomBinCode;
       QRPrinter.LastPage := prep.UserPrinterSettings.LastPage;
       QRPrinter.FirstPage := prep.UserPrinterSettings.FirstPage;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
       QRPrinter.aPrinterSettings.ExtendedDuplex := prep.UserPrinterSettings.ExtendedDuplex;
       QRPrinter.aPrinterSettings.UseExtendedDuplex := prep.UserPrinterSettings.UseExtendedDuplex;
       exit;
  end;
  if qrprinter.ParentReport is TCustomquickrep then
  Begin
       TCustomQuickrep(QRPrinter.ParentReport).PrinterSetup;
       tagval := TCustomQuickrep(QRPrinter.ParentReport).tag;
       if tagval <> 0 then exit;
       prep := TCustomquickrep( qrprinter.ParentReport);
       qrprinter.PrinterIndex := prep.PrinterSettings.printerindex;
       if prep.UserPrinterSettings.CustomBinCode >= integer(Last) then
       begin
            QRPrinter.aPrinterSettings.UseCustomBinCode := true;
            QRPrinter.aPrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
       end
       else
       begin
            QRPrinter.aPrinterSettings.UseCustomBinCode := false;
            QRPrinter.aPrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
       end;
       QRPrinter.aPrinterSettings.Collate := prep.UserPrinterSettings.Collate;
       QRPrinter.aPrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
       QRPrinter.aPrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
       QRPrinter.aPrinterSettings.Copies := prep.UserPrinterSettings.Copies;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.ExtendedDuplex = 1;
       QRPrinter.LastPage := prep.UserPrinterSettings.LastPage;
       QRPrinter.FirstPage := prep.UserPrinterSettings.FirstPage;
       QRPrinter.aPrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
       QRPrinter.aPrinterSettings.ExtendedDuplex := prep.UserPrinterSettings.ExtendedDuplex;
       QRPrinter.aPrinterSettings.UseExtendedDuplex := prep.UserPrinterSettings.UseExtendedDuplex;
       if not PrintMetafileFromPreview then
       begin
           // set the quickrep settings
           if prep.UserPrinterSettings.CustomBinCode >= integer(Last) then
           begin
               prep.PrinterSettings.UseCustomBinCode := true;
               prep.PrinterSettings.CustomBinCode := prep.UserPrinterSettings.CustomBinCode;
           end
           else
           begin
               prep.PrinterSettings.UseCustomBinCode := false;
               prep.PrinterSettings.OutputBin := TQRBin(prep.UserPrinterSettings.CustomBinCode);
           end;
           prep.PrinterSettings.PrinterIndex := prep.UserPrinterSettings.PrinterIndex;
           prep.PrinterSettings.Copies := prep.UserPrinterSettings.Copies;
           prep.PrinterSettings.Duplex := prep.UserPrinterSettings.Duplex;
           prep.PrinterSettings.FirstPage := prep.UserPrinterSettings.FirstPage;
           prep.PrinterSettings.LastPage := prep.UserPrinterSettings.LastPage;
           prep.PrinterSettings.UseStandardprinter := prep.UserPrinterSettings.UseStandardprinter;
           prep.PrinterSettings.ExtendedDuplex := prep.UserPrinterSettings.ExtendedDuplex;
           prep.PrinterSettings.UseExtendedDuplex := prep.UserPrinterSettings.UseExtendedDuplex;
           prep.PrinterSettings.UseCustomPaperCode := prep.UserPrinterSettings.UseCustomPaperCode;
           prep.PrinterSettings.CustomPaperCode := prep.UserPrinterSettings.CustomPaperCode;
           prep.PrinterSettings.MemoryLimit := prep.UserPrinterSettings.MemoryLimit;
           prep.PrinterSettings.PrintQuality := prep.UserPrinterSettings.PrintQuality;
           prep.PrinterSettings.Collate := prep.UserPrinterSettings.Collate;
           prep.PrinterSettings.ColorOption := prep.UserPrinterSettings.ColorOption;
           prep.PrinterSettings.Orientation := prep.UserPrinterSettings.Orientation;
           prep.PrinterSettings.PaperSize := prep.UserPrinterSettings.PaperSize;
       end;
  end;
 finally
 end;
end;

procedure TQRStandardPreview.LoadClick(Sender: TObject);
begin
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
                 FParentReport.OnStandPrevEvent( self, spLoad, 'Load',eventHandled);
  if eventHandled then exit;

  with TOpenDialog.Create(Application) do
  try
    Title := SqrLoadReport;
    Filter := SqrQRFile + ' (*.' +cQRPDefaultExt + ')|*.' + cqrpDefaultExt;
    if Execute then
      if FileExists(FileName) then
      begin
        QRPrinter.Load(Filename);
        reportTitle := filename;
        QRPreview.PageNumber := 1;
        QRPreview.PreviewImage.PageNumber := 1;
        // fix orientation bug. NOTE : this sould be done in qrprinter.load()
        FReportOrientation := QRPrinter.Orientation;
        qrprinter.aPrinterSettings.Orientation := QRPrinter.Orientation;
        TQuickrep(qrprinter.ParentReport).Page.PaperSize := qrprinter.aPrinterSettings.PaperSize;
        TQuickrep(qrprinter.ParentReport).Page.Orientation := QRPrinter.Orientation;
        qrpreview.UpdateZoom; // fixes thumb orientation
        // have to reset the thumbs with this call
        resizeThumb( self);
        QRPreviewPageAvailable( self, 1);
        thumbGrid.Row := 0;
        //PrintSetup.Enabled := False;
        PrintMetafileFromPreview := true;
        Print.Enabled := true;
        SaveReport.Enabled := false;
        SaveReport.visible := false;
      end
      else
        ShowMessage(SqrFileNotExist);
  finally
    free;
  end;
end;

procedure TQRStandardPreview.QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
begin
  cancelbutton.Enabled := true;
  UpdateInfo;
  ThumbGrid.RowCount := QRPrinter.PageCount;
  ThumbGrid.Invalidate;
  if qrprinter.status = mpFinished then
  begin
    PrintSetup.Enabled := true;
    Print.Enabled := true;
    SaveReport.Enabled := true;
    LoadReport.Enabled := true;
    findButton.Enabled := true;
    gotoPageButton.Enabled := true;
    firstPage.Enabled := true;
    nextPage.Enabled := true;
    previouspage.Enabled := true;
    lastPage.Enabled := true;
    ThumbGrid.RowCount := QRPrinter.PageCount;
    cancelbutton.Enabled := false;
    Sleep(100);
  end
  else
  begin
    ThumbGrid.RowCount := QRPrinter.PageCount-1;
    PrintSetup.Enabled := false;
    Print.Enabled := false;
    SaveReport.Enabled := false;
    LoadReport.Enabled := false;
    findButton.Enabled := false;
    gotoPageButton.Enabled := false;
    firstPage.Enabled := false;
    nextPage.Enabled := false;
    previouspage.Enabled := false;
    lastPage.Enabled := false;
  end;

    // QR5  stop report after n pages
    if (QRPrinter.PageCount = FParentReport.PagesInPreview) and (FParentReport.PagesInPreview<>0) then
                 FParentReport.UserCancel := true;
end;

procedure TQRStandardPreview.QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
begin
  if Progress >= LastProgress + 5 then
  begin
    StatusBar.Panels[0].Text := IntToStr(Progress)+'%';
    LastProgress := Progress;
  end;
  if (Progress = 0) or (Progress = 100) then StatusBar.Panels[0].Text := '';
end;

procedure TQRStandardPreview.FormCreate(Sender: TObject);
begin
   HorzScrollbar.Tracking := true;
   VertScrollbar.Tracking := true;
   TResizeGrid(ThumbGrid).OnResize := ResizeThumb;
end;

procedure TQRStandardPreview.QRPreviewHyperlink(Sender: TObject;
  EventType: TQRHyperlinkEventType; Link: String; var Handled: Boolean);
begin
  Statusbar.Panels[2].Text := Link;
end;

procedure TQRStandardPreview.ResizeThumb(Sender: TObject);
begin
  ThumbFontHeight := ThumbGrid.Canvas.TextHeight('P');
  ThumbGrid.DefaultColWidth := ThumbGrid.Width - 4;
  if FReportOrientation = poPortrait then
  begin
      ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
      ThumbDrawHeight := Round((ThumbDrawWidth / QRPrinter.PaperWidth) * QRPrinter.PaperLength - ThumbFontHeight);
  end
  else
  begin
      ThumbDrawWidth := Round((ThumbGrid.DefaultColWidth - 20));
      ThumbDrawHeight := Round((ThumbDrawWidth / QRPrinter.PaperLength) * QRPrinter.PaperWidth - ThumbFontHeight);
  end;

  ThumbGrid.DefaultRowHeight := ThumbDrawHeight;
  ThumbLeftMargin := Round((ThumbGrid.DefaultColWidth - ThumbDrawWidth) / 2);
  ThumbTopMargin := Round((ThumbGrid.DefaultRowHeight - ThumbDrawHeight) / 2);
end;

procedure TQRStandardPreview.ThumbGridDrawCell(Sender: TObject; ACol, ARow: Integer; ARect: TRect; State: TGridDrawState);
var
  APage : TMetafile;
begin
  APage := QRPrinter.GetPage(ARow+1);
  if APage <> nil then
    PaintPageToCanvas(APage, ThumbGrid.Canvas, Rect(ARect.Left + ThumbLeftMargin, ARect.Top + 10,
                                 ARect.Right - 30, ARect.Bottom - 10), true);
  ThumbGrid.Canvas.Brush.Color := clBtnFace;
  ThumbGrid.Canvas.pen.Color := clblack;
  SetBkMode(ThumbGrid.Canvas.Handle, TRANSPARENT);
  ThumbGrid.Canvas.Textout(ARect.Left, ARect.Top, IntToStr(ARow + 1));
  SetBkMode(ThumbGrid.Canvas.Handle, OPAQUE);          
  APage.Free;
end;

procedure TQRStandardPreview.ThumbGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
     if ThumbUpdating or ThumbSelecting then exit;
     ThumbSelecting := true;
     if QRPreview.PageNumber <> (ARow + 1) then
                 QRPreview.PageNumber := ARow + 1;
     //sleep(100);
     UpdateInfo;
     Thumbselecting := false;
end;

function TQRStandardPreview.GetTextSearch(var MatchCase : boolean; var AText : string) :  boolean;
var
    SrchDlg : TSearchDlg;
begin
  AText := '';
  Result := false;
  SrchDlg := TSearchDlg.Create( self);
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

procedure TQRStandardPreview.FindButtonClick(Sender: TObject);
var
  FindStr : string;
  MatchCase : boolean;
  I : integer;
  APage : TMetafile;
begin
  if qrprinter.Status = mpBusy then exit;
  if GetTextSearch(MatchCase, FindStr) then
  begin
    SearchResultBox.Enabled := true;
    SearchTextLabel.Caption := FindStr;
    SearchResultBox.Items.Clear;
    for I := 1 to QRPrinter.PageCount do
    begin
       APage := QRPrinter.GetPage(I);
       try
           if StrInMetafile(FindStr, APage, MatchCase) then
             SearchResultBox.Items.AddObject(sqrPage+' ' + IntToStr(I),TObject(i));
       finally
         APage.Free;
       end;
    end;
    if SearchResultBox.Items.Count = 0 then
    begin
      SearchResultBox.Items.Add(sqrSearchNoResult);
      SearchResultBox.Enabled := false;
    end;
  end;
end;

procedure TQRStandardPreview.GotoPageButtonClick(Sender: TObject);
var
  Pnum, K : integer;
  PNStr : string;
  CaptionStr : string;
begin
  CaptionStr := format(SqrGotoPage, [QRPrinter.PageCount]);
  PNStr := format( '%d', [QRPreview.PageNumber]);
  InputQuery(CaptionStr, sqrGoPage, PNStr );
  val(PNStr, Pnum, K );
  if (Pnum < 1) or (Pnum > QRPrinter.PageCount) then
     Pnum := 1;
  SelectPage(Pnum );
end;

procedure TQRStandardPreview.SearchResultBoxClick(Sender: TObject);
var
   Page:Integer;
begin
  With SearchResultBox Do
    If ItemIndex>=0 Then
      Page:=Integer(Items.Objects[ItemIndex])
    Else
      Page:=1;
  if (Page < 1) or (Page > QRPrinter.PageCount) then
     Page := 1;
  SelectPage(Page );

end;

procedure TQRStandardPreview.QRPreviewMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
   kd : word;
begin
     kd := vk_down;
     formkeydown(self, kd, []);
     handled := true;
end;

procedure TQRStandardPreview.CancelButtonClick(Sender: TObject);
begin
      // user cancels
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
                 FParentReport.OnStandPrevEvent( self, spCancel, 'Cancel',eventHandled);
  if eventHandled then exit;

  FParentReport.UserCancel := true;
end;

procedure TQRStandardPreview.copybuttonClick(Sender: TObject);
begin
     // copy to clipboard
  eventHandled := false;
  if assigned(FParentReport.OnStandPrevEvent) then
                 FParentReport.OnStandPrevEvent( self, spCopy, 'Copy',eventHandled);
  if eventHandled then exit;
  Clipboard.Assign(FQRPrinter.GetPage(QRPreview.PageNumber));
end;

end.



