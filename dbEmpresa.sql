drop database dbEmpresa;

create database dbEmpresa;

use dbEmpresa;

create table tbFuncionarios(
codFunc int not null auto_increment,
nome varchar(100),
email varchar(100),
cpf char(14) not null unique,
salario decimal(9,2) not null default 0 check (salario >= 0),
sexo char(1) default 'F' check(sexo in('F','M')),
primary key(codFunc)
);

create table tbUsuarios(
codUsu int not null auto_increment,
nome varchar (20) not null,
senha varchar (20) not null,
codFunc int not null,
primary key(codUsu),
foreign key(codFunc)references tbFuncionarios(codFunc)
);

create table tbFornecedores(
codForn int not null auto_increment,
nome varchar(100),
cnpj varchar(18),
inscrEst char(15),
email varchar(100),
telefone char(10),
primary key(codForn)
);

create table tbProdutos(
codProd int not null auto_increment,
descricao varchar(100),
quantidade int default 0 check(quantidade >=0),
valor decimal (9,2) check(valor >= 0),
codForn int not null,
primary key(codProd),
foreign key(codForn)references tbFornecedores(codForn)
);

create table tbClientes(
codCli int not null auto_increment,
nome varchar (100),
email varchar(100) not null unique,
cpf char(14),
telefone char(10),
primary key(codCli)
);

create table tbVendas(
codVend int not null auto_increment,
codProd int not null,
codCli int not null,
codUsu int not null,
dataVenda date,
horaVenda time,
quantidade int,
primary key(codVend),
foreign key(codProd)references tbProdutos(codProd),
foreign key(codCli)references tbClientes(codCli),
foreign key(codUsu)references tbUsuarios(codUsu)
);


desc tbFuncionarios;
desc tbUsuarios;
desc tbFornecedores;
desc tbProdutos;
desc tbClientes;
desc tbVendas;


insert into tbFuncionarios(nome,email,cpf,salario,sexo) values('Jon Jones','jonnyboy@gmail.com','263.658.963-52','2111.00','M');

insert into tbUsuarios(nome,senha,codFunc) values('jon.j','1055050',1);

insert into tbFornecedores(nome,cnpj,inscrEst,email,telefone)values('Fabricantes LTDA','03.396.1254.0001/36','326.152.654-110','sac@FLTDA.com.br','96332-6910');

insert into tbProdutos(descricao,quantidade,valor,codForn) values('Sorvete',1,22.96,1);

insert into tbClientes(nome,email,cpf,telefone)
	values('João Sergio do Santos','joao.SS@gmail.com','263.695.785-23','96524-8599');

insert into tbVendas(codProd,codCli,codUsu,dataVenda,horaVenda,quantidade)values(1,1,1,'2022/01/09','15:04:12',12);


select * from tbFuncionarios;
select * from tbUsuarios;
select * from tbFornecedores;
select * from tbProdutos;
select * from tbClientes;
select * from tbVendas;

-- Inner Join 
--select prod.descricao, vend.quantidade
--from tbVendas as vend
--inner join tbProdutos as prod
--on vend.codProd = prod.codProd;

--select prod.descricao, forn.nome from tbProdutos as prod
--inner join tbFornecedores as forn
--on prod.codForn = forn.codForn;

--select prod.descricao, cli.nome, usu.nome from tbVendas as vend
--inner join tbProdutos as prod on vend.codProd = prod.codProd
--inner join tbClientes as cli on vend.codCli = cli.codCli
--inner join tb tbUsuarios as usu on vend.codUsu = usu.codUsu;

select prod.descricao, prod.quantidade, forn.nome, func.nome
from tbVendas as vend
inner join tbProdutos as prod on prod.codProd = vend.codProd
inner join tbFornecedores as forn on forn.codForn = prod.codForn
inner join tbUsuarios as usu on vend.codusu	= usu.codUsu
inner join tbFuncionarios as func on usu.codFunc = func.codFunc
where vend.codProd = 1;



