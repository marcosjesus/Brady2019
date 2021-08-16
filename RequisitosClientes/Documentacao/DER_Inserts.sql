SELECT * FROM RQCL_ITEM

select ri.rqcl_requisito_id, r.nome, ri.rqcl_item_id, i.nome from RQCL_REQUISITO_ITENS ri
inner join RQCL_REQUISITO r on r.rqcl_requisito_id = ri.rqcl_requisito_id
inner join RQCL_ITEM i on i.rqcl_item_id = ri.rqcl_item_id


select * from RQCL_REQUISITO

insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (1, 1)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (1, 2)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (1, 94)

insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (2, 1)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (2, 2)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (2, 3)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (2, 49)

insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (2, 57)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (2, 80)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (2, 81)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (2, 94)


insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (3, 1)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (3, 2)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (3, 3)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (3, 81)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (3, 94)

insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (4, 1)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (4, 2)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (4, 4)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (4, 61)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (4, 82)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (4, 94)


insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (5, 1)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (5, 2)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (5, 5)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (5, 100)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (5, 31)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (5, 67)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (5, 74)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (5, 77)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (5, 83)


insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (6, 1)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (6, 2)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (6, 5)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (6, 101)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (6, 32)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (6, 83)


insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (7, 1)
insert into RQCL_REQUISITO_ITENS (rqcl_requisito_id, rqcl_item_id) values (7, 2)

select * from RQCL_ITEM where nome like '%3060%'
