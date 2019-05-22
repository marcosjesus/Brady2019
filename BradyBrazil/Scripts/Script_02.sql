
/****** Object:  View [dbo].[VSOP_OrderBillingFull]    Script Date: 08/10/2018 15:11:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[VSOP_OrderBillingFull]             
AS          
SELECT TSOP_ORDBILCOD          = A01.TSOP_ORDBILCOD          
      ,TSOP_ORICOD             = A01.TSOP_ORICOD          
      ,TSOP_ORINOM             = O01.TSOP_ORINOM          
      ,TSOP_ORDBILSITNOM       = COALESCE( B01.TSOP_DPASITTXTDEP, A01.TSOP_ORDBILSITNOM )          
      ,TSOP_ORDBILCANNOM       = COALESCE( C02.TSOP_DPACANTXTDEP, D01.TSOP_DPACANTXTDEP, C01.TSOP_DPACANTXTDEP, A01.TSOP_ORDBILCANNOM )          
      ,TSOP_ORDBILDATDOC       = A01.TSOP_ORDBILDATDOC          
      ,TSOP_ORDBILDATDOCYFY    = DATEPART(YEAR,A01.TSOP_ORDBILDATDOC) + CASE WHEN DATEPART(MONTH,A01.TSOP_ORDBILDATDOC) >= 8 THEN 1 ELSE 0 END          
      ,TSOP_ORDBILDATDOCQFY    = CASE DATEPART(MONTH,A01.TSOP_ORDBILDATDOC) WHEN 8 THEN 'Q1' WHEN 9 THEN 'Q1' WHEN 10 THEN 'Q1' WHEN 11 THEN 'Q2' WHEN 12 THEN 'Q2' WHEN 01 THEN 'Q2' WHEN 02 THEN 'Q3' WHEN 03 THEN 'Q3' WHEN 04 THEN 'Q3' WHEN 05 THEN 'Q4'  
  
    
      
       
      WHEN 06 THEN 'Q4' WHEN 07 THEN 'Q4' END          
      ,TSOP_ORDBILNRODOC       = A01.TSOP_ORDBILNRODOC          
      ,TSOP_ORDBILTIPDOC       = A01.TSOP_ORDBILTIPDOC          
      ,TSOP_ORDBILNRODOCREF    = A01.TSOP_ORDBILNRODOCREF          
      ,TSOP_ORDBILITESEQ       = A01.TSOP_ORDBILITESEQ          
      ,TSOP_ORDBILYEADOCREQCAL = DATEPART(YEAR,COALESCE(Q01.TSOP_ORDREQDATREQ,P01.TSOP_ORDREQDATREQ,A01.TSOP_ORDBILDATDOCREQ))          
      ,TSOP_ORDBILMONDOCREQCAL = DATEPART(MONTH,COALESCE(Q01.TSOP_ORDREQDATREQ,P01.TSOP_ORDREQDATREQ,A01.TSOP_ORDBILDATDOCREQ))          
      ,TSOP_ORDBILYEADOCREQ    = CASE WHEN DATEPART(MONTH,COALESCE(Q01.TSOP_ORDREQDATREQ,P01.TSOP_ORDREQDATREQ,A01.TSOP_ORDBILDATDOCREQ)) BETWEEN 8 AND 12 THEN 1 ELSE 0 END + DATEPART(YEAR,COALESCE(Q01.TSOP_ORDREQDATREQ,P01.TSOP_ORDREQDATREQ,        
      A01.TSOP_ORDBILDATDOCREQ))          
      ,TSOP_ORDBILMONDOCREQ    = CASE DATEPART(MONTH,COALESCE(Q01.TSOP_ORDREQDATREQ,P01.TSOP_ORDREQDATREQ,A01.TSOP_ORDBILDATDOCREQ)) WHEN 8 THEN 1 WHEN 9 THEN 2 WHEN 10 THEN 3 WHEN 11 THEN 4 WHEN 12 THEN 5 WHEN 1 THEN 6 WHEN 2 THEN 7 WHEN 3 THEN 8 WHEN 4 
  
    
      
        
THEN 9 WHEN 5 THEN 10 WHEN 6 THEN 11 WHEN 7 THEN 12 END          
      ,TSOP_ORDBILDATDOCREQ    = COALESCE(Q01.TSOP_ORDREQDATREQ,P01.TSOP_ORDREQDATREQ,A01.TSOP_ORDBILDATDOCREQ)          
      ,TSOP_ORDBILCLICOD       = A01.TSOP_ORDBILCLICOD          
      ,TSOP_ORDBILCLINOM       = A01.TSOP_ORDBILCLINOM          
      ,TSOP_ORDBILGRUCLINOM    = UPPER(COALESCE( L01.TSOP_DPAGRUCLITXTDEP, K01.TSOP_GRUCLINOM, NULLIF( CASE          
                                                                                                         WHEN A01.TSOP_ORDBILGRUCLINOM LIKE '%Not assigned%' THEN ''          
                                                                                                         ELSE RTRIM(LTRIM(A01.TSOP_ORDBILGRUCLINOM))          
                                                                                                       END, ''), A01.TSOP_ORDBILCLINOM ))          
      ,TSOP_GRUCLIMER          = UPPER(K01.TSOP_GRUCLIMER)          
      ,TSOP_ORDBILREPNOM       = UPPER(COALESCE( N01.TSOP_DPAREPTXTDEP, M01.TSOP_REPNOM, A01.TSOP_ORDBILREPNOM ))          
      ,TSOP_REPNOMINT          = UPPER(M01.TSOP_REPNOMINT)          
      ,TSOP_REPCSR             = UPPER(M01.TSOP_REPCSR)          
      ,TSOP_REPMKT             = UPPER(M01.TSOP_REPMKT)          
      ,TSOP_ORDBILITECOD       = A01.TSOP_ORDBILITECOD          
      ,TSOP_ORDBILITENOM       = A01.TSOP_ORDBILITENOM          
      ,TSOP_ORDBILITEUNI       = A01.TSOP_ORDBILITEUNI          
      ,TSOP_ORDBILITEFAM       = COALESCE( E01.TSOP_FAMNOM, '' )          
      ,TSOP_ORDBILITEFAMPAI    = COALESCE( E01.TSOP_FAMNOMPAI, '' )          
      ,TSOP_ORDBILITEFAM001    = COALESCE( F01.TSOP_DPAFAMTXTDEP, E01.TSOP_FAMCOD001, A01.TSOP_ORDBILITEFAM001 )     
      ,TSOP_ORDBILITEFAM002    = COALESCE( G01.TSOP_DPAFAMTXTDEP, E01.TSOP_FAMCOD002, A01.TSOP_ORDBILITEFAM002 )          
      ,TSOP_ORDBILITEFAM003    = COALESCE( H01.TSOP_DPAFAMTXTDEP, E01.TSOP_FAMCOD003, A01.TSOP_ORDBILITEFAM003 )          
      ,TSOP_ORDBILITEFAM004    = COALESCE( I01.TSOP_DPAFAMTXTDEP, E01.TSOP_FAMCOD004, A01.TSOP_ORDBILITEFAM004 )          
      ,TSOP_ORDBILITEFAM005    = COALESCE( J01.TSOP_DPAFAMTXTDEP, E01.TSOP_FAMCOD005, A01.TSOP_ORDBILITEFAM005 )          
      ,TSOP_ORDBILVALLIQ       = CAST( A01.TSOP_ORDBILVALLIQ / ( CASE WHEN A01.TSOP_ORDBILNRODOC = '18352170' AND A01.TSOP_ORDBILITECOD = 'Y3957518' THEN 1000 ELSE 1 END ) AS NUMERIC(15,02))          
      ,TSOP_ORDBILQTD          = A01.TSOP_ORDBILQTD          
      ,TSOP_ORDBILQTDSKU       = A01.TSOP_ORDBILQTDSKU          
      ,TSOP_USUCODCAD          = A01.TSOP_USUCODCAD          
      ,TSOP_ORDBILDATCAD       = A01.TSOP_ORDBILDATCAD          
      ,TSOP_USUCODALT          = A01.TSOP_USUCODALT          
      ,TSOP_ORDBILDATALT       = A01.TSOP_ORDBILDATALT          
      ,TSOP_REPACCTYP          = M01.TSOP_REPACCTYP          
      ,TSOP_ORDBILYEADOCCAL    = DATEPART(YEAR,A01.TSOP_ORDBILDATDOC)          
      ,TSOP_ORDBILMONDOCCAL    = DATEPART(MONTH,A01.TSOP_ORDBILDATDOC)          
      ,TSOP_ORDBILYEADOC       = CASE WHEN DATEPART(MONTH,A01.TSOP_ORDBILDATDOC) BETWEEN 8 AND 12 THEN 1 ELSE 0 END + DATEPART(YEAR,A01.TSOP_ORDBILDATDOC)          
      ,TSOP_ORDBILMONDOC       = CASE DATEPART(MONTH,A01.TSOP_ORDBILDATDOC) WHEN 8 THEN 1 WHEN 9 THEN 2 WHEN 10 THEN 3 WHEN 11 THEN 4 WHEN 12 THEN 5 WHEN 1 THEN 6 WHEN 2 THEN 7 WHEN 3 THEN 8 WHEN 4 THEN 9 WHEN 5 THEN 10 WHEN 6 THEN 11 WHEN 7 THEN 12 END  
  
    
      
       
         
   ,TSOP_ORDBILREGEST       = COALESCE(R01.TSOP_CLISAPCLIREG,'')          
   ,TSOP_ORDBILREG          = CASE          
                                WHEN COALESCE(R01.TSOP_CLISAPCLIREG,'') IN ('AM','RR','AP','PA','TO','RO','AC') THEN 'Região Norte'          
                                WHEN COALESCE(R01.TSOP_CLISAPCLIREG,'') IN ('MA','PI','CE','RN','PE','PB','SE','AL','BA') THEN 'Região Nordeste'          
                                WHEN COALESCE(R01.TSOP_CLISAPCLIREG,'') IN ('MT','MS','GO','DF') THEN 'Região Centro-Oeste'          
                                WHEN COALESCE(R01.TSOP_CLISAPCLIREG,'') IN ('SP','RJ','ES','MG') THEN 'Região Sudeste'          
                                WHEN COALESCE(R01.TSOP_CLISAPCLIREG,'') IN ('PR','RS','SC') THEN 'Região Sul'          
           ELSE 'Outros'          
         END          
      ,TSOP_SITCOD             = A01.TSOP_ORDBILSITNOM          
      ,TSOP_ITECLISAPITECLICOD = S01.TSOP_ITECLISAPITECLICOD    
	  ,TSOP_PRIMARYCATALOG = A01.TSOP_PRIMARYCATALOG      
	  ,TSOP_CUSTOMERPURCHASE = A01.TSOP_CUSTOMERPURCHASE       
FROM dbo.TSOP_OrderBilling A01 LEFT  JOIN dbo.TSOP_DeParaSite          B01 ON ( A01.TSOP_ORICOD                      = B01.TSOP_ORICOD          
                                                                            AND A01.TSOP_ORDBILSITNOM                = B01.TSOP_DPASITTXTANT   )          
                               LEFT  JOIN dbo.TSOP_DeParaCanal         C01 ON ( A01.TSOP_ORICOD                      = C01.TSOP_ORICOD          
                                                                            AND C01.TSOP_DPACANTIPTXT                = 'S'          
                                                                            AND A01.TSOP_ORDBILCANNOM                = C01.TSOP_DPACANTXTANT   )          
                               LEFT  JOIN dbo.TSOP_DeParaCanal         C02 ON ( A01.TSOP_ORICOD                      = C02.TSOP_ORICOD          
                                                                            AND C02.TSOP_DPACANTIPTXT                = 'S'          
                                                                            AND A01.TSOP_ORDBILCANNOM                = C02.TSOP_DPACANTXTANT          
                   AND A01.TSOP_ORDBILCANNOM                = '4110'                  )          
                               LEFT  JOIN dbo.TSOP_DeParaCanal         D01 ON ( A01.TSOP_ORICOD                      = D01.TSOP_ORICOD          
                                                                            AND D01.TSOP_DPACANTIPTXT                = 'C'          
                                                                            AND A01.TSOP_ORDBILCLICOD                = D01.TSOP_DPACANTXTANT   )          
                               LEFT  JOIN dbo.TSOP_Familia             E01 ON ( A01.TSOP_ORICOD                    = E01.TSOP_ORICOD          
                                                                            AND A01.TSOP_ORDBILITECOD                = E01.TSOP_FAMITECOD      )          
                               LEFT  JOIN dbo.TSOP_DeParaFamilia       F01 ON ( A01.TSOP_ORICOD                      = F01.TSOP_ORICOD          
                                                                            AND COALESCE( E01.TSOP_FAMCOD001,          
                                                                                          A01.TSOP_ORDBILITEFAM001 ) = F01.TSOP_DPAFAMTXTANT   )          
                               LEFT  JOIN dbo.TSOP_DeParaFamilia       G01 ON ( A01.TSOP_ORICOD                      = G01.TSOP_ORICOD          
                                                                            AND COALESCE( E01.TSOP_FAMCOD002,          
                                                                                          A01.TSOP_ORDBILITEFAM002 ) = G01.TSOP_DPAFAMTXTANT   )          
                               LEFT  JOIN dbo.TSOP_DeParaFamilia       H01 ON ( A01.TSOP_ORICOD                      = H01.TSOP_ORICOD          
                                                                            AND COALESCE( E01.TSOP_FAMCOD003,          
                                                                                          A01.TSOP_ORDBILITEFAM003 ) = H01.TSOP_DPAFAMTXTANT   )          
                               LEFT  JOIN dbo.TSOP_DeParaFamilia       I01 ON ( A01.TSOP_ORICOD                      = I01.TSOP_ORICOD          
                                                                            AND COALESCE( E01.TSOP_FAMCOD004,          
                                                                                          A01.TSOP_ORDBILITEFAM004 ) = I01.TSOP_DPAFAMTXTANT   )          
                               LEFT  JOIN dbo.TSOP_DeParaFamilia       J01 ON ( A01.TSOP_ORICOD                      = J01.TSOP_ORICOD          
                                                                            AND COALESCE( E01.TSOP_FAMCOD005,          
                                                                                          A01.TSOP_ORDBILITEFAM005 ) = J01.TSOP_DPAFAMTXTANT   )          
                               LEFT  JOIN dbo.TSOP_GrupoCliente        K01 ON ( A01.TSOP_ORICOD                      = K01.TSOP_ORICOD          
                                                                            AND A01.TSOP_ORDBILCLICOD                = K01.TSOP_GRUCLICLICOD   )          
                               LEFT  JOIN dbo.TSOP_DeParaGrupoCliente  L01 ON ( A01.TSOP_ORICOD                      = L01.TSOP_ORICOD          
                                                                            AND COALESCE( K01.TSOP_GRUCLINOM,          
                                                                                          NULLIF( CASE          
                                                                                                    WHEN A01.TSOP_ORDBILGRUCLINOM LIKE '%Not assigned%' THEN ''          
                                                                                                    ELSE RTRIM(LTRIM(A01.TSOP_ORDBILGRUCLINOM))          
                 END, ''),          
                                                                                          A01.TSOP_ORDBILCLINOM    ) = L01.TSOP_DPAGRUCLITXTANT )          
                               LEFT  JOIN dbo.TSOP_Representante       M01 ON ( A01.TSOP_ORICOD                      = M01.TSOP_ORICOD          
          AND A01.TSOP_ORDBILCLICOD                = M01.TSOP_REPCLICOD      )          
                               LEFT  JOIN dbo.TSOP_DeParaRepresentante N01 ON ( A01.TSOP_ORICOD                      = N01.TSOP_ORICOD          
                                                                        AND COALESCE( M01.TSOP_REPNOM,          
                    A01.TSOP_ORDBILREPNOM )    = N01.TSOP_DPAREPTXTANT   )          
                               INNER JOIN dbo.TSOP_Origem              O01 ON ( A01.TSOP_ORICOD                      = O01.TSOP_ORICOD         )          
                               LEFT  JOIN dbo.TSOP_OrderResquestDate   P01 ON ( A01.TSOP_ORDBILNRODOC                = P01.TSOP_ORDREQNRODOC          
                                                                            AND A01.TSOP_ORDBILITESEQ                = P01.TSOP_ORDREQSEQITE          
                                                                            AND A01.TSOP_ORDBILTIPDOC                = 'Order'                 )          
                               LEFT  JOIN dbo.TSOP_OrderResquestDate   Q01 ON ( A01.TSOP_ORDBILNRODOCREF             = Q01.TSOP_ORDREQNRODOC          
                                                                            AND A01.TSOP_ORDBILITESEQ                = Q01.TSOP_ORDREQSEQITE          
                                                                            AND A01.TSOP_ORDBILTIPDOC               <> 'Order'                 )          
          LEFT  JOIN dbo.TSOP_ClienteSAP          R01 ON ( A01.TSOP_ORDBILCLICOD                = R01.TSOP_CLISAPCLICOD   )          
          LEFT  JOIN dbo.VSOP_ItemClienteSAP      S01 ON ( A01.TSOP_ORDBILCANNOM = S01.TSOP_ITECLISAPCAN          
                                                       AND A01.TSOP_ORDBILITECOD = S01.TSOP_ITECLISAPITECOD )

GO


