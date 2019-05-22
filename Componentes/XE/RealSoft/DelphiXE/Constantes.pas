unit Constantes;

interface

Const

   OPE_ESCAPE    = 0 ;
   OPE_INCLUSAO  = 1 ;
   OPE_ALTERACAO = 2 ;
   OPE_EXCLUSAO  = 3 ;

   TAG_FIELD = -1 ;
   TAG_KEY   = -2 ;

   // Sql
   ERRO_KEYVIOLATION = 1 ;

   PAGREC_STATUS_ABERTO       = 'A' ;
   PAGREC_STATUS_CANCELADO    = 'C' ;
   PAGREC_STATUS_RECEBIDO     = 'R' ;
   PAGREC_STATUS_PAGO         = 'P' ;

   // Movimentacao bancaria
   MV_TIPO_CREDITO   = 'C' ;
   MV_TIPO_DEBITO    = 'D' ;
   MV_TIPO_CANCELADO = 'X' ;

   // Status dos lancamentos contabeis
   LC_STATUS_ABERTO = 'A' ;
   LC_STATUS_ENCERRADO = 'E' ;

   // Tipo de contas para fechamento
   FECHA_BANCO  = 'B' ;
   FECHA_CONTAB = 'C' ;

   // Tipos de movimentos de clientes
   MOVCLI_COMPRA = 'C' ;
   MOVCLI_VENDA  = 'V' ;
   MOVCLI_TRANSF = 'T' ;
   MOVCLI_DELCOM = 'c' ;
   MOVCLI_DELVEN = 'v' ;
   MOVCLI_ALTCOM = 'O' ;
   MOVCLI_ALTVEN = 'E' ;

   // Tipos de Operacoes (OpeID )
   OPEID_TRANSF = -1 ;
   OPEID_PENDBR = -2 ;

implementation

end.
