{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 3.5 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRLablWz - MAILING LABEL SETUP DIALOG                   ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.no                               ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

unit QRLablWz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, QuickRpt;

type
  TQRLabelSetup = class(TForm)
    GroupBox1: TGroupBox;
    StandardLabel: TRadioButton;
    CustomLabel: TRadioButton;
    StandardLabelType: TComboBox;
    StartWizardBtn: TButton;
    Button1: TButton;
    TopMargin: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SideMargin: TEdit;
    LabelHeight: TEdit;
    Label3: TLabel;
    LabelWidth: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    VerticalPitch: TEdit;
    HorizontalPitch: TEdit;
    NumberAcross: TEdit;
    Label8: TLabel;
    PaperSize: TComboBox;
  private
    FReport : TQuickLabelReport;
  public
    property Report : TQuickLabelReport read FReport write FReport;
  end;

var
  QRLabelSetup: TQRLabelSetup;

implementation

{$R *.DFM}



end.
