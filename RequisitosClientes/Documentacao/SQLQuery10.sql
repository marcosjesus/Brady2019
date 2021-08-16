select * from ECF_CONSULTA where QUERY = 'GL_BALANCE' and ANO_FISCAL = '2019' order by ANO

select * from ECF_CONSULTA where QUERY = 'GL_BALANCE' and ANO_FISCAL = '2020' order by ANO




insert into ECF_CONSULTA (ecf_consulta_id,nome, usuario_sap, query, VARIANTE, ano,  selecao, arquivo, ANO_FISCAL)

SELECT ECF_CONSULTA_ID, nome, usuario_sap, query, VARIANTE, ano,  selecao, arquivo, ANO_FISCAL FROM ECF_CONSULTA WHERE ANO = '2019' and ANO_FISCAL = '2019' OR 
(QUERY = 'GL_BALANCE' AND ANO = '2018'and ANO_FISCAL = '2019') OR  
(QUERY = 'GL_BALANCE5' AND ANO = '2020'and ANO_FISCAL = '2019')  
ORDER BY  ANO, QUERY 

SELECT ECF_CONSULTA_ID, nome, usuario_sap, query, VARIANTE, ano,  selecao, arquivo, ANO_FISCAL FROM ECF_CONSULTA WHERE ANO = '2020' and ANO_FISCAL = '2020' OR 
(QUERY = 'GL_BALANCE' AND ANO = '2019'and ANO_FISCAL = '2020') OR  
(QUERY = 'GL_BALANCE5' AND ANO = '2021'and ANO_FISCAL = '2020')  
ORDER BY  ANO, QUERY 


select * from ECF_CONSULTA where ECF_CONSULTA_ID = 59


update ECF_CONSULTA
set VARIANTE = '/2021', ano = '2020'
where ECF_CONSULTA_ID = 48

select * from ECF_CONSULTA where QUERY = 'L210-KE5Z'