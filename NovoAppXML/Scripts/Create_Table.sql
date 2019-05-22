select * from ecf_vinculo

select * from [dbo].[ECF_CENTRO_CUSTO]

DROP TABLE ECF_CONTA_SALDO

CREATE TABLE ECF_CONTA_SALDO
(
 ECF_CONTA_SALDO_ID INT PRIMARY KEY,
 ECF_CONTA_ID INT,
 DT_EXERCICIOFISCAL DATETIME,
 EXERCICIO VARCHAR(4) ,
 PERIODO_FISCAL VARCHAR(2) ,
 SALDO DECIMAL(18,2)
)

[dbo].[TabDef_UpdAll]

SELECT * FROM Operacao

INSERT INTO OPERACAO ( CodOperacao, Descricao, GRUPO, itemgrupo ) VALUES ( 'CAD-CONTASALDO', 'Lançamento de Saldo da Conta', 5, 4)

select * from Perfil_Operacao

insert into Perfil_Operacao ( CodPerfil, CodOperacao, Manut) values ( '1', 'CAD-CONTASALDO', 'T')
