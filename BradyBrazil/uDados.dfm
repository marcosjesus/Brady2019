object Fr_Dados: TFr_Dados
  OldCreateOrder = False
  Height = 633
  Width = 1113
  object FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 104
    Top = 25
  end
  object FDManager: TFDManager
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 104
    Top = 81
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'SERVER=GHOS2023'
      'User_Name=AppSOP'
      'Password=SOPApp1!'
      'ApplicationName=Brady'
      'Database=AppSOP'
      'MARS=yes'
      'LoginTimeout=300'
      'DriverID=MSSQL')
    Left = 103
    Top = 129
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'SELECT TSOP_ORDBILDATDOC'
      '       ,TSOP_ORDBILSITNOM'
      '      ,SUM(TSOP_ORDBILVALLIQ) AS TSOP_ORDBILVALLIQ'
      
        '      ,SUM(CASE WHEN TSOP_ORDBILTIPDOC = '#39'Billing'#39' THEN 1 ELSE 0' +
        ' END) AS TSOP_ORDBILQTDFAT'
      'FROM VSOP_OrderBilling'
      'WHERE TSOP_ORDBILTIPDOC IN ('#39'Billing'#39','#39'Return'#39')'
      '  AND TSOP_ORDBILDATDOC BETWEEN '#39'20150501'#39' AND '#39'20150531'#39
      'GROUP BY TSOP_ORDBILDATDOC'
      '        ,TSOP_ORDBILSITNOM')
    Left = 104
    Top = 185
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 104
    Top = 250
  end
  object FDQueryTSOP_ClienteSAP: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT A01.TSOP_CLISAPCOD'
      '      ,A01.TSOP_CLISAPCLICOD'
      '      ,A01.TSOP_CLISAPCLICGC'
      '      ,A01.TSOP_CLISAPCLINOM'
      '      ,A01.TSOP_CLISAPCLIPRE'
      '      ,A01.TSOP_CLISAPCLIREG'
      '      ,A01.TSOP_USUCODCAD'
      '      ,A01.TSOP_CLISAPDATCAD'
      '      ,A01.TSOP_USUCODALT'
      '      ,A01.TSOP_CLISAPDATALT'
      'FROM TSOP_ClienteSAP A01'
      'WHERE 1=2')
    Left = 384
    Top = 72
    object FDQueryTSOP_ClienteSAPTSOP_CLISAPCOD: TFDAutoIncField
      FieldName = 'TSOP_CLISAPCOD'
      Origin = 'TSOP_CLISAPCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_ClienteSAPTSOP_CLISAPCLICOD: TStringField
      FieldName = 'TSOP_CLISAPCLICOD'
      Origin = 'TSOP_CLISAPCLICOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ClienteSAPTSOP_CLISAPCLICGC: TStringField
      FieldName = 'TSOP_CLISAPCLICGC'
      Origin = 'TSOP_CLISAPCLICGC'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ClienteSAPTSOP_CLISAPCLINOM: TStringField
      FieldName = 'TSOP_CLISAPCLINOM'
      Origin = 'TSOP_CLISAPCLINOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ClienteSAPTSOP_CLISAPCLIPRE: TStringField
      FieldName = 'TSOP_CLISAPCLIPRE'
      Origin = 'TSOP_CLISAPCLIPRE'
      Size = 255
    end
    object FDQueryTSOP_ClienteSAPTSOP_CLISAPCLIREG: TStringField
      FieldName = 'TSOP_CLISAPCLIREG'
      Origin = 'TSOP_CLISAPCLIREG'
      Size = 255
    end
    object FDQueryTSOP_ClienteSAPTSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_ClienteSAPTSOP_CLISAPDATCAD: TSQLTimeStampField
      FieldName = 'TSOP_CLISAPDATCAD'
      Origin = 'TSOP_CLISAPDATCAD'
      Required = True
    end
    object FDQueryTSOP_ClienteSAPTSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_ClienteSAPTSOP_CLISAPDATALT: TSQLTimeStampField
      FieldName = 'TSOP_CLISAPDATALT'
      Origin = 'TSOP_CLISAPDATALT'
      Required = True
    end
  end
  object FDQueryTSOP_ItemClienteSAP: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT A01.TSOP_ITECLISAPCOD'
      '      ,A01.TSOP_ORICOD'
      '      ,A01.TSOP_ITECLISAPCAN'
      '      ,A01.TSOP_ITECLISAPCLICOD'
      '      ,A01.TSOP_ITECLISAPITECOD'
      '      ,A01.TSOP_ITECLISAPITECLICOD'
      '      ,A01.TSOP_USUCODCAD'
      '      ,A01.TSOP_ITECLISAPDATCAD'
      '      ,A01.TSOP_USUCODALT'
      '      ,A01.TSOP_ITECLISAPDATALT'
      'FROM TSOP_ItemClienteSAP A01'
      'WHERE 1=2')
    Left = 280
    Top = 200
    object FDQueryTSOP_ItemClienteSAPTSOP_ITECLISAPCOD: TFDAutoIncField
      FieldName = 'TSOP_ITECLISAPCOD'
      Origin = 'TSOP_ITECLISAPCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_ItemClienteSAPTSOP_ORICOD: TIntegerField
      FieldName = 'TSOP_ORICOD'
      Origin = 'TSOP_ORICOD'
      Required = True
    end
    object FDQueryTSOP_ItemClienteSAPTSOP_ITECLISAPCAN: TStringField
      FieldName = 'TSOP_ITECLISAPCAN'
      Origin = 'TSOP_ITECLISAPCAN'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ItemClienteSAPTSOP_ITECLISAPCLICOD: TStringField
      FieldName = 'TSOP_ITECLISAPCLICOD'
      Origin = 'TSOP_ITECLISAPCLICOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ItemClienteSAPTSOP_ITECLISAPITECOD: TStringField
      FieldName = 'TSOP_ITECLISAPITECOD'
      Origin = 'TSOP_ITECLISAPITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ItemClienteSAPTSOP_ITECLISAPITECLICOD: TStringField
      FieldName = 'TSOP_ITECLISAPITECLICOD'
      Origin = 'TSOP_ITECLISAPITECLICOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ItemClienteSAPTSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_ItemClienteSAPTSOP_ITECLISAPDATCAD: TSQLTimeStampField
      FieldName = 'TSOP_ITECLISAPDATCAD'
      Origin = 'TSOP_ITECLISAPDATCAD'
      Required = True
    end
    object FDQueryTSOP_ItemClienteSAPTSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_ItemClienteSAPTSOP_ITECLISAPDATALT: TSQLTimeStampField
      FieldName = 'TSOP_ITECLISAPDATALT'
      Origin = 'TSOP_ITECLISAPDATALT'
      Required = True
    end
  end
  object FDScriptTSOP_ItemClienteSAP: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_ItemClienteSAP')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 280
    Top = 240
  end
  object FDScriptTSOP_ClienteSAP: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_ClienteSAP')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 280
    Top = 96
  end
  object FDQueryTSOP_ZP00: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT A01.TSOP_Z00COD'
      '      ,A01.TSOP_ORICOD'
      '      ,A01.TSOP_Z00CAN'
      '      ,A01.TSOP_Z00ITECOD'
      '      ,A01.TSOP_Z00PER'
      '      ,A01.TSOP_Z00QTD'
      '      ,A01.TSOP_Z00VLF'
      '      ,A01.TSOP_Z00UOM'
      '      ,A01.TSOP_Z00DATINI'
      '      ,A01.TSOP_Z00DATFIM'
      '      ,A01.TSOP_USUCODCAD'
      '      ,A01.TSOP_Z00DATCAD'
      '      ,A01.TSOP_USUCODALT'
      '      ,A01.TSOP_Z00DATALT'
      'FROM TSOP_ZP00 A01'
      'WHERE 1=2')
    Left = 344
    Top = 296
    object FDQueryTSOP_ZP00TSOP_Z00COD: TFDAutoIncField
      FieldName = 'TSOP_Z00COD'
      Origin = 'TSOP_Z00COD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_ZP00TSOP_ORICOD: TIntegerField
      FieldName = 'TSOP_ORICOD'
      Origin = 'TSOP_ORICOD'
      Required = True
    end
    object FDQueryTSOP_ZP00TSOP_Z00CAN: TStringField
      FieldName = 'TSOP_Z00CAN'
      Origin = 'TSOP_Z00CAN'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZP00TSOP_Z00ITECOD: TStringField
      FieldName = 'TSOP_Z00ITECOD'
      Origin = 'TSOP_Z00ITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZP00TSOP_Z00PER: TBCDField
      FieldName = 'TSOP_Z00PER'
      Origin = 'TSOP_Z00PER'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTSOP_ZP00TSOP_Z00QTD: TBCDField
      FieldName = 'TSOP_Z00QTD'
      Origin = 'TSOP_Z00QTD'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTSOP_ZP00TSOP_Z00VLF: TBCDField
      FieldName = 'TSOP_Z00VLF'
      Origin = 'TSOP_Z00VLF'
      Required = True
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_ZP00TSOP_Z00UOM: TStringField
      FieldName = 'TSOP_Z00UOM'
      Origin = 'TSOP_Z00UOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZP00TSOP_Z00DATINI: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATINI'
      Origin = 'TSOP_Z00DATINI'
      Required = True
    end
    object FDQueryTSOP_ZP00TSOP_Z00DATFIM: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATFIM'
      Origin = 'TSOP_Z00DATFIM'
      Required = True
    end
    object FDQueryTSOP_ZP00TSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_ZP00TSOP_Z00DATCAD: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATCAD'
      Origin = 'TSOP_Z00DATCAD'
      Required = True
    end
    object FDQueryTSOP_ZP00TSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_ZP00TSOP_Z00DATALT: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATALT'
      Origin = 'TSOP_Z00DATALT'
      Required = True
    end
  end
  object FDScriptTSOP_ZP00: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_ZP00')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 280
    Top = 376
  end
  object FDQueryTSOP_ZP05: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT A01.TSOP_Z05COD'
      '      ,A01.TSOP_ORICOD'
      '      ,A01.TSOP_Z05CAN'
      '      ,A01.TSOP_Z05ITECOD'
      '      ,A01.TSOP_Z05CLICOD'
      '      ,A01.TSOP_Z05PER'
      '      ,A01.TSOP_Z05QTD'
      '      ,A01.TSOP_Z05VLF'
      '      ,A01.TSOP_Z05UOM'
      '      ,A01.TSOP_Z05DATINI'
      '      ,A01.TSOP_Z05DATFIM'
      '      ,A01.TSOP_USUCODCAD'
      '      ,A01.TSOP_Z05DATCAD'
      '      ,A01.TSOP_USUCODALT'
      '      ,A01.TSOP_Z05DATALT'
      'FROM TSOP_ZP05 A01'
      'WHERE 1=2')
    Left = 288
    Top = 464
    object FDQueryTSOP_ZP05TSOP_Z05COD: TFDAutoIncField
      FieldName = 'TSOP_Z05COD'
      Origin = 'TSOP_Z05COD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_ZP05TSOP_ORICOD: TIntegerField
      FieldName = 'TSOP_ORICOD'
      Origin = 'TSOP_ORICOD'
      Required = True
    end
    object FDQueryTSOP_ZP05TSOP_Z05CAN: TStringField
      FieldName = 'TSOP_Z05CAN'
      Origin = 'TSOP_Z05CAN'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZP05TSOP_Z05ITECOD: TStringField
      FieldName = 'TSOP_Z05ITECOD'
      Origin = 'TSOP_Z05ITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZP05TSOP_Z05CLICOD: TStringField
      FieldName = 'TSOP_Z05CLICOD'
      Origin = 'TSOP_Z05CLICOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZP05TSOP_Z05PER: TBCDField
      FieldName = 'TSOP_Z05PER'
      Origin = 'TSOP_Z05PER'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTSOP_ZP05TSOP_Z05QTD: TBCDField
      FieldName = 'TSOP_Z05QTD'
      Origin = 'TSOP_Z05QTD'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTSOP_ZP05TSOP_Z05VLF: TBCDField
      FieldName = 'TSOP_Z05VLF'
      Origin = 'TSOP_Z05VLF'
      Required = True
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_ZP05TSOP_Z05UOM: TStringField
      FieldName = 'TSOP_Z05UOM'
      Origin = 'TSOP_Z05UOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZP05TSOP_Z05DATINI: TSQLTimeStampField
      FieldName = 'TSOP_Z05DATINI'
      Origin = 'TSOP_Z05DATINI'
      Required = True
    end
    object FDQueryTSOP_ZP05TSOP_Z05DATFIM: TSQLTimeStampField
      FieldName = 'TSOP_Z05DATFIM'
      Origin = 'TSOP_Z05DATFIM'
      Required = True
    end
    object FDQueryTSOP_ZP05TSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_ZP05TSOP_Z05DATCAD: TSQLTimeStampField
      FieldName = 'TSOP_Z05DATCAD'
      Origin = 'TSOP_Z05DATCAD'
      Required = True
    end
    object FDQueryTSOP_ZP05TSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_ZP05TSOP_Z05DATALT: TSQLTimeStampField
      FieldName = 'TSOP_Z05DATALT'
      Origin = 'TSOP_Z05DATALT'
      Required = True
    end
  end
  object FDScriptTSOP_ZP05: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_ZP05')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 288
    Top = 520
  end
  object FDQueryTSOP_Item: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT A01.TSOP_ITECOD'
      '      ,A01.TSOP_ITECAN'
      '      ,A01.TSOP_ORICOD'
      '      ,A01.TSOP_ITEITECOD'
      '      ,A01.TSOP_ITEITENOM'
      '      ,A01.TSOP_ITEGRUMER'
      '      ,A01.TSOP_USUCODCAD'
      '      ,A01.TSOP_ITEDATCAD'
      '      ,A01.TSOP_USUCODALT'
      '      ,A01.TSOP_ITEDATALT'
      'FROM TSOP_Item A01'
      'WHERE 1=2')
    Left = 480
    Top = 45
    object FDQueryTSOP_ItemTSOP_ITECOD: TFDAutoIncField
      FieldName = 'TSOP_ITECOD'
      Origin = 'TSOP_ITECOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_ItemTSOP_ORICOD: TIntegerField
      FieldName = 'TSOP_ORICOD'
      Origin = 'TSOP_ORICOD'
      Required = True
    end
    object FDQueryTSOP_ItemTSOP_ITECAN: TStringField
      FieldName = 'TSOP_ITECAN'
      Origin = 'TSOP_ITECAN'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ItemTSOP_ITEITECOD: TStringField
      FieldName = 'TSOP_ITEITECOD'
      Origin = 'TSOP_ITEITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ItemTSOP_ITEITENOM: TStringField
      FieldName = 'TSOP_ITEITENOM'
      Origin = 'TSOP_ITEITENOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ItemTSOP_ITEGRUMER: TStringField
      FieldName = 'TSOP_ITEGRUMER'
      Origin = 'TSOP_ITEGRUMER'
      Size = 255
    end
    object FDQueryTSOP_ItemTSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_ItemTSOP_ITEDATCAD: TSQLTimeStampField
      FieldName = 'TSOP_ITEDATCAD'
      Origin = 'TSOP_ITEDATCAD'
      Required = True
    end
    object FDQueryTSOP_ItemTSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_ItemTSOP_ITEDATALT: TSQLTimeStampField
      FieldName = 'TSOP_ITEDATALT'
      Origin = 'TSOP_ITEDATALT'
      Required = True
    end
  end
  object FDScriptTSOP_Item: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_Item')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 480
    Top = 101
  end
  object FDQueryTSOP_OrderBilling: TFDQuery
    OnNewRecord = FDQueryTSOP_OrderBillingNewRecord
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT * FROM TSOP_OrderBilling A01 WHERE 1=2')
    Left = 520
    Top = 328
    object FDQueryTSOP_OrderBillingTSOP_ORDBILCOD: TFDAutoIncField
      FieldName = 'TSOP_ORDBILCOD'
      Origin = 'TSOP_ORDBILCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_OrderBillingTSOP_ORICOD: TIntegerField
      FieldName = 'TSOP_ORICOD'
      Origin = 'TSOP_ORICOD'
      Required = True
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILSITNOM: TStringField
      FieldName = 'TSOP_ORDBILSITNOM'
      Origin = 'TSOP_ORDBILSITNOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILCANNOM: TStringField
      FieldName = 'TSOP_ORDBILCANNOM'
      Origin = 'TSOP_ORDBILCANNOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILDATDOC: TSQLTimeStampField
      FieldName = 'TSOP_ORDBILDATDOC'
      Origin = 'TSOP_ORDBILDATDOC'
      Required = True
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILNRODOC: TStringField
      FieldName = 'TSOP_ORDBILNRODOC'
      Origin = 'TSOP_ORDBILNRODOC'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILTIPDOC: TStringField
      FieldName = 'TSOP_ORDBILTIPDOC'
      Origin = 'TSOP_ORDBILTIPDOC'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILNRODOCREF: TStringField
      FieldName = 'TSOP_ORDBILNRODOCREF'
      Origin = 'TSOP_ORDBILNRODOCREF'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILDATDOCREQ: TSQLTimeStampField
      FieldName = 'TSOP_ORDBILDATDOCREQ'
      Origin = 'TSOP_ORDBILDATDOCREQ'
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILCLICOD: TStringField
      FieldName = 'TSOP_ORDBILCLICOD'
      Origin = 'TSOP_ORDBILCLICOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILCLINOM: TStringField
      FieldName = 'TSOP_ORDBILCLINOM'
      Origin = 'TSOP_ORDBILCLINOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILGRUCLINOM: TStringField
      FieldName = 'TSOP_ORDBILGRUCLINOM'
      Origin = 'TSOP_ORDBILGRUCLINOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILREPNOM: TStringField
      FieldName = 'TSOP_ORDBILREPNOM'
      Origin = 'TSOP_ORDBILREPNOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILITECOD: TStringField
      FieldName = 'TSOP_ORDBILITECOD'
      Origin = 'TSOP_ORDBILITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILITENOM: TStringField
      FieldName = 'TSOP_ORDBILITENOM'
      Origin = 'TSOP_ORDBILITENOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILITEUNI: TStringField
      FieldName = 'TSOP_ORDBILITEUNI'
      Origin = 'TSOP_ORDBILITEUNI'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILITEFAM001: TStringField
      FieldName = 'TSOP_ORDBILITEFAM001'
      Origin = 'TSOP_ORDBILITEFAM001'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILITEFAM002: TStringField
      FieldName = 'TSOP_ORDBILITEFAM002'
      Origin = 'TSOP_ORDBILITEFAM002'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILITEFAM003: TStringField
      FieldName = 'TSOP_ORDBILITEFAM003'
      Origin = 'TSOP_ORDBILITEFAM003'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILITEFAM004: TStringField
      FieldName = 'TSOP_ORDBILITEFAM004'
      Origin = 'TSOP_ORDBILITEFAM004'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILITEFAM005: TStringField
      FieldName = 'TSOP_ORDBILITEFAM005'
      Origin = 'TSOP_ORDBILITEFAM005'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILVALLIQ: TBCDField
      FieldName = 'TSOP_ORDBILVALLIQ'
      Origin = 'TSOP_ORDBILVALLIQ'
      Required = True
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILQTD: TBCDField
      FieldName = 'TSOP_ORDBILQTD'
      Origin = 'TSOP_ORDBILQTD'
      Required = True
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_OrderBillingTSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILDATCAD: TSQLTimeStampField
      FieldName = 'TSOP_ORDBILDATCAD'
      Origin = 'TSOP_ORDBILDATCAD'
      Required = True
    end
    object FDQueryTSOP_OrderBillingTSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILDATALT: TSQLTimeStampField
      FieldName = 'TSOP_ORDBILDATALT'
      Origin = 'TSOP_ORDBILDATALT'
      Required = True
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILITESEQ: TIntegerField
      FieldName = 'TSOP_ORDBILITESEQ'
      Origin = 'TSOP_ORDBILITESEQ'
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILQTDSKU: TBCDField
      FieldName = 'TSOP_ORDBILQTDSKU'
      Origin = 'TSOP_ORDBILQTDSKU'
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_OrderBillingTSOP_ORDBILBLOCK: TStringField
      FieldName = 'TSOP_ORDBILBLOCK'
      Origin = 'TSOP_ORDBILBLOCK'
      Size = 4
    end
    object FDQueryTSOP_OrderBillingTSOP_PRIMARYCATALOG: TStringField
      FieldName = 'TSOP_PRIMARYCATALOG'
      Origin = 'TSOP_PRIMARYCATALOG'
      Size = 30
    end
    object FDQueryTSOP_OrderBillingTSOP_CUSTOMERPURCHASE: TStringField
      FieldName = 'TSOP_CUSTOMERPURCHASE'
      Origin = 'TSOP_CUSTOMERPURCHASE'
      Size = 30
    end
  end
  object FDScriptTSOP_OrderBilling: TFDScript
    SQLScripts = <
      item
        Name = 'BILLING'
        SQL.Strings = (
          
            'DELETE FROM TSOP_OrderBilling WHERE TSOP_ORDBILDATDOC = :TSOP_OR' +
            'DBILDATDOC AND TSOP_ORDBILTIPDOC IN ( '#39'Billing'#39', '#39'Return'#39' ) AND ' +
            'TSOP_ORICOD = 1')
      end
      item
        Name = 'ORDER-TAM'
        SQL.Strings = (
          
            'DELETE FROM TSOP_OrderBilling WHERE TSOP_ORDBILTIPDOC = '#39'Order'#39' ' +
            'AND TSOP_ORICOD = 1 AND TSOP_ORDBILSITNOM = '#39'1063'#39)
      end
      item
        Name = 'ORDER-MAN'
        SQL.Strings = (
          
            'DELETE FROM TSOP_OrderBilling WHERE TSOP_ORDBILTIPDOC = '#39'Order'#39' ' +
            'AND TSOP_ORICOD = 1 AND TSOP_ORDBILSITNOM <> '#39'1063'#39)
      end>
    Connection = FDConnection
    Params = <
      item
        Name = 'TSOP_ORDBILDATDOC'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 41487d
      end>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 472
    Top = 408
  end
  object FDQueryTMAQ_ItemBOM: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TMAQ_ItemBOM A01'
      'WHERE 1=2')
    Left = 616
    Top = 53
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMCOD: TFDAutoIncField
      FieldName = 'TMAQ_ITEBOMCOD'
      Origin = 'TMAQ_ITEBOMCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITECOD: TStringField
      FieldName = 'TMAQ_ITEBOMITECOD'
      Origin = 'TMAQ_ITEBOMITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITEMPRCOD: TStringField
      FieldName = 'TMAQ_ITEBOMITEMPRCOD'
      Origin = 'TMAQ_ITEBOMITEMPRCOD'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITEMTRTYP: TStringField
      FieldName = 'TMAQ_ITEBOMITEMTRTYP'
      Origin = 'TMAQ_ITEBOMITEMTRTYP'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMORDPRO: TStringField
      FieldName = 'TMAQ_ITEBOMORDPRO'
      Origin = 'TMAQ_ITEBOMORDPRO'
      Size = 255
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMSALORD: TStringField
      FieldName = 'TMAQ_ITEBOMSALORD'
      Origin = 'TMAQ_ITEBOMSALORD'
      Size = 255
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMSALORDITE: TIntegerField
      FieldName = 'TMAQ_ITEBOMSALORDITE'
      Origin = 'TMAQ_ITEBOMSALORDITE'
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITEMPRQTDBAS: TBCDField
      FieldName = 'TMAQ_ITEBOMITEMPRQTDBAS'
      Origin = 'TMAQ_ITEBOMITEMPRQTDBAS'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITEMPRFIX: TStringField
      FieldName = 'TMAQ_ITEBOMITEMPRFIX'
      Origin = 'TMAQ_ITEBOMITEMPRFIX'
      Required = True
      FixedChar = True
      Size = 1
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITEMPRQTD: TBCDField
      FieldName = 'TMAQ_ITEBOMITEMPRQTD'
      Origin = 'TMAQ_ITEBOMITEMPRQTD'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITEMPRQTDREF: TBCDField
      FieldName = 'TMAQ_ITEBOMITEMPRQTDREF'
      Origin = 'TMAQ_ITEBOMITEMPRQTDREF'
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITEMPRCOSREL: TStringField
      FieldName = 'TMAQ_ITEBOMITEMPRCOSREL'
      Origin = 'TMAQ_ITEBOMITEMPRCOSREL'
      Required = True
      Size = 1
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMSIT: TStringField
      FieldName = 'TMAQ_ITEBOMSIT'
      Origin = 'TMAQ_ITEBOMSIT'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITEMPRBUK: TStringField
      FieldName = 'TMAQ_ITEBOMITEMPRBUK'
      Origin = 'TMAQ_ITEBOMITEMPRBUK'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMITEMPRUOM: TStringField
      FieldName = 'TMAQ_ITEBOMITEMPRUOM'
      Origin = 'TMAQ_ITEBOMITEMPRUOM'
      Size = 255
    end
    object FDQueryTMAQ_ItemBOMTMAQ_ITEBOMDAT: TSQLTimeStampField
      FieldName = 'TMAQ_ITEBOMDAT'
      Origin = 'TMAQ_ITEBOMDAT'
    end
  end
  object FDScriptTMAQ_ItemBOM: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE'
          'FROM TMAQ_ItemBOM'
          
            'WHERE  MONTH(TMAQ_ITEBOMDAT) = MONTH(DATEADD(MONTH, -1, GETDATE(' +
            ')))'
          
            '  AND YEAR(TMAQ_ITEBOMDAT)   = YEAR( DATEADD(MONTH, -1, GETDATE(' +
            ')))')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 616
    Top = 109
  end
  object FDQueryTMAQ_ItemRouting: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TMAQ_ItemRouting A01'
      'WHERE 1=2')
    Left = 760
    Top = 45
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUCOD: TFDAutoIncField
      FieldName = 'TMAQ_ITEROUCOD'
      Origin = 'TMAQ_ITEROUCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUSIT: TStringField
      FieldName = 'TMAQ_ITEROUSIT'
      Origin = 'TMAQ_ITEROUSIT'
      Size = 50
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUITECOD: TStringField
      FieldName = 'TMAQ_ITEROUITECOD'
      Origin = 'TMAQ_ITEROUITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUDATINI: TSQLTimeStampField
      FieldName = 'TMAQ_ITEROUDATINI'
      Origin = 'TMAQ_ITEROUDATINI'
      Required = True
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUWKCCOD: TStringField
      FieldName = 'TMAQ_ITEROUWKCCOD'
      Origin = 'TMAQ_ITEROUWKCCOD'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUCCU: TStringField
      FieldName = 'TMAQ_ITEROUCCU'
      Origin = 'TMAQ_ITEROUCCU'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUCTR: TStringField
      FieldName = 'TMAQ_ITEROUCTR'
      Origin = 'TMAQ_ITEROUCTR'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUOPE: TIntegerField
      FieldName = 'TMAQ_ITEROUOPE'
      Origin = 'TMAQ_ITEROUOPE'
      Required = True
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUTXT: TStringField
      FieldName = 'TMAQ_ITEROUTXT'
      Origin = 'TMAQ_ITEROUTXT'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUQTDBAS: TBCDField
      FieldName = 'TMAQ_ITEROUQTDBAS'
      Origin = 'TMAQ_ITEROUQTDBAS'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUMINSEP: TBCDField
      FieldName = 'TMAQ_ITEROUMINSEP'
      Origin = 'TMAQ_ITEROUMINSEP'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUMINMAC: TBCDField
      FieldName = 'TMAQ_ITEROUMINMAC'
      Origin = 'TMAQ_ITEROUMINMAC'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUMINLAB: TBCDField
      FieldName = 'TMAQ_ITEROUMINLAB'
      Origin = 'TMAQ_ITEROUMINLAB'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUMINOVE: TBCDField
      FieldName = 'TMAQ_ITEROUMINOVE'
      Origin = 'TMAQ_ITEROUMINOVE'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_ItemRoutingTMAQ_ITEROUDAT: TSQLTimeStampField
      FieldName = 'TMAQ_ITEROUDAT'
      Origin = 'TMAQ_ITEROUDAT'
    end
  end
  object FDScriptTMAQ_ItemRouting: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE'
          'FROM TMAQ_ItemRouting'
          
            'WHERE  MONTH(TMAQ_ITEROUDAT) = MONTH(DATEADD(MONTH, -1, GETDATE(' +
            ')))'
          
            '  AND YEAR(TMAQ_ITEROUDAT)   = YEAR( DATEADD(MONTH, -1, GETDATE(' +
            ')))')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 760
    Top = 101
  end
  object FDQueryTMAQ_OrdemProducao: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TMAQ_OrdemProducao A01'
      'WHERE 1=2')
    Left = 656
    Top = 213
    object FDQueryTMAQ_OrdemProducaoTMAQ_ORDPROCOD: TFDAutoIncField
      FieldName = 'TMAQ_ORDPROCOD'
      Origin = 'TMAQ_ORDPROCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTMAQ_OrdemProducaoTMAQ_ORDPRONUM: TStringField
      FieldName = 'TMAQ_ORDPRONUM'
      Origin = 'TMAQ_ORDPRONUM'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_OrdemProducaoTMAQ_ORDPROSIT: TStringField
      FieldName = 'TMAQ_ORDPROSIT'
      Origin = 'TMAQ_ORDPROSIT'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_OrdemProducaoTMAQ_ORDPROITECOD: TStringField
      FieldName = 'TMAQ_ORDPROITECOD'
      Origin = 'TMAQ_ORDPROITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_OrdemProducaoTMAQ_ORDPROQTDPLA: TBCDField
      FieldName = 'TMAQ_ORDPROQTDPLA'
      Origin = 'TMAQ_ORDPROQTDPLA'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_OrdemProducaoTMAQ_ORDPROQTDREP: TBCDField
      FieldName = 'TMAQ_ORDPROQTDREP'
      Origin = 'TMAQ_ORDPROQTDREP'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_OrdemProducaoTMAQ_ORDPRODATENC: TSQLTimeStampField
      FieldName = 'TMAQ_ORDPRODATENC'
      Origin = 'TMAQ_ORDPRODATENC'
      Required = True
    end
  end
  object FDScriptTMAQ_OrdemProducao: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TMAQ_OrdemProducao')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 656
    Top = 269
  end
  object FDQueryTMAQ_OrdemProducaoMPR: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TMAQ_OrdemProducaoMPR A01'
      'WHERE 1=2')
    Left = 656
    Top = 357
    object FDQueryTMAQ_OrdemProducaoMPRTMAQ_ORDPROMPRCOD: TFDAutoIncField
      FieldName = 'TMAQ_ORDPROMPRCOD'
      Origin = 'TMAQ_ORDPROMPRCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTMAQ_OrdemProducaoMPRTMAQ_ORDPROMPRNUM: TStringField
      FieldName = 'TMAQ_ORDPROMPRNUM'
      Origin = 'TMAQ_ORDPROMPRNUM'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_OrdemProducaoMPRTMAQ_ORDPROMPRITECOD: TStringField
      FieldName = 'TMAQ_ORDPROMPRITECOD'
      Origin = 'TMAQ_ORDPROMPRITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_OrdemProducaoMPRTMAQ_ORDPROMPRQTDTEO: TBCDField
      FieldName = 'TMAQ_ORDPROMPRQTDTEO'
      Origin = 'TMAQ_ORDPROMPRQTDTEO'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_OrdemProducaoMPRTMAQ_ORDPROMPRQTDREA: TBCDField
      FieldName = 'TMAQ_ORDPROMPRQTDREA'
      Origin = 'TMAQ_ORDPROMPRQTDREA'
      Required = True
      Precision = 15
      Size = 3
    end
  end
  object FDScriptTMAQ_OrdemProducaoMPR: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TMAQ_OrdemProducaoMPR')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 656
    Top = 413
  end
  object FDQueryTMAQ_ItemFolha: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TMAQ_ItemFolha A01'
      'WHERE 1=2')
    Left = 656
    Top = 485
    object FDQueryTMAQ_ItemFolhaTMAQ_ITEFOLCOD: TFDAutoIncField
      FieldName = 'TMAQ_ITEFOLCOD'
      Origin = 'TMAQ_ITEFOLCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTMAQ_ItemFolhaTMAQ_ITEFOLITECOD: TStringField
      FieldName = 'TMAQ_ITEFOLITECOD'
      Origin = 'TMAQ_ITEFOLITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemFolhaTMAQ_ITEFOLQTDCOR: TIntegerField
      FieldName = 'TMAQ_ITEFOLQTDCOR'
      Origin = 'TMAQ_ITEFOLQTDCOR'
      Required = True
    end
    object FDQueryTMAQ_ItemFolhaTMAQ_ITEFOLETQBOB: TIntegerField
      FieldName = 'TMAQ_ITEFOLETQBOB'
      Origin = 'TMAQ_ITEFOLETQBOB'
    end
  end
  object FDScriptTMAQ_ItemFolha: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TMAQ_ItemFolha')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 656
    Top = 541
  end
  object FDQueryTMAQ_ItemFaca: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TMAQ_ItemFaca A01'
      'WHERE 1=2')
    Left = 496
    Top = 493
  end
  object FDScriptTMAQ_ItemFaca: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TMAQ_ItemFaca')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 496
    Top = 549
  end
  object FDQueryTMAQ_Item: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TMAQ_Item A01'
      'WHERE 1=2')
    Left = 104
    Top = 485
    object FDQueryTMAQ_ItemTMAQ_ITECOD: TFDAutoIncField
      FieldName = 'TMAQ_ITECOD'
      Origin = 'TMAQ_ITECOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTMAQ_ItemTMAQ_ITEITECOD: TStringField
      FieldName = 'TMAQ_ITEITECOD'
      Origin = 'TMAQ_ITEITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemTMAQ_ITENOM: TStringField
      FieldName = 'TMAQ_ITENOM'
      Origin = 'TMAQ_ITENOM'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemTMAQ_ITESIT: TStringField
      FieldName = 'TMAQ_ITESIT'
      Origin = 'TMAQ_ITESIT'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemTMAQ_ITEMRP: TStringField
      FieldName = 'TMAQ_ITEMRP'
      Origin = 'TMAQ_ITEMRP'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemTMAQ_ITEUNI: TStringField
      FieldName = 'TMAQ_ITEUNI'
      Origin = 'TMAQ_ITEUNI'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemTMAQ_ITEMTRTYP: TStringField
      FieldName = 'TMAQ_ITEMTRTYP'
      Origin = 'TMAQ_ITEMTRTYP'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemTMAQ_ITECOSLOT: TBCDField
      FieldName = 'TMAQ_ITECOSLOT'
      Origin = 'TMAQ_ITECOSLOT'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTMAQ_ItemTMAQ_ITEPROTYP: TStringField
      FieldName = 'TMAQ_ITEPROTYP'
      Origin = 'TMAQ_ITEPROTYP'
      Required = True
      Size = 255
    end
    object FDQueryTMAQ_ItemTMAQ_ITEMRPCON: TStringField
      FieldName = 'TMAQ_ITEMRPCON'
      Origin = 'TMAQ_ITEMRPCON'
      Size = 50
    end
    object FDQueryTMAQ_ItemTMAQ_ITEBASMAT: TStringField
      FieldName = 'TMAQ_ITEBASMAT'
      Origin = 'TMAQ_ITEBASMAT'
      Size = 50
    end
    object FDQueryTMAQ_ItemTMAQ_ITECOP: TStringField
      FieldName = 'TMAQ_ITECOP'
      Origin = 'TMAQ_ITECOP'
      Size = 50
    end
    object FDQueryTMAQ_ItemTMAQ_DTIMPORTACAO: TSQLTimeStampField
      FieldName = 'TMAQ_DTIMPORTACAO'
      Origin = 'TMAQ_DTIMPORTACAO'
    end
  end
  object FDScriptTMAQ_Item: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TMAQ_Item'
          
            'WHERE  MONTH(TMAQ_DTIMPORTACAO) = MONTH(DATEADD(MONTH, -1, GETDA' +
            'TE()))'
          
            '  AND YEAR(TMAQ_DTIMPORTACAO)   = YEAR( DATEADD(MONTH, -1, GETDA' +
            'TE()))'
          '')
      end>
    Connection = FDConnection
    Params = <
      item
        Name = 'Dt_Importacao'
        ADDataType = dtDateTime
      end>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 72
    Top = 541
  end
  object FDScriptTMAQ_OrdemProducaoMPR2: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'UPDATE TMAQ_OrdemProducaoMPR SET TMAQ_ORDPROMPRSEQ = NULL'
          'GO'
          'UPDATE A01'
          'SET A01.TMAQ_ORDPROMPRSEQ = 0'
          
            'FROM TMAQ_OrdemProducaoMPR A01 INNER JOIN TMAQ_OrdemProducao B01' +
            ' ON ( A01.TMAQ_ORDPROMPRNUM    = B01.TMAQ_ORDPRONUM )'
          
            '                               INNER JOIN TMAQ_Item          C01' +
            ' ON ( A01.TMAQ_ORDPROMPRITECOD = C01.TMAQ_ITEITECOD )'
          'WHERE C01.TMAQ_ITEMTRTYP = '#39'ZPRT'#39
          'GO'
          'WHILE @@ROWCOUNT > 0'
          'BEGIN'
          ''
          #9'UPDATE A01'
          
            #9'SET A01.TMAQ_ORDPROMPRSEQ = ISNULL((SELECT MAX(A02.TMAQ_ORDPROM' +
            'PRSEQ) FROM TMAQ_OrdemProducaoMPR A02 WHERE A02.TMAQ_ORDPROMPRNU' +
            'M = A01.TMAQ_ORDPROMPRNUM),0) + 1'
          
            #9'FROM TMAQ_OrdemProducaoMPR A01 INNER JOIN ( SELECT A01.TMAQ_ORD' +
            'PROMPRNUM, MIN(TMAQ_ORDPROMPRITECOD) AS TMAQ_ORDPROMPRITECOD FRO' +
            'M TMAQ_OrdemProducaoMPR A01 WHERE A01.TMAQ_ORDPROMPRSEQ IS NULL ' +
            'GROUP BY A01.TMAQ_ORDPROMPRNUM ) B01 ON ( A01.TMAQ_ORDPROMPRNUM ' +
            '= B01.TMAQ_ORDPROMPRNUM AND A01.TMAQ_ORDPROMPRITECOD = B01.TMAQ_' +
            'ORDPROMPRITECOD )'
          ''
          'END'
          '')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 104
    Top = 357
  end
  object FDQueryTSOP_ZD00: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TSOP_ZD00 A01'
      'WHERE 1=2')
    Left = 448
    Top = 192
    object FDQueryTSOP_ZD00TSOP_Z00COD: TFDAutoIncField
      FieldName = 'TSOP_Z00COD'
      Origin = 'TSOP_Z00COD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_ZD00TSOP_ORICOD: TIntegerField
      FieldName = 'TSOP_ORICOD'
      Origin = 'TSOP_ORICOD'
      Required = True
    end
    object FDQueryTSOP_ZD00TSOP_Z00CAN: TStringField
      FieldName = 'TSOP_Z00CAN'
      Origin = 'TSOP_Z00CAN'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZD00TSOP_Z000PARCOD: TStringField
      FieldName = 'TSOP_Z000PARCOD'
      Origin = 'TSOP_Z000PARCOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZD00TSOP_Z000GRUMER: TStringField
      FieldName = 'TSOP_Z000GRUMER'
      Origin = 'TSOP_Z000GRUMER'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ZD00TSOP_Z00PER: TBCDField
      FieldName = 'TSOP_Z00PER'
      Origin = 'TSOP_Z00PER'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTSOP_ZD00TSOP_Z00DATINI: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATINI'
      Origin = 'TSOP_Z00DATINI'
      Required = True
    end
    object FDQueryTSOP_ZD00TSOP_Z00DATFIM: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATFIM'
      Origin = 'TSOP_Z00DATFIM'
      Required = True
    end
    object FDQueryTSOP_ZD00TSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_ZD00TSOP_Z00DATCAD: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATCAD'
      Origin = 'TSOP_Z00DATCAD'
      Required = True
    end
    object FDQueryTSOP_ZD00TSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_ZD00TSOP_Z00DATALT: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATALT'
      Origin = 'TSOP_Z00DATALT'
      Required = True
    end
  end
  object FDScriptTSOP_ZD00: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_ZD00')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 448
    Top = 248
  end
  object FDQueryTSOP_ClienteParceiro: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TSOP_ClienteParceiro A01'
      'WHERE 1=2')
    Left = 392
    Top = 120
    object FDQueryTSOP_ClienteParceiroTSOP_CLIPARCOD: TFDAutoIncField
      FieldName = 'TSOP_CLIPARCOD'
      Origin = 'TSOP_CLIPARCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_ClienteParceiroTSOP_CLIPARCLICOD: TStringField
      FieldName = 'TSOP_CLIPARCLICOD'
      Origin = 'TSOP_CLIPARCLICOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ClienteParceiroTSOP_CLIPARNUM: TStringField
      FieldName = 'TSOP_CLIPARNUM'
      Origin = 'TSOP_CLIPARNUM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_ClienteParceiroTSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_ClienteParceiroTSOP_CLIPARDATCAD: TSQLTimeStampField
      FieldName = 'TSOP_CLIPARDATCAD'
      Origin = 'TSOP_CLIPARDATCAD'
      Required = True
    end
    object FDQueryTSOP_ClienteParceiroTSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_ClienteParceiroTSOP_CLIPARDATALT: TSQLTimeStampField
      FieldName = 'TSOP_CLIPARDATALT'
      Origin = 'TSOP_CLIPARDATALT'
      Required = True
    end
  end
  object FDScriptTSOP_ClienteParceiro: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_ClienteParceiro')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 288
    Top = 144
  end
  object FDQueryTSOP_A800: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT A01.TSOP_Z00COD'
      '      ,A01.TSOP_ORICOD'
      '      ,A01.TSOP_Z00CAN'
      '      ,A01.TSOP_Z00ITECOD'
      '      ,A01.TSOP_Z00PER'
      '      ,A01.TSOP_Z00QTD'
      '      ,A01.TSOP_Z00VLF'
      '      ,A01.TSOP_Z00UOM'
      '      ,A01.TSOP_Z00DATINI'
      '      ,A01.TSOP_Z00DATFIM'
      '      ,A01.TSOP_USUCODCAD'
      '      ,A01.TSOP_Z00DATCAD'
      '      ,A01.TSOP_USUCODALT'
      '      ,A01.TSOP_Z00DATALT'
      'FROM TSOP_A800 A01'
      'WHERE 1=2')
    Left = 448
    Top = 304
    object FDQueryTSOP_A800TSOP_Z00COD: TFDAutoIncField
      FieldName = 'TSOP_Z00COD'
      Origin = 'TSOP_Z00COD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_A800TSOP_ORICOD: TIntegerField
      FieldName = 'TSOP_ORICOD'
      Origin = 'TSOP_ORICOD'
      Required = True
    end
    object FDQueryTSOP_A800TSOP_Z00CAN: TStringField
      FieldName = 'TSOP_Z00CAN'
      Origin = 'TSOP_Z00CAN'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_A800TSOP_Z00ITECOD: TStringField
      FieldName = 'TSOP_Z00ITECOD'
      Origin = 'TSOP_Z00ITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_A800TSOP_Z00PER: TBCDField
      FieldName = 'TSOP_Z00PER'
      Origin = 'TSOP_Z00PER'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTSOP_A800TSOP_Z00QTD: TBCDField
      FieldName = 'TSOP_Z00QTD'
      Origin = 'TSOP_Z00QTD'
      Required = True
      Precision = 15
      Size = 3
    end
    object FDQueryTSOP_A800TSOP_Z00VLF: TBCDField
      FieldName = 'TSOP_Z00VLF'
      Origin = 'TSOP_Z00VLF'
      Required = True
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_A800TSOP_Z00UOM: TStringField
      FieldName = 'TSOP_Z00UOM'
      Origin = 'TSOP_Z00UOM'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_A800TSOP_Z00DATINI: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATINI'
      Origin = 'TSOP_Z00DATINI'
      Required = True
    end
    object FDQueryTSOP_A800TSOP_Z00DATFIM: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATFIM'
      Origin = 'TSOP_Z00DATFIM'
      Required = True
    end
    object FDQueryTSOP_A800TSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_A800TSOP_Z00DATCAD: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATCAD'
      Origin = 'TSOP_Z00DATCAD'
      Required = True
    end
    object FDQueryTSOP_A800TSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_A800TSOP_Z00DATALT: TSQLTimeStampField
      FieldName = 'TSOP_Z00DATALT'
      Origin = 'TSOP_Z00DATALT'
      Required = True
    end
  end
  object FDScriptTSOP_A800: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_A800')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 384
    Top = 352
  end
  object FDQuerySalesRep: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      
        'SELECT TSIS_USUNOM = COALESCE(A01.TSIS_USUNOM, B01.TSOP_ORDBILRE' +
        'PNOM)'
      
        '      ,TSIS_USUEML = COALESCE(A01.TSIS_USUEML,'#39'marcos.jesus.exte' +
        'rnal@k2partnering.com'#39')'
      'FROM ('
      '       SELECT A01.TSIS_USUNOM'
      #9#9#9' ,A01.TSIS_USUEML'
      #9'   FROM TSIS_Usuario A01'
      #9'   WHERE A01.TSIS_USUATI = '#39'S'#39
      '         AND A01.TSIS_USUSREP = '#39'S'#39
      #9'              ) A01 RIGHT JOIN ('
      ''
      #9#9#9#9#9#9#9#9#9#9'SELECT B01.TSOP_ORDBILREPNOM'
      
        #9#9#9#9#9#9#9#9#9#9'FROM dbo.VSOP_Months A01 CROSS JOIN dbo.VSOP_ClienteBy' +
        'SalesRep B01'
      
        #9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9' LEFT  JOIN dbo.VSOP_OrderBilling      C01 ON ( ' +
        'B01.TSOP_ORDBILCLICOD     = C01.TSOP_ORDBILCLICOD'
      
        #9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9'AND B01.TSOP_ORDBILCANNOM     = C01.T' +
        'SOP_ORDBILCANNOM'
      
        #9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9'AND A01.YEARDOC               = C01.T' +
        'SOP_ORDBILYEADOCREQ'
      
        #9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9'AND A01.MONTHDOC              = C01.T' +
        'SOP_ORDBILMONDOCREQ'
      
        #9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9'AND C01.TSOP_ORDBILDATDOCREQ >= :MES_' +
        'INI'
      
        #9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9#9'AND C01.TSOP_ORDBILDATDOCREQ <= :MES_' +
        'FIM )'
      #9#9#9#9#9#9#9#9#9#9'WHERE 1 = 1'
      #9#9#9#9#9#9#9#9#9#9'  AND A01.YEARDOC = :YEARDOC'
      #9#9#9#9#9#9#9#9#9#9'  AND A01.MONTHDOC = :MONTHDOC'
      #9#9#9#9#9#9#9#9#9#9'GROUP BY B01.TSOP_ORDBILREPNOM'
      ''
      
        '                                                                ' +
        '        ) B01 ON ( A01.TSIS_USUNOM = B01.TSOP_ORDBILREPNOM )')
    Left = 888
    Top = 141
    ParamData = <
      item
        Name = 'MES_INI'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MES_FIM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'YEARDOC'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MONTHDOC'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQuerySalesRepTSIS_USUNOM: TStringField
      FieldName = 'TSIS_USUNOM'
      Origin = 'TSIS_USUNOM'
      Size = 255
    end
    object FDQuerySalesRepTSIS_USUEML: TStringField
      FieldName = 'TSIS_USUEML'
      Origin = 'TSIS_USUEML'
      Size = 255
    end
  end
  object FDQueryTSOP_OrderResquestDate: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TSOP_OrderResquestDate A01'
      'WHERE 1=2')
    Left = 896
    Top = 344
    object FDQueryTSOP_OrderResquestDateTSOP_ORDREQCOD: TFDAutoIncField
      FieldName = 'TSOP_ORDREQCOD'
      Origin = 'TSOP_ORDREQCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_OrderResquestDateTSOP_ORICOD: TIntegerField
      FieldName = 'TSOP_ORICOD'
      Origin = 'TSOP_ORICOD'
      Required = True
    end
    object FDQueryTSOP_OrderResquestDateTSOP_ORDREQNRODOC: TStringField
      FieldName = 'TSOP_ORDREQNRODOC'
      Origin = 'TSOP_ORDREQNRODOC'
      Required = True
      Size = 255
    end
    object FDQueryTSOP_OrderResquestDateTSOP_ORDREQSEQITE: TIntegerField
      FieldName = 'TSOP_ORDREQSEQITE'
      Origin = 'TSOP_ORDREQSEQITE'
      Required = True
    end
    object FDQueryTSOP_OrderResquestDateTSOP_ORDREQDATREQ: TSQLTimeStampField
      FieldName = 'TSOP_ORDREQDATREQ'
      Origin = 'TSOP_ORDREQDATREQ'
      Required = True
    end
    object FDQueryTSOP_OrderResquestDateTSOP_USUCODCAD: TIntegerField
      FieldName = 'TSOP_USUCODCAD'
      Origin = 'TSOP_USUCODCAD'
      Required = True
    end
    object FDQueryTSOP_OrderResquestDateTSOP_ORDREQDATCAD: TSQLTimeStampField
      FieldName = 'TSOP_ORDREQDATCAD'
      Origin = 'TSOP_ORDREQDATCAD'
      Required = True
    end
    object FDQueryTSOP_OrderResquestDateTSOP_USUCODALT: TIntegerField
      FieldName = 'TSOP_USUCODALT'
      Origin = 'TSOP_USUCODALT'
      Required = True
    end
    object FDQueryTSOP_OrderResquestDateTSOP_ORDREQDATALT: TSQLTimeStampField
      FieldName = 'TSOP_ORDREQDATALT'
      Origin = 'TSOP_ORDREQDATALT'
      Required = True
    end
  end
  object FDScriptTSOP_OrderRequestDate: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'EXECUTE dbo.PSOP_OrderResquestDateGroup ')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 896
    Top = 408
  end
  object FDQuerySaldoEstoque: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM Core_ProdutoBrady A01'
      'WHERE 1=2')
    Left = 880
    Top = 472
  end
  object FDScriptSaldoEstoqueDelete: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM Core_ProdutoBrady;'
          'DELETE FROM TMKT_ESTOQUE;'
          'DELETE FROM BILLING_TMP;'
          'DELETE FROM Core_ProdutoBradyTEMP;'
          ''
          ''
          '')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 928
    Top = 552
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 240
    Top = 32
  end
  object FDQueryVSOP_OrderBillingPedidos: TFDQuery
    OnNewRecord = FDQueryTSOP_OrderBillingNewRecord
    Connection = FDConnection
    SQL.Strings = (
      'SELECT B01.TSOP_ORDBILREPNOM'
      '      ,B01.TSOP_ORDBILGRUCLINOM'
      '      ,B01.TSOP_ORDBILCANNOM'
      '      ,B01.TSOP_ORDBILSITNOM'
      '      ,TSOP_ORDBILORI = CASE :SALESREP'
      
        '                          WHEN MAX(B01.TSOP_ORDBILREPNOM) THEN '#39 +
        'ACC OWNER'#39
      
        '                          --WHEN MAX(B01.TSOP_REPNOMINT) THEN '#39'R' +
        'EGION OWNER'#39
      
        '                          --WHEN MAX(B01.TSOP_REPMKT) THEN '#39'MARK' +
        'ET MNG'#39
      '                          ELSE '#39'N/A'#39
      '                        END'
      
        '      ,TSOP_ORDBILDAT = '#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(M' +
        'AX)),2) + '#39' - '#39' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 ' +
        'THEN '#39'Setembro'#39' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHE' +
        'N 5 THEN '#39'Dezembro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro' +
        #39' WHEN 8 THEN '#39'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WH' +
        'EN 11 THEN '#39'Junho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      '      ,TSOP_ORDBILTYP = CAST('#39'Actual'#39' AS VARCHAR(255))'
      
        '      ,TSOP_ORDBILVALLIQ = CAST(SUM(ISNULL(C01.TSOP_ORDBILVALLIQ' +
        ',0.00)) AS NUMERIC(15,02))'
      '      ,B01.TSOP_REPACCTYP'
      
        'FROM dbo.VSOP_Months A01 with (nolock)  CROSS JOIN VSOP_ClienteB' +
        'ySalesRepFull B01 with (nolock)'
      
        '                         LEFT  JOIN VSOP_OrderBillingFull C01 wi' +
        'th (nolock)  ON ( B01.TSOP_ORDBILCLICOD     = C01.TSOP_ORDBILCLI' +
        'COD'
      
        '                                                                ' +
        '    AND B01.TSOP_ORDBILCANNOM     = C01.TSOP_ORDBILCANNOM'
      
        '                                                                ' +
        '    AND B01.TSOP_ORDBILSITNOM     = C01.TSOP_ORDBILSITNOM'
      
        '                                                                ' +
        '    AND A01.YEARDOC               = C01.TSOP_ORDBILYEADOCREQ'
      
        '                                                                ' +
        '    AND A01.MONTHDOC              = C01.TSOP_ORDBILMONDOCREQ'
      
        '                                                                ' +
        '    AND C01.TSOP_ORDBILDATDOCREQ >= :MES_INI'
      
        '                                                                ' +
        '    AND C01.TSOP_ORDBILDATDOCREQ <= :MES_FIM )'
      'WHERE 1 = 1'
      '&WHERE1'
      '  AND A01.YEARDOC = :YEARDOC'
      '  AND A01.MONTHDOC = :MONTHDOC'
      'GROUP BY B01.TSOP_ORDBILREPNOM'
      '        ,B01.TSOP_ORDBILGRUCLINOM'
      '        ,B01.TSOP_ORDBILCANNOM'
      '        ,B01.TSOP_ORDBILSITNOM'
      '        ,B01.TSOP_REPACCTYP'
      
        '        ,'#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(MAX)),2) + '#39' - '#39 +
        ' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 THEN '#39'Setembro'#39 +
        ' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHEN 5 THEN '#39'Dezem' +
        'bro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro'#39' WHEN 8 THEN '#39 +
        'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WHEN 11 THEN '#39'Jun' +
        'ho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      'UNION ALL'
      'SELECT B01.TSOP_ORDBILREPNOM'
      '      ,B01.TSOP_ORDBILGRUCLINOM'
      '      ,B01.TSOP_ORDBILCANNOM'
      '      ,B01.TSOP_ORDBILSITNOM'
      '      ,TSOP_ORDBILORI = CASE :SALESREP'
      
        '                          WHEN MAX(B01.TSOP_ORDBILREPNOM) THEN '#39 +
        'ACC OWNER'#39
      
        '                          --WHEN MAX(B01.TSOP_REPNOMINT) THEN '#39'R' +
        'EGION OWNER'#39
      
        '                          --WHEN MAX(B01.TSOP_REPMKT) THEN '#39'MARK' +
        'ET MNG'#39
      '                          ELSE '#39'N/A'#39
      '                        END'
      
        '      ,TSOP_ORDBILDAT = '#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(M' +
        'AX)),2) + '#39' - '#39' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 ' +
        'THEN '#39'Setembro'#39' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHE' +
        'N 5 THEN '#39'Dezembro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro' +
        #39' WHEN 8 THEN '#39'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WH' +
        'EN 11 THEN '#39'Junho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      '      ,TSOP_ORDBILTYP = CAST('#39'Billing'#39' AS VARCHAR(255))'
      
        '      ,TSOP_ORDBILVALLIQ = CAST(SUM(ISNULL(C01.TSOP_ORDBILVALLIQ' +
        ',0.00)) AS NUMERIC(15,02))'
      '      ,B01.TSOP_REPACCTYP'
      
        'FROM dbo.VSOP_Months A01 with (nolock)  CROSS JOIN VSOP_ClienteB' +
        'ySalesRepFull B01 with (nolock)'
      
        '                         LEFT  JOIN VSOP_OrderBillingFull C01 wi' +
        'th (nolock)  ON ( B01.TSOP_ORDBILCLICOD  = C01.TSOP_ORDBILCLICOD'
      
        '                                                                ' +
        '    AND B01.TSOP_ORDBILCANNOM  = C01.TSOP_ORDBILCANNOM'
      
        '                                                                ' +
        '    AND B01.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM'
      
        '                                                                ' +
        '    AND A01.YEARDOC            = C01.TSOP_ORDBILYEADOC'
      
        '                                                                ' +
        '    AND A01.MONTHDOC           = C01.TSOP_ORDBILMONDOC'
      
        '                                                                ' +
        '    AND C01.TSOP_ORDBILTIPDOC  IN ('#39'Billing'#39','#39'Return'#39') )'
      'WHERE 1 = 1'
      '&WHERE1'
      '  AND A01.YEARDOC = :YEARDOC'
      '  AND A01.MONTHDOC = :MONTHDOC'
      'GROUP BY B01.TSOP_ORDBILREPNOM'
      '        ,B01.TSOP_ORDBILGRUCLINOM'
      '        ,B01.TSOP_ORDBILCANNOM'
      '        ,B01.TSOP_ORDBILSITNOM'
      '        ,B01.TSOP_REPACCTYP'
      
        '        ,'#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(MAX)),2) + '#39' - '#39 +
        ' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 THEN '#39'Setembro'#39 +
        ' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHEN 5 THEN '#39'Dezem' +
        'bro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro'#39' WHEN 8 THEN '#39 +
        'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WHEN 11 THEN '#39'Jun' +
        'ho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      'UNION ALL'
      'SELECT B01.TSOP_ORDBILREPNOM'
      '      ,B01.TSOP_ORDBILGRUCLINOM'
      '      ,B01.TSOP_ORDBILCANNOM'
      '      ,B01.TSOP_ORDBILSITNOM'
      '     '
      '      ,TSOP_ORDBILORI = CASE :SALESREP'
      
        '                          WHEN MAX(B01.TSOP_ORDBILREPNOM) THEN '#39 +
        'ACC OWNER'#39
      
        '                          --WHEN MAX(B01.TSOP_REPNOMINT) THEN '#39'R' +
        'EGION OWNER'#39
      
        '                          --WHEN MAX(B01.TSOP_REPMKT) THEN '#39'MARK' +
        'ET MNG'#39
      '                          ELSE '#39'N/A'#39
      '                        END'
      
        '      ,TSOP_ORDBILDAT = '#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(M' +
        'AX)),2) + '#39' - '#39' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 ' +
        'THEN '#39'Setembro'#39' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHE' +
        'N 5 THEN '#39'Dezembro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro' +
        #39' WHEN 8 THEN '#39'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WH' +
        'EN 11 THEN '#39'Junho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      '      ,TSOP_ORDBILTYP = CAST('#39'Backlog'#39' AS VARCHAR(255))'
      
        '      ,TSOP_ORDBILVALLIQ = CAST(SUM(ISNULL(C01.TSOP_ORDBILVALLIQ' +
        ',0.00)) AS NUMERIC(15,02))'
      '      ,B01.TSOP_REPACCTYP'
      
        'FROM dbo.VSOP_Months A01 with (nolock)  CROSS JOIN VSOP_ClienteB' +
        'ySalesRepFull B01 with (nolock)'
      
        '                         LEFT  JOIN VSOP_OrderBillingFull C01 wi' +
        'th (nolock)  ON ( B01.TSOP_ORDBILCLICOD  = C01.TSOP_ORDBILCLICOD'
      
        '                                                                ' +
        '    AND B01.TSOP_ORDBILCANNOM  = C01.TSOP_ORDBILCANNOM'
      
        '                                                                ' +
        '    AND B01.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM'
      
        '                                                                ' +
        '    AND C01.TSOP_ORDBILTIPDOC  = '#39'Order'#39' '
      
        '                                                                ' +
        '    AND C01.TSOP_ORDBILDATDOCREQ <= :MES_FIM '
      
        '                                                                ' +
        '    )'
      'WHERE 1 = 1'
      '&WHERE1'
      '  AND A01.YEARDOC = :YEARDOC'
      '  AND A01.MONTHDOC = :MONTHDOC'
      ''
      'GROUP BY B01.TSOP_ORDBILREPNOM'
      '        ,B01.TSOP_ORDBILGRUCLINOM'
      '        ,B01.TSOP_ORDBILCANNOM'
      '        ,B01.TSOP_ORDBILSITNOM'
      '        ,B01.TSOP_REPACCTYP'
      
        '        ,'#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(MAX)),2) + '#39' - '#39 +
        ' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 THEN '#39'Setembro'#39 +
        ' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHEN 5 THEN '#39'Dezem' +
        'bro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro'#39' WHEN 8 THEN '#39 +
        'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WHEN 11 THEN '#39'Jun' +
        'ho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      'UNION ALL'
      'SELECT B01.TSOP_ORDBILREPNOM'
      '      ,B01.TSOP_ORDBILGRUCLINOM'
      '      ,B01.TSOP_ORDBILCANNOM'
      '      ,B01.TSOP_ORDBILSITNOM'
      '      ,TSOP_ORDBILORI = CASE :SALESREP'
      
        #9'                        WHEN MAX(B01.TSOP_ORDBILREPNOM) THEN '#39'A' +
        'CC OWNER'#39
      
        #9'                        --WHEN MAX(B01.TSOP_REPNOMINT) THEN '#39'RE' +
        'GION OWNER'#39
      
        #9'                        --WHEN MAX(B01.TSOP_REPMKT) THEN '#39'MARKE' +
        'T MNG'#39
      #9'                        ELSE '#39'N/A'#39
      #9'                      END'
      
        '      ,TSOP_ORDBILDAT = '#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(M' +
        'AX)),2) + '#39' - '#39' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 ' +
        'THEN '#39'Setembro'#39' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHE' +
        'N 5 THEN '#39'Dezembro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro' +
        #39' WHEN 8 THEN '#39'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WH' +
        'EN 11 THEN '#39'Junho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      '      ,TSOP_ORDBILTYP = CAST('#39'Sales FCST'#39' AS VARCHAR(255))'
      
        '      ,TSOP_ORDBILVALLIQ = CAST( SUM(ISNULL(C01.TSOP_BUDVLF,0.00' +
        ')) AS NUMERIC(15,02))'
      '      ,B01.TSOP_REPACCTYP'
      
        'FROM dbo.VSOP_Months A01 with (nolock)  CROSS JOIN VSOP_ClienteB' +
        'ySalesRepFull B01 with (nolock)'
      
        '                         LEFT  JOIN dbo.VSOP_ClienteBySalesRep B' +
        '02 with (nolock)  ON ( B01.TSOP_ORDBILCLICOD     = B02.TSOP_ORDB' +
        'ILCLICOD'
      
        '            '#9#9#9#9#9#9'                                              ' +
        '    AND B01.TSOP_ORDBILCANNOM     = B02.TSOP_ORDBILCANNOM'
      
        #9#9#9#9#9#9'                                                          ' +
        '    AND B01.TSOP_ORDBILSITNOM     = B02.TSOP_ORDBILSITNOM '
      
        '                                                                ' +
        '                                            )'
      
        '                         LEFT  JOIN TSOP_Budget                 ' +
        '     C01 with (nolock)  ON ( B02.TSOP_ORDBILSITNOM  = C01.TSOP_O' +
        'RDBILSITNOM '
      
        '                                                                ' +
        '                         AND B02.TSOP_ORDBILCLICOD  = C01.TSOP_B' +
        'UDCLICOD'
      
        '                                                                ' +
        '          AND A01.YEARDOC               = CASE WHEN MONTH(C01.TS' +
        'OP_BUDDAT) >= 8 THEN  1 ELSE 0 END +  YEAR(C01.TSOP_BUDDAT)'
      
        '                                                                ' +
        '          AND A01.MONTHDOC              = CASE WHEN MONTH(C01.TS' +
        'OP_BUDDAT) >= 8 THEN -7 ELSE 5 END + MONTH(C01.TSOP_BUDDAT)'
      
        '                                                                ' +
        '          AND C01.TSOP_BUDTIP           = '#39'SF'#39
      
        '                                                                ' +
        '          AND C01.TSOP_BUDDATREF        = :MES_ANT'
      
        '                                                                ' +
        '          AND C01.TSOP_BUDDAT          >= :MES_INI'
      
        '                                                                ' +
        '          AND C01.TSOP_BUDDAT          <= :MES_FIM )'
      'WHERE 1 = 1'
      '&WHERE1'
      '  AND A01.YEARDOC = :YEARDOC'
      '  AND A01.MONTHDOC = :MONTHDOC'
      ''
      'GROUP BY B01.TSOP_ORDBILREPNOM'
      '        ,B01.TSOP_ORDBILGRUCLINOM'
      '        ,B01.TSOP_ORDBILCANNOM'
      '        ,B01.TSOP_ORDBILSITNOM'
      '        ,B01.TSOP_REPACCTYP'
      
        '        ,'#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(MAX)),2) + '#39' - '#39 +
        ' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 THEN '#39'Setembro'#39 +
        ' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHEN 5 THEN '#39'Dezem' +
        'bro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro'#39' WHEN 8 THEN '#39 +
        'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WHEN 11 THEN '#39'Jun' +
        'ho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      'UNION ALL'
      'SELECT B01.TSOP_ORDBILREPNOM'
      '      ,B01.TSOP_ORDBILGRUCLINOM'
      '      ,B01.TSOP_ORDBILCANNOM'
      '      ,B01.TSOP_ORDBILSITNOM'
      '      ,TSOP_ORDBILORI = CASE :SALESREP'
      
        #9'                        WHEN MAX(B01.TSOP_ORDBILREPNOM) THEN '#39'A' +
        'CC OWNER'#39
      
        #9'                        --WHEN MAX(B01.TSOP_REPNOMINT) THEN '#39'RE' +
        'GION OWNER'#39
      
        #9'                        --WHEN MAX(B01.TSOP_REPMKT) THEN '#39'MARKE' +
        'T MNG'#39
      #9'                        ELSE '#39'N/A'#39
      #9'                      END'
      
        '      ,TSOP_ORDBILDAT = '#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(M' +
        'AX)),2) + '#39' - '#39' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 ' +
        'THEN '#39'Setembro'#39' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHE' +
        'N 5 THEN '#39'Dezembro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro' +
        #39' WHEN 8 THEN '#39'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WH' +
        'EN 11 THEN '#39'Junho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      '      ,TSOP_ORDBILTYP = CAST('#39'Gross Margin'#39' AS VARCHAR(255))'
      
        '      ,TSOP_ORDBILVALLIQ = CAST( SUM(ISNULL(C01.TSOP_BUDVLF,0.00' +
        ')) AS NUMERIC(15,02))'
      '      ,B01.TSOP_REPACCTYP'
      
        'FROM dbo.VSOP_Months A01 with (nolock)  CROSS JOIN VSOP_ClienteB' +
        'ySalesRepFull B01 with (nolock)'
      
        '                         LEFT  JOIN dbo.VSOP_ClienteBySalesRep B' +
        '02 with (nolock)  ON ( B01.TSOP_ORDBILCLICOD     = B02.TSOP_ORDB' +
        'ILCLICOD'
      
        '            '#9#9#9#9#9#9'                                              ' +
        '    AND B01.TSOP_ORDBILCANNOM     = B02.TSOP_ORDBILCANNOM'
      
        #9#9#9#9#9#9'                                                          ' +
        'AND B01.TSOP_ORDBILSITNOM     = B02.TSOP_ORDBILSITNOM '
      
        '                                                                ' +
        '                                        )'
      
        '                         LEFT  JOIN TSOP_Budget                 ' +
        '     C01 with (nolock)  ON (  B02.TSOP_ORDBILSITNOM  = C01.TSOP_' +
        'ORDBILSITNOM '
      
        '                                                                ' +
        '                          AND B02.TSOP_ORDBILCLICOD     = C01.TS' +
        'OP_BUDCLICOD'
      
        '                                                                ' +
        '          AND A01.YEARDOC               = CASE WHEN MONTH(C01.TS' +
        'OP_BUDDAT) >= 8 THEN  1 ELSE 0 END +  YEAR(C01.TSOP_BUDDAT)'
      
        '                                                                ' +
        '          AND A01.MONTHDOC              = CASE WHEN MONTH(C01.TS' +
        'OP_BUDDAT) >= 8 THEN -7 ELSE 5 END + MONTH(C01.TSOP_BUDDAT)'
      
        '                                                                ' +
        '          AND C01.TSOP_BUDTIP           = '#39'GM'#39
      
        '                                                                ' +
        '          AND 1 = 2'
      
        '                                                                ' +
        '          AND C01.TSOP_BUDDATREF        = :MES_INI'
      
        '                                                                ' +
        '          AND C01.TSOP_BUDDAT          >= :MES_INI'
      
        '                                                                ' +
        '          AND C01.TSOP_BUDDAT          <= :MES_FIM )'
      'WHERE 1 = 1'
      '&WHERE1'
      '  AND A01.YEARDOC = :YEARDOC'
      '  AND A01.MONTHDOC = :MONTHDOC'
      ''
      'GROUP BY B01.TSOP_ORDBILREPNOM'
      '        ,B01.TSOP_ORDBILGRUCLINOM'
      '        ,B01.TSOP_ORDBILCANNOM'
      '        ,B01.TSOP_ORDBILSITNOM'
      '        ,B01.TSOP_REPACCTYP'
      
        '        ,'#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(MAX)),2) + '#39' - '#39 +
        ' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 THEN '#39'Setembro'#39 +
        ' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHEN 5 THEN '#39'Dezem' +
        'bro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro'#39' WHEN 8 THEN '#39 +
        'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WHEN 11 THEN '#39'Jun' +
        'ho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      ''
      'ORDER BY 4,3,5,1,2,6,9,7')
    Left = 936
    Top = 66
    ParamData = <
      item
        Name = 'SALESREP'
        DataType = ftString
        ParamType = ptInput
        Value = 'Guilherme Couto'
      end
      item
        Name = 'MES_INI'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 42248d
      end
      item
        Name = 'MES_FIM'
        DataType = ftString
        ParamType = ptInput
        Value = '09/30/2015'
      end
      item
        Name = 'YEARDOC'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2016
      end
      item
        Name = 'MONTHDOC'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'MES_ANT'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 42217d
      end>
    MacroData = <
      item
        Value = ''
        Name = 'WHERE1'
      end>
    object FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILSITNOM: TStringField
      FieldName = 'TSOP_ORDBILSITNOM'
      Origin = 'TSOP_ORDBILSITNOM'
      ReadOnly = True
      Size = 255
    end
    object FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILCANNOM: TStringField
      DisplayLabel = 'Canal'
      FieldName = 'TSOP_ORDBILCANNOM'
      Origin = 'TSOP_ORDBILCANNOM'
      ReadOnly = True
      Size = 255
    end
    object FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILORI: TStringField
      FieldName = 'TSOP_ORDBILORI'
      Origin = 'TSOP_ORDBILORI'
      ReadOnly = True
      Required = True
      Size = 12
    end
    object FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILREPNOM: TStringField
      DisplayLabel = 'Acc Owner'
      FieldName = 'TSOP_ORDBILREPNOM'
      Origin = 'TSOP_ORDBILREPNOM'
      ReadOnly = True
      Size = 255
    end
    object FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILGRUCLINOM: TStringField
      DisplayLabel = 'Grupo de Cliente'
      FieldName = 'TSOP_ORDBILGRUCLINOM'
      Origin = 'TSOP_ORDBILGRUCLINOM'
      ReadOnly = True
      Size = 255
    end
    object FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILDAT: TMemoField
      DisplayLabel = 'Data Requerida'
      FieldName = 'TSOP_ORDBILDAT'
      Origin = 'TSOP_ORDBILDAT'
      ReadOnly = True
      BlobType = ftMemo
      Size = 2147483647
    end
    object FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILTYP: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TSOP_ORDBILTYP'
      Origin = 'TSOP_ORDBILTYP'
      ReadOnly = True
      Size = 255
    end
    object FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILVALLIQ: TBCDField
      DisplayLabel = 'Valor L'#237'quido (NET)'
      FieldName = 'TSOP_ORDBILVALLIQ'
      Origin = 'TSOP_ORDBILVALLIQ'
      ReadOnly = True
      DisplayFormat = '#,##0'
      Precision = 15
      Size = 2
    end
    object FDQueryVSOP_OrderBillingPedidosTSOP_REPACCTYP: TStringField
      FieldName = 'TSOP_REPACCTYP'
      Origin = 'TSOP_REPACCTYP'
      ReadOnly = True
      Size = 10
    end
  end
  object FDQueryGrupoCliente: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT DISTINCT'
      '       A01.TSOP_ORDBILCLICOD'
      '      ,A01.TSOP_ORDBILCLINOM'
      'FROM dbo.VSOP_OrderBilling A01'
      'WHERE NULLIF(RTRIM(LTRIM(A01.TSOP_ORDBILGRUCLINOM)),'#39#39') IS NULL'
      'ORDER BY 2, 1')
    Left = 912
    Top = 253
    object FDQueryGrupoClienteTSOP_ORDBILCLICOD: TStringField
      FieldName = 'TSOP_ORDBILCLICOD'
      Origin = 'TSOP_ORDBILCLICOD'
      Required = True
      Size = 255
    end
    object FDQueryGrupoClienteTSOP_ORDBILCLINOM: TStringField
      FieldName = 'TSOP_ORDBILCLINOM'
      Origin = 'TSOP_ORDBILCLINOM'
      Required = True
      Size = 255
    end
  end
  object FDQueryAccOwner: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT A01.TSOP_ORDBILCLICOD'
      '      ,A01.TSOP_ORDBILCLINOM'
      #9'  ,MAX(A01.TSOP_ORDBILDATDOC) AS TSOP_ORDBILDATDOC'
      'FROM dbo.VSOP_OrderBilling A01'
      
        'WHERE NULLIF(NULLIF(RTRIM(LTRIM(A01.TSOP_ORDBILREPNOM)),'#39#39'),'#39'N/A' +
        #39') IS NULL'
      'GROUP BY A01.TSOP_ORDBILCLICOD'
      '        ,A01.TSOP_ORDBILCLINOM'
      'ORDER BY 2, 1')
    Left = 920
    Top = 301
    object FDQueryAccOwnerTSOP_ORDBILCLICOD: TStringField
      FieldName = 'TSOP_ORDBILCLICOD'
      Origin = 'TSOP_ORDBILCLICOD'
      Required = True
      Size = 255
    end
    object FDQueryAccOwnerTSOP_ORDBILCLINOM: TStringField
      FieldName = 'TSOP_ORDBILCLINOM'
      Origin = 'TSOP_ORDBILCLINOM'
      Required = True
      Size = 255
    end
    object FDQueryAccOwnerTSOP_ORDBILDATDOC: TSQLTimeStampField
      FieldName = 'TSOP_ORDBILDATDOC'
      Origin = 'TSOP_ORDBILDATDOC'
    end
  end
  object FDScriptSaldoEstoqueUpdate: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'CALL PROC_UPDATEESTOQUE;')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 792
    Top = 528
  end
  object FDScriptTFIS_ParcelaDedutivel: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          
            'DELETE FROM TFIS_ParcelaDedutivel WHERE TFIS_PARDEDANOMES = CONV' +
            'ERT(CHAR(06),DATEADD(MONTH,-1,GETDATE()),112)')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 800
    Top = 168
  end
  object FDQueryTFIS_ParcelaDedutivel: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT *'
      'FROM TFIS_ParcelaDedutivel A01'
      'WHERE 1=2')
    Left = 800
    Top = 232
    object FDQueryTFIS_ParcelaDedutivelTFIS_PARDEDCOD: TFDAutoIncField
      FieldName = 'TFIS_PARDEDCOD'
      Origin = 'TFIS_PARDEDCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTFIS_ParcelaDedutivelTFIS_ITECOD: TStringField
      FieldName = 'TFIS_ITECOD'
      Origin = 'TFIS_ITECOD'
      Required = True
      Size = 255
    end
    object FDQueryTFIS_ParcelaDedutivelTFIS_ITEQTD: TFMTBCDField
      FieldName = 'TFIS_ITEQTD'
      Origin = 'TFIS_ITEQTD'
      Required = True
      Precision = 15
      Size = 6
    end
    object FDQueryTFIS_ParcelaDedutivelTFIS_ITEQTDMPR: TFMTBCDField
      FieldName = 'TFIS_ITEQTDMPR'
      Origin = 'TFIS_ITEQTDMPR'
      Required = True
      Precision = 15
      Size = 6
    end
    object FDQueryTFIS_ParcelaDedutivelTFIS_ITEORIMPR: TIntegerField
      FieldName = 'TFIS_ITEORIMPR'
      Origin = 'TFIS_ITEORIMPR'
      Required = True
    end
    object FDQueryTFIS_ParcelaDedutivelTFIS_ITEPREPORMPR: TFMTBCDField
      FieldName = 'TFIS_ITEPREPORMPR'
      Origin = 'TFIS_ITEPREPORMPR'
      Required = True
      Precision = 15
      Size = 6
    end
    object FDQueryTFIS_ParcelaDedutivelTFIS_ITEPREMPR: TFMTBCDField
      FieldName = 'TFIS_ITEPREMPR'
      Origin = 'TFIS_ITEPREMPR'
      Required = True
      Precision = 15
      Size = 6
    end
    object FDQueryTFIS_ParcelaDedutivelTFIS_PARDEDANOMES: TStringField
      FieldName = 'TFIS_PARDEDANOMES'
      Origin = 'TFIS_PARDEDANOMES'
      Size = 6
    end
  end
  object FDQueryTFIS_NotaFiscal: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT * FROM TFIS_NotaFiscal A01 WHERE 1=2')
    Left = 392
    Top = 472
    object FDQueryTFIS_NotaFiscalTFIS_NOTFISANOMES: TStringField
      FieldName = 'TFIS_NOTFISANOMES'
      Origin = 'TFIS_NOTFISANOMES'
      Required = True
      Size = 6
    end
    object FDQueryTFIS_NotaFiscalTFIS_NOTFISDATEMI: TSQLTimeStampField
      FieldName = 'TFIS_NOTFISDATEMI'
      Origin = 'TFIS_NOTFISDATEMI'
      Required = True
    end
    object FDQueryTFIS_NotaFiscalTFIS_NOTFISCLI: TStringField
      FieldName = 'TFIS_NOTFISCLI'
      Origin = 'TFIS_NOTFISCLI'
      Required = True
      Size = 255
    end
    object FDQueryTFIS_NotaFiscalTFIS_NOTFISNUM: TStringField
      FieldName = 'TFIS_NOTFISNUM'
      Origin = 'TFIS_NOTFISNUM'
      Required = True
      Size = 255
    end
    object FDQueryTFIS_NotaFiscalTFIS_NOTFISITE: TStringField
      FieldName = 'TFIS_NOTFISITE'
      Origin = 'TFIS_NOTFISITE'
      Required = True
      Size = 255
    end
    object FDQueryTFIS_NotaFiscalTFIS_NOTFISCFO: TStringField
      FieldName = 'TFIS_NOTFISCFO'
      Origin = 'TFIS_NOTFISCFO'
      Required = True
      Size = 255
    end
    object FDQueryTFIS_NotaFiscalTFIS_NOTFISQTD: TFMTBCDField
      FieldName = 'TFIS_NOTFISQTD'
      Origin = 'TFIS_NOTFISQTD'
      Required = True
      Precision = 15
      Size = 6
    end
    object FDQueryTFIS_NotaFiscalTFIS_NOTFISVAL: TFMTBCDField
      FieldName = 'TFIS_NOTFISVAL'
      Origin = 'TFIS_NOTFISVAL'
      Required = True
      Precision = 15
      Size = 6
    end
  end
  object FDScriptTFIS_NotaFiscal: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          
            'DELETE FROM TFIS_NotaFiscal WHERE TFIS_NOTFISANOMES= :TFIS_NOTFI' +
            'SANOMES')
      end>
    Connection = FDConnection
    Params = <
      item
        Name = 'TFIS_NOTFISANOMES'
        DataType = ftString
        ParamType = ptInput
      end>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 392
    Top = 528
  end
  object FDQueryCargaMaquina01: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT A01.TMAQ_SITNOM'
      
        '      ,CASE WHEN ( A01.Domingo + B01.Domingo ) = 0 THEN 0 ELSE A' +
        '01.Domingo / ( A01.Domingo + B01.Domingo ) * 100.00 END AS Domin' +
        'go'
      
        '  '#9'  ,CASE WHEN ( A01.Segunda + B01.Segunda ) = 0 THEN 0 ELSE A0' +
        '1.Segunda / ( A01.Segunda + B01.Segunda ) * 100.00 END AS Segund' +
        'a'
      
        #9'    ,CASE WHEN ( A01.Terca   + B01.Terca   ) = 0 THEN 0 ELSE A0' +
        '1.Terca   / ( A01.Terca   + B01.Terca   ) * 100.00 END AS Terca'
      
        #9'    ,CASE WHEN ( A01.Quarta  + B01.Quarta  ) = 0 THEN 0 ELSE A0' +
        '1.Quarta  / ( A01.Quarta  + B01.Quarta  ) * 100.00 END AS Quarta'
      
        #9'    ,CASE WHEN ( A01.Quinta  + B01.Quinta  ) = 0 THEN 0 ELSE A0' +
        '1.Quinta  / ( A01.Quinta  + B01.Quinta  ) * 100.00 END AS Quinta'
      
        #9'    ,CASE WHEN ( A01.Sexta   + B01.Sexta   ) = 0 THEN 0 ELSE A0' +
        '1.Sexta   / ( A01.Sexta   + B01.Sexta   ) * 100.00 END AS Sexta'
      
        #9'    ,CASE WHEN ( A01.Sabado  + B01.Sabado  ) = 0 THEN 0 ELSE A0' +
        '1.Sabado  / ( A01.Sabado  + B01.Sabado  ) * 100.00 END AS Sabado'
      'FROM ('
      ''
      
        '         SELECT TMAQ_SITNOM, ISNULL([1],0.00) AS Domingo, ISNULL' +
        '([2],0.00) AS Segunda, ISNULL([3],0.00) AS Terca, ISNULL([4],0.0' +
        '0) AS Quarta, ISNULL([5],0.00) AS Quinta, ISNULL([6],0.00) AS Se' +
        'xta, ISNULL([7],0.00) AS Sabado'
      '         FROM ('
      ''
      '                  SELECT TMAQ_SITNOM'
      '                        ,DATEPART(WEEKDAY,TMAQ_APODATINI) AS DAY'
      
        '                        ,CAST(TMAQ_APOMIN AS NUMERIC(15,06)) AS ' +
        'TMAQ_APOMIN'
      '                  FROM VMAQ_Apontamento'
      
        '                  WHERE TMAQ_APODATINI BETWEEN :DATA_INI AND :DA' +
        'TA_FIM'
      '                    AND TMAQ_ATITIP IN (1,2)'
      ''
      '                            ) QRY'
      '         PIVOT ('
      ''
      '                 SUM (TMAQ_APOMIN)'
      
        '                 FOR DAY IN ( [1], [2], [3], [4], [5], [6], [7] ' +
        ')'
      ''
      '         '#9'              ) AS PVT'
      ''
      #9#9#9#9#9#9'           ) A01 INNER JOIN ('
      ''
      
        '                                                         SELECT ' +
        'TMAQ_SITNOM, ISNULL([1],0.00) AS Domingo, ISNULL([2],0.00) AS Se' +
        'gunda, ISNULL([3],0.00) AS Terca, ISNULL([4],0.00) AS Quarta, IS' +
        'NULL([5],0.00) AS Quinta, ISNULL([6],0.00) AS Sexta, ISNULL([7],' +
        '0.00) AS Sabado'
      '                                                         FROM ('
      ''
      
        '                                                                ' +
        '  SELECT TMAQ_SITNOM'
      
        '                                                                ' +
        '        ,DATEPART(WEEKDAY,TMAQ_APODATINI) AS DAY'
      
        '                                                                ' +
        '        ,CAST(TMAQ_APOMIN AS NUMERIC(15,06)) AS TMAQ_APOMIN'
      
        '                                                                ' +
        '  FROM VMAQ_Apontamento'
      
        '                                                                ' +
        '  WHERE TMAQ_APODATINI BETWEEN :DATA_INI AND :DATA_FIM'
      
        '                                                                ' +
        '    AND TMAQ_ATITIP = 3'
      ''
      
        '                                                                ' +
        '            ) QRY'
      '                                                         PIVOT ('
      ''
      
        '                                                                ' +
        ' SUM (TMAQ_APOMIN)'
      
        '                                                                ' +
        ' FOR DAY IN ( [1], [2], [3], [4], [5], [6], [7] )'
      ''
      
        #9'                                                               ' +
        '        ) AS PVT'
      ''
      
        '                                                                ' +
        '                              ) B01 ON ( A01.TMAQ_SITNOM = B01.T' +
        'MAQ_SITNOM )'
      '')
    Left = 552
    Top = 176
    ParamData = <
      item
        Name = 'DATA_INI'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA_FIM'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDQueryForecast: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT B01.TSOP_ORDBILGRUCLINOM'
      '      ,B01.TSOP_ORDBILCLICOD'
      '      ,B01.TSOP_ORDBILCLINOM'
      
        '      ,TSOP_ORDBILDAT = '#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(M' +
        'AX)),2) + '#39': '#39' + RIGHT('#39'0'#39'+CAST(A01.MONTHDOC AS VARCHAR(MAX)),2)' +
        ' + '#39' - '#39' + CASE A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 THEN '#39'S' +
        'etembro'#39' WHEN 3 THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHEN 5 THE' +
        'N '#39'Dezembro'#39' WHEN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro'#39' WHEN ' +
        '8 THEN '#39'Mar'#231'o'#39' WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WHEN 11 T' +
        'HEN '#39'Junho'#39' WHEN 12 THEN '#39'Julho'#39' END'
      
        '      ,TSOP_ORDBILVALLIQ = CAST( SUM(ISNULL(C01.TSOP_BUDVLF,0.00' +
        ')) AS NUMERIC(15,02))'
      
        'FROM dbo.VSOP_Months A01 CROSS JOIN dbo.VSOP_ClienteBySalesRep  ' +
        '     B01'
      
        '                         LEFT  JOIN TSOP_Budget                 ' +
        '     C01 ON ( B01.TSOP_ORDBILCLICOD     = C01.TSOP_BUDCLICOD'
      
        '                                                                ' +
        '          AND A01.YEARDOC               = CASE WHEN MONTH(C01.TS' +
        'OP_BUDDAT) >= 8 THEN  1 ELSE 0 END +  YEAR(C01.TSOP_BUDDAT)'
      
        '                                                                ' +
        '          AND A01.MONTHDOC              = CASE WHEN MONTH(C01.TS' +
        'OP_BUDDAT) >= 8 THEN -7 ELSE 5 END + MONTH(C01.TSOP_BUDDAT)'
      
        '                                                                ' +
        '          AND C01.TSOP_BUDTIP           = '#39'SF'#39' )'
      'WHERE B01.TSOP_ORDBILREPNOM = :REPNOM'
      '  AND (A01.YEAR_MONTH BETWEEN :DATAINI AND :DATAFIM)'
      'GROUP BY B01.TSOP_ORDBILGRUCLINOM'
      '        ,B01.TSOP_ORDBILCLICOD'
      '        ,B01.TSOP_ORDBILCLINOM'
      
        '        ,'#39'FY'#39'+RIGHT(CAST(A01.YEARDOC AS VARCHAR(MAX)),2) + '#39': '#39' ' +
        '+ RIGHT('#39'0'#39'+CAST(A01.MONTHDOC AS VARCHAR(MAX)),2) + '#39' - '#39' + CASE' +
        ' A01.MONTHDOC WHEN 1 THEN '#39'Agosto'#39' WHEN 2 THEN '#39'Setembro'#39' WHEN 3' +
        ' THEN '#39'Outubro'#39' WHEN 4 THEN '#39'Novembro'#39' WHEN 5 THEN '#39'Dezembro'#39' WH' +
        'EN 6 THEN '#39'Janeiro'#39' WHEN 7 THEN '#39'Fevereiro'#39' WHEN 8 THEN '#39'Mar'#231'o'#39' ' +
        'WHEN 9 THEN '#39'Abril'#39' WHEN 10 THEN '#39'Maio'#39' WHEN 11 THEN '#39'Junho'#39' WHE' +
        'N 12 THEN '#39'Julho'#39' END'
      'ORDER BY 3,2,1,4')
    Left = 968
    Top = 138
    ParamData = <
      item
        Name = 'REPNOM'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'DATAINI'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'DATAFIM'
        DataType = ftString
        ParamType = ptInput
      end>
    object FDQueryForecastTSOP_ORDBILGRUCLINOM: TStringField
      FieldName = 'TSOP_ORDBILGRUCLINOM'
      Origin = 'TSOP_ORDBILGRUCLINOM'
      Size = 255
    end
    object FDQueryForecastTSOP_ORDBILCLICOD: TStringField
      FieldName = 'TSOP_ORDBILCLICOD'
      Origin = 'TSOP_ORDBILCLICOD'
      Required = True
      Size = 255
    end
    object FDQueryForecastTSOP_ORDBILCLINOM: TStringField
      FieldName = 'TSOP_ORDBILCLINOM'
      Origin = 'TSOP_ORDBILCLINOM'
      Size = 255
    end
    object FDQueryForecastTSOP_ORDBILDAT: TMemoField
      FieldName = 'TSOP_ORDBILDAT'
      Origin = 'TSOP_ORDBILDAT'
      ReadOnly = True
      BlobType = ftMemo
      Size = 2147483647
    end
    object FDQueryForecastTSOP_ORDBILVALLIQ: TBCDField
      FieldName = 'TSOP_ORDBILVALLIQ'
      Origin = 'TSOP_ORDBILVALLIQ'
      ReadOnly = True
      Precision = 15
      Size = 2
    end
  end
  object FDQueryForecastExport: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT A01.TSOP_ORDBILGRUCLINOM'
      '      ,A01.TSOP_ORDBILCLICOD'
      '      ,A01.TSOP_ORDBILCLINOM'
      'FROM dbo.VSOP_ClienteBySalesRep A01'
      'WHERE A01.TSOP_ORDBILREPNOM = :SALES_REP'
      'ORDER BY A01.TSOP_ORDBILGRUCLINOM'
      '        ,A01.TSOP_ORDBILCLICOD')
    Left = 1000
    Top = 194
    ParamData = <
      item
        Name = 'SALES_REP'
        DataType = ftString
        ParamType = ptInput
      end>
    object FDQueryForecastExportTSOP_ORDBILGRUCLINOM: TStringField
      FieldName = 'TSOP_ORDBILGRUCLINOM'
      Origin = 'TSOP_ORDBILGRUCLINOM'
      Size = 255
    end
    object FDQueryForecastExportTSOP_ORDBILCLICOD: TStringField
      FieldName = 'TSOP_ORDBILCLICOD'
      Origin = 'TSOP_ORDBILCLICOD'
      Required = True
      Size = 255
    end
    object FDQueryForecastExportTSOP_ORDBILCLINOM: TStringField
      FieldName = 'TSOP_ORDBILCLINOM'
      Origin = 'TSOP_ORDBILCLINOM'
      Size = 255
    end
    object FDQueryForecastExportTSOP_ORDBILDAT: TMemoField
      FieldName = 'TSOP_ORDBILDAT'
      Origin = 'TSOP_ORDBILDAT'
      ReadOnly = True
      BlobType = ftMemo
      Size = 2147483647
    end
    object FDQueryForecastExportTSOP_ORDBILVALLIQ: TBCDField
      FieldName = 'TSOP_ORDBILVALLIQ'
      Origin = 'TSOP_ORDBILVALLIQ'
      ReadOnly = True
      Precision = 15
      Size = 2
    end
  end
  object FDQueryTSOP_GMCustos: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM TSOP_GMCustos A01')
    Left = 176
    Top = 440
    object FDQueryTSOP_GMCustosTSOP_GMCCOD: TFDAutoIncField
      FieldName = 'TSOP_GMCCOD'
      Origin = 'TSOP_GMCCOD'
      ReadOnly = True
    end
    object FDQueryTSOP_GMCustosTSOP_GMCITE: TStringField
      FieldName = 'TSOP_GMCITE'
      Origin = 'TSOP_GMCITE'
      Required = True
    end
    object FDQueryTSOP_GMCustosTSOP_GMCSIT: TStringField
      FieldName = 'TSOP_GMCSIT'
      Origin = 'TSOP_GMCSIT'
      Required = True
    end
    object FDQueryTSOP_GMCustosTSOP_GMCLOT: TBCDField
      FieldName = 'TSOP_GMCLOT'
      Origin = 'TSOP_GMCLOT'
      Required = True
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_GMCustosTSOP_GMCDAT: TSQLTimeStampField
      FieldName = 'TSOP_GMCDAT'
      Origin = 'TSOP_GMCDAT'
      Required = True
    end
    object FDQueryTSOP_GMCustosTSOP_GMCPRIUNI: TBCDField
      FieldName = 'TSOP_GMCPRIUNI'
      Origin = 'TSOP_GMCPRIUNI'
      Required = True
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_GMCustosTSOP_GMCCUSSTD: TBCDField
      FieldName = 'TSOP_GMCCUSSTD'
      Origin = 'TSOP_GMCCUSSTD'
      Required = True
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_GMCustosTSOP_GMCCUSMOV: TBCDField
      FieldName = 'TSOP_GMCCUSMOV'
      Origin = 'TSOP_GMCCUSMOV'
      Required = True
      Precision = 15
      Size = 2
    end
    object FDQueryTSOP_GMCustosTSOP_GMCBUD: TStringField
      FieldName = 'TSOP_GMCBUD'
      Origin = 'TSOP_GMCBUD'
      Size = 1
    end
    object FDQueryTSOP_GMCustosTSOP_DTIMPORTACAO: TSQLTimeStampField
      FieldName = 'TSOP_DTIMPORTACAO'
      Origin = 'TSOP_DTIMPORTACAO'
    end
  end
  object FDQueryTSOP_UOM: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM TSOP_UOM A01')
    Left = 72
    Top = 424
    object FDQueryTSOP_UOMTSOP_UOMCOD: TFDAutoIncField
      FieldName = 'TSOP_UOMCOD'
      Origin = 'TSOP_UOMCOD'
      ReadOnly = True
    end
    object FDQueryTSOP_UOMTSOP_UOMITE: TStringField
      FieldName = 'TSOP_UOMITE'
      Origin = 'TSOP_UOMITE'
      Required = True
    end
    object FDQueryTSOP_UOMTSOP_UOMSIT: TStringField
      FieldName = 'TSOP_UOMSIT'
      Origin = 'TSOP_UOMSIT'
      Required = True
    end
    object FDQueryTSOP_UOMTSOP_UOMSIG: TStringField
      FieldName = 'TSOP_UOMSIG'
      Origin = 'TSOP_UOMSIG'
      Required = True
    end
    object FDQueryTSOP_UOMTSOP_UOMNUM: TFMTBCDField
      FieldName = 'TSOP_UOMNUM'
      Origin = 'TSOP_UOMNUM'
      Required = True
      Precision = 15
      Size = 6
    end
    object FDQueryTSOP_UOMTSOP_UOMDEM: TFMTBCDField
      FieldName = 'TSOP_UOMDEM'
      Origin = 'TSOP_UOMDEM'
      Required = True
      Precision = 15
      Size = 6
    end
    object FDQueryTSOP_UOMTSOP_DTIMPORTACAO: TSQLTimeStampField
      FieldName = 'TSOP_DTIMPORTACAO'
      Origin = 'TSOP_DTIMPORTACAO'
    end
  end
  object FDScriptTSOP_GMCustos: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_GMCustos'
          
            'WHERE  MONTH(TSOP_DTIMPORTACAO) = MONTH(DATEADD(MONTH, -1, GETDA' +
            'TE()))'
          
            '  AND YEAR(TSOP_DTIMPORTACAO)   = YEAR( DATEADD(MONTH, -1, GETDA' +
            'TE()))')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 200
    Top = 541
  end
  object FD_Insert_EntregaXML: TFDQuery
    Connection = FDConnection
    Left = 64
    Top = 312
  end
  object FD_Consulta_EntregaXML: TFDQuery
    Connection = FDConnection
    Left = 200
    Top = 312
  end
  object FDQueryTSOP_EMAIL: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM TSOP_EMAIL')
    Left = 1024
    Top = 376
  end
  object FDQueryTSOP_RepresentanteCanal: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select TSOP_RepresentanteCanalCOD, UPPER(TSOP_REPNOM) as TSOP_RE' +
        'PNOM, UPPER(TSOP_PLANTA) as TSOP_PLANTA, UPPER(TSOP_CANAL) as TS' +
        'OP_CANAL '
      'from TSOP_RepresentanteCanal')
    Left = 1016
    Top = 464
    object FDQueryTSOP_RepresentanteCanalTSOP_RepresentanteCanalCOD: TFDAutoIncField
      FieldName = 'TSOP_RepresentanteCanalCOD'
      Origin = 'TSOP_RepresentanteCanalCOD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTSOP_RepresentanteCanalTSOP_REPNOM: TStringField
      FieldName = 'TSOP_REPNOM'
      Origin = 'TSOP_REPNOM'
      ReadOnly = True
      Size = 255
    end
    object FDQueryTSOP_RepresentanteCanalTSOP_PLANTA: TStringField
      FieldName = 'TSOP_PLANTA'
      Origin = 'TSOP_PLANTA'
      ReadOnly = True
      Size = 100
    end
    object FDQueryTSOP_RepresentanteCanalTSOP_CANAL: TStringField
      FieldName = 'TSOP_CANAL'
      Origin = 'TSOP_CANAL'
      ReadOnly = True
      Size = 100
    end
  end
  object FDQueryTSOP_SETONFORECAST: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT TSOP_DPACANTXTDEP,TSOP_PERIODO, SUM(TSOP_VALOR_LIKELY) as' +
        ' TSOP_VALOR_LIKELY, '
      'SUM(TSOP_VALOR_FORECAST) as TSOP_VALOR_FORECAST'
      'FROM  TSOP_SETONFORECAST'
      'WHERE TSOP_PERIODO = :TSOP_PERIODO'
      'AND TSOP_DPACANTXTDEP = :TSOP_DPACANTXTDEP'
      'GROUP BY TSOP_DPACANTXTDEP,TSOP_PERIODO')
    Left = 1024
    Top = 280
    ParamData = <
      item
        Name = 'TSOP_PERIODO'
        DataType = ftDate
        ADDataType = dtDate
        ParamType = ptInput
      end
      item
        Name = 'TSOP_DPACANTXTDEP'
        DataType = ftString
        ADDataType = dtAnsiString
        ParamType = ptInput
      end>
    object FDQueryTSOP_SETONFORECASTTSOP_DPACANTXTDEP: TStringField
      FieldName = 'TSOP_DPACANTXTDEP'
      Origin = 'TSOP_DPACANTXTDEP'
      Size = 255
    end
    object FDQueryTSOP_SETONFORECASTTSOP_PERIODO: TDateField
      FieldName = 'TSOP_PERIODO'
      Origin = 'TSOP_PERIODO'
    end
    object FDQueryTSOP_SETONFORECASTTSOP_VALOR_LIKELY: TFMTBCDField
      FieldName = 'TSOP_VALOR_LIKELY'
      Origin = 'TSOP_VALOR_LIKELY'
      ReadOnly = True
      Precision = 38
      Size = 2
    end
    object FDQueryTSOP_SETONFORECASTTSOP_VALOR_FORECAST: TFMTBCDField
      FieldName = 'TSOP_VALOR_FORECAST'
      Origin = 'TSOP_VALOR_FORECAST'
      ReadOnly = True
      Precision = 38
      Size = 2
    end
  end
  object FDQueryConsultaPreco: TFDQuery
    Connection = FDConnection
    Left = 848
    Top = 16
  end
  object FDQueryGravaPreco: TFDQuery
    Connection = FDConnection
    Left = 952
    Top = 16
  end
  object FDScriptTSOP_UOM: TFDScript
    SQLScripts = <
      item
        Name = 'DELETE'
        SQL.Strings = (
          'DELETE FROM TSOP_UOM'
          
            'WHERE  MONTH(TSOP_DTIMPORTACAO) = MONTH(DATEADD(MONTH, -1, GETDA' +
            'TE()))'
          
            '  AND YEAR(TSOP_DTIMPORTACAO)   = YEAR( DATEADD(MONTH, -1, GETDA' +
            'TE()))')
      end>
    Connection = FDConnection
    Params = <>
    Macros = <>
    Left = 544
    Top = 256
  end
  object FDConsultaMagentoLocal: TFDQuery
    Connection = FDConnection
    Left = 352
    Top = 24
  end
end
