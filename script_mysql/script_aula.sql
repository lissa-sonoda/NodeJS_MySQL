create database if not exists db_hospital;

use db_hospital;

create table if not exists tb_medico(
	crm int,
    nome varchar(100) not null,
    primary key(crm)
);

create table if not exists tb_paciente(
	cpf bigint,
    nome varchar(100) not null,
    idade smallint not null,
    primary key(cpf)
);

create table if not exists tb_consulta(
	data_hora datetime not null,
    crm int not null,
    cpf bigint not null,
    primary key(data_hora, crm, cpf),
    constraint fk_medico foreign key(crm) references tb_medico(crm),
    constraint fk_paciente foreign key(cpf) references tb_paciente(cpf)
);

insert into tb_medico(crm, nome) 
	values(123456, "Danilo"),
			(987654, "Jose");

insert into tb_paciente(cpf, nome, idade)
	values (99887766554, "Maria", 22),
			(66554433221, "Antonio", 65),
            (11223344556, "Francisco", 75);
            
insert into tb_consulta(data_hora, crm, cpf) 
	values('2021-11-09 13:53:00', 123456, 99887766554),
			('2021-11-10 18:00:00', 123456, 66554433221),
            ('2021-11-15 15:30:00', 123456, 99887766554),
            ('2021-11-20 12:30:00', 987654, 11223344556);

select * from tb_medico;
select * from tb_paciente;
select * from tb_consulta;

select * from tb_consulta order by data_hora asc;
select * from tb_consulta order by data_hora desc;

select m.crm, m.nome, c.data_hora
from tb_medico m
inner join tb_consulta c
on m.crm = c.crm
where m.nome like "D%";

select m.crm as "CRM do médico", 
m.nome as "Nome do médico", 
c.data_hora as "Data da consulta",
p.nome as "Nome do paciente"
from tb_medico m
inner join tb_consulta c
on m.crm = c.crm
inner join tb_paciente p
on c.cpf = p.cpf
where m.nome like "D%";

select m.crm as "CRM do médico", 
m.nome as "Nome do médico", 
date_format(data_hora, "%d/%m/%y %H:%i") as "Data da consulta",
p.nome as "Nome do paciente" 
from tb_medico m
inner join tb_consulta c
on m.crm = c.crm
inner join tb_paciente p
on c.cpf = p.cpf;

select p.nome, count(p.cpf) as total_consultas
from tb_consulta c
inner join tb_paciente p
on c.cpf = p.cpf
group by p.nome;

