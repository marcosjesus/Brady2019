{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::                                           
  :: QUICKRPT.PAS - MAIN UNIT                                ::
  ::                                                         ::
  :: Copyright (c) 2007     QBS Software                     ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.com                              ::
  :: V4.00                                                   ::
  :: 12/12/2003 add composite export                         ::
  :: 14/12/2003 add frames export                            ::
  :: 20/12/2003 Transparent property for band                ::
  :: 20/12/2003 BackgroundImage property for TQuickrep       ::
  :: 03/03/04 Orientation bug after setup dialog fixed       ::
  :: 12/12/06 composite rep duplex fixed                     ::
  :: 27/02/07 sumary band position in multicolumn fix        ::
  :: VER 5                                                   ::
  :: PagesInPreview added
  :: Replaced PreviewModal method
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}
{$define notLLIONPDF}
{$define BDETABLES}
{$define QRXDOC}
unit QuickRpt;

interface

{$R-}
{$T-}
{$B-}

uses Windows, Classes, Controls, StdCtrls, Sysutils, Graphics, Buttons,
  Forms, ExtCtrls, Dialogs, Printers, DB, QRPrntr, QR5Const,
 QRPrgres, QRExpr, QRExpbld{$ifdef LLIONPDF},PDF{$endif}, OleCtnrs
 {$ifdef BDETABLES}, DBTables {$endif};

type
  TExportType = ( exptText, exptNumeric, exptFormula );
  { Forward declarations }
  TCustomQuickRep = class;
  TQRBasePanel = class;
  TQRCustomBand = class;
  TQRChildBand = class;
  TQRPrintable = class;
  TQRSubDetail = class;
  TQRNewComponentClass = class of TQRPrintable;

  { TQRController class }
  TQROnNeedDataEvent = procedure (Sender : TObject; var MoreData : Boolean) of object;
  TQRPrinterEvent = procedure( Sender : TObject; var Cancel : Boolean; DevMode : pointer ) of object;
  TQRNotifyOperation = (qrMasterDataAdvance, qrBandPrinted, qrBandSizeChange);
  TQRNotifyOperationEvent = procedure (Sender : TObject; Operation : TQRNotifyOperation) of object;
  // QR5
  TCBPrintOrder = ( cboBeforeParent, cboAfterParent, cboBeforeAndAfter );// childband print order
  TPrevEventType = (etPrintButton, etSaveButton, etControlClick,etLoadButton,etPrintSetup,
                                      etMouseOver, etMouseOut, etBandClick );
  TQRPreviewXEvent = procedure( Sender : TObject; eventNum : TPrevEventType;
                                  cName, CText : string; rec : integer ) of object;
  TStandPrevEventType =  ( spOpen, spClose, spCopy, spPrint, spPrintSetup, spLoad, spSave, spCancel);
  TQRStandPrevEvent = procedure( Sender : TObject; eventType : TStandPrevEventType;
                                  contName : string; var Handled : boolean) of object;
  TCompositeEvent = procedure( Sender : TObject; Report : TObject; reportNumber : integer ) of object;

  TQRCustomController = class(TComponent)
  private
    OrgOwner : TComponent;
    FMaster : TComponent;                                      
    PrintAfterList : TList;
    PrintBeforeList : TList;
    GroupList : TList;
    FPrintIfEmpty : boolean;
    FSelfCheck : TComponent;
    FParentReport : TCustomQuickRep;
    FPrintBefore : boolean;
    NotifyList : TList;
    EvConstant : TQREvElement;
    function CheckGroups : boolean;
    procedure CheckLastGroupFooters;
    procedure NewPageCheckGroups;
    procedure SetMaster(Value : TComponent);
  protected
    function LocalVarValue : TQREvResult; virtual;
    procedure AddAfter(aController : TQRCustomController);
    procedure AddBefore(aController : TQRCustomController);
    procedure BuildTree; virtual;
    procedure Execute; virtual;
    procedure NotifyClients(Operation : TQRNotifyOperation);
    procedure Prepare; virtual;
    procedure Unprepare; virtual;
    procedure PrintAfterControllers; virtual;
    procedure PrintBeforeControllers; virtual;
    procedure PrintEmptyController; virtual;
    procedure PrintGroupHeaders;
    procedure PrintGroupFooters;
    procedure RegisterBands; virtual;
    procedure RegisterDatasets; virtual;
    procedure SetPrintBefore(Value : boolean); virtual;
    procedure UpdateLocalVar; virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure AddNotifyClient(Value : TQRPrintable);
    property Master : TComponent read FMaster write SetMaster;
    property ParentReport : TCustomQuickRep read FParentReport write FParentReport;
    property PrintBefore : boolean read FPrintBefore write SetPrintBefore;
    property PrintIfEmpty : boolean read FPrintIfEmpty write FPrintIfEmpty;
    property SelfCheck : TComponent read FSelfCheck write FSelfCheck;
  end;

  TQRController = class(TQRCustomController)
  private
    FDataSet : TDataSet;
    FDetail : TQRCustomBand;
    FFooter : TQRCustomBand;
    FHeader : TQRCustomBand;
    FOnNeedDataEvent : TQROnNeedDataEvent;
    FDetailNumber : integer;
    UpdateSQLParams : boolean;
    procedure SetDataSet(Value : TDataSet);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Prepare; override;
    procedure PrintEmptyController; override;
    procedure RegisterBands; override;
    procedure RegisterDatasets; override;
    procedure Execute; override;
  public
    property DataSet : TDataSet read FDataSet write SetDataSet;
    property DetailNumber : integer read FDetailNumber;
    property Detail : TQRCustomBand read FDetail write FDetail;
    property Footer : TQRCustomband read FFooter write FFooter;
    property Header : TQRCustomBand read FHeader write FHeader;
    property OnNeedData : TQROnNeedDataEvent read FOnNeedDataEvent write FOnNeedDataEvent;
  end;

  { TQRFrame }
  TQRFrame = class(TPersistent)
  private
    FColor : TColor;
    FBottom : boolean;
    FLeft : boolean;
    FParent : TControl;
    FPenStyle : TPenStyle;
    FRight : boolean;
    FTop : boolean;
    FWidth : integer;
    procedure SetColor(Value : TColor);
    procedure SetParent(Value : TControl);
    procedure SetStyle(Value : TPenStyle);
    procedure SetValue(index : integer; Value : boolean);
    procedure SetWidth(Value : integer);
  protected
    procedure PaintIt(ACanvas : TCanvas; ARect : TRect; XFact, YFact : extended);
    procedure SetPen(aPen : TPen);
  public
    constructor Create;
    function AnyFrame : boolean;
    property Parent : TControl read FParent write SetParent;
  published
    property Color: TColor read FColor write SetColor;
    property DrawTop : boolean index 0 read FTop write SetValue;
    property DrawBottom : boolean index 1 read FBottom write SetValue;
    property DrawLeft : boolean index 2 read FLeft write SetValue;
    property DrawRight : boolean index 3 read FRight write SetValue;
    property Style: TPenStyle read FPenStyle write SetStyle default psSolid;
    property Width: Integer read FWidth write SetWidth default 1;
  end;

  { TQRUnitBase - Base class for positioning objects with multiple units support }
  TQRUnit =(MM, Inches, Pixels, Characters, Native);

  TQRUnitBase = class(TPersistent)
  private
    FResolution : integer;
    FUnits : TQRUnit;
    SavedUnits : TQRUnit;
    FParentReport : TCustomQuickRep;
    FParentUpdating : boolean;
    FZoom : integer;
    function LoadUnit(Value : extended; aUnit : TQRUnit; Horizontal : boolean) : extended; virtual;
    function SaveUnit(Value : extended; aUnit : TQRUnit; Horizontal : boolean) : extended; virtual;
  protected
    function GetUnits : TQRUnit; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; virtual;
    procedure ReadValues(Reader : TReader); virtual;
    procedure SetParentSizes; virtual;
    procedure SetUnits(Value : TQRUnit); virtual;
    procedure WriteValues(Writer : TWriter); virtual;
    procedure SetPixels;
    procedure RestoreUnit;
  public
    constructor Create;
    property ParentReport : TCustomQuickRep read FParentReport write FParentReport;
    property ParentUpdating : boolean read FParentUpdating write FParentUpdating;
    property Resolution : integer read FResolution;
    property Units : TQRUnit read GetUnits write SetUnits;
    property Zoom : integer read FZoom write FZoom;
  end;

  { TQRBandSize - Object for storing band size information }
  TQRBandSize = class(TQRUnitBase)
  private
    FWidth : extended;
    FLength : extended;
    Parent : TQRCustomBand;
    function GetValue(Index : integer): extended;
    procedure SetValue(Index : integer; Value : extended);
  protected
    procedure ReadValues(Reader : TReader); override;
    procedure SetParentSizes; override;
    procedure WriteValues(Writer : TWriter); override;
    procedure FixZoom;
  public
    constructor Create(AParent : TQRCustomBand);
    property Length : extended index 0 read GetValue write SetValue stored false;
  published
    { All properties are stored by the WriteValues method }
    property Height : extended index 0 read GetValue write SetValue stored false;
    property Width : extended index 1 read GetValue write SetValue stored false;
  end;

  { TQRPage - Object for storing page layout information }
  TQRPrintOrder = (ColByCol, RowByRow);

  TQRPage = class(TQRUnitBase)
  private
    FBottomMargin : extended;
    FColumnSpace : extended;
    FColumns : integer;
    FLeftMargin : extended;
    FLength : extended;
    FOrientation : TPrinterOrientation;
    FPaperSize : TQRPaperSize;
    FPrintOrder : TQRPrintOrder;
    FRightMargin : extended;
    FRuler : boolean;
    FTopMargin : extended;
    FWidth : extended;
    Parent : TCustomQuickRep;
    function GetPaperSize : TQRPaperSize;
    function GetRuler : boolean;
    function GetValue(Index : integer): extended;
    procedure SetColumns(Value : integer);
    procedure SetOrientation(Value : TPrinterOrientation);
    procedure SetPaperSize(Value : TQRPaperSize);
    procedure SetPrintOrder(Value : TQRPrintOrder);
    procedure SetRuler(Value : boolean);
    procedure SetValue(Index : integer; Value : extended);
    property PrintOrder : TQRPrintOrder read FPrintOrder write SetPrintOrder;
  protected
    procedure ReadValues(Reader : TReader); override;
    procedure SetParentSizes; override;
    procedure SetUnits(Value : TQRUnit); override;
    procedure WriteValues(Writer : TWriter); override;
    procedure FixZoom;
  public
    constructor Create(AParent : TCustomQuickRep);
  published
    { All the extended properties are stored by the WriteValues method }
    property BottomMargin : extended index 0 read GetValue write SetValue stored false;
    property ColumnSpace : extended index 6 read GetValue write SetValue stored false;
    property Columns : integer read FColumns write SetColumns;
    property LeftMargin : extended index 4 read GetValue write SetValue stored false;
    property Length : extended index 1 read GetValue write SetValue stored false;
    property Orientation : TPrinterOrientation read FOrientation write SetOrientation;
    property PaperSize : TQRPaperSize read GetPaperSize write SetPaperSize;
    property RightMargin : extended index 5 read GetValue write SetValue stored false;
    property Ruler : boolean read GetRuler write SetRuler default true;
    property TopMargin : extended index 2 read GetValue write SetValue stored false;
    property Width : extended index 3 read GetValue write SetValue stored false;
  end;

  { TQRBasePanel }
  TQRBasePanel = class(TCustomPanel)
  private
    FFontSize : integer;
    FZoom : integer;
    FFrame : TQRFrame;
    function GetFrame : TQRFrame;
    procedure SetFrame(Value : TQRFrame);
  protected
    procedure SetZoom(Value : integer); virtual;
    procedure Paint; override;
    procedure PaintRuler(Units : TQRUnit); virtual;
    procedure PrepareComponents;
    procedure UnprepareComponents;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Zoom : integer read FZoom write SetZoom;
    property FontSize : integer read FFontSize write FFontSize;
  published
    property Frame : TQRFrame read GetFrame write SetFrame;
  end;

  { TQRCustomBand }
  TQRBandBeforePrintEvent = procedure (Sender : TQRCustomBand; var PrintBand : Boolean) of object;

  TQRBandAfterPrintEvent = procedure (Sender : TQRCustomBand; BandPrinted : Boolean) of object;

  TQRCustomBand = class(TQRBasePanel)
  private
    FPreCaluculateBandHeight : boolean;
    FKeepOnOnePage : boolean;
    FExpandedHeight : extended;
    BandFrameRect : TRect;
    ButtonDown : boolean;
    FExpanded : extended;
    FAfterPrintEvent : TQRBandAfterPrintEvent;
    FAlignToBottom : boolean;
    FBeforePrintEvent : TQRBandBeforePrintEvent;
    FEnabled : boolean;
    FForceNewColumn : boolean;
    FForceNewPage : boolean;
    FLinkBand : TQRCustomBand;
    FParentReport : TCustomQuickRep;
    FParentUpdating : boolean;
    FTransparentBand : boolean;
    FQRBandType : TQRBandType;
    LoadedHeight : integer;
    FSize : TQRBandSize;
    FNotifyController : TQRCustomController;
    procedure SetLinkBand(Value : TQRCustomBand);
    function GetBandSize : TQRBandSize;
    function GetHasChild : boolean;
    function GetChild : TQRChildBand;
    procedure SetBandType(Value : TQRBandType);
    procedure SetHasChild(Value : boolean);
  protected
    function GetUnits : TQRUnit;
    function StretchHeight(IncludeNext : boolean) : extended;
    function BandTypeName : string; virtual;
    function BandComponentName : string; virtual;
    procedure AdvancePaper;
    procedure Loaded; override;
    procedure MakeSpace;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure PaintRuler(Units : TQRUnit); override;
    procedure Print;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetParentReport(AParentReport : TCustomQuickRep); virtual;
    procedure SetBandSize(Value : TQRBandSize);
    procedure SetEnabled(Value : boolean); override;
    procedure SetUnits(Value : TQRUnit);
    procedure SetZoom(Value : integer); override;
    procedure WriteDummy(Writer : TWriter); virtual;
    property NotifyController : TQRCustomController read FNotifyController write FNotifyController;
    property ParentUpdating : boolean read FParentUpdating write FParentUpdating;
    property Units : TQRUnit read GetUnits write SetUnits;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;
    function AddPrintable(PrintableClass : TQRNewComponentClass) : TQRPrintable;
    function CanExpand(Value : extended) : boolean;
    function ExpandBand(Value : extended; var NewExpanded : extended; var HasExpanded : boolean): boolean;
    property Expanded : extended read FExpanded;
    property BandType : TQRBandType read FQRBandType write SetBandType;
    property ChildBand : TQRChildBand read GetChild;
    property ParentReport : TCustomQuickRep read FParentReport write SetParentReport;
    procedure ExpandedHeight( var NewHeight : extended );
  published
    property AfterPrint : TQRBandAfterPrintEvent read FAfterPrintEvent write FAfterPrintEvent;
    property AlignToBottom : boolean read FAlignToBottom write FAlignToBottom;
    property BeforePrint : TQRBandBeforePrintEvent read FBeforePrintEvent write FBeforePrintEvent;
    property Color;
    property Enabled : boolean read FEnabled write SetEnabled default true;
    property TransparentBand : boolean read FTransparentBand write FTransparentBand;
    property Font;
    property ForceNewColumn : boolean read FForcenewColumn write FForceNewColumn;
    property ForceNewPage : boolean read FForceNewPage write FForceNewPage;
    property HasChild : boolean read GetHasChild write SetHasChild stored false;
    property LinkBand : TQRCustomBand read FLinkBand write SetLinkBand;
    property ParentFont;
    property Size : TQRBandSize read GetBandSize write SetBandSize;
    property PreCaluculateBandHeight : boolean  read FPreCaluculateBandHeight write FPreCaluculateBandHeight;
    property KeepOnOnePage : boolean  read FKeepOnOnePage write FKeepOnOnePage;

  end;

  { TQRBand }
  TQRBand = class(TQRCustomBand)
  published
    property BandType;
    property TransparentBand;
    property PreCaluculateBandHeight;
    property KeepOnOnePage;
  end;

  { TQRWildBand }
  TQRWildBand = class(TQRCustomBand)
  protected
    FPrintNow : boolean;
    procedure SetPrintNow( value : boolean );
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    property PrintNow : boolean read FPrintNow write SetPrintNow;
  end;

  { TQRChildBand }
  TQRChildBand = class(TQRCustomBand)
  private
    FParentBand : TQRCustomBand;
    FPrintOrder : TCBPrintOrder;
    procedure SetParentBand(Value : TQRCustomBand);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property ParentBand : TQRCustomBand read FParentBand write SetParentBand;
    property PrintOrder : TCBPrintOrder read FPrintOrder write FPrintOrder;
  end;

  { TQRControllerBand }
  TQRControllerBand = class(TQRCustomBand)
  private
    LocalVarCreated : boolean;
    FController : TQRCustomController;
    FMaster : TComponent;
  protected
    function GetPrintIfEmpty : boolean;
    function GetPrintBefore : boolean;
    procedure SetPrintBefore(Value : boolean);
    procedure CreateController; virtual;
    procedure RegisterBands; virtual;
    procedure SetMaster(Value : TComponent); virtual;
    procedure SetName(const NewName : TComponentName); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetParentReport(AParentReport : TCustomQuickRep); override;
    procedure CreateLocalVar; virtual;
    procedure RemoveLocalVar; virtual;
    function LocalVarExpression : string; virtual;
    procedure SetPrintIfEmpty(Value : boolean);
    property Controller : TQRCustomController read FController write FController;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property PrintIfEmpty : boolean read GetPrintIfEmpty write SetPrintIfEmpty;
    property PrintBefore : boolean read GetPrintBefore write SetPrintBefore;
  published
    property Master : TComponent read FMaster write SetMaster;
  end;

  { TQRSubDetailGroupBands }
  TQRSubDetailGroupBands = class(TPersistent)
  private
    Owner : TQRSubDetail;
    function GetFooterBand : TQRCustomBand;
    function GetHasFooter : boolean;
    function GetHasHeader : boolean;
    function GetHeaderBand : TQRCustomBand;
    procedure SetHasFooter(Value : boolean);
    procedure SetHasHeader(Value : boolean);
  public
    constructor Create(AOwner : TQRSubDetail);
    property FooterBand : TQRCustomBand read GetFooterBand;
    property HeaderBand : TQRCustomBand read GetHeaderBand;
  published
    property HasFooter : boolean read GetHasFooter write SetHasFooter stored false;
    property HasHeader : boolean read GetHasHeader write SetHasHeader stored false;
  end;

  { TQRSubDetail }
  TQRSubDetail = class(TQRControllerBand)
  private
    FBands : TQRSubDetailGroupBands;
    function GetDataSet : TDataSet;
    function GetFooterBand : TQRCustomBand;
    function GetHeaderBand : TQRCustomBand;
    function GetOnNeedData : TQROnNeedDataEvent;
    procedure SetDataSet(Value :TDataSet);
    procedure SetFooterBand(Value : TQRCustomBand);
    procedure SetHeaderBand(Value : TQRCustomBand);
    procedure SetOnNeedData(Value : TQROnNeedDataEvent);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RegisterBands; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure AddNotifyClient(Value : TQRPrintable);
  published
    property Bands : TQRSubDetailGroupBands read FBands write FBands;
    property DataSet : TDataSet read GetDataSet write SetDataSet;
    property FooterBand : TQRCustomBand read GetFooterBand write SetFooterBand;
    property HeaderBand : TQRCustomBand read GetHeaderBand write SetHeaderBand;
    property OnNeedData : TQROnNeedDataEvent read GetOnNeedData write SetOnNeedData;
    property PrintBefore;
    property PrintIfEmpty;
  end;

  { TQRLoopController }
  TQRLoopController = class(TQRCustomController)
  private
    FCount : integer;
    FPrintCount : integer;
    FDetailBand : TQRCustomBand;
  protected
    function LocalVarValue : TQREvResult; override;
    procedure RegisterBands; override;
  public
    constructor Create(AOwner : TComponent); override;
    procedure Execute; override;
    property Detail : TQRCustomBand read FDetailBand write FDetailBand;
    property PrintCount : integer read FPrintCount write FPrintCount;
    property Count : integer read FCount write FCount;
  end;

  { TQRLoopBand }
  TQRLoopBand = class(TQRControllerBand)
  protected
    function GetPrintCount : integer;
    procedure SetPrintCount(Value : integer);
    procedure CreateController; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function BandTypeName : string; override;
    function BandComponentName : string; override;
    function GetCount : integer;
    function LocalVarExpression : string; override;
  public
    constructor Create(AOwner : TComponent); override;
    property Count : integer read GetCount;
  published
    property PrintCount : integer read GetPrintCount write SetPrintCount;
    property PrintBefore;
  end;

  { TQRStringsController }
  TQRStringsController = class(TQRCustomController)
  private
    FItems : TStrings;
    FIndex : integer;
    FDetailBand : TQRCustomBand;
  protected
    function LocalVarValue : TQREvResult; override;
    procedure RegisterBands; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Execute; override;
    property Detail : TQRCustomBand read FDetailBand write FDetailBand;
    property Items : TStrings read FItems write FItems;
    property Index : integer read FIndex write FIndex;
  end;

  { TQRStringsBand }
  TQRStringsBand = class(TQRControllerBand)
  protected
    function GetIndex : integer;
    function GetItem : string;
    function GetItems : TStrings;
    function BandTypeName : string; override;
    function BandComponentName : string; override;
    function LocalVarExpression : string; override;
    procedure SetItems(Value : TStrings);
    procedure CreateController; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    property Item : string read GetItem;
    property Index : integer read GetIndex;
  published
    property Items : TStrings read GetItems write SetItems;
    property PrintBefore;
  end;

  { TQuickRepBands }
  TQuickRepBands = class(TPersistent)
  private
    FOwner : TCustomQuickRep;
    function BandInList(BandType : TQRBandType) : TQRCustomBand;
    procedure SetBand(BandType : TQRBandType; Value : boolean);
    function GetBand(Index : Integer) : TQRCustomBand;
    function GetHasBand(Index : integer) : boolean;
    procedure SetHasBand(Index : integer; Value : boolean);
  public
    constructor Create(AOwner : TCustomQuickRep);
    property TitleBand : TQRCustomBand index 1 read GetBand;
    property PageHeaderBand : TQRCustomBand index 2 read GetBand;
    property ColumnHeaderBand : TQRCustomBand index 3 read GetBand;
    property DetailBand : TQRCustomBand index 4 read GetBand;
    property ColumnFooterBand : TQRCustomBand index 5 read GetBand;
    property PageFooterBand : TQRCustomBand index 6 read GetBand;
    property SummaryBand : TQRCustomBand index 7 read GetBand;
  published
    property HasTitle : boolean index 1 read GetHasBand write SetHasBand stored false;
    property HasPageHeader : boolean index 2 read GetHasBand write SetHasBand stored false;
    property HasColumnHeader : boolean index 3 read GetHasBand write SetHasBand stored false;
    property HasDetail : boolean index 4 read GetHasBand write SetHasBand stored false;
    property HasPageFooter : boolean index 6 read GetHasBand write SetHasBand stored false;
    property HasSummary : boolean index 7 read GetHasBand write SetHasBand stored false;
  end;

  TQRState = (qrAvailable, qrPrepare, qrPreview, qrPrint, qrEdit);

  { TQuickRepPrinterSettings }
  TQuickRepPrinterSettings = class(TQRPrinterSettings)
  private
     FPrintMetaFile : boolean;
  published
    property Copies;
    property OutputBin; 
    property Duplex;
    property FirstPage;
    property LastPage;
    property UseStandardprinter;
    property UseCustomBinCode;
    property CustomBinCode;
    property ExtendedDuplex;
    property UseCustomPaperCode;
    property CustomPaperCode;
    property PrintMetaFile : boolean read FPrintMetaFile write FPrintMetaFile;
    // added in QR4
    property MemoryLimit;
    property PrintQuality;
    property Collate;
    property ColorOption;
  end;

  TQRCompositePrinterSettings = class(TQuickRepPrinterSettings)
  published
    property Orientation;
    property PaperSize;
    property MemoryLimit;
    property PrintQuality;
    property Collate;
    property ColorOption;
  end;

  { TQRCreateReportThread - class used to spawn background thread }
  TQRCreateReportThread = class(TThread)
  private
    FQRPrinter : TQRPrinter;
    FQuickRep : TCustomQuickRep;
  public
    constructor Create(AReport : TCustomQuickRep);
    procedure Execute; override;
    property QuickRep : TCustomQuickRep read FQuickRep write FQuickRep;
  end;

  TQuickReportOption = (FirstPageHeader,
                        LastPageFooter,
                        Compression);

  TQuickReportOptions = set of TQuickReportOption;

  { TQuickRep - QuickReport main class }
  TQRNotifyEvent = procedure (Sender : TCustomQuickRep) of object;

  TQRReportBeforePrintEvent = procedure (Sender : TCustomQuickRep; var PrintReport : Boolean) of object;

  TCustomQuickRep = class(TQRBasePanel)
  private
    BGThread : TQRCreateReportThread;
    FBackgroundImage : string;
    FBackgroundcontrol : TQRPrintable;
    BandRegList : TList;
    FAllDataSets : TList;
    FAfterPrintEvent : TQRAfterPrintEvent;
    FAfterPreviewEvent : TQRAfterPreviewEvent;
    FAvailable : boolean;
    FBandList : TList;
    FBands : TQuickRepBands;
    FBeforePrintEvent : TQRReportBeforePrintEvent;
    FCancelled : boolean;
    FBackgroundColor : TColor;
    FController : TQRCustomController;
    FColumnTopPosition : integer;
    FCurrentColumn : integer;
    FCurrentX : integer;
    FCurrentY : integer;
    FDescription : TStrings;
    FEnvironment : TQREvEnvironment;
    FExportFilter : TQRExportFilter;
    FExporting : boolean;
    FFinalPass : boolean;
    FHideBands : boolean;
    FLastPage : boolean;
    FModified : boolean;
    FOnEndPageEvent : TQRNotifyEvent;
    FOnNeedDataEvent : TQROnNeedDataEvent;
    FOnPreviewEvent : TNotifyEvent;
    FOnStartPageEvent : TQRNotifyEvent;
    FOptions : TQuickReportOptions;
    FPage : TQRPage;
    FPreviewPage : TMetafile;
    FPageFooterSize : extended;
    FPrinterSettings : TQuickRepPrinterSettings;
    FReportTitle : string;
    FRotateBands : integer;
    FShowProgress : boolean;
    FSnapToGrid : boolean;
    FState : TQRState;
    FQRPrinter : TQRPrinter;
    NewColumnForced : boolean;
    NewPageForced : boolean;
    ReferenceDC : THandle;
    PreparingDesignTime : boolean;
    EvPageNumber : TQREvElement;
    EvColumnNumber : TQREvElement;
    EvReportTitle : TQREvElement;
    NoForceNewPage : boolean;
    FPrevFormStyle : TFormStyle;
    FPreviewInitialState : TWindowState;
    FPreviewWidth : integer;
    FPreviewHeight : integer;
    FPagecount : integer;
    // qr4 :
    FPrevShowThumbs : boolean;
    FPrevShowSearch : boolean;
    FPrevInitialZoom : TQRZoomstate;
    FOnGetPrinterSettings : TQRPrinterEvent;
    FOnApplyPrinterSettings : TQRPrinterEvent;
    // QR5
    FOnPrevXEvent : TQRPreviewXEvent;
    FonStandPrevEvent : TQRStandPrevEvent;
    FPagesInPreview : integer;
    FPreviewDefaultSaveType : TPrevSaveType;
    function GetPreviewHeight : integer;
    function GetPreviewWidth : integer;
    function GetPrevShowThumbs : boolean;
    procedure SetPrevShowThumbs( value : boolean);
    function GetUnits : TQRUnit;
    function GetPrintIfEmpty : boolean;
    procedure PrintBand(ABand : TQRCustomBand);
    procedure PrintPageBackground;
    procedure SetExportFilter(Value : TQRExportFilter);
    procedure SetUnits(Value : TQRUnit); virtual;
    procedure SetDescription(Value : TStrings);
    procedure SetPrinterValues;
    procedure SetController(Value : TQRCustomController);
  protected
    procedure Execute; virtual;
    procedure CMPageAvailable(var Message : TCM_QRPageAvailable); Message CM_QRPAGEAVAILABLE;
    procedure CMPreviewClose(var Message : TCM_QRPreviewClose); Message CM_QRPREVIEWCLOSE;
    procedure CMPrint(var Message : TCM_QRPrint); Message CM_QRPRINT;
    function PrepareQRPrinter : boolean;
    procedure CreateReport(CompositeReport : boolean); virtual;
    procedure ForceNewColumn;
    procedure ForceNewPage;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PaintColumns; virtual;
    procedure PaintMargins; virtual;
    procedure PaintFrame; virtual;
    procedure PaintRuler(Units : TQRUnit); override;
    procedure PreviewFinished(Sender : TObject);
    procedure PreviewIt(Modal : boolean);
    procedure PrintFinished(Sender : TObject);
    procedure RebuildBandList;
    procedure RegisterBand(aBand : TQRCustomBand);
    procedure SetControllerBands; virtual;
    procedure SetPrintIfEmpty(Value : boolean); virtual;
    procedure SetHideBands(Value : boolean);
    procedure SetRotateBands(Value : integer);
    procedure SetZoom(Value : integer); override;
    property Controller : TQRCustomController read FController write SetController;
  public
    UserCancel : boolean; // QR5
    UserPrinterSettings : TQuickRepPrinterSettings;
    ParentComposite : TObject;
    constructor Create(AOwner : TComponent); override;
    constructor CreateNew(AOwner : TComponent; Dummy: Integer = 1); virtual;
    destructor Destroy; override;
    function AvailableSpace : integer;
    function CreateBand(BandType : TQRBandType) : TQRBand;
    function TextHeight(aFont : TFont; aText : string) : integer;
    function TextWidth(aFont : TFont; aText : string) : integer;
    procedure AddBand(aBand : TQRCustomBand);
    procedure AddNotifyClient(Value : TQRPrintable); virtual;
    procedure Cancel;
    procedure GetChildren(Proc: TGetChildProc; root: TComponent); override;
    // export
    procedure ExportComposite(AFilter : TQRExportFilter; expQRPrinter : TQRPrinter);
    procedure ExportToFilter(AFilter : TQRExportFilter);
    procedure EndPage;
    procedure Modify;
    procedure NewColumn;
    procedure NewPage;
    procedure Paint; override;
{$ifdef LLIONPDF}
    procedure PrintToPDF( PDFDocument : TPDFDocument );
    procedure StreamToPDF( PDFDocument: TPDFDocument; ostream : TStream );
{$endif}
    procedure Print;
    procedure PrintBackground;
    procedure PrinterSetup;
    procedure Prepare;
    procedure Preview;
    procedure PreviewXML;// QR5
    procedure PreviewModeless;
    procedure PreviewModal;
    procedure ResetPageFooterSize;
    procedure RemoveBand(aBand : TQRCustomBand);
    procedure SetBandValues;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Available : boolean read FAvailable;
    property AllDataSets : TList read FAllDataSets write FAllDataSets;
    property BandList : TList read FBandList;
    property Cancelled : boolean read FCancelled;
    property ColumnTopPosition : integer read FColumnTopPosition write FColumnTopPosition;
    property CurrentColumn : integer read FCurrentColumn;
    property CurrentX : integer read FCurrentX write FCurrentX;
    property CurrentY : integer read FCurrentY write FCurrentY;
    property ExportFilter : TQRExportFilter read FExportFilter write SetExportFilter;
    property Exporting : boolean read FExporting;
    property FinalPass : boolean read FFinalPass;
    property HideBands : boolean read FHideBands write SetHideBands;
    property PageNumber : integer read FPageCount;
    property Printer : TQRPrinter read FQRPrinter;
    property QRPrinter : TQRPrinter read FQRPrinter write FQRPrinter;
    property RotateBands : integer read FRotateBands write SetRotateBands;
    property State : TQRState read FState write FState;
    property AfterPrint : TQRAfterPrintEvent read FAfterPrintEvent write FAfterPrintEvent;
    property AfterPreview : TQRAfterPreviewEvent read FAfterPreviewEvent write FAfterPreviewEvent;
    property Bands : TQuickRepBands read FBands write FBands;
    property BeforePrint : TQRReportBeforePrintEvent read FBeforePrintEvent write FBeforePrintEvent;
    property Description : TStrings read FDescription write SetDescription;
    property BackImageControl : string read FBackgroundImage write FBackgroundImage;
    property Font;
    property Functions : TQREvEnvironment read FEnvironment write FEnvironment stored true;
    property OnEndPage : TQRNotifyEvent read FOnEndPageEvent write FOnEndPageEvent;
    property OnNeedData : TQROnNeedDataEvent read FOnNeedDataEvent write FOnNeedDataEvent;
    property OnPreview : TNotifyEvent read FOnPreviewEvent write FOnPreviewEvent;
    property OnStartPage : TQRNotifyEvent read FOnStartPageEvent write FOnStartPageEvent;
    property Options : TQuickReportOptions read FOptions write FOptions;
    property Page : TQRPage read FPage write FPage;
    property PrintIfEmpty : boolean read GetPrintIfEmpty write SetPrintIfEmpty;
    property PrinterSettings : TQuickRepPrinterSettings read FPrinterSettings write FPrinterSettings;
    property ReportTitle : string read FReportTitle write FReportTitle;
    property ShowProgress : boolean read FShowProgress write FShowProgress default true;
    property SnapToGrid : boolean read FSnapToGrid write FSnapToGrid;
    property Units : TQRUnit read GetUnits write SetUnits stored true;
    property Zoom;
    Property PrevFormStyle : TFormStyle read FPrevFormStyle write FPrevFormStyle;
    Property PreviewInitialState : TWindowState read FPreviewInitialState write FPreviewInitialState;
    Property PreviewWidth : integer read GetPreviewWidth write FPreviewWidth default 500;
    Property PreviewHeight : integer read GetPreviewHeight write FPreviewHeight default 500;
    // qr4
    Property PrevShowThumbs : boolean read GetPrevShowThumbs write SetPrevShowThumbs default true;
    Property PrevShowSearch : boolean read FPrevShowSearch write FPrevShowSearch default true;
    Property PrevInitialZoom : TQRZoomstate read FPrevInitialZoom write FPrevInitialZoom;
    property OnGetPrinterSettings : TQRPrinterEvent read FOnGetPrinterSettings write FOnGetPrinterSettings;
    property OnApplyPrinterSettings : TQRPrinterEvent read FOnApplyPrinterSettings write FOnApplyPrinterSettings;
    // QR5
    Property PreviewDefaultSaveType : TPrevSaveType read FPreviewDefaultSaveType write FPreviewDefaultSaveType;
    Property BackgroundColor : TColor read FBackgroundColor write FBackgroundColor default clWhite;
    property OnPrevXEvent : TQRPreviewXEvent read FOnPrevXEvent write FOnPrevXEvent;
    property OnStandPrevEvent : TQRStandPrevEvent read FOnStandPrevEvent write FOnStandPrevEvent;
    Property PagesInPreview : integer read FPagesInPreview write FPagesInPreview default 0;
  end;

  TQuickRep = class(TCustomQuickRep)
  private
    function GetDataSet : TDataSet;
    function GetRecordCount : integer;
    function GetRecordNumber : integer;
    procedure SetDataSet(Value : TDataSet);
  protected
    procedure Execute; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetControllerBands; override;
  public
    constructor CreateNew(AOwner : TComponent; Dummy: Integer = 1); override;
    destructor Destroy; override;
    property RecordCount : integer read GetRecordCount;
    property RecordNumber : integer read GetRecordNumber;
  published
    property AfterPrint;
    property AfterPreview;
    property BackImageControl;
    property Bands ;//: TQuickRepBands read FBands write FBands;
    property BeforePrint;
    property DataSet : TDataSet read GetDataSet write SetDataSet;
    property Description;
    property Font;
    property Functions;
    property OnEndPage;
    property OnNeedData;
    property OnPreview;
    property OnStartPage;
    property Options;
    property Page;
    property PrinterSettings;
    property PrintIfEmpty;
    property ReportTitle;
    property ShowProgress;
    property SnapToGrid;
    property Units;
    property Zoom;
    property OnGetPrinterSettings;
    property OnApplyPrinterSettings;
    Property PrevFormStyle;
    Property PreviewInitialState;
    Property PreviewWidth;
    Property PreviewHeight;
    // QR4
    Property PrevShowThumbs;
    Property PrevShowSearch;
    Property PrevInitialZoom;
    // QR5
    Property PreviewDefaultSaveType;
    Property BackgroundColor;
    property OnPrevXEvent;
    property OnStandPrevEvent;
    Property PagesInPreview;
  end;

  { TQuickReport }
  TQuickAbstractRep = class(TCustomQuickRep)
  published
    property AfterPrint;
    property AfterPreview;
    property Bands; // : TQuickRepBands read FBands write FBands;
    property BeforePrint;
    property Description;
    property Font;
    property Functions;
    property OnEndPage;
    property OnPreview;
    property OnStartPage;
    property Options;
    property Page;
    property PrinterSettings;
    property PrintIfEmpty;
    property ReportTitle;
    property Units;
    property Zoom;
  end;

  { TQRLabelSetup }
  {$hints off}
  TQRLabelSetup = class(TQRUnitBase)
  private
    FTopMargin : extended;
    FSideMargin : extended;
    FVerticalPitch : extended;
    FLabelWidth : extended;
    FLabelHeight : extended;
    FHorizontalPitch : extended;
    FNumberDown : integer;
    FNumberAcross : integer;
    FParent : TCustomQuickRep;
  protected
    function GetValue(Index : integer) : extended;
    function GetInteger(Index : integer) : integer;
    procedure SetValue(Index : integer; Value : extended);
    procedure SetInteger(Index : integer; Value : integer);
  public
    constructor Create(Parent : TCustomQuickRep);
  published
    property TopMargin : extended index 0 read GetValue write SetValue stored false;
    property SideMargin : extended index 1 read GetValue write SetValue stored false;
    property VerticalPitch : extended index 2 read GetValue write SetValue stored false;
    property LabelWidth : extended index 3 read GetValue write SetValue stored false;
    property LabelHeight : extended index 4 read GetValue write SetValue stored false;
    property HorizontalPitch : extended index 5 read GetValue write SetValue stored false;
    property NumberDown : integer index 0 read GetInteger write SetInteger stored false;
    property NumberAcross : integer index 1 read GetInteger write SetInteger stored false;
  end;
  {$hints on}

  TQuickLabelReport = class(TCustomQuickRep)
  private
    FLabelSetup : TQRLabelSetup;
  public
    constructor CreateNew(AOwner : TComponent; Dummy : integer); override;
    destructor Destroy; override;
  published
    property LabelSetup : TQRLabelSetup read FLabelSetup write FLabelSetup;
  end;

  { TQRGroup }
  TQRGroup = class(TQRCustomBand)
  private
    Evaluator : TQREvaluator;
    FExpression : string;
    FFooterBand : TQRBand;
    FMaster : TComponent;
    FReprint : boolean;
    FReprintOnNewPage : boolean;
    GroupValue : TQREvResult;
    HasResult : boolean;
    InGroup : boolean;
    PrintPageNumber : integer;
    procedure SetFooterBand(Value : TQRBand);
    procedure SetMaster(Value : TComponent);
  protected
    property Reprint : boolean read FReprint write FReprint;
    procedure Check;
    procedure NewPageCheck;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Prepare;
    procedure PrintGroupHeader;
    procedure PrintGroupFooter;
    procedure SetExpression(Value : string);
    procedure SetParent(AParent: TWinControl); override;
    procedure Unprepare;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Expression : string read FExpression write SetExpression;
    property FooterBand : TQRBand read FFooterBand write SetFooterBand;
    property Master : TComponent read FMaster write SetMaster;
    property ReprintOnNewPage : boolean read FReprintOnNewPage write FReprintOnNewPage;
  end;

  { TQRPrintableSize - Class storing size and positioning information for
    all printable objects }
  TQRPrintableSize = class(TQRUnitBase)
  private
    FHeight : extended;
    FLeft : extended;
    FTop : extended;
    FWidth : extended;
    Parent : TQRPrintable;
    function GetValue(Index : integer): extended;
    procedure SetValue(Index : integer; Value : extended);
  protected
    procedure SetParentSizes; override;
    procedure ReadValues(Reader : TReader); override;
    procedure WriteValues(Writer : TWriter); override;
    procedure FixZoom;
  public
    constructor Create(AParent : TQRPrintable);
  published
    property Height : extended index 0 read GetValue write SetValue stored false;
    property Left : extended index 1 read GetValue write SetValue stored false;
    property Top : extended index 2 read GetValue write SetValue stored false;
    property Width : extended index 3 read GetValue write SetValue stored false;
  end;

  { TQRPrintableEditor }
  TQRPrintableClass = class of TQRPrintable;
  TQRPrintableEditorClass = class of TQRPrintableEditor;

  TQRPrintableEditor = class(TObject)
  private
    FControl : TQRPrintable;
  protected
    function GetColor : TColor; virtual;
    function GetFont : TFont; virtual;
    function GetPrintableClass : TQRPrintableClass; virtual;
    function GetValue : string; virtual;
    function GetGlyphResName : string; virtual;
    function GetControlName : string; virtual;
{$ifndef QRSTANDARD}
    function GetAlignment : TAlignment; virtual;
    procedure SetAlignment(Value : TAlignment); virtual;
{$endif}
    procedure SetColor(Value : TColor); virtual; abstract;
    procedure SetFont(Value : TFont); virtual; abstract;
    procedure SetValue(Value : string); virtual; abstract;
  public
    constructor Create(AControl : TQRPrintable); virtual;
    function ShowEditor : boolean; virtual; abstract;
{$ifndef QRSTANDARD}
    property Alignment : TAlignment read GetAlignment write SetAlignment;
{$endif}
    property Control : TQRPrintable read FControl write FControl;
    property Color : TColor read GetColor write SetColor;
    property Font : TFont read GetFont write SetFont;
    property PrintableClass : TQRPrintableClass read GetPrintableClass;
    property Value : string read GetValue write SetValue;
    property GlyphResName : string read GetGlyphResName;
    property ControlName : string read GetControlName;
  end;

  { TQRPrintable - Base QuickReport printable object }
  TQRPrintable = class(TCustomControl)
  private
    { Private variables and methods }
    AlignUpdating : boolean;
    FAlignment : TAlignment;
    FAlignToBand : boolean;
    ButtonDown : boolean;
    FFrame : TQRFrame;
    FIsPrinting : boolean;
    FParentReport : TCustomQuickRep;
    FPrintFinished : boolean;
    FQRPrinter : TQRPrinter;
    FSize : TQRPrintableSize;
    LoadedTop : integer;
    LoadedWidth : integer;
    LoadedHeight : integer;
    LoadedLeft : integer;
    // QR5
    FExportAs : TExportType;
    function GetTransparent : boolean;
    procedure SetTransparent(Value : boolean);
    function GetZoom : integer;
    procedure SetAlignToBand(Value : boolean);
    procedure SetFrame(Value : TQRFrame);
  protected
    function IsEnabled : boolean; virtual;
    function GetEditorClass : TQRPrintableEditorClass; virtual;
    procedure AlignIt; virtual;
    procedure Loaded; override;
    procedure PaintCorners;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetZoom(Value : integer);
    procedure Paint; override;
    procedure Prepare; virtual;
    procedure Print(OfsX, OfsY : integer); virtual;
    procedure QRNotification(Sender : TObject; Operation : TQRNotifyOperation); virtual;
    procedure SetAlignment(Value : TAlignment); virtual;
    procedure UnPrepare; virtual;
    property Alignment : TAlignment read FAlignment write SetAlignment;
    property AlignToBand : boolean read FAlignToBand write SetAlignToBand;
    property IsPrinting : boolean read FIsPrinting write FIsPrinting;
    property PrintFinished : boolean read FPrintFinished write FPrintFinished;
    property QRPrinter : TQRPrinter read FQRPrinter write FQRPrinter;
    property Transparent : boolean read GetTransparent write SetTransparent;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetExpandedHeight(var newheight : extended ); virtual;
    procedure GetFieldString( var DataStr : string); virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property ParentReport : TCustomQuickRep read FParentReport write FParentReport;
    property Zoom : integer read GetZoom write SetZoom;
    property EditorClass : TQRPrintableEditorClass read GetEditorClass;
    property ExportAs : TexportType read FExportAs write FExportAs;
  published
    property Enabled;
    property Frame : TQRFrame read FFrame write SetFrame;
    property Size : TQRPrintableSize read FSize write FSize;
  end;

  { TQRCompositeReport - Component which combines several reports into one }

  TQRCompositeReport = class;

  TQRCompositeWinControl = class(TWinControl)
  protected
    ParentReport : TQRCompositeReport;
    procedure CMPreviewClose(var Message : TCM_QRPreviewClose); Message CM_QRPREVIEWCLOSE;
    procedure CMPrint(var Message : TCM_QRPrint); Message CM_QRPRINT;
  public
    destructor Destroy; override;
  end;

  TQRCompositeReport = class(TComponent)
  private
    FOnAddReports : TNotifyEvent;
    FOnFinished : TNotifyEvent;
    FOnStartReport : TCompositeEvent;
    FOptions : TQuickReportOptions;
    FPrinterSettings : TQRCompositePrinterSettings;
    FQRPrinter : TQRPrinter;
    FReports : TList;
    FIndex : integer;
    FReportTitle : string;
    FGenerating : boolean;
    aReport : TQuickRep;
    aWinControl : TQRCompositeWinControl;
    procedure CreateComposite;
    procedure SetPrinterValues;
  protected
    procedure CMPreviewClose(var Message : TCM_QRPreviewClose);
    procedure CMPrint(var Message : TCM_QRPrint);
    property Generating : boolean read FGenerating;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Prepare;
    // export
{$ifdef LLIONPDF}
    procedure PrintToPDF( pdfcont : TPDFDocument );
    procedure StreamToPDF( pdfcont : TPDFDocument; pdfstream : TStream );
{$endif}
    procedure ExportToFilter(AFilter : TQRExportFilter);
    procedure PrinterSetup;
    procedure Preview;
    procedure Print;
    property Index : integer read FIndex;
    property Reports : TList read FReports write FReports;
  published
    property OnAddReports : TNotifyEvent read FOnAddReports write FOnAddReports;
    property OnStartReport : TCompositeEvent read FOnStartReport write FOnStartReport;
    property OnFinished : TNotifyEvent read FOnFinished write FOnFinished;
    property Options : TQuickReportOptions read FOptions write FOptions;
    property PrinterSettings : TQRCompositePrinterSettings read FPrinterSettings write FPrinterSettings;
    property ReportTitle : string read FReportTitle write FReportTitle;
  end;

var
  debugext : extended;
  PrintMetafileFromPreview : boolean;
{$ifdef BDETABLES}
  procedure PerformSQLParamsUpdate(Query : TQuery; Environment : TQREvEnvironment);
{$endif}
  procedure SetQRHiColor;
  procedure SetQRLoColor;
  function UniqueName(AComponent : TComponent; Start : string) : string;


implementation

uses
  QRCtrls, CommDlg, QRPrnSu2 , qrframelines, qrxdocument;

const
  cQRBandTypeName : array[rbTitle..rbChild] of string =
    (SqrTitle, SqrPageHeader, SqrDetail, SqrPageFooter,
     SqrSummary, SqrGroupHeader, SqrGroupFooter, SqrSubDetail,
     SqrColumnHeader, SqrOverlay, SqrWild, SqrChild);

  cQRBandComponentName : array[rbTitle..rbChild] of string =
    (SqrTitleBandName, SqrPageHeaderBandName, SqrDetailBandName, SqrPageFooterBandName,
     SqrSummaryBandName, SqrGroupHeaderBandName, SqrGroupFooterBandName, SqrSubDetailBandName,
     SqrColumnHeaderBandName, SqrOverlayBandName, SqrWildBandName, SqrChildBandName);

{$R QUICKRPT.RES}

{ Misc. internal routines }

var
  GlobalCompositeFlag : boolean;
  cqrRulerMinorStyle : TPenStyle;
  cqrRulerMajorStyle : TPenStyle;
  cqrRulerMinorColor : TColor;
  cqrRulerMajorColor : TColor;
  cqrRulerFontName : string[30];
  cqrRulerFontColor : TColor;
  cqrRulerFontSize : integer;

  cqrMarginStyle : TPenStyle;
  cqrMarginColor : TColor;

  cqrBandFrameStyle : TPenStyle;
  cqrBandFrameColor : TColor;
  LocalMeasureInches : boolean;
  PageBroken : boolean;

  procedure PrintBitmap(aCanvas : TCanvas; Dest : TRect; Bitmap : TBitmap);
  var
    Info : PBitmapInfo;
    InfoSize : DWORD;
    Image : Pointer;
    ImageSize : DWord;
  begin
    with Bitmap do
    begin
      GetDIBSizes(Handle, InfoSize, ImageSize);
      Info := AllocMem(InfoSize);
      try
        Image := AllocMem(ImageSize);
        try
          GetDIB(Handle, Palette, Info^, Image^);
          if not Monochrome then
            SetStretchBltMode(ACanvas.Handle, STRETCH_DELETESCANS);
          with Info^.bmiHeader do
            StretchDIBits(aCanvas.Handle, Dest.Left, Dest.Top,
              Dest.RIght - Dest.Left, Dest.Bottom - Dest.Top,
              0, 0, biWidth, biHeight, Image, Info^, DIB_RGB_COLORS, SRCCOPY);
        finally
          FreeMem(Image, ImageSize);
        end;
      finally
        FreeMem(Info, InfoSize);
      end;
    end;
  end;
  
function UniqueName(AComponent : TComponent; Start : string) : string;
var
  i : integer;
begin
  i := 1;
  while AComponent.FindComponent(Start + IntToStr(I)) <> nil do
    inc(i);
  result := Start + IntToStr(I);
end;

function DataSetOK(ADataSet : TDataSet) : boolean;
begin
  Result := (ADataSet <> nil) and
    ADataSet.Active;
end;

function CharWidth(Size : integer):extended;
begin
  result := 80 / Size / 2.54;
end;

function CharHeight(Size : integer):extended;
begin
  result := 145.3 / Size / 2.54;
end;

function SnapToUnit(Value : extended; aUnit : TQRUnit) : extended;
begin
  case aUnit of
    Characters : Result := round(Value);
    MM : Result := round(Value)
  else
    Result := round(Value * 40) / 40;
  end
end;

{ TQRCustomController }

constructor TQRCustomController.Create(AOwner : TComponent);
begin
  inherited Create(nil);
  OrgOwner := AOwner;
  PrintAfterList := TList.Create;
  PrintBeforeList := TList.Create;
  GroupList := TList.Create;
  Master := nil;
  FSelfCheck := self;
  PrintBefore := false;
  PrintIfEmpty := true;
  NotifyList := TList.Create;
end;

destructor TQRCustomController.Destroy;
begin
  PrintAfterList.Free;
  PrintBeforeList.Free;
  GroupList.Free;
  NotifyList.Free;
  inherited Destroy;
end;

procedure TQRCustomController.AddAfter(aController : TQRCustomController);
begin
  PrintAfterList.Add(aController);
end;

procedure TQRCustomController.AddBefore(aController : TQRCustomController);
begin
  PrintBeforeList.Add(aController);
end;

function TQRCustomController.CheckGroups : boolean;
var
  I, J : integer;
begin
  result := false;
  for I := 0 to GroupList.Count - 1 do
  begin
    TQRGroup(GroupList[I]).Check;
    if TQRGroup(GroupList[I]).Reprint then
    begin
      result := true;
      for J := I + 1 to GroupList.Count - 1 do
        with TQRGroup(GroupList[J]) do
        begin
          GroupValue := Evaluator.Value;
          Reprint := true;
          HasResult := true;
        end;
      exit;
    end
  end
end;

procedure TQRCustomController.NewPageCheckGroups;
var
  I, J : integer;
  Reprint : boolean;
begin
  for I := 0 to GroupList.Count - 1 do
    if TQRGroup(GroupList[I]).Reprint then
      Exit;
  for I := 0 to PrintBeforeList.Count - 1 do
    TQRCustomController(PrintBeforeList[I]).NewPageCheckGroups;
  Reprint := false;
  for I := 0 to GroupList.Count - 1 do
  begin
    TQRGroup(GroupList[I]).NewPageCheck;
    if TQRGroup(GroupList[I]).Reprint then
    begin
      Reprint := true;
      for J := I + 1 to GroupList.Count - 1 do
        with TQRGroup(GroupList[J]) do
        begin
          GroupValue := Evaluator.Value;
          Reprint := true;
          HasResult := true;
        end;
      break;
    end
  end;
  if Reprint then PrintGroupHeaders;
  for I := 0 to PrintAfterList.Count - 1 do
    TQRCustomController(PrintAfterList[I]).NewPageCheckGroups;
end;

procedure TQRCustomController.PrintGroupHeaders;
var
  I : integer;
begin
  for I := 0 to GroupList.Count - 1 do
    if TQRGroup(GroupList[I]).Reprint then
      TQRGroup(GroupList[I]).PrintGroupHeader;
end;

procedure TQRCustomController.PrintGroupFooters;
var
  I : integer;
begin
  for I := GroupList.Count - 1 downto 0 do
    if TQRGroup(GroupList[I]).Reprint then
      TQRGroup(GroupList[I]).PrintGroupFooter;
end;

procedure TQRCustomController.SetMaster(Value : TComponent);
begin
  if (Value <> TControl(Self)) and
    ((Value is TCustomQuickRep) or (Value is TQRCustomController) or (Value is TQRControllerBand)) then
  begin
    FMaster := Value;
{$ifdef win32}
    if Assigned(Value) then Value.FreeNotification(Self);
{$endif}
  end
end;

procedure TQRCustomController.SetPrintBefore(Value : boolean);
begin
   FPrintBefore := Value;
end;

procedure TQRCustomController.CheckLastGroupFooters;
var
  I : integer;
begin
  for I := 0 to GroupList.Count - 1 do
    TQRGroup(GroupList[I]).Reprint := not TQRGroup(GroupList[I]).Reprint;
end;

procedure TQRCustomController.RegisterBands;
begin

end;

procedure TQRCustomController.BuildTree;
var
  Controller : TQRCustomController;
  Group : TQRGroup;

  procedure BuildTreeFrom(Component: TComponent);
  var
    I : integer;
  begin
    if Component = nil then Exit;
    for I := 0 to Component.ComponentCount - 1 do
    begin
      if (Component.Components[I] is TQRCustomController) or
         (Component.Components[I] is TQRControllerBand) then
      begin
        if (Component.Components[I] is TQRControllerBand) then
          Controller := TQRControllerBand(Component.Components[I]).Controller
        else
          Controller := TQRCustomController(Component.Components[I]);
        if (Controller <> nil) and (TQRCustomController(Controller.Master) = SelfCheck) then
        begin
          Controller.ParentReport := ParentReport;
          if Controller.PrintBefore then
            AddBefore(Controller)
          else
            AddAfter(Controller);
          Controller.BuildTree;
        end
      end;
      if (Component.Components[I] is TQRGroup) then
      begin
        Group := TQRGroup(Component.Components[I]);
        if (Group.Master = SelfCheck) and not (csDestroying in Group.ComponentState) then
        begin
          GroupList.Add(Group);
          Group.ParentReport := ParentReport;
        end
      end
    end
  end;

begin
  if not (csDestroying in ComponentState) then
  begin
    PrintBeforeList.Clear;
    PrintAfterList.Clear;
    GroupList.Clear;
    if SelfCheck is TQRCustomController then
      BuildTreeFrom(TQRCustomController(SelfCheck).OrgOwner)
    else
      BuildTreeFrom(SelfCheck.Owner);
    BuildTreeFrom(SelfCheck);
    RegisterDatasets;
  end;
end;

procedure TQRCustomController.RegisterDatasets;
begin
end;

procedure TQRCustomController.PrintBeforeControllers;
var
  I : integer;
begin
  for I := 0 to PrintBeforeList.Count - 1 do
    TQRCustomController(PrintBeforeList[I]).Execute;
end;

procedure TQRCustomController.PrintAfterControllers;
var
  I : integer;
begin
  for I := 0 to PrintAfterList.Count - 1 do
    TQRCustomController(PrintAfterList[I]).Execute;
end;

procedure TQRCustomController.PrintEmptyController;
begin
  PrintBeforeControllers;
  PrintAfterControllers;
end;

procedure TQRCustomController.Prepare;
var
  I : integer;
begin
  NotifyList.Clear;
  for I := 0 to PrintBeforeList.Count - 1 do
    TQRCustomController(PrintBeforeList[I]).Prepare;
  for I := 0 to PrintAfterList.Count - 1 do
    TQRCustomController(PrintAfterList[I]).Prepare;
  for I := 0 to GroupList.Count - 1 do
    TQRGroup(GroupList[I]).Prepare;
  EvConstant := ParentReport.Functions.GetConstant(OrgOwner.Name);
end;

function TQRCustomController.LocalVarValue : TQREvResult;
begin
  //result := TQREvResult.Create;
  Result.Kind := resError;
end;

procedure TQRCustomController.UpdateLocalVar;
begin
  ParentReport.Functions.SetConstant(EvConstant, LocalVarValue);
end;

procedure TQRCustomController.Unprepare;
var
  I : integer;
begin
  for I := 0 to PrintBeforeList.Count - 1 do
    TQRCustomController(PrintBeforeList[I]).Unprepare;
  for I := 0 to PrintAfterList.Count - 1 do
    TQRCustomController(PrintAfterList[I]).Unprepare;
  for I := 0 to GroupList.Count - 1 do
    TQRGroup(GroupList[I]).Unprepare;
end;

procedure TQRCustomController.Execute;
begin
  if PrintIfEmpty then
    PrintEmptyController;
end;

procedure TQRCustomController.AddNotifyClient(Value : TQRPrintable);
begin
  NotifyList.Add(Value);
end;

procedure TQRCustomController.NotifyClients(Operation : TQRNotifyOperation);
var
  I : integer;
begin
  for I := 0 to NotifyList.Count - 1 do
    TQRPrintable(NotifyList[I]).QRNotification(Self, Operation);
end;


{ TQRController }

procedure TQRController.RegisterBands;
var
  I : integer;
begin
  inherited RegisterBands;
  if assigned(FHeader) then ParentReport.RegisterBand(Header);
  for I := 0 to GroupList.Count - 1 do
    ParentReport.RegisterBand(TQRGroup(GroupList[I]));
  for I := 0 to PrintBeforeList.Count - 1 do
    TQRController(PrintBeforeList[I]).RegisterBands;
  if assigned(FDetail) then ParentReport.RegisterBand(Detail);
  for I := 0 to PrintAfterList.Count - 1 do
    TQRController(PrintAfterList[I]).RegisterBands;
  for I := GroupList.Count - 1 downto 0 do
    if TQRGroup(GroupList[I]).FooterBand <> nil then
      ParentReport.RegisterBand(TQRGroup(GroupList[I]).FooterBand);
  if assigned(FFooter) then ParentReport.RegisterBand(Footer);
end;

procedure TQRController.RegisterDatasets;
begin
  if DataSetOK(FDataSet) and (ParentReport.AllDataSets <> nil) then
    ParentReport.AllDataSets.Add(DataSet);
end;

procedure TQRController.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = Header then
      Header := nil;
    if AComponent = Detail then
      Detail := nil;
    if AComponent = Footer then
      Footer := nil;
    if AComponent = DataSet then
      DataSet := nil;
    if AComponent = Master then
      Master := nil;
  end
end;

procedure TQRController.PrintEmptyController;
begin
  if assigned(FHeader) then
  begin
    ParentReport.PrintBand(FHeader);
  end;
  PrintBeforeControllers;
  if assigned(FDetail) then
  begin
    ParentReport.PrintBand(FDetail);
  end;
  PrintAfterControllers;
  if assigned(FFooter) then
  begin
    ParentReport.PrintBand(FFooter);
  end;
end;

procedure TQRController.Prepare;
var
  I : integer;
begin
  inherited Prepare;
  {$ifdef BDETABLES}
  UpdateSQLParams := false;
  if (Dataset <> nil) and (Dataset is TQuery) and (TQuery(Dataset).ParamCount > 0) then
  begin
    for I := 0 to TQuery(Dataset).ParamCount - 1 do
      UpdateSQLParams := UpdateSQLParams or
        (ParentReport.Functions.IndexOf(AnsiUpperCase(TQuery(Dataset).Params.Items[I].Name)) >= 0);
  end;
  {$endif}
end;

procedure TQRController.Execute;
var
  MoreData : boolean;
  RecCount : integer;
  DSOK : boolean;
  I : integer;
begin
  RecCount := 1;
  for I := 0 to GroupList.Count - 1 do
    TQRGroup(GroupList[I]).HasResult := False ;
  if (DataSetOK(FDataSet) or assigned(FOnNeedDataEvent)) and
  assigned(FParentReport) then
  begin
    MoreData := true;
    DSOK := DataSetOK(FDataSet);
    if DSOK then
    begin
{$ifdef BDETABLES}
      if UpdateSQLParams then
        PerformSQLParamsUpdate(TQuery(Dataset), ParentReport.Functions);
{$endif}
      FDataSet.First;
      MoreData := not FDataSet.Eof;
      if ParentReport is TQuickRep then RecCount := TQuickRep(ParentReport).GetRecordCount;
      if (not Moredata) and PrintIfEmpty then
        PrintEmptyController;
    end else
    begin
      if assigned(FOnNeedDataEvent) and not (csDesigning in ComponentState) then
        OnNeedData(SelfCheck, MoreData);
    end;
    FDetailNumber := 0;
    if FDetail <> nil then
      FDetail.NotifyController := Self;
    if MoreData then
    begin
      Application.ProcessMessages;
      if Parentreport.Cancelled then exit;
      if assigned(FHeader) then
      begin
        ParentReport.PrintBand(FHeader);
        if (SelfCheck is TCustomQuickRep) then
          ParentReport.NoForceNewPage := true;
      end;
      if ((ParentReport.PageNumber <= 1) or GlobalCompositeFlag ) and
         (SelfCheck is TCustomQuickRep) then
      begin
         if (ParentReport.Bands.ColumnHeaderBand <> nil) and
            (ParentReport.Bands.ColumnHeaderBand.Enabled) then
         begin
           ParentReport.PrintBand(ParentReport.Bands.ColumnHeaderBand);
           ParentReport.NoForceNewPage := true;
         end;
      end;
      CheckGroups;
      self.FParentReport.UserCancel := false;
      while MoreData do
      begin
        Application.ProcessMessages;
        if ParentReport.QRPrinter.Cancelled then
          Exit;
        if ParentReport.PreparingDesignTime and (ParentReport.FPageCount > 1) then Exit;
        ExportingRecordNumber := FDetailNumber;
        inc(FDetailNumber);
        PrintGroupHeaders;
        PrintBeforeControllers;
        ParentReport.PrintBand(FDetail);
        PrintAfterControllers;
        if DSOK then
        begin
          DataSet.Next;
          MoreData := not FDataSet.Eof
        end else
        begin
          MoreData := false;
          if assigned(FOnNeedDataEvent) and not (csDesigning in ComponentState) then
            OnNeedData(SelfCheck, MoreData);
        end;
        if CheckGroups then
          begin
            if DSOK then
              DataSet.Prior;
            PrintGroupFooters;
            if DSOK then
              DataSet.Next;
        end;
        if ParentReport is TQuickRep and
          DSOK and  (TQuickRep(ParentReport).DataSet = DataSet) and (RecCount <> 0) then
            ParentReport.QRPrinter.Progress := (Longint(DetailNumber) * 100) div RecCount;
          // QR5
          MoreData := moredata and not FParentReport.UserCancel;
{$ifdef DEMO}
          MoreData := moredata and (FDetailNumber< 200);
{$endif}
          if FParentReport.PagesInPreview > 0 then
              MoreData := moredata and (FParentReport.QRPrinter.PageNumber <= FParentReport.PagesInPreview);
      end;
      CheckLastGroupFooters;
      PrintGroupFooters;
      if assigned(FFooter) then // this the summary band
      begin
        if (SelfCheck is TCustomQuickRep) and FFooter.AlignToBottom then;
                                      // ParentReport.FPageFooterSize := 0;
        if (FFooter <> nil) and (ParentReport.PageNumber = 0) then
               ParentReport.NewPage;
        // will the summary band fit ? PrintBand only checks for space
        // if AlignToBottom is true.
        if ParentReport.AvailableSpace < FFooter.Size.Height then
                ParentReport.NewColumn;
        ParentReport.PrintBand(FFooter);
      end;
    end
  end
  else
    if PrintIfEmpty then
      PrintEmptyController;
end;

procedure TQRController.SetDataSet(Value : TDataSet);
begin
  FDataSet := Value;
  if Value <> nil then
    FDataSet.FreeNotification(self);
end;

{ TQRGroup }

constructor TQRGroup.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Evaluator := TQREvaluator.Create;
  BandType := rbGroupHeader;
  InGroup := false;
end;

destructor TQRGroup.Destroy;
begin
  Evaluator.Free;
  inherited Destroy;
end;

procedure TQRGroup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FFooterBand then
      FFooterBand := nil;
    if AComponent = FMaster then
      FMaster := nil;
  end
end;

procedure TQRGroup.SetExpression(Value : string);
begin
  FExpression := Value;
end;

procedure TQRGroup.PrintGroupHeader;
begin
  ParentReport.PrintBand(Self);
  InGroup := true;
  PrintPageNumber := ParentReport.PageNumber;
end;

procedure TQRGroup.PrintGroupFooter;
begin
  if FooterBand <> nil then
  begin
    ParentReport.PrintBand(FooterBand);
  end;
  InGroup := false;
end;

procedure TQRGroup.NewPageCheck;
begin
  if ReprintOnNewPage and InGroup and (PrintPageNumber <> ParentReport.PageNumber) then
  begin
    Reprint := true;
    PrintPageNumber := ParentReport.PageNumber;
  end else
    Reprint := false;
end;

procedure TQRGroup.Check;
var
  aValue : TQREvResult;
begin
  //aValue := TQREvResult.Create;
  Reprint := false;
  if not HasResult then
  begin
    GroupValue := Evaluator.Value;
    Reprint := true;
    HasResult := true;
  end else
  begin
    aValue := Evaluator.Value;
    if aValue.Kind <> GroupValue.Kind then
      Reprint := true
    else
    begin
      case aValue.Kind of
        resString : Reprint := aValue.StrResult <> GroupValue.StrResult;
        resInt : Reprint := aValue.IntResult <> GroupValue.IntResult;
        resDouble : Reprint := aValue.dblResult <> GroupValue.dblResult;
        resBool : Reprint := aValue.booResult <> GroupValue.booResult;
      end
    end;
    if Reprint then GroupValue := aValue;
  end;
end;

procedure TQRGroup.SetFooterBand(Value : TQRBand);
begin
  FFooterBand := Value;
  if FFooterBand <> nil then
  begin
    FFooterBand.BandType := rbGroupFooter;
    FFooterBand.FreeNotification(self);
  end;
end;

procedure TQRGroup.SetMaster(Value : TComponent);
begin
  if (Value is TQRControllerBand) or
     (Value is TCustomQuickRep) then
  begin
    FMaster := Value;
    ParentReport.RebuildBandList;
    ParentReport.SetBandValues;
    FMaster.FreeNotification(self);
  end;
end;

procedure TQRGroup.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if (Master = nil) and (AParent is TCustomQuickRep) then
    Master := AParent;
end;

procedure TQRGroup.Prepare;
begin
  Evaluator.DataSets := ParentReport.AllDataSets;
  Evaluator.Environment := ParentReport.Functions;
  Evaluator.Prepare(Expression);
  HasResult := false;
  PrintPageNumber := 1;
end;

procedure TQRGroup.Unprepare;
begin
  Evaluator.Unprepare;
end;

{ TQRFrame }

constructor TQRFrame.Create;
begin
  FWidth := 1;
  FTop := false;
  FBottom := false;
  FLeft := false;
  FRight := false;
  FPenStyle := psSolid;
end;

// updared 16th March 2005 to paint frameline controls
procedure TQRFrame.PaintIt(ACanvas : TCanvas; ARect : TRect; XFact, YFact : extended);
var
  FWX, FWY : integer;
  // frames export
  framebit : TQRShape;
  parentrep : TCustomquickrep;
  parentcontrol : TQRPrintable;
  fbackcolor : TColor;
  PaintBackground : boolean;
//{$ifdef FRAMELINES}
  i, tempx : integer;
  procedure ExportFramelines;
  var
      i : integer;
  begin
    if fparent is TQRCustomband then
    begin
        for i := 0 to TQRCustomband(fparent).Controlcount-1 do
        begin
            if TQRCustomband(fparent).Controls[i] is TQRFrameline then
            begin
               tempx := TQRFrameline(TQRCustomband(fparent).Controls[i]).Left + ( TQRFrameline(TQRCustomband(fparent).Controls[i]).width div 2);
               tempx := arect.Left + round( 1.0*(arect.Right-arect.Left)* tempx/TQRCustomband(fparent).Width);
               framebit.Shape := qrsVertLine;
               framebit.left := tempx;
               framebit.top := ARect.top;
               framebit.Width := FWX;
               framebit.Height := arect.bottom-arect.top;
               TQRExportFilter(parentrep.ExportFilter).acceptgraphic( tempx, ARect.top, framebit );
            end;
         end;
    end;
  end;
//{$endif}

begin
  FWX := round(XFact / 72 * 254 * FWidth);
  if ((FWX < 1) and (FWidth >= 1)) or (FWidth = -1) then
    FWX := 1;
  FWY := round(YFact / 72 * 254 * FWidth);
  if ((FWY < 1) and (FWidth >= 1)) or (FWidth = -1) then
    FWY := 1;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := Color;
  SetPen(ACanvas.Pen);
  fbackcolor :=  clBlack;
  with aCanvas do
  begin
    if DrawTop then
      FillRect(Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Top + FWY));
    if DrawBottom then
      FillRect(Rect(ARect.Left, ARect.Bottom, ARect.Right, ARect.Bottom - FWY));
    if DrawLeft then
      FillRect(Rect(ARect.Left, ARect.Top, ARect.Left + FWX, ARect.Bottom));
    if DrawRight then
      FillRect(Rect(ARect.Right - FWX, ARect.Top, ARect.Right, ARect.Bottom));
  end;
  // export
  if fparent = nil then exit;
  try
  if fparent is TQRPrintable then
  begin
       parentrep := TQRPrintable(fparent).parentreport;
       parentcontrol := TQRPrintable(fparent);
       fbackcolor :=  parentcontrol.Color;
       PaintBackground := not parentcontrol.Transparent;
  end
  else if fparent is TQRCustomband then
  begin
       parentrep := TQRCustomband(fparent).parentreport;
       parentcontrol := nil;
       PaintBackground := false;
       // paint the Frameline controls
//{$ifdef FRAMELINES}
       for i := 0 to TQRCustomband(fparent).Controlcount-1 do
       begin
           if TQRCustomband(fparent).Controls[i] is TQRFrameline then
           begin
               acanvas.Pen.Style := psSolid;
               aCanvas.Pen.Width := FWX;
               tempx := TQRFrameline(TQRCustomband(fparent).Controls[i]).Left + ( TQRFrameline(TQRCustomband(fparent).Controls[i]).width div 2);
               tempx := arect.Left + round( 1.0*(arect.Right-arect.Left)* tempx/TQRCustomband(fparent).Width);
               aCanvas.MoveTo(tempx, ARect.Top);
               aCanvas.LineTo(tempx, ARect.Bottom);
           end;
       end;
//{$endif}
  end
  else if fparent is TCustomQuickrep then
  begin
       parentrep := TCustomQuickrep(fparent);
       parentcontrol := nil;
       PaintBackground := false;
  end
  else
      exit;
  ACanvas.Brush.Style := bsClear;
  if ParentRep<>nil then
   if parentrep.Exporting then
   begin
    framebit := TQRShape.Create( nil );
    framebit.Shape := qrsRectangle;
    if (parentcontrol <> nil) then
    begin
       if PaintBackground then
       begin
         framebit.Brush.style := bsSolid;
         framebit.Pen.Style := psClear;
         framebit.Brush.color := fbackcolor;
         framebit.left := ARect.Left;
         framebit.top := ARect.Top;
         framebit.Width := ARect.Right-arect.left;
         framebit.Height := arect.bottom-arect.top;
         TQRExportFilter(parentrep.ExportFilter).acceptgraphic( ARect.Left, ARect.Top, framebit );
       end;
    end;
    if DrawTop and DrawBottom and DrawLeft and DrawRight then
    begin
       framebit.Brush.style := bsClear;
       framebit.Pen.Style := psSolid;
       framebit.Pen.Width := FWX;
       framebit.Pen.color := self.FColor;
       framebit.left := ARect.Left;
       framebit.top := ARect.Top;
       framebit.Width := ARect.Right-arect.left;
       framebit.Height := arect.bottom-arect.top;
       TQRExportFilter(parentrep.ExportFilter).acceptgraphic( ARect.Left, ARect.Top, framebit );
//{$ifdef FRAMELINES}
       ExportFramelines; // theres another one at the bottom !!!
//{$endif}       
       framebit.free;
       exit; // all done
    end;
    framebit.Pen.Color := self.FColor;
    framebit.Pen.Style := psSolid;
    framebit.Brush.Style := bsClear;
    framebit.Pen.Width := FWX;
    if DrawTop then
    begin
          framebit.Shape := qrsHorLine;
          framebit.left := ARect.Left;
          framebit.top := ARect.Top;
          framebit.Width := ARect.Right-arect.left;
          framebit.Height := FWY;
          TQRExportFilter(parentrep.ExportFilter).acceptgraphic( ARect.Left, ARect.Top, framebit );
    end;
    if DrawBottom then
    begin
          framebit.Shape := qrsHorLine;
          framebit.left := ARect.Left;
          framebit.top := ARect.Bottom;
          framebit.Width := ARect.Right-arect.left;
          framebit.Height := FWY;
          TQRExportFilter(parentrep.ExportFilter).acceptgraphic( ARect.Left, ARect.bottom-FWY, framebit );
    end;
    if DrawLeft then
    begin
          framebit.Shape := qrsVertLine;
          framebit.left := ARect.Left;
          framebit.top := ARect.top;
          framebit.Width := FWX;
          framebit.Height := arect.bottom-arect.top;
          TQRExportFilter(parentrep.ExportFilter).acceptgraphic( ARect.Left, ARect.top, framebit );
    end;
    if DrawRight then
    begin
          framebit.Shape := qrsVertLine;
          framebit.left := ARect.right-FWX;
          framebit.top := ARect.top;
          framebit.Width := FWX;
          framebit.Height := arect.bottom-arect.top;
          TQRExportFilter(parentrep.ExportFilter).acceptgraphic( ARect.right-FWX, ARect.top, framebit );
    end;
//{$ifdef FRAMELINES}
    ExportFramelines;
//{$endif}
    framebit.free;
  end;
  except
  end;
end;

function TQRFrame.AnyFrame : boolean;
begin
  Result := FTop or FBottom or FLeft or FRight;
end;

procedure TQRFrame.SetColor(Value : TColor);
begin
  FColor := Value;
  Parent.Invalidate;
end;

procedure TQRFrame.SetParent(Value : TControl);
begin
  FParent := Value;
end;

procedure TQRFrame.SetStyle(Value : TPenStyle);
begin
  FPenStyle := Value;
  Parent.Invalidate;
end;

procedure TQRFrame.SetValue(Index : integer; Value : boolean);
begin
  case Index of
    0 : FTop := Value;
    1 : FBottom := Value;
    2 : FLeft := Value;
    3 : FRight := Value;
  end;
  Parent.Invalidate;
end;

procedure TQRFrame.SetWidth(Value : integer);
begin
  FWidth := Value;
  Parent.Invalidate;
end;

procedure TQRFrame.SetPen(APen : TPen);
begin
  aPen.Width := 1;
  aPen.Style := Style;
  aPen.Color := Color;
end;

{ TQRUnitBase }

constructor TQRUnitBase.Create;
begin
  if LocalMeasureInches then
    Units := Inches
  else
    Units := MM;
  SavedUnits := Units;
  FResolution := Screen.PixelsPerInch;
  FParentUpdating := false;
  FZoom := 100;
end;

function TQRUnitBase.GetUnits : TQRUnit;
begin
  result := FUnits;
end;

procedure TQRUnitBase.SetUnits(Value : TQRUnit);
begin
  FUnits := Value;
end;

function TQRUnitBase.LoadUnit(Value : extended; aUnit : TQRUnit; Horizontal : boolean): extended;
begin
  case aUnit of
    MM : result := Value / 10;
    Inches : result := Value / 254.0;
    Pixels : result := Value / (254 / Resolution) * Zoom / 100;
    Characters : if Horizontal then
                     result := Value/CharWidth(abs(ParentReport.Font.Size)) / 10
                   else
                     result := Value/CharHeight(abs(ParentReport.Font.Size)) / 10;
  else
    result := Value;
  end
end;

function TQRUnitBase.SaveUnit(Value : extended; aUnit : TQRUnit; Horizontal : boolean): extended;
begin
  case aUnit of
    MM : result := Value * 10;
    Inches : result := Value * 254.0;
    Pixels : result := Value * (254 / Resolution) / Zoom * 100;
    Characters : if Horizontal then
                     result := Value * CharWidth(abs(ParentReport.Font.Size)) * 10
                   else
                     result := Value * CharHeight(abs(ParentReport.Font.Size)) * 10;
  else
    result := Value;
  end;
end;

procedure TQRUnitBase.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('Values', ReadValues, WriteValues, true); // Do not translate
  inherited DefineProperties(Filer);
end;

procedure TQRUnitBase.SetPixels;
begin
  SavedUnits := Units;
  FUnits := Pixels;
end;

procedure TQRUnitBase.Loaded;
begin
  SetParentSizes;
end;

procedure TQRUnitBase.SetParentSizes;
begin
end;

procedure TQRUnitBase.ReadValues(Reader : TReader);
begin
end;

procedure TQRUnitBase.WriteValues(Writer : TWriter);
begin
end;

procedure TQRUnitBase.RestoreUnit;
begin
  FUnits := SavedUnits;
end;

{ TQRBandSize }

constructor TQRBandSize.Create(AParent : TQRCustomBand);
begin
  inherited Create;
  Parent := AParent;
  FWidth := 40;
  FLength := 20;
end;

procedure TQRBandSize.FixZoom;
begin
  SetParentSizes;
end;

function TQRBandSize.GetValue(Index : integer): extended;
begin
  if Index = 0 then
    result := LoadUnit(FLength, Units, false)
  else
    result := LoadUnit(FWidth, Units, true);
end;

procedure TQRBandSize.ReadValues(Reader : TReader);
begin
  Reader.ReadListBegin;
  FLength := Reader.ReadFloat;
  FWidth := Reader.ReadFloat;
  Reader.ReadListEnd;
end;

procedure TQRBandSize.SetParentSizes;
begin
  if assigned(Parent) then
  begin
    ParentUpdating := true;
    Parent.SetBounds(Parent.Left, Parent.Top,
                     round(LoadUnit(FWidth, Pixels, true)),
                     round(LoadUnit(FLength, Pixels, false)));
    ParentUpdating := false;
  end;
end;

procedure TQRBandSize.SetValue(Index : integer; Value : extended);
begin
  case Index of
    0 : FLength := SaveUnit(Value, Units, false);
    1 : FWidth := SaveUnit(Value, Units, true);
  end;
  SetParentSizes;
end;

procedure TQRBandSize.WriteValues(Writer : TWriter);
begin
  Writer.WriteListBegin;
  Writer.WriteFloat(FLength);
  Writer.WriteFloat(FWidth);
  Writer.WriteListEnd;
end;

{ TQRPage }

constructor TQRPage.Create(AParent : TCustomQuickRep);
begin
  inherited create;
  Parent := AParent;
  BottomMargin := 0;
  if LocalMeasureInches then
  begin
    Units := Inches;
    PaperSize := Letter;
    TopMargin := 0.5;
    BottomMargin := 0.5;
    RightMargin := 0.5;
    LeftMargin := 0.5;
  end else
  begin
    Units := MM;
    PaperSize := A4;
    TopMargin := 10;
    BottomMargin := 10;
    LeftMargin := 10;
    RightMargin := 10;
  end;
  FRuler := true;
  FColumns := 1;
  FPrintOrder := ColByCol;
end;

function TQRPage.GetValue(Index : integer): extended;
begin
  case index of
    0 : result := LoadUnit(FBottomMargin, Units, false);
    1 : result := LoadUnit(FLength, Units, false);
    2 : result := LoadUnit(FTopMargin, Units, false);
    3 : result := LoadUnit(FWidth, Units, true);
    4 : result := LoadUnit(FLeftMargin, Units, true);
    5 : result := LoadUnit(FRightMargin, Units, true);
  else
    result := LoadUnit(FColumnSpace, Units, true);
  end
end;

procedure TQRPage.FixZoom;
begin
  SetParentSizes;
end;

procedure TQRPage.ReadValues(Reader : TReader);
begin
  Reader.ReadListBegin;
  FBottomMargin := Reader.ReadFloat;
  FLength := Reader.ReadFloat;
  FTopMargin := Reader.ReadFloat;
  FWidth := Reader.ReadFloat;
  FLeftMargin := Reader.ReadFloat;
  FRightMargin := Reader.ReadFloat;
  FColumnSpace := Reader.ReadFloat;
  Reader.ReadListEnd;
  SetParentSizes;
end;

procedure TQRPage.SetColumns(Value : integer);
begin
  if (FColumns <> Value) and (Value > 0) then
  begin
    FColumns := Value;
    if assigned(Parent) then
    begin
      Parent.SetBandValues;
      Parent.Invalidate;
    end
  end
end;

procedure TQRPage.WriteValues(Writer : TWriter);
begin
  Writer.WriteListBegin;
  Writer.WriteFloat(FBottomMargin);
  Writer.WriteFloat(FLength);
  Writer.WriteFloat(FTopMargin);
  Writer.WriteFloat(FWidth);
  Writer.WriteFloat(FLeftMargin);
  Writer.WriteFloat(FRightMargin);
  Writer.WriteFloat(FColumnSpace);
  Writer.WriteListEnd;
end;

function TQRPage.GetPaperSize : TQRPaperSize;
begin
  Result := FPaperSize;
end;

function TQRPage.GetRuler : boolean;
begin
  Result := FRuler;
end;

procedure TQRPage.SetOrientation(Value : TPrinterOrientation);
begin
  FOrientation := Value;
  PaperSize := PaperSize;
end;

procedure TQRPage.SetParentSizes;
begin
  if not ParentUpdating and assigned(Parent) then
  begin
    ParentUpdating := true;
    Parent.Width := round(LoadUnit(FWidth, Pixels, true));
    Parent.Height := round(LoadUnit(FLength, Pixels, false));
    ParentUpdating := false;
  end;
end;

procedure TQRPage.SetValue(Index : integer; Value : extended);
begin
  case index of
    0 : begin
          FBottomMargin := SaveUnit(Value, Units, false);
          SetParentSizes;
          Parent.SetBandValues;
        end;
    1 : if PaperSize=Custom then
        begin
          FLength := SaveUnit(Value, Units, false);
          SetParentSizes;
          Parent.SetBandValues;
        end;
    2 : begin
          FTopMargin := SaveUnit(Value, Units, false);
          Parent.SetBandValues;
          Parent.Invalidate;
        end;
    3 : if PaperSize=Custom then
        begin
          FWidth := SaveUnit(Value, Units, true);
          SetParentSizes;
          Parent.SetBandValues;
        end;
    4 : begin
          FLeftMargin := SaveUnit(Value, Units, true);
          Parent.SetBandValues;
          Parent.Invalidate;
        end;
    5 : begin
          FRightMargin := SaveUnit(Value, Units, true);
          Parent.SetBandValues;
          Parent.Invalidate;
        end;
    6 : begin
          FColumnSpace := SaveUnit(Value, Units, true);
          Parent.SetBandValues;
          Parent.Invalidate;
        end;
  end;
end;

procedure TQRPage.SetRuler(Value : boolean);
begin
  if Value <> FRuler then
  begin
    FRuler := Value;
    if assigned(Parent) then
    begin
      Parent.Invalidate;
      Parent.Units := Parent.Units;
    end
  end
end;

procedure TQRPage.SetUnits(Value : TQRUnit);
begin
  inherited SetUnits(Value);
  if assigned(Parent) then
     Parent.Invalidate;
end;

procedure TQRPage.SetPaperSize(Value : TQRPaperSize);
begin
  if (Value <> Default) and (Value <> Custom) then
  begin
    SetPixels;
    Units := MM;
    PaperSize := Custom;
    if Orientation = poPortrait then
    begin
      Width := cQRPaperSizeMetrics[Value, 0];
      Length := cQRPaperSizeMetrics[Value, 1];
    end else
    begin
      Width := cQRPaperSizeMetrics[Value, 1];
      Length := cQRPaperSizeMetrics[Value, 0];
    end;
    RestoreUnit;
    Parent.SetBandValues;
  end;
  FPaperSize := Value;
end;

procedure TQRPage.SetPrintOrder(Value : TQRPrintOrder);
begin
  FPrintOrder := Value;
  Parent.SetBandValues;
end;

{ TQRBasePanel }
constructor TQRBasePanel.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FFrame := TQRFrame.Create;
  FFrame.Parent := Self;
  FontSize := 12;
  FZoom := 100;
end;

destructor TQRBasePanel.Destroy;
begin
  FFrame.Free;
  inherited Destroy;
end;

function TQRBasePanel.GetFrame : TQRFrame;
begin
  result := FFrame;
end;

procedure TQRBasePanel.SetFrame(Value : TQRFrame);
begin
  FFrame := Value;
  Invalidate;
end;

procedure TQRBasePanel.SetZoom(Value : integer);
var
  I : integer;
begin
  if Value <> 0 then
  begin
    FZoom := Value;
    for I := 0 to ControlCount - 1 do
    begin
      if Controls[I] is TQRPrintable then
        TQRPrintable(Controls[I]).Zoom := Value
      else if Controls[I] is TQRBasePanel then
        TQRBasePanel(Controls[I]).Zoom := Value;
    end
  end
end;

procedure TQRBasePanel.PaintRuler(Units : TQRUnit);
var
  TotalLines : integer;
  Resolution : integer;
  Factor : extended;
  PaintMinor : boolean;
  PaintNumbers : boolean;

  procedure PaintInches;
  var
    I : integer;
    Major : boolean;
  begin
    PaintMinor := Zoom > 49;
    with Canvas do
    begin
      Factor := Resolution / 4 * Zoom / 100;
      TotalLines := round(Width / Resolution / Zoom * 400);
      for i := 1 to TotalLines do
      begin
        if (i mod 4) = 0 then
        begin
          Pen.Color := cqrRulerMajorColor;
          Pen.Style := cqrRulerMajorStyle;
          Major := true;
        end else
        begin
          Pen.Color := cqrRulerMinorColor;
          Pen.Style := cqrRulerMinorStyle;
          Major := false;
        end;
        if PaintMinor or Major then
        begin
          MoveTo(round(I * Factor), 0);
          LineTo(round(I * Factor), height);
          if PaintNumbers and ((I mod 4) = 0) then TextOut(2 + round(I * Factor), 2, IntToStr(i div 4));
        end;
      end;
      TotalLines := round(Height / Resolution / Zoom * 400);
      for I := 1 to TotalLines do
      begin
        if (i mod 4) = 0 then
        begin
          Pen.Style := cqrRulerMajorStyle;
          Pen.Color := cqrRulerMajorColor;
          Major := true;
        end else
        begin
          Pen.Style := cqrRulerMinorStyle;
          Pen.Color := cqrRulerMinorColor;
          Major := false;
        end;
        if PaintMinor or Major then
        begin
          MoveTo(0, round(I * Factor));
          LineTo(Width,round(I * Factor));
          if ((I mod 4) = 0) and PaintNumbers then TextOut(2, 2 + round(I * Factor), IntToStr(i div 4));
        end
      end
    end
  end;

  procedure PaintMM;
  var
    I : integer;
    Major : boolean;
  begin
    PaintMinor := Zoom > 59;
    with Canvas do
    begin
      Factor := 1 / Resolution * 5.08 / Zoom * 100;
      TotalLines := round(Width * Factor);
      for I := 1 to TotalLines do
      begin
        if (I mod 2) = 1 then
        begin
          Pen.Style := cqrRulerMinorStyle;
          Pen.Color := cqrRulerMinorColor;
          Major := false;
        end else
        begin
          Pen.Color := cqrRulerMajorColor;
          Pen.Style := cqrRulerMajorStyle;
          Major := true;
          if PaintNumbers and PaintMinor then
            TextOut(2 + round(I / Factor), 2, IntToStr(I div 2));
        end;
        if PaintMinor or Major then
        begin
          MoveTo(round(I / Factor), 0);
          LineTo(round(I / Factor), Height);
        end
      end;
      TotalLines := round(Height * Factor);
      for I := 1 to TotalLines do
      begin
        if (I mod 2) = 1 then
        begin
          Pen.Color := cqrRulerMinorColor;
          Pen.Style := cqrRulerMinorStyle;
          Major := false;
        end else
        begin
          Pen.Style := cqrRulerMajorStyle;
          Pen.Color := cqrRulerMajorColor;
          Major := true;
          if PaintNumbers and PaintMinor then
            TextOut(2, 2 + round(I / Factor), IntToStr(I div 2));
        end;
        if PaintMinor or Major then
        begin
          MoveTo(0, round(I / Factor));
          LineTo(width, round(I / Factor));
        end
      end
    end
  end;

  procedure PaintCharacters;
  var
     I : integer;
  begin
    with Canvas do
    begin
      Pen.Style := psDot;
      TotalLines := round(Width / Resolution * 25.4 / CharWidth(FontSize) / 10);
      for I := 1 to TotalLines do
      begin
        MoveTo(round(I * CharWidth(FontSize) * Resolution / 2.54), 0);
        LineTo(Round(I * CharWidth(FontSize) * Resolution / 2.54), Height);
        if PaintNumbers then TextOut(2 + round(I * CharWidth(FontSize) * Resolution / 2.54), 2, IntToStr(I * 10));
      end;
      TotalLines := round(Height / Resolution * 25.4 / CharHeight(FontSize));
      for I := 1 to TotalLines do
      begin
        MoveTo(0, round(I * CharHeight(FontSize) * Resolution / 25.4));
        LineTo(Width, round(I * CharHeight(FontSize) * Resolution / 25.4));
        if PaintNumbers then TextOut(2, 2 + round(I * CharHeight(FontSize) * Resolution / 25.4), IntToStr(I));
      end
    end
  end;

begin
  with Canvas do
  begin
    Resolution := Screen.PixelsPerInch;
    Font.Name := cqrRulerFontName;
    Font.Size := cqrRulerFontSize;
    Font.Color := cqrRulerFontColor;
    Canvas.Pen.Color := clSilver;
    Pen.Width := 1;
    PaintNumbers := self is TCustomQuickRep;
    if Units = Inches then
      PaintInches
    else
      if Units = MM then
        PaintMM
      else
        if Units = Characters then
          PaintCharacters;
    Pen.Style := psSolid;
  end
end;

procedure TQRBasePanel.Paint;
begin
  with Canvas do
  begin
    if Enabled then
      Brush.Color := Color
    else
      Brush.Color := clSilver;
    Brush.Style := bsSolid;
    FillRect(ClientRect);
    Brush.Style := bsClear;
  end
end;

procedure TQRBasePanel.PrepareComponents;
var
  I : integer;
begin
  for I := 0 to ControlCount - 1 do
    if Controls[I] is TQRPrintable then
      TQRPrintable(Controls[I]).Prepare
    else
      if Controls[I] is TQRBasePanel then
        TQRBasePanel(Controls[I]).PrepareComponents;
end;

procedure TQRBasePanel.UnprepareComponents;
var
  I : integer;
begin
  for I := 0 to ControlCount - 1 do
    if Controls[I] is TQRPrintable then
      TQRPrintable(Controls[I]).Unprepare
    else
      if Controls[I] is TQRBasePanel then
        TQRBasePanel(Controls[I]).UnprepareComponents;
end;

procedure TQRBasePanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if Params.WndParent = 0 then Params.WndParent := Application.Handle;
end;

{ TQRCustomBand }

constructor TQRCustomBand.Create(AOwner : TComponent);
begin
  FSize := TQRBandSize.Create(Self);
  FParentUpdating := false;
  ParentReport := nil;
  inherited Create(AOwner);
  Align := alNone;
  Caption := '';
  Color := clWhite;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Enabled := true;
  ButtonDown := false;
  Height := 40;
  LoadedHeight := 40;
  FNotifyController := nil;
end;

destructor TQRCustomBand.Destroy;
begin
  if ParentReport <> nil then
    ParentReport.RemoveBand(Self);
  FSize.Free;
  inherited destroy;
end;

procedure TQRCustomBand.ExpandedHeight( var NewHeight : extended );
var
  I : integer;
  BottomGap : extended;
  theight : extended;
  pixfactor : extended;
begin
      FExpandedheight := size.height;
      pixfactor := 0.37795; // seems to be correct whichever canvas is in effect !
      bottomgap := 0;
      for I := 0 to ControlCount - 1 do
      begin
          if (Controls[I] is TQRDBText) or (Controls[I] is TQRDBImage)
               or (Controls[I] is TQRMemo) or (Controls[I] is TQRCustomRichText) then
          begin
             if TQRPrintable(Controls[I]).Enabled then
             begin
                if Controls[I] is TQRMemo then
                        TQRMemo(Controls[I]).GetExpandedHeight( theight )
                else if Controls[I] is TQRCustomRichText then
                        TQRCustomRichText(Controls[I]).GetExpandedHeight( theight )
                else
                        TQRPrintable(Controls[I]).GetExpandedHeight( theight );
                theight := (theight + Controls[I].top)/ pixfactor;
                if theight > FExpandedheight then
                begin
                   FExpandedheight := theight;
                   bottomgap := (self.height - Controls[I].top - Controls[I].height + 1)/ pixfactor;
                end;
            end;
          end;
      end;
      if bottomgap < 0 then bottomgap := 0;
      newheight := bottomgap + FExpandedheight;
end;

function TQRCustomBand.GetBandSize : TQRBandSize;
begin
  result := FSize;
end;

procedure TQRCustomBand.WriteDummy(Writer : TWriter);
begin
end;

procedure TQRCustomBand.Loaded;
begin
  inherited Loaded;
  Size.Loaded;
  if (LoadedHeight <> 40) and (Height = 40) then Height := LoadedHeight;
end;

function TQRCustomBand.GetChild : TQRChildBand;
var
  I : integer;
begin
  result := nil;
  if ParentReport <> nil then
  begin
    for I := 0 to ParentReport.BandList.Count - 1 do
    begin
      if (TQRCustomBand(ParentReport.BandList[I]).BandType = rbChild) and
         ((TQRChildBand(ParentReport.BandList[I]).ParentBand) = self) then
      begin
        result := TQRChildBand(ParentReport.BandList[I]);
        break;
      end
    end
  end
end;

function TQRCustomBand.BandTypeName : string;
begin
  Result := cQRBandTypeName[BandType];
end;

function TQRCustomBand.BandComponentName : string;
begin
  Result := cQRBandComponentName[BandType];
end;

function TQRCustomBand.GetHasChild : boolean;
begin
  result := (GetChild <> nil);
end;

procedure TQRCustomBand.SetEnabled(Value : boolean);
begin
  FEnabled := Value;
  inherited SetEnabled(Value);
  Invalidate;
end;

procedure TQRCustomBand.SetZoom(Value: integer);
begin
  inherited SetZoom(Value);
  Size.Zoom := Zoom;
  Size.FixZoom;
end;

procedure TQRCustomBand.SetHasChild(Value : boolean);
var
  aBand : TQRChildBand;
  aName : string;
  AComponent : TComponent;
begin
  if GetHasChild <> Value then
  begin
    if Value then
    begin
      if csDesigning in ComponentState then
      begin
        AComponent := Owner;
        while not (AComponent is TCustomForm) and (AComponent <> nil) do
          AComponent := AComponent.Owner;
        if AComponent <> nil then
          AName := TCustomForm(AComponent).Designer.UniqueName(cQRBandComponentName[rbChild]);
      end else
        AName := '';
      aBand := TQRChildBand.Create(Owner);
      aBand.Name := aName;
      aBand.Parent := Parent;
      aBand.ParentBand := self;
    end else
    begin
      aBand := GetChild;
      if aBand.HasChild then
        aBand.ChildBand.ParentBand := Self;
      aBand.Free;
    end
  end
end;

function TQRCustomBand.GetUnits : TQRUnit;
begin
  if assigned(FSize) then
    Result := FSize.Units
  else
    Result := Native;
end;

procedure TQRCustomBand.SetBandType(Value : TQRBandType);
begin
  FQRBandType := Value;
  if assigned(FParentReport) then
  begin
    ParentReport.RebuildBandList;
    ParentReport.SetBandValues;
  end
end;

procedure TQRCustomBand.SetBandSize(Value : TQRBandSize);
begin
  FSize := Value;
end;

procedure TQRCustomBand.SetParent(AParent: TWinControl);
begin
  if (Parent <> nil) and (Parent is TCustomQuickRep) then
    TCustomQuickRep(Parent).RemoveBand(Self);
  if (AParent <> nil) and (AParent is TQRCustomBand) then
    AParent := AParent.Parent;
  inherited SetParent(AParent);
  if (Parent <> nil) and (Parent is TCustomQuickRep) then
  begin
    ParentReport := TCustomQuickRep(AParent);
    ParentReport.AddBand(Self);
    Size.ParentReport := ParentReport;
    Zoom := ParentReport.Zoom;
  end;
end;

procedure TQRCustomBand.SetParentReport(AParentReport : TCustomQuickRep);
begin
  FParentReport := AParentReport;
end;

procedure TQRCustomBand.SetUnits(Value : TQRUnit);
var
  I : integer;
begin
  if assigned(FSize) then
     FSize.Units := Value;
  Invalidate;
  for I := 0 to ControlCount - 1 do
    if Controls[I] is TQRPrintable then TQRPrintable(Controls[I]).Size.Units := Value;
end;

procedure TQRCustomBand.Paint;
var
  aRect : TRect;
begin
  inherited Paint;
  if assigned(FParentReport) and ParentReport.Page.Ruler then
    PaintRuler(ParentReport.Units);
  with Canvas do
  begin
    Pen.Color := cqrBandFrameColor;
    Pen.Width := 1;
    Pen.Style := cqrBandFrameStyle;
    MoveTo(0, 0);
    LineTo(Width, 0);

    MoveTo(0, Height - 1);
    LineTo(Width - 1, Height - 1);

    MoveTo(0, 0);
    LineTo(0, Height - 1);

    MoveTo(Width - 1, 0);
    LineTo(Width - 1, Height - 1);
    aRect := GetClientRect;
    dec(aRect.Right);
    dec(aRect.Bottom);
    Frame.PaintIt(Canvas, aRect, Screen.PixelsPerInch / 254, Screen.PixelsPerInch / 254);
    Font.Name := cqrRulerFontName;
    Font.Size := cqrRulerFontSize;

    if BandType = rbChild then
      font.color := cqrRulerFontColor
    else
      font.color := cqrRulerFontColor;
    TextOut(2, Height - TextHeight('W') - 4, BandTypeName)
  end
end;

procedure TQRCustomBand.PaintRuler(Units : TQRUnit);
begin
  if ParentReport <> nil then
    FontSize := abs(ParentReport.Font.Size);
  inherited PaintRuler(Units);
end;

procedure TQRCustomBand.AdvancePaper;
begin
  ParentReport.CurrentY := ParentReport.CurrentY + round(Size.Length + Expanded );
end;

function TQRCustomBand.CanExpand(Value : extended) : boolean;
begin
  result := ParentReport.AvailableSpace >= round(Size.Length + Expanded + Value);
end;

function TQRCustomBand.ExpandBand(Value : extended; var NewExpanded : extended; var HasExpanded : boolean) : boolean;
begin
  Result := false;
  if CanExpand(Value) then
  begin
    if not HasExpanded and (Expanded > Value) then
    begin
      NewExpanded := Expanded;
      Result := true;
      HasExpanded := true;
      Exit;
    end else
    begin
      FExpanded := Expanded + Value;
      NewExpanded := Expanded;
      HasExpanded := true;
    end;
  end
end;

function TQRCustomBand.AddPrintable(PrintableClass : TQRNewComponentClass) : TQRPrintable;
var
  aPrintable : TQRPrintable;
  I : integer;
  MaxX : integer;
begin
  aPrintable := PrintableClass.Create(Owner);
  aPrintable.Parent := Self;
  MaxX := 1;
  for I := 0 to ControlCount-1 do
    if (Controls[I] is TQRPrintable) and
      ((TQRPrintable(Controls[I]).Left + TQRPrintable(Controls[I]).Width) > MaxX) then
      MaxX := TQRPrintable(Controls[I]).Left + TQRPrintable(Controls[I]).Width + 10;
  aPrintable.Left := MaxX;
  result := aPrintable;
end;

procedure TQRCustomBand.MakeSpace;
var
  AHeight : integer;
begin
  if (ParentReport.Page.PrintOrder = ColByCol) or (ParentReport.Page.Columns = 1) then
  begin
    AHeight := round(StretchHeight(True));
    if (BandType <> rbPageFooter) and (ParentReport.AvailableSpace < AHeight) 
      and (AHeight <= (ParentReport.Page.Length - (ParentReport.Page.TopMargin + ParentReport.Page.BottomMargin)))
       or (ParentReport.PageNumber = 0) then
    begin
      PageBroken := (bandtype in [rbDetail]);
      ParentReport.NewColumn;
    end
    else
      if BandType = rbDetail then PageBroken := false;
  end
  else
    begin
    end;
end;

procedure TQRCustomBand.Print;
var
  I : integer;
  OrgLength : extended;
  newHeight : extended;
  saveExpanded : extended;
  PrintBand : boolean;
  MyChild : TQRChildBand;
  AllFinished : boolean;
  FirstPass : boolean;
  startx, starty : extended;
  framebit : TQRShape;
  xpos : integer;
begin
  PrintBand := Enabled;
  startx := parentreport.currentx;
  starty := parentreport.currenty;
  if Enabled and assigned(FBeforePrintEvent) and not (csDesigning in ComponentState) then
    FBeforePrintEvent(Self, PrintBand);
  if BandType in [rbSummary] then
  begin
       // summary band multicolumn fix
       parentreport.currentx := round(parentreport.Page.LeftMargin);
  end;

  if PrintBand then
  begin
  if HasChild then
  begin
      MyChild := ChildBand;
      if MyChild.PrintOrder in [cboBeforeParent, cboBeforeAndAfter] then
      begin
       if BandType = rbPageFooter then
         MyChild.BandType := rbPageFooter;
       ParentReport.PrintBand(MyChild);
       MyChild.BandType := rbChild;
      end;
    end;
    if ForceNewPage and not PageBroken and
        not (BandType in [rbPageHeader, rbPageFooter, rbTitle, rbOverlay]) and (ParentReport.PageNumber > 0)
    then
    begin
      ParentReport.ForceNewPage;
      PageBroken := false;
    end
    else
      if ForceNewColumn and not (BandType in [rbPageHeader, rbPageFooter, rbTitle, rbOverlay]) and (ParentReport.PageNumber > 0) then
        ParentReport.ForceNewColumn
      else
      begin
        MakeSpace;
      end;
    if NotifyController <> nil then
      NotifyController.NotifyClients(qrMasterDataAdvance);
    if KeepOnOnePage then
    begin
          ExpandedHeight( newHeight);
          // there's no danger of getting stuck if the band
          // exceeds the full page size, because the striping behaviour
          // is still operating.
          if newHeight > ParentReport.AvailableSpace then
              ParentReport.NewColumn;
    end;
    // ************************* paint expanded height **************
    if not TransparentBand and Enabled then
    begin
       if PreCaluculateBandHeight then
                     ExpandedHeight( newHeight)
       else
          newheight := size.Length;
       orglength := size.Length;
       size.Length := newHeight;
       BandFrameRect := rect(ParentReport.QRPrinter.XPos(ParentReport.CurrentX),
                          ParentReport.QRPrinter.YPos(ParentReport.CurrentY),
                          ParentReport.QRPrinter.XPos(ParentReport.CurrentX + Size.Width),
                          ParentReport.QRPrinter.YPos(ParentReport.CurrentY + Size.Length));
       if parentreport.Exporting then
       begin
         framebit := TQRShape.Create(self);
         framebit.Shape := qrsRectangle;
         framebit.Brush.style := bsSolid;
         framebit.Pen.Style := psClear;
         framebit.Brush.color := color;
         framebit.left := BandFrameRect.Left;
         framebit.top := BandFrameRect.Top;
         framebit.Width := BandFrameRect.Right-BandFrameRect.left;
         framebit.Height := BandFrameRect.bottom-BandFrameRect.top;
         TQRExportFilter(parentreport.ExportFilter).acceptgraphic( BandFrameRect.Left, BandFrameRect.Top, framebit );
         framebit.Free;
       end;
       size.Length := orglength;
    end;
    if (Height <> 0) and Enabled then
    begin
      if ParentReport.FinalPass and not TransparentBand then
      begin
        with ParentReport.QRPrinter.Canvas do
        begin
          Brush.Color := Self.Color;
          Brush.Style := bsSolid;
          FillRect(BandFrameRect);
        end;
      end;
      FExpanded := 0;
      saveExpanded := 0;
      OrgLength := Size.Length;
      FirstPass := true;
      repeat
        AllFinished := true;
        for I := 0 to ControlCount - 1 do
        begin
          if Controls[I] is TQRPrintable then
          begin
            if TQRPrintable(Controls[I]).Enabled then
            begin
              FExpanded := 0; // every control must see the original band ...
              if FirstPass or not TQRPrintable(Controls[I]).PrintFinished then
                      TQRPrintable(Controls[I]).Print(ParentReport.CurrentX, ParentReport.CurrentY);
              AllFinished := AllFinished and TQRPrintable(Controls[I]).PrintFinished;
              if FExpanded > saveExpanded then saveExpanded := FExpanded; // ... but we need to know the expansion
            end;
          end;
        end;
        FExpanded := saveExpanded; // set the expanded after all controls are printed.
        if ParentReport.FinalPass or Parentreport.Exporting then
        begin
          BandFrameRect := rect(ParentReport.QRPrinter.XPos(ParentReport.CurrentX),
                                ParentReport.QRPrinter.YPos(ParentReport.CurrentY),
                                ParentReport.QRPrinter.XPos(ParentReport.CurrentX + Size.Width),
                                ParentReport.QRPrinter.YPos(ParentReport.CurrentY + Size.Length + FExpanded + 1));
          Frame.PaintIt(ParentReport.QRPrinter.Canvas, BandFrameRect, ParentReport.QRPrinter.XFactor,
                        ParentReport.QRPrinter.YFactor);
//{--------------------------------------------------
          // paint expanding control. Must be QRShape enabled=false
          for I := 0 to ControlCount - 1 do
          begin
            if Controls[I] is TQRShape then
            begin
               if (TQRShape(Controls[i]).Tag <> 1000) or (TQRShape(Controls[i]).Shape <> qrsVertLine) then continue;
               ParentReport.QRPrinter.canvas.Pen.Style := psSolid;
               ParentReport.QRPrinter.Canvas.Pen.Width := TQRShape(Controls[i]).pen.width;
               xpos := TQRShape(Controls[i]).Left + ( TQRShape(Controls[i]).width div 2);
               xpos := BandFrameRect.Left + round( 1.0*(BandFrameRect.Right-BandFrameRect.Left)* xpos/Width);
               ParentReport.QRPrinter.Canvas.MoveTo(xpos, BandFrameRect.Top);
               ParentReport.QRPrinter.Canvas.LineTo(xpos, BandFrameRect.Bottom);
               if ParentReport.Exporting then
               begin
                    TQRShape(Controls[i]).Brush.Style := bsClear;
                    TQRShape(Controls[i]).pen.Style := psSolid;
                    TQRShape(Controls[i]).Top := BandFrameRect.Top;
                    TQRShape(Controls[i]).Height := abs(BandFrameRect.Bottom - BandFrameRect.top);
                    parentReport.ExportFilter.AcceptGraphic(
                               ParentReport.QRPrinter.XPos(TQRShape(Controls[i]).size.left+ParentReport.CurrentX),
                               ParentReport.QRPrinter.YPos(TQRShape(Controls[i]).Size.Top),
                               Controls[i]);
               end;
            end;
          end;
//------------------------------------------------}
        end;
        if not AllFinished then
        begin
          PageBroken := true;
          ParentReport.NewColumn;
          PageBroken := false;
          Size.Height := OrgLength;
          FExpanded := 0;
          saveExpanded := 0;
        end;
        FirstPass := false;
      until AllFinished;
      AdvancePaper;
      Size.Length := OrgLength;
    end;
    if parentreport.Exporting then
      parentreport.ExportFilter.AcceptBand( self, startX, starty, FExpanded );
  end
  else if (NotifyController <> nil) and not Enabled then
      NotifyController.NotifyClients(qrMasterDataAdvance);
  if assigned(FAfterPrintEvent) and not (csDesigning in ComponentState) then
    FAfterPrintEvent(self, PrintBand);
  if HasChild then
  begin
    MyChild := ChildBand;
    if MyChild.PrintOrder in [cboAfterParent, cboBeforeAndAfter] then
    begin
      if BandType = rbPageFooter then
         MyChild.BandType := rbPageFooter;
       ParentReport.PrintBand(MyChild);
       MyChild.BandType := rbChild;
      end;
  end;
  pagebroken := false;
end;

procedure TQRCustomBand.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = LinkBand) then
    FLinkBand := nil;
end;

procedure TQRCustomBand.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  aUnit : TQRUnit;
  I : integer;
begin
  if (not assigned(FSize)) or (csLoading in ComponentState) then
  begin
    if csLoading in ComponentState then
      if AHeight <> 40 then LoadedHeight := AHeight;
  end else
  begin
    if ParentReport = nil then
      inherited SetBounds(ALeft, ATop, AWidth, AHeight);
    if Size.ParentUpdating then
    begin
      inherited SetBounds(ALeft, ATop, AWidth, AHeight);
      if not ParentUpdating and assigned(FParentReport) then
        ParentReport.SetBandValues;
      for I := 0 to ControlCount - 1 do
        if Controls[I] is TQRPrintable then
          with TQRPrintable(Controls[I]) do
            if AlignToBand then
              QRNotification(self, qrBandSizeChange);
    end else
    begin
      aUnit := Size.Units;
      Size.Units := Pixels;
      if aHeight <> Size.Length then Size.Length := aHeight;
{      if aWidth <> Size.Width then Size.Width := aWidth;}
      if (aTop <> Top) or (aLeft <> Left) then
      begin
        inherited SetBounds(aLeft, ATop, Width, Height);
        ParentReport.SetBandValues;
      end;
      Size.Units := aUnit;
      if assigned(ParentReport) then ParentReport.Modify;
    end;
  end;
end;

function TQRCustomBand.StretchHeight(IncludeNext : Boolean): extended;
begin
  Result := Size.Length;
  if Assigned(FLinkBand) and IncludeNext then
    Result := Result + LinkBand.StretchHeight(True) + LinkBand.Height;
end;

procedure TQRCustomBand.SetLinkBand(Value : TQRCustomBand);
var
  aBand : TQRCustomBand;
begin
  aBand := Value;
  while (aBand <> Self) and (aBand <> nil) do
    aBand := aBand.LinkBand;
  if aBand = nil then
    FLinkBand := Value
  else
  begin
    if csDesigning in ComponentState then
      ShowMessage(SqrNoCircular);
  end;
end;

{ TQRWildBand }
procedure TQRWildBand.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
  end;
end;

constructor TQRWildBand.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  BandType := rbWild;
end;

procedure TQRWildBand.SetPrintNow( value : boolean );
begin
   if value then
     self.Print;// print it
   FPrintNow := false;
end;

{ TQRChildBand }

constructor TQRChildBand.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  BandType := rbChild;
end;

procedure TQRChildBand.SetParentBand(Value : TQRCustomBand);
var
  aBand : TQRCustomBand;
begin
  aBand := Value;
  while (aBand <> Self) and (aBand <> nil) do
  begin
    if aBand is TQRChildBand then
      aBand := TQRChildBand(aBand).ParentBand
    else
      aBand := nil;
  end;
  if aBand = nil then
  begin
    if ParentReport <> nil then
    begin
      FParentBand := Value;
      if not (csDestroying in ParentReport.ComponentState) then
      begin
        ParentReport.RebuildBandList;
        ParentReport.SetBandValues;
      end;
    end
  end else
  begin
    if csDesigning in ComponentState then
      ShowMessage(SqrNoCircular);
  end;
end;

procedure TQRChildBand.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = ParentBand then
      ParentBand := nil;
  end
end;

{ TQRControllerBand }

constructor TQRControllerBand.Create(AOwner : TComponent);
begin
  CreateController;
  FController.SelfCheck := Self;
  LocalVarCreated := false;
  PrintBefore := false;
  inherited Create(AOwner);
end;

destructor TQRControllerBand.Destroy;
begin
  FController.Free;
  FController := nil;
  inherited Destroy;
end;

procedure TQRControllerBand.CreateController;
begin
  FController := TQRController.Create(self);
  TQRController(FController).Detail := Self;
  TQRController(FController).Header := nil;
  TQRController(FController).Footer := nil;
end;

procedure TQRControllerBand.SetPrintBefore(Value : boolean);
begin
  if Value <> PrintBefore then
  begin
    Controller.PrintBefore := Value;
    if ParentReport <> nil then
    begin
      ParentReport.RebuildBandList;
      ParentReport.SetBandValues;
    end;
  end
end;

function TQRControllerBand.GetPrintBefore : boolean;
begin
  Result := Controller.PrintBefore;
end;

procedure TQRControllerBand.SetName(const NewName : TComponentName);
begin
  if LocalVarCreated then RemoveLocalVar;
  inherited SetName(NewName);
  if ParentReport <> nil then CreateLocalVar;
end;

procedure TQRControllerBand.SetParentReport(AParentReport : TCustomQuickRep);
begin
  inherited SetParentReport(AParentReport);
  if (ParentReport <> nil) and not LocalVarCreated then
    CreateLocalVar;
end;

procedure TQRControllerBand.CreateLocalVar;
begin
  if LocalVarExpression <> '' then
  begin
    ParentReport.Functions.AddFunction(Name, LocalVarExpression);
    LocalVarCreated := true;
  end;
end;

procedure TQRControllerBand.RemoveLocalVar;
begin
  ParentReport.Functions.DeleteFunction(Name);
  LocalVarCreated := false;
end;

function TQRControllerband.LocalVarExpression : string;
begin
  Result := '';
end;

procedure TQRControllerBand.RegisterBands;
begin
  ParentReport.RegisterBand(Self);
end;

procedure TQRControllerBand.SetMaster(Value : TComponent);
var
  aComponent : TComponent;
begin
  if Value <> TControl(Self) then
  begin
    aComponent := Value;
    while (aComponent <> Self) and (aComponent <> nil) do
    begin
      if aComponent is TQRControllerBand then
        aComponent := TQRControllerBand(aComponent).Master
      else
        aComponent := nil;
    end;
    if aComponent = nil then
    begin
      FMaster := Value;
      Controller.Master := Value;
      if (ParentReport <> nil) and not (csDestroying in ParentReport.ComponentState) then
      begin
        ParentReport.RebuildBandList;
        ParentReport.SetBandValues;
      end;
      if Assigned(Value) then Value.FreeNotification(Self);
    end else
    begin
      if csDesigning in ComponentState then
        ShowMessage(SqrNoCircular);
    end;
  end;
end;

procedure TQRControllerBand.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if (Master = nil) and (AParent is TCustomQuickRep) then
    Master := AParent;
end;

function TQRControllerBand.GetPrintIfEmpty : boolean;
begin
  Result := FController.PrintIfEmpty;
end;

procedure TQRControllerBand.SetPrintIfEmpty(Value : boolean);
begin
  FController.PrintIfEmpty := Value;
end;

{ TQRSubDetailGroupBands }

constructor TQRSubDetailGroupBands.Create(AOwner : TQRSubDetail);
begin
  inherited Create;
  Owner := AOwner;
end;

function TQRSubDetailGroupBands.GetHasFooter : boolean;
begin
  Result := Owner.FooterBand <> nil;
end;

function TQRSubDetailGroupBands.GetHasHeader : boolean;
begin
  Result := Owner.HeaderBand <> nil;
end;

function TQRSubDetailGroupBands.GetHeaderBand : TQRCustomBand;
begin
  Result := Owner.HeaderBand;
end;

function TQRSubDetailGroupBands.GetFooterBand : TQRCustomBand;
begin
  Result := Owner.FooterBand;
end;

procedure TQRsubDetailGroupBands.SetHasHeader(Value : boolean);
begin
  if Value then
  begin
    if not HasHeader then
      Owner.HeaderBand := Owner.ParentReport.CreateBand(rbGroupHeader)
  end else
  begin
    if HasHeader then
    begin
      HeaderBand.Free;
      Owner.HeaderBand := nil;
    end
  end
end;

procedure TQRSubDetailGroupBands.SetHasFooter(Value : boolean);
begin
  if Value then
  begin
    if not HasFooter then
      Owner.FooterBand := Owner.ParentReport.CreateBand(rbGroupFooter);
  end else
  begin
    if HasFooter then
    begin
      FooterBand.Free;
      Owner.FooterBand := nil;
    end
  end
end;

{ TQRSubDetail }

constructor TQRSubDetail.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  BandType := rbSubDetail;
  Bands := TQRSubDetailGroupBands.Create(Self);
end;

destructor TQRSubDetail.Destroy;
begin
  Bands.Free;
  inherited Destroy;
end;

procedure TQRSubDetail.AddNotifyClient(Value : TQRPrintable);
begin
  Controller.AddNotifyClient(Value);
end;

function TQRSubDetail.GetDataSet : TDataSet;
begin
  if (Controller <> nil) and (Controller is TQRController) then
    Result := TQRController(Controller).DataSet
  else
    Result := nil;
end;

function TQRSubDetail.GetOnNeedData : TQROnNeedDataEvent;
begin
  Result := TQRController(Controller).OnNeedData;
end;

procedure TQRSubDetail.SetDataSet(Value : TDataSet);
begin
  TQRController(Controller).DataSet := Value;
end;

procedure TQRSubDetail.SetOnNeedData(Value : TQROnNeedDataEvent);
begin
  TQRController(Controller).OnNeedData := Value;
end;

function TQRSubDetail.GetFooterBand : TQRCustomBand;
begin
  if Controller <> nil then
    Result := TQRController(Controller).Footer
  else
    Result := nil;
end;

function TQRSubDetail.GetHeaderBand : TQRCustomBand;
begin
  if Controller <> nil then
    Result := TQRController(Controller).Header
  else
    Result := nil;
end;

procedure TQRSubDetail.RegisterBands;
begin
  if not (csDestroying in ComponentState) then
  begin
    if HeaderBand <> nil then ParentReport.RegisterBand(HeaderBand);
    ParentReport.RegisterBand(Self);
    if FooterBand <> nil then ParentReport.RegisterBand(FooterBand);
  end;
end;

procedure TQRSubDetail.SetFooterBand(Value : TQRCustomBand);
begin
  with TQRController(Controller) do
  begin
    Footer := Value;
    if Footer <> nil then
    begin
      Footer.BandType := rbGroupFooter;
      Footer.FreeNotification(self);
    end;
  end
end;

procedure TQRSubDetail.SetHeaderBand(Value : TQRCustomBand);
begin
  with TQRController(Controller) do
  begin
    Header := Value;
    if Header <> nil then
    begin
      Header.BandType := rbGroupHeader;
      Header.FreeNotification(self);
    end
  end
end;

procedure TQRSubDetail.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FooterBand then
      FooterBand := nil;
    if AComponent = HeaderBand then
      HeaderBand := nil;
    if AComponent = DataSet then
      DataSet := nil;
    if AComponent = Master then
      Master := nil;
  end
end;

{ TQRLoopController }

constructor TQRLoopController.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FCount := 0;
end;

procedure TQRLoopController.RegisterBands;
var
  I : integer;
begin
  for I := 0 to PrintBeforeList.Count - 1 do
    TQRController(PrintBeforeList[I]).RegisterBands;
  ParentReport.RegisterBand(FDetailBand);
  for I := 0 to PrintAfterList.Count - 1 do
    TQRController(PrintAfterList[I]).RegisterBands;
end;

function TQRLoopController.LocalVarValue : TQREvResult;
begin
   //result := TQREvResult.Create;
   Result.Kind := resInt;
   Result.IntResult := Count;
end;

procedure TQRLoopController.Execute;
var
  I : integer;
begin
  for I := 0 to FPrintCount - 1 do
  begin
    FCount := I;
    UpdateLocalVar;
    PrintBeforeControllers;
    ParentReport.PrintBand(FDetailBand);
    PrintAfterControllers;
  end;
  FCount := 0;
end;

{ TQRLoopBand }

constructor TQRLoopBand.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  BandType := rbSubDetail;
end;

function TQRLoopBand.BandTypeName : string;
begin
  Result := SqrLoopBandType;
end;

function TQRLoopBand.LocalVarExpression : string;
begin
  Result := IntToStr(Count);
end;

function TQRLoopBand.BandComponentName : string;
begin
  Result := SqrLoopBandName;
end;

procedure TQRLoopBand.CreateController;
begin
  FController := TQRLoopController.Create(self);
  TQRLoopController(FController).Detail := Self;
end;

function TQRLoopBand.GetPrintCount : integer;
begin
  Result := TQRLoopController(Controller).PrintCount;
end;

procedure TQRLoopBand.SetPrintCount(Value : integer);
begin
  TQRLoopController(Controller).PrintCount := Value;
end;

function TQRLoopBand.GetCount : integer;
begin
  Result := TQRLoopController(FController).Count;
end;

procedure TQRLoopBand.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = Master then
      Master := nil;
  end
end;

{ TQRStringsController }

constructor TQRStringsController.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FIndex := -1;
  FItems := TStringList.Create;
end;

destructor TQRStringsController.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TQRStringsController.RegisterBands;
var
  I : integer;
begin
  for I := 0 to PrintBeforeList.Count - 1 do
    TQRController(PrintBeforeList[I]).RegisterBands;
  ParentReport.RegisterBand(FDetailBand);
  for I := 0 to PrintAfterList.Count - 1 do
    TQRController(PrintAfterList[I]).RegisterBands;
end;

function TQRStringsController.LocalVarValue : TQREvResult;
begin
  //Result := TQREvResult.Create;
  Result.Kind := resString;
  Result.StrResult := Items[Index];
end;

procedure TQRStringsController.Execute;
var
  I : integer;
begin
  for I := 0 to Items.Count - 1 do
  begin
    FIndex := I;
    UpdateLocalVar;
    PrintBeforeControllers;
    ParentReport.PrintBand(FDetailBand);
    PrintAfterControllers;
  end;
  FIndex := -1;
end;

{ TQRStringsBand }

constructor TQRStringsBand.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  BandType := rbSubDetail;
end;

function TQRStringsBand.BandTypeName : string;
begin
  Result := SqrStringsBandType;
end;

function TQRStringsBand.LocalVarExpression : string;
begin
  Result := '''''';
end;

function TQRStringsBand.BandComponentName : string;
begin
  Result := SqrStringsBandName;
end;

procedure TQRStringsBand.CreateController;
begin
  FController := TQRStringsController.Create(self);
  TQRStringsController(FController).Detail := Self;
end;

function TQRStringsBand.GetIndex : integer;
begin
  Result := TQRStringsController(Controller).Index;
end;

function TQRStringsBand.GetItem : string;
begin
  if Index >= 0 then
    Result := Items[Index]
  else
    Result := '';
end;

function TQRStringsBand.GetItems : TStrings;
begin
  Result := TQRStringsController(Controller).Items;
end;

procedure TQRStringsBand.SetItems(Value : TStrings);
begin
  TQRStringsController(Controller).Items.Assign(Value);
end;

procedure TQRStringsBand.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = Master then
      Master := nil;
  end
end;

{ TQuickRepBands }

constructor TQuickRepBands.Create(AOwner : TCustomQuickRep);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TQuickRepBands.BandInList(BandType : TQRBandType) : TQRCustomBand;
var
  I : integer;
begin
  result := nil;
  if assigned(FOwner) and (FOwner.BandList <> nil) then
  begin
    for I := 0 to FOwner.BandList.Count - 1 do
    begin
      if TQRCustomBand(FOwner.BandList[I]).BandType = BandType then
      begin
        result := TQRCustomBand(FOwner.BandList[I]);
        break;
      end
    end
  end
end;

function TQuickRepBands.GetHasBand(Index : integer) : boolean;
begin
  case Index of
    1 : result := BandInList(rbTitle) <> nil;
    2 : result := BandInList(rbPageHeader) <> nil;
    3 : result := BandInList(rbColumnHeader) <> nil;
    4 : result := BandInList(rbDetail) <> nil;
    5 : result := false;
    6 : result := BandInList(rbPageFooter) <> nil;
  else
    result := BandInList(rbSummary) <> nil;
  end
end;

function TQuickRepBands.GetBand(Index : integer) : TQRCustomBand;
begin
  case Index of
    1 : result := BandInList(rbTitle);
    2 : result := BandInList(rbPageHeader);
    3 : result := BandInList(rbColumnHeader);
    4 : result := BandInList(rbDetail);
    5 : result := nil;
    6 : result := BandInList(rbPageFooter);
  else
    result := BandInList(rbSummary);
  end;
end;

procedure TQuickRepBands.SetBand(BandType : TQRBandType; Value : boolean);
var
  aBand : TQRCustomBand;
begin
  if (BandInList(BandType) <> nil) <> Value then
  begin
    if Value then
      TCustomQuickRep(FOwner).CreateBand(BandType)
    else
    begin
      aBand := BandInList(BandType);
      aBand.Free;
    end
  end;
end;

procedure TQuickRepBands.SetHasBand(Index : integer; Value : boolean);
begin
  case Index of
    1 : SetBand(rbTitle, Value);
    2 : SetBand(rbPageHeader, Value);
    3 : SetBand(rbColumnHeader, Value);
    4 : SetBand(rbDetail, Value);
    5 : ;
    6 : SetBand(rbPageFooter, Value);
    7 : SetBand(rbSummary, Value);
  end;
end;

{ TQRCreateReportTread }

constructor TQRCreateReportThread.Create(AReport : TCustomQuickRep);
begin
  FQuickRep := AReport;
  FreeOnTerminate := true;
  FQRPrinter := AReport.QRPrinter;
  inherited Create(false);
end;

procedure TQRCreateReportThread.Execute;
begin
  FQuickRep.CreateReport(false);
  if FQuickRep.Cancelled then
    FQUickRep.QRPrinter.Free;
  FQuickRep.PreparingDesignTime := false;
end;

{ TCustomQuickRep }
constructor TCustomQuickRep.Create(AOwner : TComponent);
begin
  CreateNew(AOwner);
  if (ClassType <> TCustomQuickRep) and not (csDesigning in ComponentState) then
    InitInheritedComponent(Self, TCustomQuickRep)
end;

constructor TCustomQuickRep.CreateNew(AOwner : TComponent; Dummy: Integer);
begin
  inherited Create(AOwner);
  FController := TQRCustomController.Create(self);
  FController.ParentReport := Self;
  FController.SelfCheck := Self;
  FBandList := TList.Create;
  BandRegList := TList.Create;
  FEnvironment := TQREvEnvironment.Create;
  with FEnvironment do
  begin
    AddFunction('PAGENUMBER', '0'); // Do not translate
    AddFunction('COLUMNNUMBER', '0'); // Do not translate
    AddFunction('REPORTTITLE','''''');  // Do not translate
  end;
  FDescription := TStringList.Create;
  FBands := TQuickRepBands.Create(self);
  FPage := TQRPage.Create(self);
  FPrinterSettings := TQuickRepPrinterSettings.Create;
  UserPrinterSettings := TQuickRepPrinterSettings.Create;
  Color := clWhite;
  // QR5
  try
     Page.PaperSize := DefaultPrinterPaperSize;
  except
      Page.PaperSize := Default;
  end;
  FBackgroundColor := clWhite;
  Top := 0;
  Left := 0;
  Page.ParentReport := Self;
  SnapToGrid := True;
  State := qrAvailable;
  FReportTitle := '';
  FAvailable := true;
  FExporting := false;
  FFinalPass := true;
  FPrevShowThumbs := true;
  FPrevShowSearch := true;
  FExportFilter := nil;
  AfterPreview := nil;
  AfterPrint := nil;
  FAllDataSets := nil;
  ShowProgress := true;
  FHideBands := false;
  FRotateBands := 0;
  Options := [FirstPageHeader, LastPageFooter];
  if SysLocale.PriLangID <> LANG_JAPANESE then
  begin
    Font.Name := 'Arial'; { do not resource }
    Font.Size := 10;
  end;
  FPreviewPage := nil;
  ReferenceDC := CreateCompatibleDC(0);

  FQRPrinter := nil;
  if Owner is TCustomForm then
    TForm(Owner).Scaled := false;
  PreparingDesignTime := false;
  FModified := false;
  PrintMetafileFromPreview := false;
end;

destructor TCustomQuickRep.Destroy;
begin
  DeleteDC(ReferenceDC);
  if FEnvironment <> nil then FEnvironment.Free;
  FDescription.Free;
  FPrinterSettings.Free;
  UserPrinterSettings.Free;
  FPage.Free;
  BandRegList.Free;
  FBandList.Free;
  FBands.Free;
  Controller.Free;
  inherited Destroy;
end;

procedure TCustomQuickRep.SetController(Value : TQRCustomController);
begin
  if FController <> nil then FController.Free;
  FController := Value;
end;

procedure TCustomQuickRep.Modify;
begin
  if not FModified and not PreparingDesignTime then
  begin
    FModified := true;
    if FPreviewPage <> nil then
    begin
      FPreviewPage.Free;
      FPreviewPage := nil;
    end;
    invalidate;
  end;
end;

procedure TCustomQuickRep.Cancel;
begin
  if not Available then
  begin
    FCancelled := true;
    QRPrinter.Cancel;
  end;
end;

{$ifndef DELPHI6}
function TCustomQuickRep.CreateBand(BandType : TQRBandType) : TQRBand;
var
  Designer: IDesignerHook;
  BandOwner: TComponent;
  aName : string;
  aBand : TQRBand;

  function FindDesigner : IDesignerHook;
  var
    Component: TComponent;
  begin
    Result := nil;
    if csDesigning in ComponentState then
    begin
      Component := Owner;
      while not (Component is TCustomForm) and (Component <> nil) do
        Component := Component.Owner;
      Result := IDesignerHook(TCustomForm(Component).Designer);
    end
  end;

begin
  Designer := FindDesigner;
  BandOwner := nil;
  if Designer <> nil then BandOwner := Designer.GetRoot;
  if BandOwner = nil then BandOwner := Owner;
  if BandOwner = nil then BandOwner := Self;
  aBand := TQRBand.Create(BandOwner);
  Result := aBand;
  result.Parent := Self;
  result.BandType := BandType;
  if Designer <> nil then
  begin
    aName := Result.BandComponentName;
    if Copy(aName, 1, 1) = 'T' then
      aName := 'T'+ aName;
    Result.Name := Designer.UniqueName(aName);
    Designer.Modified;
  end else
    Result.Name := UniqueName(BandOwner, Result.BandComponentName);
end;
{$else}
function TCustomQuickRep.CreateBand(BandType : TQRBandType) : TQRBand;
var
  Designer : IDesignerHook;
  BandOwner: TComponent;
  aName : string;
  aBand : TQRBand;

  function FindDesigner : IDesignerHook;
  var
    Component: TComponent;
  begin
    Result := nil;
    if csDesigning in ComponentState then
    begin
      Component := Owner;
      while not (Component is TCustomForm) and (Component <> nil) do
        Component := Component.Owner;
      Result := TCustomForm(Component).Designer;
    end
  end;

begin
  Designer := FindDesigner;
  BandOwner := nil;
  if Designer <> nil then BandOwner := Designer.GetRoot;
  if BandOwner = nil then BandOwner := Owner;
  if BandOwner = nil then BandOwner := Self;
  aBand := TQRBand.Create(BandOwner);
  Result := aBand;
  result.Parent := Self;
  result.BandType := BandType;
  if Designer <> nil then
  begin
    aName := Result.BandComponentName;
    if Copy(aName, 1, 1) = 'T' then
      aName := 'T'+ aName;
    Result.Name := Designer.UniqueName(aName);
    Designer.Modified;
  end else
    Result.Name := UniqueName(BandOwner, Result.BandComponentName);
end;
{$endif}
function TCustomQuickRep.GetUnits : TQRUnit;
begin
  Result := Page.Units;
end;

function TCustomQuickRep.TextHeight(aFont : TFont; aText : string) : integer;
var
  SavedFont : THandle;
  Extent : TSize;
begin
  SavedFont := SelectObject(ReferenceDC, aFont.Handle);
  if GetTextExtentPoint(ReferenceDC, 'A', Length(aText), Extent) then
    result := Extent.cY
  else
    result := 0;
  SelectObject(ReferenceDC,SavedFont);
end;

function TCustomQuickRep.TextWidth(aFont : TFont; aText : string) : integer;
var
  SavedFont : THandle;
  Extent : TSize;
begin
  SavedFont := SelectObject(ReferenceDC, aFont.Handle);
  if GetTextExtentPoint(ReferenceDC, PChar(aText), Length(aText), Extent) then
    result := Extent.cX + 1
  else
    result := 0;
  SelectObject(ReferenceDC,SavedFont);
end;

procedure TCustomQuickRep.SetDescription(Value : TStrings);
begin
  FDescription.Assign(Value);
end;

function TCustomQuickRep.GetPrintIfEmpty : boolean;
begin
  Result := Controller.PrintIfEmpty
end;

function TCustomQuickRep.GetPrevShowThumbs : boolean;
begin
    result := FPrevShowThumbs;
end;

procedure TCustomQuickRep.SetPrevShowThumbs( value : boolean);
begin
    FPrevShowThumbs := value;
end;

function TCustomQuickRep.GetPreviewHeight : integer;
begin
     if FPreviewheight > 0 then
        Result := FPreviewHeight
     else
        result := 500;
end;

function TCustomQuickRep.GetPreviewWidth : integer;
begin
     if FPreviewWidth > 0 then
        Result := FPreviewWidth
     else
        result := 500;
end;

procedure TCustomQuickRep.SetPrintIfEmpty(Value : boolean);
begin
  Controller.PrintIfEmpty := Value;
end;

procedure TCustomQuickRep.AddNotifyClient(Value : TQRPrintable);
begin
  Controller.AddNotifyClient(Value);
end;

procedure TCustomQuickRep.SetHideBands(Value : boolean);
begin
  if Value <> FHideBands then
  begin
    FHideBands := Value;
    SetBandValues;
  end;
end;

procedure TCustomQuickRep.SetRotateBands(Value : integer);
begin
  if Value <> FRotateBands then
  begin
    FRotateBands := Value;
    RebuildBandList;
    SetBandValues;
  end;
end;

procedure TCustomQuickRep.SetZoom(Value : integer);
begin
  if (Value > 0) and (Value <= 300) then
  begin
    inherited SetZoom(Value);
    Page.Zoom := Zoom;
    Page.FixZoom;
    SetBandValues;
  end
end;

procedure TCustomQuickRep.AddBand(ABand : TQRCustomBand);
begin
  if FBandList.IndexOf(ABand) < 0 then
  begin
    FBandList.Add(ABand);
    RebuildBandList;
    SetBandValues;
  end;
end;

procedure TCustomQuickRep.ResetPageFooterSize;
var
  I : integer;
  aBand : TQRCustomBand;
begin
  FPageFooterSize := 0;
  for I := 0 to ControlCount - 1 do
  begin
    if Controls[I] is TQRCustomBand then
      with TQRCustomBand(Controls[I]) do
      begin
        if (BandType = rbPageFooter) and Enabled then
        begin
          FPageFooterSize := FPageFooterSize + Size.Length;
          aBand := TQRCustomBand(Self.Controls[I]);
          while aBand.HasChild do
          begin
            aBand := aBand.ChildBand;
            FPageFooterSize := FPageFooterSize + aBand.Size.Length;
          end;
        end;
      end
  end
end;

procedure TCustomQuickRep.PrintBand(ABand : TQRCustomBand);
var
  spaceleft, spacerequ : integer;
begin
  if ABand <> nil then
  begin
    if ABand.AlignToBottom then
    begin
      if (aBand.BandType = rbSummary) and (not (LastPageFooter in Options)) then
        FPageFooterSize := 0.0;
      spacerequ := round( aband.size.length + page.BottomMargin + FPageFooterSize );
      if Page.Orientation = poPortrait then
        spaceleft := round(QRPrinter.PaperLength) - CurrentY
      else
        spaceleft := round(QRPrinter.PaperWidth) - CurrentY;
      if spaceleft >= spacerequ then
      begin
         if Page.Orientation = poPortrait then
              CurrentY := round(QRPrinter.PaperLength) - round(aband.size.length) - round(page.BottomMargin + FPageFooterSize)
         else
              CurrentY := round(QRPrinter.PaperWidth) - round(aband.size.length) - round(page.BottomMargin + FPageFooterSize);
      end;
    end;
    ABand.Print;
  end;
end;


procedure TCustomQuickRep.ForceNewColumn;
begin
  if (not Available) then
  begin
    if NewColumnForced or (CurrentColumn > 1) then
      NewColumn
    else
      NewColumnForced := true;
  end;
end;

procedure TCustomQuickRep.ForceNewPage;
begin
  if not Available then
  begin
    if NoForceNewPage then
      NoForceNewPage := false
    else
      repeat
        NewColumn
      until CurrentColumn = 1
  end;
end;

procedure TCustomQuickRep.Execute;
begin
  Controller.Execute;
end;

procedure TCustomQuickRep.CreateReport(CompositeReport : boolean);
var
    k : integer;

  procedure AddAll(AOwner : TWinControl);
  var
    I : integer;
  begin
    for I := 0 to AOwner.ComponentCount - 1 do
      if AOwner.Components[I] is TDataset then
        FAllDatasets.Add(TDataset(AOwner.Components[I]))
      else
        if AOwner.Components[I] is TWinControl then
          AddAll(TWinControl(AOwner.Components[I]));
  end;

  procedure AddLocalDataSets;
  var
    AControl : TWinControl;
  begin
    AControl := Parent;
    while (not (AControl is TCustomForm)) and (AControl <> nil) do
      AControl := AControl.Parent;
    if AControl <> nil then
      AddAll(AControl);
  end;

  procedure UpdateChildren;
  var
    I : integer;
  begin
    for I := 0 to ControlCount - 1 do
    begin
      if Controls[I] is TQRCustomBand then
        TQRCustomBand(Controls[I]).ParentReport := self
      else
        if Controls[I] is TQRPrintable then
          TQRPrintable(Controls[I]).ParentReport := self;
    end;
  end;

var
  PrintReport : boolean;
  SavedUnits : TQRUnit;
  WasVisible : boolean;
begin
  if Available then
  begin
    WasVisible := Visible;
    if Visible then
      {visible := false};
    FPreviewPage := nil;
    if Page.Width - Page.LeftMargin - Page.RightMargin < 0 then
    begin
      Page.LeftMargin := 0;
      Page.RightMargin := 0;
    end;
    if Page.Length - Page.TopMargin - Page.BottomMargin < 0 then
    begin
      Page.TopMargin := 0;
      Page.BottomMargin := 0;
    end;
    FAvailable := false;
    FCancelled := false;
    FLastPage := false;
    NoForceNewPage := false;
    NewColumnForced := false;
    NewPageForced := false;
    PrintReport := true;
    FAllDataSets := TList.Create;
    try
      AddLocalDataSets;
      // find the BackgroundImage
      FBackgroundcontrol := nil;      
      for k := 0 to Controlcount-1 do
      begin
            if Controls[k] is TQRImage then
            begin
                if Controls[k].Name = BackImagecontrol then
                              FBackgroundcontrol := TQRImage( controls[k]);
            end;
      end;

      if assigned(FBeforePrintEvent) and not (csDesigning in ComponentState) then
        FBeforePrintEvent(Self, PrintReport);
      if PrintReport then
      try
        SavedUnits := Units;
        Units := Native;
        if not CompositeReport then
        begin
          SetPrinterValues;
          QRPrinter.Title := ReportTitle;
          QRPrinter.Compression := Compression in Options;
          QRPrinter.BeginDoc;
          FCurrentY := -1;
          FPageCount := 0;
          FCurrentColumn := Page.Columns;
        end else
        begin
          Page.PaperSize := QRPrinter.PaperSize;
          Page.Orientation := QRPrinter.Orientation;
          FCurrentColumn := Page.Columns;
        end;
        if Exporting and (not ExportFilter.Active) then
          ExportFilter.Start(round(Page.Width), round(Page.Length), Font);
        ResetPageFooterSize;
        UpdateChildren;
        FCurrentX := round(Page.LeftMargin);
        { Prepare Environments and Components }
        Controller.BuildTree;
        QRGlobalEnvironment.Prepare;
        Functions.Datasets := AllDatasets;
        with Functions do
        begin
          Prepare;
          EvPageNumber := GetConstant('PAGENUMBER');  // Do not translate
          EvColumnNumber := GetConstant('COLUMNNUMBER'); // Do not translate
          EvReportTitle := GetConstant('REPORTTITLE'); // Do not translate
          SetStringConstant(EvReportTitle, ReportTitle);
        end;
        Controller.Prepare;
        PrepareComponents;
        GlobalCompositeFlag := CompositeReport;
        Execute;
        if not CompositeReport then
        begin
          FCurrentX := round(Page.LeftMargin);
          FLastPage := true;
          if not Cancelled then
            EndPage;
          if Exporting then ExportFilter.Finish;
        end else
          if Tag = 999 then
          begin
            FLastPage := true;
            EndPage;
            // exports
            if Exporting then ExportFilter.Finish;
          end;
        Units := SavedUnits;
        { Unprepare Environments and Components }
        UnprepareComponents;
        Controller.Unprepare;
        Functions.Unprepare;
        QRGlobalEnvironment.Unprepare;
      finally
        if not Cancelled then
        begin
          if not CompositeReport then
          begin
            if FinalPass then
              QRPrinter.EndDoc
            else
              QRPrinter.AbortDoc;
          end
        end else
          QRPrinter.AbortDoc;
      end;
    finally
      FAllDataSets.Free;
      FAllDataSets := nil;
    end;
    Visible := WasVisible;
    FAvailable := true;
  end;
end;

procedure TCustomQuickRep.SetPrinterValues;
begin
   // this will cause the printer's devmode to be interrogated
   // and the printersettings values set..
   QRPrinter.PrinterIndex := PrinterSettings.PrinterIndex;
   // now we override with the designed values.
   QRPrinter.PaperSize := Page.PaperSize;

   if QRPrinter.PaperSize = Custom then
   begin
    QRPrinter.PaperWidth := round(Page.Width);
    QRPrinter.PaperLength := round(Page.Length);
   end;
   
   QRPrinter.Orientation := Page.Orientation;
   QRPrinter.Copies := PrinterSettings.Copies;
   QRPrinter.OutputBin := PrinterSettings.OutputBin;
   QRPrinter.FirstPage := PrinterSettings.FirstPage;
   QRPrinter.LastPage := PrinterSettings.LastPage;
   qrprinter.Duplex := PrinterSettings.Duplex;
   qrprinter.UseStandardPrinter := printersettings.UseStandardPrinter;
   qrprinter.PrintMetafile := printersettings.PrintMetaFile;
   qrprinter.UseCustomBinCode := printersettings.UseCustomBinCode;
   qrprinter.CustomBinCode := printersettings.CustomBinCode;
   qrprinter.UseCustomPaperCode := printersettings.UseCustomPaperCode;
   qrprinter.CustomPaperCode := printersettings.CustomPaperCode;
   qrprinter.PrintQuality := printersettings.PrintQuality;
   qrprinter.Collate := printersettings.Collate;
   qrprinter.ColorOption := printersettings.ColorOption;
   qrprinter.ExtendedDuplex := printersettings.ExtendedDuplex;
   qrprinter.OnApplyPrinterSettings := OnApplyPrinterSettings;
   qrprinter.OnGetPrinterSettings := OnGetPrinterSettings;
end;

{$ifdef LLIONPDF}
procedure TCustomQuickRep.PrintToPDF( PDFDocument: TPDFDocument);
var
  AProgress : TQRProgressForm;
  OldQRPrinter : TQRPrinter;
begin
  AProgress := nil;
  OldQRPrinter := QRPrinter;
  if PrepareQRPrinter and QRPrinter.PrinterOK then
  try
    QRPrinter.PDFDoc := PDFDocument;
    PDFDocument.OutputStream := nil;
    QRPrinter.Destination := qrdPDFFile;
    AProgress := TQRProgressForm.Create(Application);
    AProgress.QRPrinter := QRPrinter;
    if ShowProgress then AProgress.Show;
    QRPrinter.Client := AProgress;
    CreateReport(false);
  finally
    QRPrinter.Free;
    QRPrinter := OldQRPrinter;
    AProgress.Free;
  end else
  begin
    if QRPrinter <> nil then
      QRPrinter.Free;
    QRPrinter := OldQRPrinter;
  end;
end;

procedure TCustomQuickRep.StreamToPDF( PDFDocument: TPDFDocument; ostream : TStream );
var
  AProgress : TQRProgressForm;
  OldQRPrinter : TQRPrinter;
begin
  AProgress := nil;
  OldQRPrinter := QRPrinter;
  if PrepareQRPrinter and QRPrinter.PrinterOK then
  try
    QRPrinter.PDFDoc := PDFDocument;
    PDFDocument.OutputStream := ostream;
    QRPrinter.Destination := qrdPDFFile;
    AProgress := TQRProgressForm.Create(Application);
    AProgress.QRPrinter := QRPrinter;
    if ShowProgress then AProgress.Show;
    QRPrinter.Client := AProgress;
    CreateReport(false);
  finally
    QRPrinter.Free;
    QRPrinter := OldQRPrinter;
    AProgress.Free;
  end else
  begin
    if QRPrinter <> nil then
      QRPrinter.Free;
    QRPrinter := OldQRPrinter;
  end;
end;
{$endif}

procedure TCustomQuickRep.Print;
var
  AProgress : TQRProgressForm;
  OldQRPrinter : TQRPrinter;
begin
  if ParentComposite <> nil then
  begin
      TQRCompositeReport( ParentComposite).Print;
      exit;
  end; 
  AProgress := nil;
  OldQRPrinter := QRPrinter;
  if PrepareQRPrinter and QRPrinter.PrinterOK then
  try
    QRPrinter.Destination := qrdPrinter;
    if ShowProgress then
    begin
         AProgress := TQRProgressForm.Create(Application);
         AProgress.QRPrinter := QRPrinter;
         AProgress.Show;
         QRPrinter.Client := AProgress;
    end;
    CreateReport(false);
  finally
    QRPrinter.Free;
    QRPrinter := OldQRPrinter;
    if showprogress then
                  AProgress.Free;
  end else
  begin
    if QRPrinter <> nil then
      QRPrinter.Free;
    QRPrinter := OldQRPrinter;
  end;
end;

procedure TCustomQuickRep.PreviewFinished(Sender : TObject);
begin
  if assigned(FAfterPreviewEvent) then
    FAfterPreviewEvent(Self);
end;

procedure TCustomQuickRep.PrintFinished(Sender : TObject);
begin
  if assigned(FAfterPrintEvent) then
    FAfterPrintEvent(Self);
end;

function TCustomQuickRep.PrepareQRPrinter : boolean;
var
  aReceiver : TWinControl;
begin
  Result := Available;
  if Result then
  begin
    if assigned(FQRPrinter) then
      AReceiver := QRPrinter.Client
    else
      AReceiver := nil;
      // standard printer option
    QRPrinter := TQRPrinter.Create( self );
    QRPrinter.Client := AReceiver;
    QRPrinter.AfterPreview := PreviewFinished;
    QRPrinter.AfterPrint := PrintFinished;
  end;
end;

procedure TCustomQuickRep.PrintBackground;
begin
  if PrepareQRPrinter and QRPrinter.PrinterOK then
  begin
    QRPrinter.Destination := qrdPrinter;
    BGThread := TQRCreateReportThread.Create(Self);
  end;
end;

procedure TCustomQuickRep.CMPageAvailable(var Message : TCM_QRPageAvailable);
begin
  if Message.PageCount = 1 then
  begin
    FPreviewPage := FQRPrinter.GetPage(1);
    invalidate;
//    Canvas.StretchDraw(rect(0, 0, Width, Height), FPreviewPage);
  end;
end;

procedure TCustomQuickRep.CMPreviewClose(var Message : TCM_QRPreviewClose);
begin
  if not Available then
    Cancel
  else if QRPrinter <> nil then  // bug fix 10/06/07
  begin
    if QRPrinter.ShowingPreview then
      QRPrinter.ShowingPreview := false;
    QRPrinter.Free;
    QRPrinter := nil;
  end;
end;

procedure TCustomQuickRep.CMPrint(var Message : TCM_QRPrint);
begin
  Print;
end;

procedure TCustomQuickRep.Prepare;
begin
  if PrepareQRPrinter and not QRPrinter.ShowingPreview then
  begin
    QRPrinter.Destination := qrdMetafile;
    QRPrinter.Master := Self;
    QRPrinter.OnPrintSetup := PrinterSetup;
    QRPrinter.OnExportToFilter := ExportToFilter;
    QRPrinter.Title := ReportTitle;
    if assigned(FOnPreviewEvent) then
      QRPrinter.OnPreview := FOnPreviewEvent;
    CreateReport(false);
    QRPrinter.ReportLoaded := true;
  end;
end;

procedure TCustomQuickRep.PreviewModeless;
begin
  PreviewIt(false);
end;

procedure TCustomQuickRep.Preview;
begin
  Application.ProcessMessages;
  if PrepareQRPrinter and not QRPrinter.ShowingPreview then
  begin
    QRPrinter.Destination := qrdMetafile;
    QRPrinter.Master := Self;
    QRPrinter.OnPrintSetup := PrinterSetup;
    QRPrinter.OnExportToFilter := ExportToFilter;
    QRPrinter.Title := ReportTitle;
    if assigned(FOnPreviewEvent) then
      QRPrinter.OnPreview := FOnPreviewEvent;
    // call below is in QR4 only
    SetPrinterValues;
    QRPrinter.Preview;
    CreateReport(false);
    QRPrinter.ReportLoaded := true;
    if assigned(FAfterPreviewEvent) then
        FAfterPreviewEvent(Self);
    if Cancelled then
    begin
      QRPrinter.Free;
      Exit;
    end;
    repeat
      Application.HandleMessage
    until (QRPrinter = nil) or (not QRPrinter.ShowingPreview) or Application.Terminated ;
  end;
end;

// cures the 1400 bug
procedure TCustomQuickRep.PreviewModal; 
begin 
  // the thread seems to cause problems with handle ownership
  if PrepareQRPrinter and not QRPrinter.ShowingPreview then 
  begin 
    QRPrinter.Destination := qrdMetafile; 
    QRPrinter.Master := Self; 
    QRPrinter.OnPrintSetup := PrinterSetup; 
    QRPrinter.OnExportToFilter := ExportToFilter; 
    QRPrinter.Title := ReportTitle; 
    if assigned(FOnPreviewEvent) then 
      QRPrinter.OnPreview := FOnPreviewEvent; 
    // call below is in QR4 only 
    SetPrinterValues; 
    CreateReport(false); 
    QRPrinter.ReportLoaded := true; 
    if assigned(FAfterPreviewEvent) then 
        FAfterPreviewEvent(Self); 
    if Cancelled then 
    begin 
      QRPrinter.Free; 
      Exit; 
    end; 
    QRPrinter.PreviewModal; 
  end; 
end; 

procedure TCustomQuickRep.PreviewXML;
var
    qrxDoc : TQRXDocument;
begin
    qrxDoc := TQRXDocument.Create(self);

    qrxDoc.Showthumbs := self.PrevShowThumbs;
    qrxDoc.ShowSearch := self.PrevShowSearch;
    qrxDoc.ShowToolbar := true;
    qrxDoc.ShowPrintButtons := true;
    qrxDoc.ShowSaveButton := true;
    qrxDoc.ShowLoadButton := true;
    qrxDoc.InitViewerWidth := self.PreviewWidth;
    qrxDoc.InitViewerHeight := self.PreviewHeight;
    qrxDoc.InitViewerTop := 1;
    qrxDoc.InitViewerLeft := 1;
    qrxDoc.InitViewerZoom := self.Zoom;
    qrxDoc.InitViewerZoomState := self.PrevInitialZoom;
    qrxDoc.InitViewerState := wsNormal;

    qrxDoc.ViewReport(self);
end;

procedure TCustomQuickRep.PreviewIt(Modal : boolean);
begin
  if PrepareQRPrinter and not QRPrinter.ShowingPreview then
  begin
    QRPrinter.Destination := qrdMetafile;
    QRPrinter.Master := Self;
    QRPrinter.OnPrintSetup := PrinterSetup;
    QRPrinter.OnExportToFilter := ExportToFilter;
    QRPrinter.Title := ReportTitle;
    if assigned(FOnPreviewEvent) then
      QRPrinter.OnPreview := FOnPreviewEvent;
    BGThread := TQRCreateReportThread.Create(Self);
    if Modal then
      QRPrinter.PreviewModal
    else
      QRPrinter.Preview;
  end;
end;


procedure TCustomQuickRep.PrinterSetup;
var
  aDialog : TQR5PrintDialog;
  I : TQRBin;
  aBin : integer;
begin
  aDialog := TQR5PrintDialog.Create(Application);
  //aDialog.Printer := Printers.Printer;
  //aDialog.Printer.GetPrinter(Device, Driver, Port, hDMode);
  // 23/05/05 don't null the printer settings
  //aDialog.Printer.SetPrinter(Device, Driver, Port, 0);

  aDialog.PrinterIndex := PrinterSettings.PrinterIndex;
  CompositePrinterIndex := -999;
  with aDialog do
  try
    MinPage := 0;
    MaxPage := 9999;
    if (QRPrinter <> nil) and (QRPrinter.Status = mpFinished) then
    begin
      MinPage := 1;
      MaxPage := QRPrinter.PageCount;
      FromPage := 1;
      ToPage := MaxPage;
    end;
      Options := [poPageNums, poWarning];
      aDialog.Orientation := Page.Orientation;
      Copies := PrinterSettings.Copies;
      if Execute then
      begin
        PrinterSettings.Copies := Copies;
        PrinterSettings.PrinterIndex := aDialog.PrinterIndex;
        Page.Orientation := aDialog.Orientation;
        // catch the user selections
        UserPrintersettings.CustomBinCode := aDialog.outputbin;
        UserPrintersettings.ExtendedDuplex := aDialog.DuplexCode;
        UserPrintersettings.PrintQuality := aDialog.PrintQuality;
        UserPrintersettings.Collate := aDialog.Collate;
        UserPrintersettings.ColorOption := aDialog.ColorOption;
        UserPrintersettings.Copies := aDialog.Copies;
        UserPrintersettings.Orientation := aDialog.Orientation;
        UserPrintersettings.FirstPage := aDialog.FromPage;
        UserPrintersettings.LastPage := aDialog.ToPage;
        UserPrintersettings.OutputBin := Printersettings.OutputBin;
        aBin := aDialog.outputbin;
        if aBin > 255 then aBin := aBin - 256;
        for I := First to Last do
         if cQRBinTranslate[I] = aBin then
         begin
          UserPrintersettings.OutputBin := I;
          break;
         end;

        UserPrintersettings.CustomPaperCode := aDialog.PaperSize;
        UserPrintersettings.PrinterIndex := aDialog.PrinterIndex;
        UserPrintersettings.FirstPage := aDialog.FromPage;
        UserPrintersettings.LastPage := aDialog.ToPage;
        UserPrinterSettings.Duplex := aDialog.Duplex;
        case PrintRange of
          prAllPages,
          prSelection : begin
                         PrinterSettings.FirstPage := 0;
                         PrinterSettings.LastPage := 0;
                       end;
          prPageNums : begin
                         PrinterSettings.FirstPage := FromPage;
                         PrinterSettings.LastPage := ToPage;
                       end;
        end;
        Self.Tag := 0;
      end
      else Self.Tag := 1;
  finally
    free;
  end
end;

// exports
procedure TCustomQuickRep.ExportComposite(AFilter : TQRExportFilter; expQRPrinter : TQRPrinter);
var
  OldQRPrinter : TQRPrinter;
  AProgress : TQRProgressForm;
begin
  aProgress := nil;
  ExportFilter := AFilter;
  AFilter.Owner := Self;
  FFinalPass := false;
  AFilter.OriginalQRPrinter := QRPrinter;
  OldQRPrinter := QRPrinter;
  try
    QRPrinter := expQRPrinter;
    AProgress := TQRProgressForm.Create(Application);
    AProgress.QRPrinter := QRPrinter;
    AProgress.Caption := 'Exporting Progress';

    if ShowProgress then AProgress.Show;
    QRPrinter.Client := AProgress;
    CreateReport(true);
  finally
    AProgress.Free;
    QRPrinter.Client := nil;
  end;
  FFinalPass := true;
  QRPrinter := OldQRPrinter;
end;


procedure TCustomQuickRep.ExportToFilter(AFilter : TQRExportFilter);
var
  OldQRPrinter : TQRPrinter;
  AProgress : TQRProgressForm;
begin
  aProgress := nil;
  ExportFilter := AFilter;
  AFilter.Owner := Self;
  AFilter.OriginalQRPrinter := QRPrinter;
  FFinalPass := false;
  OldQRPrinter := QRPrinter;
  try
    QRPrinter := TQRPrinter.Create( self );
    if ShowProgress then
    begin
      AProgress := TQRProgressForm.Create(Application);
      AProgress.QRPrinter := QRPrinter;
      AProgress.Show;
      AProgress.Caption := 'Exporting Progress';
      QRPrinter.Client := AProgress;
    end;
    CreateReport(false);
  finally
    QRPrinter.Free;
    if ShowProgress then
            AProgress.Free;
  end;
  ExportFilter := nil;
  FFinalPass := true;
  QRPrinter := OldQRPrinter;
end;

function TCustomQuickRep.AvailableSpace : integer;
begin
  if not Available then
  begin
    if CurrentY = -1 then
      Result := 0
    else
      if Exporting and ExportFilter.Streaming then
        Result := round(QRPrinter.PaperLength)
      else
        if Page.Orientation = poPortrait then
          Result := round(QRPrinter.PaperLength - Page.BottomMargin - FPageFooterSize - CurrentY)
        else
          if Page.PaperSize = Custom then
            Result := round(QRPrinter.PaperLength - Page.BottomMargin - FPageFooterSize - CurrentY)
          else
            Result := round(QRPrinter.PaperWidth - Page.BottomMargin - FPageFooterSize - CurrentY);
  end else
    Result := 0;
end;

procedure TCustomQuickRep.NewColumn;
var
  aWidth : integer;
begin
  PrintBand(Bands.ColumnFooterBand);
  if FCurrentColumn = Page.Columns then
  begin
    FCurrentColumn := 1;
    FCurrentX := round(Page.LeftMargin);
    NewPage;
  end else
  begin
    if Bands.HasDetail then
      aWidth := round(Bands.DetailBand.Size.Width)
    else
    begin
      aWidth :=  round(page.Width - (Page.LeftMargin + Page.RightMargin));
      aWidth := ((aWidth - round(Page.ColumnSpace) * (Page.Columns - 1)) div Page.Columns);
    end;
    FCurrentX := FCurrentX + aWidth + round(Page.ColumnSpace);
    FCurrentY := FColumnTopPosition;
    inc(FCurrentColumn);
  end;
  Functions.SetIntegerConstant(EvColumnNumber, FCurrentColumn);
  if not ((FCurrentColumn = 1) and (FPageCount = 1)) then
  begin
    PrintBand(Bands.ColumnHeaderBand);
    Controller.NewPageCheckGroups;
  end;
end;

procedure TCustomQuickRep.NewPage;
var
    x, y, iw, ih : integer;
    backrect : TQRShape;
begin
  EndPage;
  if Exporting then
    ExportFilter.NewPage;
  inc(FPageCount);
  Functions.SetIntegerConstant(EvPageNumber, FPageCount);
  if FinalPass or (FPageCount = 1) then
    QRPrinter.NewPage;
  FCurrentY := round(Page.TopMargin);
  if assigned(FOnStartPageEvent) and not (csDesigning in ComponentState) then
    FOnStartPageEvent(Self);
  // paint the background
  if FBackgroundcolor <> clWhite then
  begin
       qrprinter.Canvas.Brush.Color := FBackgroundcolor;
       iw := round(page.FWidth*QRPrinter.YFactor);
       ih := round(page.FLength*QRPrinter.YFactor);
       QRprinter.Canvas.rectangle( 0, 0, iw, ih );
       backRect := TQRShape.Create(self);
       backrect.Width := iw;
       backrect.Height := ih;
       backrect.Shape := qrsRectangle;
       backrect.Brush.Style := bsSolid;
       backrect.pen.Style := psClear;
       backrect.Brush.Color := FBackgroundcolor;
       if Exporting then
               TQRExportFilter(ExportFilter).acceptgraphic( 0,0, backRect );

  end;
  // print the background image
  if FBackgroundcontrol <> nil then
  begin
          x := QRPrinter.XPos(TQRImage(FBackgroundcontrol).size.Left);
          y := QRPrinter.YPos(TQRImage(FBackgroundcontrol).size.Top);
          ih := round(TQRImage(FBackgroundcontrol).size.Height*QRPrinter.YFactor);
          iw := round(TQRImage(FBackgroundcontrol).size.Width*QRPrinter.XFactor);
          QRprinter.Canvas.StretchDraw( Rect(x, y, iw+x, ih+y ),
                    TQRImage(FBackgroundcontrol).Picture.Graphic);
          if Exporting then
               TQRExportFilter(ExportFilter).acceptgraphic( x,y, FBackgroundcontrol );
  end;
  if (FPageCount > 1) or ((FPageCount = 1) and (FirstPageHeader in Options)) then
    PrintBand(Bands.PageHeaderBand);
  FColumnTopPosition := FCurrentY;
  FCurrentColumn := 1;
  if (PageNumber = 1) and Bands.HasTitle then
    FColumnTopPosition := FColumnTopPosition + Round(Bands.TitleBand.Size.Height);
//  Controller.NewPageCheckGroups;
end;

procedure TCustomQuickRep.PrintPageBackground;
var
  I : integer;
{$ifdef DEMO}
   xmed, ymed : integer;
{$endif}
begin
  for I := 0 to ControlCount - 1 do
    if (Controls[I] is TQRPrintable) and ( Controls[I] <> FBackgroundcontrol) then
      TQRPrintable(Controls[I]).Print(0, 0);
      
  if FinalPass or Exporting then
    Frame.PaintIt(QRPrinter.Canvas,
      rect(QRPrinter.XPos(Page.LeftMargin),
           QRPrinter.YPos(Page.TopMargin),
           QRPrinter.XPos(Page.Width - Page.RightMargin),
           QRPrinter.YPos(Page.Length - Page.BottomMargin)),
           QRPrinter.XFactor,QRPrinter.YFactor);
{$ifdef DEMO}
     xmed := round(QRPrinter.XPos(Page.LeftMargin));
     ymed := round(QRPrinter.YPos(Page.Length) / 2);
     qrprinter.Canvas.Font.Size := 40;
     qrprinter.Canvas.font.Color := clRED;
     qrprinter.Canvas.TextOut(xmed, ymed, 'QuickReports Evaluation');
     if exporting then
          ExportFilter.TextOut(xmed, ymed, qrprinter.Canvas.Font, clWhite,
                           taLeftJustify,'QuickReports Evaluation');
{$endif}
end;

procedure TCustomQuickRep.EndPage;
begin
  if FPageCount > 0 then
  begin
    CurrentY := round(Page.Length - Page.BottomMargin - FPageFooterSize);
    FCurrentX := round(Page.LeftMargin);
    if (FPageCount > 0) and ((not FLastPage) or (LastPageFooter in Options)) then
      PrintBand(Bands.PageFooterBand);
    PrintPageBackground;
    if assigned(FOnEndPageEvent) and not (csDesigning in ComponentState) then
      FOnEndPageEvent(Self);
  end;
  if Exporting then ExportFilter.EndPage;
end;

procedure TCustomQuickRep.RegisterBand(ABand : TQRCustomBand);
begin
  if ABand <> nil then
  begin
    if not (csDestroying in ABand.ComponentState) and
      (BandRegList.IndexOf(ABand) < 0) then
    begin
      BandRegList.Add(ABand);
      while (aBand <> nil) and aBand.HasChild do
      begin
        aBand := aBand.ChildBand;
        BandRegList.Add(aBand);
      end
    end;
  end;
end;

procedure TCustomQuickRep.SetControllerBands;
begin
end;

procedure TCustomQuickRep.RebuildBandList;
var
  aBand : TQRCustomBand;
  I : integer;

  procedure AddBandsToList(BandType : TQRBandType);
  var
    I : integer;
  begin
    for I := 0 to FBandList.Count - 1 do
    begin
      if TQRCustomBand(FBandList[I]).BandType = BandType then
      begin
        aBand := TQRCustomBand(FBandList[I]);
        RegisterBand(aBand);
      end
    end
  end;

begin
  if not (csLoading in ComponentState) then
  begin
    SetControllerBands;
    Controller.BuildTree;
    BandRegList.Clear;
    AddBandsToList(rbPageHeader);
    if Bands.HasTitle then
      AddBandsToList(rbTitle);
    AddBandsToList(rbColumnHeader);
    Controller.RegisterBands;
    AddBandsToList(rbPageFooter);
    for I := 0 to FBandList.Count - 1 do
    begin
      if BandRegList.IndexOf(FBandList[I]) = -1 then
        RegisterBand(TQRCustomBand(FBandList[I]));
    end;
    FBandList.Free;
    FBandList := BandRegList;
    BandRegList := TList.Create;
  end;
  if FBandList.Count > 0 then
    for I := 1 to RotateBands do
      FBandList.Move(0, FBandList.Count - 1);
end;

procedure TCustomQuickRep.SetBandValues;
var
  I : integer;
  VertPos : integer;
  BandWidth : integer;
  ColumnWidth : integer;
  aUnit : TQRUnit;
  aBand : TQRCustomBand;
  aChildBand : TQRChildBand;
  aBandType : TQRBandType;
begin
  if assigned(FPage) and assigned(FBandList) and
    not (csDestroying in ComponentState) and not (csLoading in ComponentState) then
  begin
    aUnit := Units;
    Units := Pixels;
    VertPos := round(Page.TopMargin);
    BandWidth := Width - round(Page.LeftMargin + Page.RightMargin);
    ColumnWidth := ((BandWidth - round(Page.ColumnSpace) * (Page.Columns - 1)) div Page.Columns);
    for I := 0 to FBandList.Count - 1 do
    begin
      aBand := TQRCustomBand(FBandList[I]);
      if assigned(aBand) and not (csDestroying in aBand.ComponentState) then
      begin
        aBand.ParentUpdating := true;
        aBand.Left := round(Page.LeftMargin);
        if HideBands then
          aBand.Top := round(Page.Length)
        else
          aBand.Top := VertPos;
        inc(VertPos, aBand.Height);
        aBandType := aBand.BandType;
        if aBand is TQRChildBand then
        begin
          aChildBand := TQRChildBand(aBand);
          while (aChildBand.ParentBand <> nil) and
                (aChildBand.ParentBand is TQRChildBand) do
            aChildBand := TQRChildBand(aChildBand.ParentBand);
          if aChildBand.ParentBand <> nil then
            aBandType := aChildBand.ParentBand.BandType;
        end;
        if (aBandType in [rbTitle, rbPageHeader, rbPageFooter, rbSummary, rbOverlay]) or
          ((aBandType in [rbGroupHeader, rbGroupFooter]) and (Page.PrintOrder = RowByRow)) then
          aBand.Size.Width := BandWidth
        else
          aBand.Size.Width := ColumnWidth;
        aBand.ParentUpdating := false;
      end
    end;
    Units := aUnit;
  end;
end;

procedure TCustomQuickRep.GetChildren(Proc: TGetChildProc; root: TComponent);
var
  I: Integer;
  OwnedComponent: TComponent;
begin
  inherited GetChildren(Proc, root);
  if root = Self then
    for I := 0 to ComponentCount - 1 do
    begin
      OwnedComponent := Components[I];
      if not OwnedComponent.HasParent then Proc(OwnedComponent);
    end
end;

procedure TCustomQuickRep.Loaded;
begin
  inherited Loaded;
  RebuildBandList;
  SetBandValues;
end;

procedure TCustomQuickRep.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if not (csDestroying in ComponentState) then
  begin
    if Operation = opRemove then
    begin
//      if (AComponent is TQRCustomBand) then
//        if (FBandList.IndexOf(AComponent) >= 0) then
//          RemoveBand(TQRCustomBand(AComponent));
    end
  end
end;

procedure TCustomQuickRep.RemoveBand(ABand : TQRCustomBand);
var
  BandIndex : integer;
begin
  if not (csDestroying in ComponentState) then
  begin
    BandIndex := FBandList.IndexOf(ABand);
    if BandIndex >= 0 then
    begin
      FBandList.Delete(BandIndex);
      RebuildBandList;
      SetBandValues;
    end
  end
end;

procedure TCustomQuickRep.Paint;
begin
  inherited Paint;
  if FModified then
  begin
    FModified := false;
  end;
  if FPreviewPage <> nil then
    Canvas.StretchDraw(rect(0, 0, Width, Height), FPreviewPage);
  if Page.Ruler then
    PaintRuler(Units);
  PaintMargins;
  PaintFrame;
  PaintColumns;
end;

procedure TCustomQuickRep.PaintColumns;
var
  I : integer;
  ColumnWidth : integer;
begin
  if Page.Columns > 1 then with Canvas do
  begin
    Pen.Width := 1;
    Pen.Style := cqrMarginStyle;
    Pen.Color := cqrMarginColor;
    Page.SetPixels;
    ColumnWidth := round(((Page.Width - Page.LeftMargin - Page.RightMargin - Page.ColumnSpace *
                   (Page.Columns - 1)) / Page.Columns));
    for i := 1 to Page.Columns-1 do
    begin
      MoveTo(round(Page.LeftMargin + I * ColumnWidth + (I - 1) * Page.ColumnSpace), 0);
      LineTo(round(Page.LeftMargin + I * ColumnWidth + (I - 1) * Page.ColumnSpace), round(Page.TopMargin));

      MoveTo(round(Page.LeftMargin + I * (ColumnWidth + Page.ColumnSpace)), 0);
      LineTo(round(Page.LeftMargin + I * (ColumnWidth + Page.ColumnSpace)), round((Page.TopMargin)));
    end;
    Page.RestoreUnit;
    Pen.Style := psSolid;
  end
end;

procedure TCustomQuickRep.PaintMargins;
begin
  with canvas do
  begin
    Pen.Style := cqrMarginStyle;
    Pen.Color := cqrMarginColor;
    Page.SetPixels;
    rectangle(round(Page.LeftMargin),round(Page.TopMargin),Width-round(Page.RightMargin),Height-Round(Page.BottomMargin));
    Pen.Style := psSolid;
    Page.RestoreUnit;
  end
end;

procedure TCustomQuickRep.PaintFrame;
begin
  with canvas do
  begin
    Frame.SetPen(Pen);
    Page.SetPixels;
    if Frame.DrawTop then
    begin
      MoveTo(round(Page.LeftMargin), Round(Page.TopMargin));
      LineTo(round(Page.Width - Page.RightMargin) - 1, Round(Page.TopMargin));
    end;
    if Frame.DrawBottom then
    begin
      MoveTo(round(Page.LeftMargin), Round(Page.Length - Page.BottomMargin) - 1);
      LineTo(round(Page.Width - Page.RightMargin) - 1, Round(Page.Length - Page.BottomMargin) - 1);
    end;
    if Frame.DrawLeft then
    begin
      MoveTo(round(Page.LeftMargin), Round(Page.TopMargin));
      LineTo(round(Page.LeftMargin), Round(Page.Length - Page.BottomMargin) - 1);
    end;
    if Frame.DrawRight then
    begin
      MoveTo(round(Page.Width - Page.RightMargin) - 1, Round(Page.TopMargin));
      LineTo(round(Page.Width - Page.RightMargin) - 1, Round(Page.Length - Page.BottomMargin) - 1);
    end;
    Page.RestoreUnit;
  end
end;

procedure TCustomQuickRep.PaintRuler(Units : TQRUnit);
begin
  FontSize := abs(Font.Size);
  inherited PaintRuler(Units);
end;

procedure TCustomQuickRep.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  UpdatePage : boolean;
begin
  UpdatePage := (AWidth <> Width) or (AHeight <> Height);
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if assigned(FPage) and (not Page.ParentUpdating) and UpdatePage and (Page.PaperSize = Custom) then
  begin
    Page.ParentUpdating := true;
    Page.SetPixels;
    Page.Width := aWidth;
    Page.Length := aHeight;
    Page.RestoreUnit;
    Page.ParentUpdating := false;
  end;
  SetBandValues;
end;

procedure TCustomQuickRep.SetExportFilter(Value : TQRExportFilter);
begin
  FExportFilter := Value;
  if Value <> nil then
    FExporting := true
  else
    FExporting := false;
end;

procedure TCustomQuickRep.SetUnits(Value : TQRUnit);
var
  I : integer;
begin
  Page.Units := Value;
  for I := 0 to FBandList.Count - 1 do
    TQRCustomBand(FBandList[I]).Units := Units;
  for I := 0 to ControlCount - 1 do
  begin
    if Controls[I] is TQRPrintable then
      TQRPrintable(Controls[I]).Size.Units := Units;
  end;
end;

{ TQuickRep }

constructor TQuickRep.CreateNew(AOwner : TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner);
  Controller := TQRController.Create(self);
  Controller.ParentReport := Self;
  Controller.SelfCheck := Self;
end;

destructor TQuickRep.Destroy;
begin
  inherited Destroy;
end;


function TQuickRep.GetDataSet : TDataSet;
begin
  if Controller is TQRController then
    Result := TQRController(Controller).DataSet
  else
    Result := nil;
end;

procedure TQuickRep.SetDataSet(Value : TDataSet);
begin
  if Controller is TQRController then
    TQRController(Controller).DataSet := Value;
end;

function TQuickRep.GetRecordNumber : integer;
begin
  Result := TQRController(Controller).DetailNumber
end;

function TQuickRep.GetRecordCount : integer;
begin
  result := 1;
  if DataSetOK(DataSet) then
    begin
      try
        result := DataSet.RecordCount;
      except
        result := 1;
      end;
    end
end;

procedure TQuickRep.Execute;
begin
  SetControllerBands;
  with TQRController(Controller) do
  begin
    OnNeedData := Self.OnNeedData;
    Execute;
  end;
end;

procedure TQuickRep.SetControllerBands;
begin
  with TQRController(Controller) do
  begin
    Detail := Bands.DetailBand;
    Header := Bands.TitleBand;
    Footer := Bands.SummaryBand;
  end;
end;

procedure TQuickRep.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if not (csDestroying in ComponentState) then
  begin
    if Operation = opRemove then
    begin
      if (AComponent is TDataSet) and (AComponent = DataSet) then
         DataSet := nil;
    end
  end
end;

{ TQRLabelSetup }

constructor TQRLabelSetup.Create(Parent : TCustomQuickRep);
begin
  inherited Create;
  FParent := Parent;
end;

function TQRLabelSetup.GetValue(Index : integer) : extended;
begin
  case Index of
    0 : result := FParent.Page.TopMargin;
    1 : result := FParent.Page.LeftMargin;
    2 : begin
          Result := FParent.Bands.DetailBand.Size.Height;
          if FParent.Bands.DetailBand.HasChild then
            Result := Result + FParent.Bands.DetailBand.ChildBand.Size.Height
        end;
    3 : result := FParent.Bands.DetailBand.Size.Width;
    4 : result := FParent.Bands.DetailBand.Size.Height;
    5 : result := LabelWidth + FParent.Page.ColumnSpace;
  else
    Result := 0;
  end;
end;

function TQRLabelSetup.GetInteger(Index : integer) : integer;
begin
  case Index of
    0 : result := FNumberDown;
    1 : result := FParent.Page.Columns;
  else
    Result := 0;
  end;
end;

procedure TQRLabelSetup.SetValue(Index : integer; Value : extended);
var
  OldVPitch : extended;
begin
  case Index of
    0 : FParent.Page.TopMargin := Value;
    1 : begin
          FParent.Page.LeftMargin := Value;
          FParent.Page.RightMargin := Value;
        end;
    2 : if Value = LabelHeight then
        begin
          FParent.Bands.DetailBand.HasChild := false;
          FParent.Bands.DetailBand.Size.Height := Value;
        end else
        begin
          FParent.Bands.DetailBand.HasChild := true;
          FParent.Bands.DetailBand.ChildBand.Size.Height := Value - LabelHeight;
        end;
    3 : begin
          SideMargin := (FParent.Page.Width - (Value * NumberAcross) + ((NumberAcross - 1) * FParent.Page.ColumnSpace)) / 2;
        end;
    4 : begin
          OldVPitch := VerticalPitch;
          FParent.Bands.DetailBand.Size.Height := Value;
          if Value = VerticalPitch then
            FParent.Bands.DetailBand.HasChild := false
          else
            if Value > VerticalPitch then
              VerticalPitch := Value
            else
            begin
              FParent.Bands.DetailBand.HasChild := true;
              FParent.Bands.DetailBand.ChildBand.Size.Height := OldVPitch - Value;
            end;
        end;
    5 : if NumberAcross = 1 then
          FParent.Page.ColumnSpace := 0
        else
          FParent.Page.ColumnSpace := (FParent.Page.Width - (SideMargin * 2) - (LabelWidth * NumberAcross))
                                     / (NumberAcross - 1);
    end;
end;

procedure TQRLabelSetup.SetInteger(Index : integer; Value : integer);
begin
  case Index of
    1 : FParent.Page.Columns := Value;
  end;
end;

{ TQuickLabelReport }
constructor TQuickLabelReport.CreateNew(AOwner : TComponent; Dummy : integer);
begin
  inherited CreateNew(AOwner);
  FLabelSetup := TQRLabelSetup.Create(Self);
  Bands.HasDetail := true;
end;

destructor TQuickLabelReport.Destroy;
begin
  FLabelSetup.Free;
  inherited Destroy;
end;

{ TQRPrintableSize }

constructor TQRPrintableSize.Create(AParent : TQRPrintable);
begin
  inherited create;
  Parent := AParent;
  FHeight := 20;
  FWidth := 20;
  FTop := 20;
  FLeft := 20;
end;

function TQRPrintableSize.GetValue(Index : integer): extended;
begin
  case Index of
    0 : Result := LoadUnit(FHeight, Units, false);
    1 : Result := LoadUnit(FLeft, Units, true);
    2 : Result := LoadUnit(FTop, Units, false);
  else
    Result := LoadUnit(FWidth, Units, true);
  end;
  if Units = Pixels then
    if Parent.Parent is TQRBasePanel then
      Result := (result * TQRBasePanel(Parent.Parent).Zoom) / 100;
end;

procedure TQRPrintableSize.ReadValues(Reader : TReader);
begin
  Reader.ReadListBegin;
  FHeight := Reader.ReadFloat;
  FLeft := Reader.ReadFloat;
  FTop := Reader.ReadFloat;
  FWidth := Reader.ReadFloat;
  Reader.ReadListEnd;
end;

procedure TQRPrintableSize.FixZoom;
begin
  SetParentSizes;
end;

procedure TQRPrintableSize.SetParentSizes;
begin
  if assigned(Parent) then
  begin
    ParentUpdating := true;
    Parent.SetBounds(round(LoadUnit(FLeft, Pixels, true)),
                     round(LoadUnit(FTop, Pixels, false)),
                     round(LoadUnit(FWidth, Pixels, true)),
                     round(LoadUnit(FHeight, Pixels, false)));
    ParentUpdating := false;
  end
end;

procedure TQRPrintableSize.SetValue(Index : integer; Value : extended);
begin
  case Index of
    0 : FHeight := SaveUnit(Value, Units, false);
    1 : FLeft := SaveUnit(Value, Units, true);
    2 : FTop := SaveUnit(Value, Units, false);
    3 : FWidth := SaveUnit(Value, Units, true);
  end;
  SetParentSizes;
end;

procedure TQRPrintableSize.WriteValues(Writer : TWriter);
begin
  Writer.WriteListBegin;
  Writer.WriteFloat(FHeight);
  Writer.WriteFloat(FLeft);
  Writer.WriteFloat(FTop);
  Writer.WriteFloat(FWidth);
  Writer.WriteListEnd;
end;


{ TQRPrintableEditor }

constructor TQRPrintableEditor.Create(AControl : TQRPrintable);
begin
  inherited Create;
  Control := AControl;
end;

function TQRPrintableEditor.GetColor : TColor;
begin
  Result := clBlack;
end;

function TQRPrintableEditor.GetFont : TFont;
begin
  Result := nil;
end;

function TQRPrintableEditor.GetGlyphResName : string;
begin
  Result := '';
end;

function TQRPrintableEditor.GetPrintableClass : TQRPrintableClass;
begin
  Result := TQRPrintable;
end;

function TQRPrintableEditor.GetValue : string;
begin
  Result := '';
end;

function TQRPrintableEditor.GetControlName : string;
begin
  Result := '';
end;

{$ifndef QRSTANDARD}
function TQRPrintableEditor.GetAlignment : TAlignment;
begin
  Result := taLeftJustify;
end;

procedure TQRPrintableEditor.SetAlignment(Value : TAlignment);
begin

end;

{$endif}

{ TQRPrintable }

constructor TQRPrintable.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FSize := TQRPrintableSize.Create(Self);
  FFrame := TQRFrame.Create;
  FFrame.Parent := Self;
  Color := clWhite;
  ButtonDown := false;
  Height := 10;
  Width := 10;
  FAlignment := taLeftJustify;
  FAlignToBand := false;
  AlignUpdating := false;
  FPrintFinished := true;
  IsPrinting := false;
  LoadedTop := 0;
  LoadedLeft := 0;
  LoadedWidth := 0;
  LoadedHeight := 0;
end;

destructor TQRPrintable.Destroy;
begin
  FSize.Free;
  FFrame.Free;
  inherited Destroy;
end;

procedure TQRPrintable.Loaded;
begin
  inherited Loaded;
  Size.Loaded;
  if (Left = 0) and (LoadedLeft <> 0 ) then Left := LoadedLeft;
  if (Top = 0) and (LoadedTop <> 0) then Top := LoadedTop;
  if (Width = 0) and (LoadedWidth <> 0) then Width := LoadedWidth;
  if (Height = 0) and (LoadedHeight <> 0) then Height := LoadedHeight;
end;

procedure TQRPrintable.GetExpandedHeight(var newheight : extended );
begin
end;

procedure TQRPrintable.GetFieldString( var DataStr : string);
begin
end;

function TQRPrintable.IsEnabled : boolean;
begin
  result := Enabled or (Visible = false)
end;

function TQRPrintable.GetEditorClass : TQRPrintableEditorClass;
begin
  Result := TQRPrintableEditor;
end;

function TQRPrintable.GetZoom : integer;
begin
  result := Size.Zoom;
end;

procedure TQRPrintable.SetZoom(Value : integer);
begin
  Size.Zoom := Value;
  Size.FixZoom;
end;

procedure TQRPrintable.AlignIt;
begin
  if AlignToBand then
  begin
    AlignUpdating := true;
    case Alignment of
      taLeftJustify : Left := 0;
      taRightJustify : if Parent is TQRCustomBand then
                  Left := TQRCustomBand(Parent).Width - Width;
      taCenter : if Parent is TQRCustomBand then
                  Left := (TQRCustomBand(Parent).Width - Width) div 2;
    end;
    AlignUpdating := false;
  end
end;

procedure TQRPrintable.Prepare;
begin
   IsPrinting := true;
   QRPrinter := ParentReport.QRPrinter;
end;

procedure TQRPrintable.SetAlignment(Value : TAlignment);
begin
  FAlignment := Value;
  if AlignToBand then AlignIt;
  Invalidate;
end;

procedure TQRPrintable.SetAlignToBand(Value : boolean);
begin
  FAlignToBand := Value;
  AlignIt;
end;

procedure TQRPrintable.SetFrame(Value : TQRFrame);
begin
  FFrame := Value;
  Invalidate;
end;

procedure TQRPrintable.QRNotification(Sender : TObject; Operation : TQRNotifyOperation);
begin
  case Operation of
    qrBandSizeChange : AlignIt;
  end
end;

procedure TQRPrintable.Paint;
var
  aRect : TRect;
begin
  if not IsPrinting then
  begin
    if not Transparent then
    begin
      Canvas.Brush.Color := clWhite;
      Canvas.Brush.Style := bsSolid;
      Canvas.FillRect(ClientRect);
    end;
    PaintCorners;
    aRect := GetClientRect;
    dec(aRect.Bottom);
    dec(aRect.Right);
    FFrame.PaintIt(Canvas, aRect, Screen.PixelsPerInch / 254 * Zoom/100, Screen.PixelsPerInch / 254 * Zoom/100);
  end;
end;

procedure TQRPrintable.Print(OfsX, OfsY : integer);
begin
  if ParentReport.FinalPass and FFrame.AnyFrame then
    FFrame.PaintIt(ParentReport.QRPrinter.Canvas,
      Rect(ParentReport.QRPrinter.XPos(OfsX + Size.Left),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top),
      ParentReport.QRPrinter.XPos(OfsX + Size.Left + Size.Width),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top + Size.Height)),
      ParentReport.QRPrinter.XFactor,
      ParentReport.QRPrinter.YFactor);
end;

procedure TQRPrintable.PaintCorners;
begin
  with Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    { Top left corner }
    MoveTo(0, cQRCornerSize);
    LineTo(0, 0);
    LineTo(cQRCornerSize, 0);
    { Bottom left corner }
    MoveTo(0, Height - cQRCornerSize - 1);
    LineTo(0, Height - 1);
    LineTo(cQRCornerSize,Height - 1);
    { Top Right corner }
    MoveTo(Width - cQRCornerSize - 1, 0);
    LineTo(Width - 1, 0);
    LineTo(Width - 1, cQRCornerSize);
    { Bottom Right corner }
    MoveTo(Width - cQRCornerSize - 1, Height - 1);
    LineTo(Width - 1, Height - 1);
    LineTo(Width - 1, Height - cQRCornerSize - 1);
  end
end;

procedure TQRPrintable.SetBounds(ALeft, ATop, AWidth, AHeight : Integer);
var
  aUnit : TQRUnit;
begin
  if Size.ParentUpdating then
  begin
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
    if ParentReport <> nil then ParentReport.Modify;
  end else
    if not (csLoading in ComponentState) and ((ParentReport = nil) or not ParentReport.PreparingDesignTime) then
    begin
      aUnit := Size.Units;
      Size.Units := Pixels;
      if AHeight <> Size.Height then Size.Height := aHeight;
      if aWidth <> Size.Width then Size.Width := aWidth;
      if aTop <> Size.Top then Size.Top := aTop;
      if aLeft <> Size.Left then Size.Left := aLeft;
      Size.Units := aUnit;
    end else
    begin
      if ALeft <> 0 then LoadedLeft := ALeft;
      if ATop <> 0 then LoadedTop := ATop;
      if AWidth <> 0 then LoadedWidth := AWidth;
      if AHeight <> 0 then LoadedHeight := AHeight;
    end;
  if AlignToBand and not AlignUpdating then AlignIt;
end;

procedure TQRPrintable.SetParent(AParent: TWinControl);
var
  aTop, ALeft : integer;
begin
  inherited SetParent(AParent);
  if AParent is TQuickRep then
  begin
    FSize.Units := TCustomQuickRep(AParent).Units;
    ParentReport := TCustomQuickRep(AParent);
    Size.ParentReport := ParentReport;
    aTop := top;
    aLeft := Left;
    Zoom := ParentReport.Zoom;
    Top := aTop;
    Left := aLeft;
  end else
  begin
    if AParent is TQRCustomBand then
    begin
      FSize.Units := TQRCustomBand(AParent).Units;
      if TQRCustomBand(AParent).ParentReport <> nil then
      begin
        ParentReport := TQRCustomBand(AParent).ParentReport;
        Size.ParentReport := ParentReport;
       aTop := top;
       aLeft := Left;
       Zoom := ParentReport.Zoom;
       Top := aTop;
       Left := aLeft;
      end;
      aTop := top;aLeft := Left;
      Top := aTop;Left := aLeft;
    end
  end
end;

function TQRPrintable.GetTransparent : boolean;
begin
  Result := not (csOpaque in ControlStyle);
end;

procedure TQRPrintable.SetTransparent(Value : boolean);
begin
  if Transparent <> Value then
  begin
    if Value then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end
end;

procedure TQRPrintable.Unprepare;
begin
   FIsPrinting := false;
end;

{ TQRCompositeReport }

constructor TQRCompositeReport.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FReports := TList.Create;
  FPrinterSettings := TQRCompositePrinterSettings.Create;
  FGenerating := false;
  aWinControl := TQRCompositeWinControl.Create(nil);
  aWinControl.ParentReport := self;
end;

destructor TQRCompositeReport.Destroy;
begin
  FReports.Free;
  FPrinterSettings.Free;
//  aWinControl.Parent := nil;
  if aWinControl <> nil then
    aWinControl.Free;
  inherited Destroy;
end;

procedure TQRCompositeReport.PrinterSetup;
var
  aDialog : TQR5PrintDialog;
  I : TQRBin;
  aBin : integer;
begin
  aDialog := TQR5PrintDialog.Create(Application);
  //aDialog.Printer := Printers.Printer;
  //aDialog.Printer.GetPrinter(Device, Driver, Port, hDMode);
  //aDialog.Printer.SetPrinter(Device, Driver, Port, 0);
  with aDialog do
  try
    MinPage := 0;
    MaxPage := 9999;
    if (FQRPrinter <> nil) and (FQRPrinter.Status = mpFinished) then
    begin
      MinPage := 1;
      MaxPage := FQRPrinter.PageCount;
      FromPage := 1;
      ToPage := MaxPage;                                      
    end;

    Options := [poPageNums, poWarning];
    aDialog.Orientation := PrinterSettings.Orientation;
    Copies := PrinterSettings.Copies;
    if Execute then
    begin
      PrinterSettings.Copies := Copies;
      PrinterSettings.PrinterIndex := aDialog.PrinterIndex;
      PrinterSettings.CustomBincode := aDialog.OutputBin;
      PrinterSettings.ExtendedDuplex := aDialog.DuplexCode;
      aBin := aDialog.outputbin;
      if aBin > 255 then aBin := aBin - 256;
      for I := First to Last do
      if cQRBinTranslate[I] = aBin then
      begin
          Printersettings.OutputBin := I;
          break;
      end;
      CompositePrinterIndex := aDialog.PrinterIndex;
      case PrintRange of
        prAllPages,
        prSelection : begin
                       PrinterSettings.FirstPage := 0;
                       PrinterSettings.LastPage := 0;
                     end;
        prPageNums : begin
                       PrinterSettings.FirstPage := FromPage;
                       PrinterSettings.LastPage := ToPage;
                     end;
      end;
      Self.Tag := 0;
    end
    else Self.Tag := 1;
  finally
    free;
  end
end;

procedure TQRCompositeReport.SetPrinterValues;
begin
  FQRPrinter.PrinterIndex := PrinterSettings.PrinterIndex;
  FQRPrinter.PaperSize := PrinterSettings.PaperSize;
  FQRPrinter.Orientation := PrinterSettings.Orientation;
  FQRPrinter.Copies := PrinterSettings.Copies;
  FQRPrinter.OutputBin := PrinterSettings.OutputBin;
  FQRPrinter.FirstPage := PrinterSettings.FirstPage;
  FQRPrinter.LastPage := PrinterSettings.LastPage;
  FQRPrinter.Title := PrinterSettings.Title;
   fqrprinter.UseStandardPrinter := printersettings.UseStandardPrinter;
   fqrprinter.PrintMetafile := printersettings.PrintMetaFile;
   fqrprinter.UseCustomBinCode := printersettings.UseCustomBinCode;
   fqrprinter.CustomBinCode := printersettings.CustomBinCode;
   fqrprinter.UseCustomPaperCode := printersettings.UseCustomPaperCode;
   fqrprinter.CustomPaperCode := printersettings.CustomPaperCode;
   // bug fixed !
   fqrprinter.ExtendedDuplex := printersettings.ExtendedDuplex;
   fqrprinter.Duplex := printersettings.Duplex;
   // QR4
   fqrprinter.PrintQuality := printersettings.PrintQuality;
   fqrprinter.Collate := printersettings.Collate;
   fqrprinter.ColorOption := printersettings.ColorOption;
end;

procedure TQRCompositeWinControl.CMPreviewClose(var Message : TCM_QRPreviewClose);
begin
  ParentReport.CMPreviewClose(Message);
end;

procedure TQRCompositeWinControl.CMPrint(var Message : TCM_QRPrint);
begin
  ParentReport.CMPrint(Message);
end;

destructor TQRCompositeWinControl.Destroy;
begin
  ParentReport.aWinControl := nil;
  inherited Destroy;
end;

procedure TQRCompositeReport.CMPreviewClose(var Message : TCM_QRPreviewClose);
begin
  if Generating then
    aReport.Cancel
  else
  begin
    FQRPrinter.Free;
    FQRPrinter := nil;
  end;
end;

procedure TQRCompositeReport.CMPrint(var Message : TCM_QRPrint);
begin
  Print;
end;

// exports
procedure TQRCompositeReport.ExportToFilter(AFilter : TQRExportFilter);
var
  I : integer;
  LastCurrentY : integer;
  LastPageCount : integer;
  LastColumn : integer;
  UserCancelled : boolean;
  SavedTag : integer;
  SavePrinter : TQRPrinter;
begin
  SavePrinter := FQRPrinter;
  FQRPrinter := TQRPrinter.Create( self );
  FQRPrinter.Destination := qrdPrinter;

  // lines above from .Print method
  Reports.Clear;
  aWinControl.Parent := TWinControl(Owner);
  FQRPrinter.PrinterIndex := FPrinterSettings.PrinterIndex;
  if assigned(FOnAddReports) then
    FOnAddReports(self);
  if Reports.Count > 0 then
  begin
    SetPrinterValues;
    FQRPrinter.Destination := qrdMetafile;
    FQRPrinter.BeginDoc;
    FQRPrinter.NewPage;
    aReport := TQuickRep(Reports[0]);
    aReport.Units := Native;
    LastCurrentY := round(aReport.Page.Length);
    LastPageCount := 0;
    LastColumn := 0;
    UserCancelled := false;
    FGenerating := true;
    for I := 0 to Reports.Count - 1 do
    begin
      aReport := TQuickRep(Reports[I]);
      aReport.QRPrinter := FQRPrinter;
      aReport.CurrentY := LastCurrentY;
      aReport.FPageCount := LastPageCount;
      aReport.FCurrentColumn := LastColumn;
      areport.CurrentX := trunc(aReport.Page.LeftMargin);
      SavedTag := aReport.Tag;
      if I = Reports.Count - 1 then
        aReport.Tag := 999;
      if assigned( FOnStartReport ) then
          FOnStartReport( self, aReport, I );
      aReport.ExportComposite( AFilter, FQRPrinter );
      // *** fire the afterPrint event ***
      if assigned(aReport.AfterPrint) then
                 aReport.AfterPrint( aReport);
      aReport.Tag := SavedTag;
      UserCancelled := aReport.Cancelled;
      if UserCancelled then Break;
      if assigned(FOnFinished) then FOnFinished(Reports[I]);
      LastCurrentY := aReport.CurrentY;
      LastPageCount := aReport.FPageCount;
      LastColumn := aReport.CurrentColumn;
    end;
    if not UserCancelled then
    begin
      FQRPrinter.EndDoc
    end
    else
    begin
      FQRPrinter.Free;
      FQRPrinter := nil;
    end;
    FGenerating := false;
  end;
  // 2 lines from .Print
  FQRPrinter.free;
  FQRPrinter := SavePrinter;
  if assigned(FOnFinished) then FOnFinished(Self);
end;

{$ifdef LLIONPDF}
procedure TQRCompositeReport.PrintToPDF( pdfcont : TPDFDocument );
var
  SavePrinter : TQRPrinter;
begin
    SavePrinter := FQRPrinter;
{$ifdef VER36PRO}
    FQRPrinter := TQRPrinter.Create( self );
{$else}
    FQRPrinter := TQRPrinter.Create;
{$endif}
    FQRPrinter.PDFDoc := pdfcont;
    pdfcont.OutputStream := nil;
    FQRPrinter.Destination := qrdPDFFile;
    CreateComposite;
    FQRPrinter.free;
    FQRPrinter := SavePrinter;
end;

procedure TQRCompositeReport.StreamToPDF( pdfcont : TPDFDocument; pdfstream : TStream );
var
  SavePrinter : TQRPrinter;
begin
    SavePrinter := FQRPrinter;
{$ifdef VER36PRO}
    FQRPrinter := TQRPrinter.Create( self );
{$else}
    FQRPrinter := TQRPrinter.Create;
{$endif}
    QRPrinter.PDFDoc := pdfcont;
    pdfcont.OutputStream := pdfstream;
    FQRPrinter.Destination := qrdPDFFile;
    CreateComposite;
    FQRPrinter.free;
    FQRPrinter := SavePrinter;
end;
{$endif}

procedure TQRCompositeReport.CreateComposite;
var
  I : integer;
  LastCurrentY : integer;
  LastPageCount : integer;
  LastColumn : integer;
  UserCancelled : boolean;
  SavedTag : integer;
begin
  Reports.Clear;
  aWinControl.Parent := TWinControl(Owner);
  // this loses all the settings because it interrogates the printer !
  //FQRPrinter.PrinterIndex := FPrinterSettings.PrinterIndex;
  if assigned(FOnAddReports) then
    FOnAddReports(self);
    UserCancelled := false;
  if Reports.Count > 0 then
  begin
    SetPrinterValues;
    FQRPrinter.BeginDoc;
    aReport := TQuickRep(Reports[0]);
    aReport.Units := Native;
    LastCurrentY := round(aReport.Page.Length);
    LastPageCount := 0;
    // attemp to fix the canvas bug
    LastColumn := aReport.Page.Columns;
    //UserCancelled := false;
    FGenerating := true;
    for I := 0 to Reports.Count - 1 do
    begin
      aReport := TQuickRep(Reports[I]);
      aReport.ExportFilter := nil;
      aReport.QRPrinter := FQRPrinter;
      aReport.CurrentY := LastCurrentY;
      aReport.FPageCount := LastPageCount;
      aReport.FCurrentColumn := LastColumn;
      SavedTag := aReport.Tag;
      if I = Reports.Count - 1 then
        aReport.Tag := 999;
      if assigned( FOnStartReport ) then
          FOnStartReport( self, aReport, I );
      aReport.CreateReport(true);
      if assigned(aReport.AfterPrint) then
                 aReport.AfterPrint( aReport);
      aReport.Tag := SavedTag;
      UserCancelled := aReport.Cancelled;
      if UserCancelled then Break;
      if assigned(FOnFinished) then FOnFinished(Reports[I]);
      LastCurrentY := aReport.CurrentY;
      LastPageCount := aReport.FPageCount;
      LastColumn := aReport.CurrentColumn;
    end;
    if not UserCancelled then
    begin
      FQRPrinter.EndDoc
    end else
    begin
      FQRPrinter.Free;
      FQRPrinter := nil;
    end;
    FGenerating := false;
  end;
  if assigned(FOnFinished) then FOnFinished(Self);
end;

procedure TQRCompositeReport.Print;
var
  SavePrinter : TQRPrinter;
  temprep, firstrep : TQuickrep;
begin
  SavePrinter := FQRPrinter;
  // get the reports because we need some settings to initialise the preview
  if assigned(FOnAddReports) then
    FOnAddReports(self);
  if reports.count = 0 then exit; // no reports
  // using a new report obj is safe - to get the new qrprinter to inherit
  // the setup options of the first report
  temprep := TQuickrep.Create(self);
  firstrep := TQuickRep(Reports[0]);
  // copy the settings
  temprep.Page.Orientation := firstrep.Page.Orientation;
  temprep.Page.PaperSize := firstrep.Page.PaperSize;
  temprep.previewwidth := firstrep.previewwidth;
  temprep.PreviewHeight := firstrep.PreviewHeight;
  temprep.PrinterSettings.Orientation := firstrep.Page.Orientation;
  temprep.PrinterSettings.FirstPage := PrinterSettings.FirstPage;
  temprep.PrinterSettings.LastPage := PrinterSettings.LastPage;
  FQRPrinter := TQRPrinter.Create( temprep);
  FQRPrinter.Orientation := firstrep.Page.Orientation;
  FQRPrinter.Title := ReportTitle;

  FQRPrinter.FirstPage := self.PrinterSettings.FirstPage;
  FQRPrinter.LastPage := self.PrinterSettings.LastPage;
  self.PrinterSettings.Orientation := firstrep.Page.Orientation;
  self.PrinterSettings.PaperSize := firstrep.Page.PaperSize;
  self.PrinterSettings.Title := ReportTitle;
  FQRPrinter.Destination := qrdPrinter;
  CreateComposite;
  FQRPrinter.free;
  temprep.Free;
  FQRPrinter := SavePrinter;
end;

procedure TQRCompositeReport.Preview;
var
  SavePrinter : TQRPrinter;
  temprep, firstrep : TQuickrep;
begin
  SavePrinter := FQRPrinter;
  // get the reports because we need some settings to initialise the preview
  if assigned(FOnAddReports) then
    FOnAddReports(self);
  if reports.count = 0 then exit; // no reports
  // using a new report obj is safe - to get the new qrprinter to inherit
  // the setup options of the first report
  temprep := TQuickrep.Create(self);
  firstrep := TQuickRep(Reports[0]);
  // copy the settings
  temprep.Page.Orientation := firstrep.Page.Orientation;
  temprep.Page.PaperSize := firstrep.Page.PaperSize;
  temprep.previewwidth := firstrep.previewwidth;
  temprep.PreviewHeight := firstrep.PreviewHeight;
  temprep.PrevFormStyle := firstrep.PrevFormStyle;
  temprep.PreviewInitialState := firstrep.PreviewInitialState;
  temprep.PrevInitialZoom := firstrep.PrevInitialZoom;  // 14th July 2006
  temprep.PrevShowThumbs := firstrep.PrevShowThumbs;
  temprep.PrevShowSearch := firstrep.PrevShowSearch;
  temprep.ReportTitle := firstrep.ReportTitle;
  temprep.PrinterSettings.FirstPage := PrinterSettings.FirstPage;
  temprep.PrinterSettings.LastPage := PrinterSettings.LastPage;
  temprep.ParentComposite := self;
  FQRPrinter := TQRPrinter.Create( temprep);
  FQRPrinter.Orientation := firstrep.Page.Orientation;
  FQRPrinter.OnPrintSetup := PrinterSetup;
  FQRPrinter.Master := AWinControl;
  FQRPrinter.FirstPage := self.PrinterSettings.FirstPage;
  FQRPrinter.LastPage := self.PrinterSettings.LastPage;
  // enable calls to custom previews
  FQRPrinter.OnPreview := firstrep.OnPreview;
  // export from preview enabled
  FQRPrinter.OnExportToFilter := ExportToFilter;
  FQRPrinter.Preview;
  CreateComposite;
  if FQRPrinter <> nil then
             FQRPrinter.ReportLoaded := true;
  repeat
    Application.HandleMessage
  until (FQRPrinter = nil) or (not FQRPrinter.ShowingPreview) or Application.Terminated;
  if assigned( FQRPrinter) then
      FQRPrinter.Free;
  FQRPrinter := SavePrinter;
  temprep.Free;
end;

procedure TQRCompositeReport.Prepare;
begin
    FQRPrinter := TQRPrinter.Create( self );
    CreateComposite;
end;

{$ifdef BDETABLES}
procedure PerformSQLParamsUpdate(Query : TQuery; Environment : TQREvEnvironment);
var
  I : integer;
  AResult : TQREvResult;
begin
  //aResult := TQREvResult.Create;
  Query.Active := false;
  for I := 0 to Query.ParamCount - 1 do
    if Environment.IndexOf(Query.Params.Items[I].Name) >= 0 then
      with Query.Params.Items[I] do
      begin
        AResult := Environment.Value(Name);
        case DataType of
          ftString : if AResult.Kind = resString then
            AsString := AResult.strResult;
          ftSmallInt,
          ftInteger,
          ftWord : if AResult.Kind = resInt then AsInteger := AResult.IntResult;
          ftBoolean : if AResult.Kind = resBool then AsBoolean := AResult.BooResult;
          ftFloat,
          ftCurrency,
          ftBCD : if AResult.Kind = resDouble then AsFloat := AResult.DblResult;
          ftDate : if AResult.Kind = resString then AsDate := StrToDate(AResult.strResult);
          ftTime : if AResult.Kind = resString then AsTime := StrToTime(AResult.StrResult);
          ftDateTime : if AResult.Kind = resString then AsDateTime := StrToDateTime(AResult.StrResult);
        end;
      end;
  Query.Active := true;
  //aresult.Free;
end;
{$endif}

procedure SetQRHiColor;
begin
  cqrRulerMinorStyle := psSolid;
  cqrRulerMajorStyle := psSolid;
  cqrRulerMinorColor := $f9f9f9;
  cqrRulerMajorColor := $f0f0f0;
  cqrRulerFontName := 'Small Fonts'; {<-- do not resource }
  cqrRulerFontColor := $707070;
  cqrRulerFontSize := 6;

  cqrMarginStyle := psDot;
  cqrMarginColor := $ff8080;

  cqrBandFrameStyle := psDot;
  cqrBandFrameColor := $606060;
end;

procedure SetQRLoColor;
begin
  cqrRulerMinorStyle := psDot;
  cqrRulerMajorStyle := psSolid;
  cqrRulerMinorColor := clSilver;
  cqrRulerMajorColor := clSilver;
  cqrRulerFontName := 'Small Fonts'; {<-- do not resource }
  cqrRulerFontColor := clSilver;
  cqrRulerFontSize := 6;

  cqrMarginStyle := psDash;
  cqrMarginColor := clGray;

  cqrBandFrameStyle := psSolid;
  cqrBandFrameColor := clGray;
end;

{ Initialization and finalization code }

procedure SetQRColorScheme;
var
  NumCol : integer;
  DC : THandle;
begin
  DC := GetDC(0);
  NumCol := GetDeviceCaps(DC,numcolors);
  if (NumCol > 256) or (NumCol < 0) then
    SetQRHiColor
  else
    SetQRLoColor;
  ReleaseDC(0, DC);
end;

var
  DefaultLCID: LCID;

initialization
  SetQRColorScheme;
  DefaultLCID := GetSystemDefaultLCID;
  LocalMeasureInches := GetLocaleChar(DefaultLCID, LOCALE_IMEASURE, ' ') = '1';
{$ifdef DELPHI6}
  GroupDescendentsWith(TQRCompositeReport, TControl);
{$endif}
end.


