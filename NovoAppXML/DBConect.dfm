object DB_Conect: TDB_Conect
  OldCreateOrder = False
  Height = 356
  Width = 502
  object FDConnection: TFDConnection
    Params.Strings = (
      'Server=DESKTOP-99M8LEG\SQLEXPRESS'
      'User_Name=sa'
      'Password=123'
      'DATABASE=EntradaXML'
      'ApplicationName=Brady'
      'MARS=yes'
      'LoginTimeout=300'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 47
    Top = 25
  end
  object sqlAuxiliar: TFDQuery
    Connection = FDConnection
    Left = 48
    Top = 80
  end
  object sqlAux: TFDQuery
    Connection = FDConnection
    Left = 48
    Top = 152
  end
  object sqlAux180: TFDQuery
    Connection = FDConnection
    Left = 48
    Top = 240
  end
  object sqlAux180Itens: TFDQuery
    Connection = FDConnection
    Left = 168
    Top = 208
  end
  object sql155: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      '       SELECT '#39'|'#39' + REGISTRO + '#39'|'#39' as REGISTRO, '
      '              CONTA + '#39'|'#39' AS CONTA,  '
      '              CCUSTO + '#39'|'#39' AS CCUSTO, '
      '              CONVERT(VARCHAR,SUM(VALOR1)) + '#39'|'#39'  AS VALOR1,'
      '              TIPO1 + '#39'|'#39' AS TIPO1, '
      '              CONVERT(VARCHAR,SUM(VALOR2)) + '#39'|'#39'  AS VALOR2,'
      '              CONVERT(VARCHAR,SUM(VALOR3)) + '#39'|'#39'  AS VALOR3, '
      '              CONVERT(VARCHAR,SUM(VALOR4)) + '#39'|'#39'  AS VALOR4, '
      '              TIPO2 + '#39'|'#39' AS TIPO2 '
      '       FROM SPCT_155  '
      '        WHERE DT_INICIAL = :DT_INICIAL AND DT_FINAL = :DT_FINAL '
      '      AND ARQUIVO_ID = :ARQUIVO_ID'
      '       GROUP BY REGISTRO,CONTA, CCUSTO,TIPO1, TIPO2  ')
    Left = 288
    Top = 72
    ParamData = <
      item
        Name = 'DT_INICIAL'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DT_FINAL'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARQUIVO_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object sql155REGISTRO: TStringField
      FieldName = 'REGISTRO'
      Origin = 'REGISTRO'
      ReadOnly = True
      Size = 6
    end
    object sql155CONTA: TStringField
      FieldName = 'CONTA'
      Origin = 'CONTA'
      ReadOnly = True
      Size = 11
    end
    object sql155CCUSTO: TStringField
      FieldName = 'CCUSTO'
      Origin = 'CCUSTO'
      ReadOnly = True
      Size = 11
    end
    object sql155VALOR1: TStringField
      FieldName = 'VALOR1'
      Origin = 'VALOR1'
      ReadOnly = True
      Size = 31
    end
    object sql155TIPO1: TStringField
      FieldName = 'TIPO1'
      Origin = 'TIPO1'
      ReadOnly = True
      Size = 2
    end
    object sql155VALOR2: TStringField
      FieldName = 'VALOR2'
      Origin = 'VALOR2'
      ReadOnly = True
      Size = 31
    end
    object sql155VALOR3: TStringField
      FieldName = 'VALOR3'
      Origin = 'VALOR3'
      ReadOnly = True
      Size = 31
    end
    object sql155VALOR4: TStringField
      FieldName = 'VALOR4'
      Origin = 'VALOR4'
      ReadOnly = True
      Size = 31
    end
    object sql155TIPO2: TStringField
      FieldName = 'TIPO2'
      Origin = 'TIPO2'
      ReadOnly = True
      Size = 2
    end
  end
  object sql250: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT  '#39'|'#39' + REGISTRO + '#39'|'#39' AS REGISTRO, '
      '        CONTA + '#39'|'#39' AS CONTA,  '
      '        CCUSTO + '#39'|'#39' AS CCUSTO, '
      '        CONVERT(VARCHAR, VALOR1) + '#39'|'#39' AS VALOR1, '
      '        TIPO1 + '#39'|'#39' AS TIPO1, '
      '        CODIGO + '#39'|'#39' AS CODIGO,  '
      '        BRANCO1 + '#39'|'#39' AS BRANCO1, '
      '        DESCRICAO + '#39'|'#39' AS DESCRICAO,  '
      '        BRANCO2 + '#39'|'#39' AS BRANCO2   '
      'FROM SPCT_250  '
      'WHERE   SPCT_200_ID = :SPCT_200_ID  '
      'AND ARQUIVO_ID = :ARQUIVO_ID'
      'ORDER BY SPCT_250_ID ')
    Left = 288
    Top = 144
    ParamData = <
      item
        Name = 'SPCT_200_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ARQUIVO_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object sql250REGISTRO: TStringField
      FieldName = 'REGISTRO'
      Origin = 'REGISTRO'
      ReadOnly = True
      Size = 6
    end
    object sql250CONTA: TStringField
      FieldName = 'CONTA'
      Origin = 'CONTA'
      ReadOnly = True
      Size = 11
    end
    object sql250CCUSTO: TStringField
      FieldName = 'CCUSTO'
      Origin = 'CCUSTO'
      ReadOnly = True
      Size = 11
    end
    object sql250VALOR1: TStringField
      FieldName = 'VALOR1'
      Origin = 'VALOR1'
      ReadOnly = True
      Size = 31
    end
    object sql250TIPO1: TStringField
      FieldName = 'TIPO1'
      Origin = 'TIPO1'
      ReadOnly = True
      Size = 2
    end
    object sql250CODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ReadOnly = True
      Size = 41
    end
    object sql250BRANCO1: TStringField
      FieldName = 'BRANCO1'
      Origin = 'BRANCO1'
      ReadOnly = True
      Size = 41
    end
    object sql250DESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      ReadOnly = True
      Size = 101
    end
    object sql250BRANCO2: TStringField
      FieldName = 'BRANCO2'
      Origin = 'BRANCO2'
      ReadOnly = True
      Size = 41
    end
  end
  object sqlGeral: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from SPCT_GERAL where 1 = 1')
    Left = 288
    Top = 216
    object sqlGeralSPCT_GERAL_ID: TFDAutoIncField
      FieldName = 'SPCT_GERAL_ID'
      Origin = 'SPCT_GERAL_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object sqlGeralLINHA: TStringField
      FieldName = 'LINHA'
      Origin = 'LINHA'
      Size = 500
    end
  end
  object sql200: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT SPCT_200_ID,  '#39'|'#39' + REGISTRO + '#39'|'#39' AS REGISTRO, '
      'NUMERO + '#39'|'#39' AS NUMERO,  '
      'DATA + '#39'|'#39' AS DATA,  '
      'CONVERT(VARCHAR,VALOR) + '#39'|'#39' AS VALOR,  '
      'LETRA + '#39'|'#39' as LETRA  '
      'FROM SPCT_200  '
      'WHERE Numero = :Numero '
      'AND ARQUIVO_ID = :ARQUIVO_ID'
      'Order by SPCT_200_ID ')
    Left = 288
    Top = 272
    ParamData = <
      item
        Name = 'NUMERO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARQUIVO_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object sql200SPCT_200_ID: TFDAutoIncField
      FieldName = 'SPCT_200_ID'
      Origin = 'SPCT_200_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object sql200REGISTRO: TStringField
      FieldName = 'REGISTRO'
      Origin = 'REGISTRO'
      ReadOnly = True
      Size = 6
    end
    object sql200DATA: TStringField
      FieldName = 'DATA'
      Origin = 'DATA'
      ReadOnly = True
      Size = 11
    end
    object sql200VALOR: TStringField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ReadOnly = True
      Size = 31
    end
    object sql200LETRA: TStringField
      FieldName = 'LETRA'
      Origin = 'LETRA'
      ReadOnly = True
      Size = 2
    end
    object sql200NUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      ReadOnly = True
      Size = 41
    end
  end
  object sql355: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      ' SELECT '#39'|'#39' + REGISTRO AS REGISTRO  ,'
      '        '#39'|'#39' + CONTA  AS CONTA,'
      '        '#39'|'#39' + CCUSTO  AS CCUSTO,'
      '        '#39'|'#39' +  CONVERT(VARCHAR, SUM(VALOR)) AS VALOR ,'
      '        '#39'|'#39' + TIPO + '#39'|'#39' AS TIPO'
      ' FROM SPCT_355'
      'WHERE ARQUIVO_ID =  :ARQUIVO_ID'
      ' GROUP BY REGISTRO, CONTA, CCUSTO, TIPO'
      ' ORDER BY  CONTA, CCUSTO')
    Left = 368
    Top = 232
    ParamData = <
      item
        Name = 'ARQUIVO_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object sql355REGISTRO: TStringField
      FieldName = 'REGISTRO'
      Origin = 'REGISTRO'
      ReadOnly = True
      Size = 5
    end
    object sql355CONTA: TStringField
      FieldName = 'CONTA'
      Origin = 'CONTA'
      ReadOnly = True
      Size = 11
    end
    object sql355CCUSTO: TStringField
      FieldName = 'CCUSTO'
      Origin = 'CCUSTO'
      ReadOnly = True
      Size = 11
    end
    object sql355VALOR: TStringField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ReadOnly = True
      Size = 32
    end
    object sql355TIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      ReadOnly = True
      Size = 2
    end
  end
  object FDQuery_Insert_F01: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    SQL.Strings = (
      'select * from ECF_MOV_F01 where 1 = 2')
    Left = 384
    Top = 48
    object FDQuery_Insert_F01ECF_MOV_F01_ID: TFDAutoIncField
      FieldName = 'ECF_MOV_F01_ID'
      Origin = 'ECF_MOV_F01_ID'
      ProviderFlags = [pfInKey]
      ReadOnly = True
    end
    object FDQuery_Insert_F01NUMERO_CONTA: TStringField
      FieldName = 'NUMERO_CONTA'
      Origin = 'NUMERO_CONTA'
      Size = 10
    end
    object FDQuery_Insert_F01TIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object FDQuery_Insert_F01VALOR_FIS_01: TBCDField
      FieldName = 'VALOR_FIS_01'
      Origin = 'VALOR_FIS_01'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_02: TBCDField
      FieldName = 'VALOR_FIS_02'
      Origin = 'VALOR_FIS_02'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_03: TBCDField
      FieldName = 'VALOR_FIS_03'
      Origin = 'VALOR_FIS_03'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_04: TBCDField
      FieldName = 'VALOR_FIS_04'
      Origin = 'VALOR_FIS_04'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_05: TBCDField
      FieldName = 'VALOR_FIS_05'
      Origin = 'VALOR_FIS_05'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_06: TBCDField
      FieldName = 'VALOR_FIS_06'
      Origin = 'VALOR_FIS_06'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_07: TBCDField
      FieldName = 'VALOR_FIS_07'
      Origin = 'VALOR_FIS_07'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_08: TBCDField
      FieldName = 'VALOR_FIS_08'
      Origin = 'VALOR_FIS_08'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_09: TBCDField
      FieldName = 'VALOR_FIS_09'
      Origin = 'VALOR_FIS_09'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_10: TBCDField
      FieldName = 'VALOR_FIS_10'
      Origin = 'VALOR_FIS_10'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_11: TBCDField
      FieldName = 'VALOR_FIS_11'
      Origin = 'VALOR_FIS_11'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_12: TBCDField
      FieldName = 'VALOR_FIS_12'
      Origin = 'VALOR_FIS_12'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01VALOR_FIS_13: TBCDField
      FieldName = 'VALOR_FIS_13'
      Origin = 'VALOR_FIS_13'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_F01DATA_IMPORT: TSQLTimeStampField
      FieldName = 'DATA_IMPORT'
      Origin = 'DATA_IMPORT'
    end
    object FDQuery_Insert_F01ANO: TIntegerField
      FieldName = 'ANO'
      Origin = 'ANO'
    end
    object FDQuery_Insert_F01EMPRESA: TStringField
      FieldName = 'EMPRESA'
      Origin = 'EMPRESA'
      Size = 4
    end
    object FDQuery_Insert_F01ECF_CONTROLE_ID: TIntegerField
      FieldName = 'ECF_CONTROLE_ID'
      Origin = 'ECF_CONTROLE_ID'
    end
  end
  object FDQuery_Insert_KE5Z: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    SQL.Strings = (
      'select * from ECF_MOV_KE5Z where 1 = 2')
    Left = 384
    Top = 136
    object FDQuery_Insert_KE5ZECF_MOV_KE5Z_ID: TFDAutoIncField
      FieldName = 'ECF_MOV_KE5Z_ID'
      Origin = 'ECF_MOV_KE5Z_ID'
      ProviderFlags = [pfInKey]
      ReadOnly = True
    end
    object FDQuery_Insert_KE5ZPlant: TStringField
      FieldName = 'Plant'
      Origin = 'Plant'
      Size = 4
    end
    object FDQuery_Insert_KE5ZDC: TStringField
      FieldName = 'DC'
      Origin = 'DC'
      FixedChar = True
      Size = 1
    end
    object FDQuery_Insert_KE5ZACC_NUMBER: TStringField
      FieldName = 'ACC_NUMBER'
      Origin = 'ACC_NUMBER'
    end
    object FDQuery_Insert_KE5ZPURCHASING_DOC: TStringField
      FieldName = 'PURCHASING_DOC'
      Origin = 'PURCHASING_DOC'
    end
    object FDQuery_Insert_KE5ZACC_NUMBER_VEN_CRE: TStringField
      FieldName = 'ACC_NUMBER_VEN_CRE'
      Origin = 'ACC_NUMBER_VEN_CRE'
    end
    object FDQuery_Insert_KE5ZNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 100
    end
    object FDQuery_Insert_KE5ZPOSITION_PERIODO: TStringField
      FieldName = 'POSITION_PERIODO'
      Origin = 'POSITION_PERIODO'
      Size = 3
    end
    object FDQuery_Insert_KE5ZFISCAL_YEAR: TStringField
      FieldName = 'FISCAL_YEAR'
      Origin = 'FISCAL_YEAR'
      Size = 4
    end
    object FDQuery_Insert_KE5ZAMOUNT: TBCDField
      FieldName = 'AMOUNT'
      Origin = 'AMOUNT'
      Precision = 18
      Size = 2
    end
    object FDQuery_Insert_KE5ZMOEDA: TStringField
      FieldName = 'MOEDA'
      Origin = 'MOEDA'
      Size = 3
    end
    object FDQuery_Insert_KE5ZPAIS: TStringField
      FieldName = 'PAIS'
      Origin = 'PAIS'
      Size = 4
    end
    object FDQuery_Insert_KE5ZDATA_IMPORT: TSQLTimeStampField
      FieldName = 'DATA_IMPORT'
      Origin = 'DATA_IMPORT'
    end
    object FDQuery_Insert_KE5ZECF_CONTROLE_ID: TIntegerField
      FieldName = 'ECF_CONTROLE_ID'
      Origin = 'ECF_CONTROLE_ID'
    end
    object FDQuery_Insert_KE5ZANO_BASE: TStringField
      FieldName = 'ANO_BASE'
      Origin = 'ANO_BASE'
      Size = 4
    end
    object FDQuery_Insert_KE5ZCENTRO_CUSTO: TStringField
      FieldName = 'CENTRO_CUSTO'
      Origin = 'CENTRO_CUSTO'
      Size = 10
    end
  end
  object FDQuery_FBL3N: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    SQL.Strings = (
      'select * from ECF_FBL3N where 1 = 2')
    Left = 168
    Top = 56
    object FDQuery_FBL3NFBL3N_ID: TFDAutoIncField
      FieldName = 'FBL3N_ID'
      Origin = 'FBL3N_ID'
      ProviderFlags = [pfInKey]
      ReadOnly = True
    end
    object FDQuery_FBL3NCD: TStringField
      FieldName = 'CD'
      Origin = 'CD'
      Size = 4
    end
    object FDQuery_FBL3NNUMERO_CONTA: TStringField
      FieldName = 'NUMERO_CONTA'
      Origin = 'NUMERO_CONTA'
      Size = 10
    end
    object FDQuery_FBL3NCENTRO_CUSTO: TStringField
      FieldName = 'CENTRO_CUSTO'
      Origin = 'CENTRO_CUSTO'
      Size = 10
    end
    object FDQuery_FBL3NDATA: TDateField
      FieldName = 'DATA'
      Origin = 'DATA'
    end
    object FDQuery_FBL3NVALOR: TBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Precision = 18
      Size = 2
    end
    object FDQuery_FBL3NMOEDA: TStringField
      FieldName = 'MOEDA'
      Origin = 'MOEDA'
      Size = 5
    end
    object FDQuery_FBL3NDC: TStringField
      FieldName = 'DC'
      Origin = 'DC'
      Size = 1
    end
    object FDQuery_FBL3NDATA_IMPORT: TSQLTimeStampField
      FieldName = 'DATA_IMPORT'
      Origin = 'DATA_IMPORT'
    end
    object FDQuery_FBL3NANO_FISCAL: TStringField
      FieldName = 'ANO_FISCAL'
      Origin = 'ANO_FISCAL'
      Size = 4
    end
    object FDQuery_FBL3NMES_FISCAL: TStringField
      FieldName = 'MES_FISCAL'
      Origin = 'MES_FISCAL'
      Size = 2
    end
    object FDQuery_FBL3NECF_CONTROLE_ID: TIntegerField
      FieldName = 'ECF_CONTROLE_ID'
      Origin = 'ECF_CONTROLE_ID'
    end
    object FDQuery_FBL3NANO_BASE: TStringField
      FieldName = 'ANO_BASE'
      Origin = 'ANO_BASE'
      Size = 4
    end
    object FDQuery_FBL3NTIPO_SA: TStringField
      FieldName = 'TIPO_SA'
      Origin = 'TIPO_SA'
      FixedChar = True
      Size = 1
    end
  end
  object FDQuery_Controle: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM ECF_CONTROLE WHERE 1 = 2')
    Left = 176
    Top = 144
    object FDQuery_ControleECF_CONTROLE_ID: TFDAutoIncField
      FieldName = 'ECF_CONTROLE_ID'
      Origin = 'ECF_CONTROLE_ID'
      ProviderFlags = [pfInKey]
      ReadOnly = True
    end
    object FDQuery_ControleANO: TStringField
      FieldName = 'ANO'
      Origin = 'ANO'
      Size = 4
    end
    object FDQuery_ControleANO_ANTERIOR: TStringField
      FieldName = 'ANO_ANTERIOR'
      Origin = 'ANO_ANTERIOR'
      Size = 4
    end
    object FDQuery_ControleDATA_IMPORT: TSQLTimeStampField
      FieldName = 'DATA_IMPORT'
      Origin = 'DATA_IMPORT'
    end
  end
end
