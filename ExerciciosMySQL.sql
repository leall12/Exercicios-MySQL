-- EXERCÍCIOS 11
-- drop database dbdistribuidora;

create database dbDistribuidora;
use dbDistribuidora;

create table tbCliente(
Id int primary key auto_increment,
NomeCli varchar(200) not null,
NumEnd decimal(6,0) not null,
CompEnd varchar(50) null,
CepCli decimal(8,0) null
) auto_increment=1;

create table tbCliente_pf(
CPF decimal(11,0) primary key,
Rg decimal(9,0) not null,
Rg_dig char(1) not null,
Nasc date not null,
Id int
);

create table tbCliente_pj(
CNPJ decimal(14,0) primary key,
IE decimal(11,0) null unique,
Id int
);

create table tbEndereco(
CEP decimal(8,0) primary key ,
Logradouro varchar(200) not null,
BairroId int not null,
CidadeId int not null,
UFId int not null
);

create table tbBairro(
BairroId int primary key auto_increment,
Bairro varchar(200) not null unique
)auto_increment=1; 

create table tbCidade(
CidadeId int primary key auto_increment,
Cidade varchar(200) not null unique
)auto_increment=1;

create table tbEstado(
UFId int primary key auto_increment,
UF char(2) not null unique
)auto_increment=1;

create table tbVenda(
NumeroVenda int primary key,
DataVenda date not null,
TotalVenda decimal(8,2) not null,
Id_Cli int not null,
NF int
);

create table tbNota_fiscal(
NF int primary key,
TotalNota decimal(8,2) not null,
DataEmissao date not null
);

create table tbItemVenda(
NumeroVenda int,
CodigoBarras decimal (14,0),
ValorItem decimal(8,2) not null,
Qtd int not null,
constraint primary key (NumeroVenda, CodigoBarras)
);

create table tbProduto(
CodigoBarras decimal (14,0) primary key,
Nome varchar(200) not null, 
Valor decimal(8,2) not null,
Qtd int null
);

create table tbItemCompra(
NotaFiscal int,
CodigoBarras decimal(14,0),
ValorItem decimal(8,2) not null,
Qtd int not null,
constraint primary key (NotaFiscal, CodigoBarras)
);

create table tbCompra(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal(8,2) not null,
QtdTotal int not null,
Codigo int 
);

create table tbFornecedor(
Codigo int primary key auto_increment,
CNPJ decimal (14,0) null unique,
Nome varchar(200) not null,
Telefone decimal(11,0) null
) auto_increment=1;

-- Criando as foreign keys

alter table tbCliente_pf add constraint Fk_Id_Clientepf foreign key (Id) references tbCliente(Id);
alter table tbCliente_pj add constraint Fk_Id_Clientepj foreign key (Id) references tbCliente(Id);
alter table tbCliente add constraint Fk_Cep_Cliente foreign key (CepCli) references tbEndereco(CEP);
alter table tbEndereco add constraint Fk_Id_Bairro foreign key (BairroId) references tbBairro(BairroId);
alter table tbEndereco add constraint Fk_Id_Cidade foreign key (CidadeId) references tbCidade(CidadeId);
alter table tbEndereco add constraint Fk_Id_UF foreign key (UFId) references tbEstado(UFId);
alter table tbVenda add constraint Fk_IdCli_Venda foreign key (Id_Cli) references tbCliente(Id);
alter table tbVenda add constraint Fk_NF_Venda foreign key (NF) references tbNota_Fiscal(NF);
alter table tbItemVenda add constraint Fk_NumeroVenda_itemVenda foreign key (NumeroVenda) references tbVenda(NumeroVenda);
alter table tbItemVenda add constraint Fk_CodigoBarras_ItemVenda foreign key (CodigoBarras) references tbProduto(CodigoBarras);
alter table tbItemCompra add constraint Fk_CodigoBarras_ItemCompra foreign key (CodigoBarras) references tbproduto(CodigoBarras);
alter table tbitemCompra add constraint fk_NotaFiscal_ItemCompra foreign key (NotaFiscal) references tbCompra(NotaFiscal);
alter table tbCompra add constraint fk_Codigo_compra foreign key (Codigo) references tbFornecedor(Codigo);


-- Inserindo a partir das Procs Criadas
-- EXE1 - inserindo dados com a proc do tbfornecedor
DELIMITER $$
create procedure sp_Insert_Fornecedor(vCNPJ decimal(14,0), vNome varchar(200), vTelefone decimal(11,0))
BEGIN
insert into tbFornecedor (CNPJ, Nome, Telefone) values (vCNPJ, vNome, vTelefone);
END $$

call sp_Insert_Fornecedor(1245678937123, 'Revenda Chico Loco', 11934567897);
call sp_Insert_Fornecedor(1345678937123, 'José Faz Tudo S/A', 11934567898);
call sp_Insert_Fornecedor(1445678937123, 'Vadalto Entregas', 11934567899);
call sp_Insert_Fornecedor(1545678937123, 'Astrogildo das Estrela', 11934567890);
call sp_Insert_Fornecedor(1645678937123, 'Amoroso e Doce', 11934567891);
call sp_Insert_Fornecedor(1745678937123, 'Marcelo Dedal', 11934567892);
call sp_Insert_Fornecedor(1845678937123, 'Franciscano Cachaça', 11934567893);
call sp_Insert_Fornecedor(1945678937123, 'Joãozinho Chupeta', 11934567894);

--  EXE2 - inserindo dados com a proc do tbCidade

create procedure sp_Insert_Cidade(vNomeCidade varchar(200))
BEGIN
	insert into tbCidade (Cidade) values(vNomeCidade);
END $$

call sp_Insert_Cidade('Rio de Janeiro');
call sp_Insert_Cidade('São Carlos');
call sp_Insert_Cidade('Campinas');
call sp_Insert_Cidade('Franco da Rocha');
call sp_Insert_Cidade('Osasco');
call sp_Insert_Cidade('Pirituba');
call sp_Insert_Cidade('Lapa');
call sp_Insert_Cidade('Ponta Grossa');

-- EXE3 - inserindo dados com a proc do tbEstado

create procedure sp_Insert_Estado (vNomeEstado char(2))
BEGIN
insert into tbEstado (UF) values(vNomeEstado);
END $$

call sp_Insert_Estado('SP');
call sp_Insert_Estado('RJ');
call sp_Insert_Estado('RS');

-- EXE4 - inserindo dados com a proc do tbBairro

create procedure sp_Insert_Bairro(vNomeBairro varchar(200))
BEGIN
insert into tbBairro (Bairro) values (vNomeBairro);
END $$

call sp_Insert_Bairro('Aclimação');
call sp_Insert_Bairro('Capão Redondo');
call sp_Insert_Bairro('Pirituba');
call sp_Insert_Bairro('Liberdade');

-- EXE5 - inserindo dados com a proc do tbProduto

create procedure sp_Insert_Produto(vCodigoBarras decimal(14,0), vNome varchar(200), vValor decimal(8,2), vQtd int)
BEGIN
	insert into tbProduto(CodigoBarras, Nome, Valor, Qtd) values(vCodigoBarras, vNome, vValor, vQtd);
END $$

call sp_Insert_Produto(12345678910111, 'Rei de Papel Mache', 54.61, 120);
call sp_Insert_Produto(12345678910112, 'Bolinha de Sabão', 100.45, 120);
call sp_Insert_Produto(12345678910113, 'Carro Bate', 44.00, 120);
call sp_Insert_Produto(12345678910114, 'Bola Furada', 10.00, 120);
call sp_Insert_Produto(12345678910115, 'Maça Laranja', 99.44, 120);
call sp_Insert_Produto(12345678910116, 'Boneco do Hitler', 124.00, 200);
call sp_Insert_Produto(12345678910117, 'Farinha de Suruí', 50.00, 200);
call sp_Insert_Produto(12345678910118, 'Zelador de Cemitério', 42.50, 100);

select * from tbProduto;

-- EXE6 - inserindo dados com a proc do tbEndereco / ver com o professor dados que estão incorretos
	

create procedure sp_Insert_Endereco(vCEP decimal(8,0), vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF char(2))
BEGIN

	declare vBairroId int;
    declare vCidadeId int;
    declare vUFId int;
    
	if(not exists (select BairroId from tbBairro where Bairro = vBairro)) then
		insert into tbBairro (Bairro) values(vBairro);
    End if;
    
    set vBairroId = (select BairroId from tbBairro where Bairro = vBairro);
    
    if(not exists (select CidadeId from tbCidade where Cidade = vCidade)) then
		insert into tbCidade (Cidade) values(vCidade);
    End if;
    
	set vCidadeId = (select CidadeId from tbCidade where Cidade = vCidade);
    
	if(not exists (select UFId from tbEstado where Uf = vUF)) then
		insert	into tbEstado (UF) values(vUF);
    end if;
	
    set vUFId = (select UFId from tbEstado where UF = vUF);
    
    if(not exists (select CEP from tbEndereco where CEP = vCEP)) then
		insert into tbEndereco (CEP, Logradouro, BairroId, CidadeId, UFId) values(vCEP, vLogradouro, vBairroId, vCidadeId, vUFId);
	end if;
    
END $$

call sp_Insert_Endereco(12345050, 'Rua da Federal', 'Lapa', 'São Paulo', 'SP');
call sp_Insert_Endereco(12345051, 'Av Brasil', 'Lapa', 'Campinas', 'SP');
call sp_Insert_Endereco(12345052, 'Rua Liberdade', 'Consolação', 'São Paulo', 'SP');
call sp_Insert_Endereco(12345053, 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call sp_Insert_Endereco(12345054, 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
call sp_Insert_Endereco(12345055, 'Rua Piu XI', 'Penha', 'Campinas', 'SP');
call sp_Insert_Endereco(12345056, 'Rua Chocolate', 'Aclimação', 'Barra Mansa', 'RJ');
call sp_Insert_Endereco(12345057, 'Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa', 'RS');
call sp_Insert_Endereco(12345112, 'Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa', 'RS');

-- EXE7 - inserindo dados dos Clientes (PF) com a proc

create procedure sp_Insert_ClientePf(vCEP decimal(8,0), vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF char(2), vNomeCli varchar(200), vNumEnd decimal(6,0), vCompEnd varchar(50), vCPF decimal(11,0), vRG decimal(9,0), vRg_dig char(1), vNasc date)
BEGIN

    call sp_Insert_Endereco(vCEP, vLogradouro, vBairro, vCidade, vUF);

    insert into tbCliente(NomeCli, NumEnd, CompEnd, CepCli) 
			values (vNomeCli, vNumEnd, vCompEnd, (select CEP from tbEndereco where CEP = vCEP));

    set @ClienteId = LAST_INSERT_ID();

    insert into tbCliente_pf(CPF, RG, Rg_dig, Nasc, Id) 
			values (vCPF, vRG, vRg_dig, vNasc, @ClienteId);
END $$

call sp_Insert_ClientePf(12345051, 'Av Brasil', 'Lapa', 'Campinas', 'SP', 'Pimpão', 325, Null, 12345678911, 12345678, '0', '2000-10-12');
call sp_Insert_ClientePf(12345053, 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ', 'Disney Chaplin', 89, 'Ap. 12', 12345678912, 12345679, '0', '2001-11-21');
call sp_Insert_ClientePf(12345054, 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ', 'Marciano', 774, Null, 12345678913, 12345680, '0', '2001-06-01');
call sp_Insert_ClientePf(12345059, 'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT', 'Lança Perfume', 128, Null, 12345678914, 12345681, 'X', '2004-04-05');
call sp_Insert_ClientePf(12345058, 'Av Nova', 'Jardim Santa Isabel', 'Cuiabá', 'MT', 'Remédio Antigo', 2585 , Null, 12345678915, 12345682, '0', '2002-07-15');

-- EXE8 - inserindo dados dos clientes (PJ) com a proc
create procedure sp_Insert_ClientePj(vNomeCli varchar(200), vCNPJ decimal(14,0), vIE decimal(11,0), vCEP decimal(8,0), vLogradouro varchar(200), vNumEnd decimal(6,0), vCompEnd varchar(50), vBairro varchar(200), vCidade varchar(200), vUF char(2))
BEGIN
	call sp_Insert_Endereco(vCEP, vLogradouro, vBairro, vCidade, vUF);
    
        insert into tbCliente(NomeCli, NumEnd, CompEnd, CepCli) 
			values (vNomeCli, vNumEnd, vCompEnd, (select CEP from tbEndereco where CEP = vCEP));
            
            set @ClienteID = last_insert_id();
            
		insert into tbCliente_pj(CNPJ, IE, Id)
			values(vCNPJ, vIE, @ClienteID);
    
END $$

call sp_Insert_ClientePj('Paganada', 12345678912345, 98765432198, 12345051, 'Av Brasil', 159, Null, 'Lapa', 'Campinas', 'SP');
call sp_Insert_ClientePj('Caloteando', 12345678912346, 98765432199, 12345053, 'Av Paulista', 69, Null, 'Penha', 'Rio de Janeiro', 'RJ');
call sp_Insert_ClientePj('Sem Grana', 12345678912347, 98765432100, 12345060, 'Rua dos Amores', 189, Null, 'Sei Lá', 'Recife', 'PE');
call sp_Insert_ClientePj('Cemreais', 12345678912348, 98765432101, 12345060, 'Rua dos Amores', 5024, 'Sala 23', 'Sei Lá', 'Recife', 'PE');
call sp_Insert_ClientePj('Durango', 12345678912349, 98765432102, 12345060, 'Rua dos Amores', 1254, Null, 'Sei Lá', 'Recife', 'PE');

-- EXE9 - inserindo dados das compras (tbCompra) com a proc
create procedure sp_Insert_Compra(vNotaFiscal int, vFornecedor varchar(200), vDataCompra varchar(10), vCodigoBarras decimal(14,0), vValor decimal(8,2), vQtd int, vQtdTotal int, vValorTotal decimal(8,2))
BEGIN

    
    if exists (select Codigo from tbFornecedor where Nome = vFornecedor) and exists (select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras) then
     	if not exists (select NotaFiscal from tbCompra where NotaFiscal = vNotaFiscal) then
			insert into tbCompra (NotaFiscal, DataCompra, Codigo, QtdTotal, ValorTotal)
						values (vNotaFiscal, STR_TO_DATE(vDataCompra, '%d/%m/%Y'),(select Codigo from tbFornecedor where Nome = vFornecedor), vQtdTotal, vValorTotal);
	end if;

	insert into tbItemCompra (NotaFiscal, CodigoBarras, ValorItem, Qtd)
						values (vNotaFiscal, vCodigoBarras, vValor, vQtd);

    end if;
END $$

call sp_Insert_Compra(8459, 'Amoroso e Doce', '01/05/2018', 12345678910111, 22.22, 200, 700, 21944.00);
call sp_Insert_Compra(2482, 'Revenda Chico Loco', '22/04/2020', 12345678910112, 40.50, 180, 180, 7290.00);
call sp_Insert_Compra(21563, 'Marcelo Dedal', '12/07/2020', 12345678910113, 3.00, 300, 300, 900.00);
call sp_Insert_Compra(8459, 'Amoroso e Doce', '01/05/2018', 12345678910114, 35.00, 500, 700, 21944.00);
call sp_Insert_Compra(156354, 'Revenda Chico Loco', '23/11/2021', 12345678910115, 54.00, 350, 350, 18900.00);

-- EXE10 - Inserindo dados na tbVenda com a proc
create procedure sp_Insert_Venda(vNumeroVenda int, vCliente varchar(200), vCodigoBarras decimal(14,0), vQtd int)
BEGIN
	declare ClienteId int;
    declare ValorItem decimal(8,2);
    declare TotalVenda decimal(10,2);
	
    set ClienteId = (select Id from tbCliente where NomeCli = vCliente);
	set ValorItem = (select Valor from tbProduto where CodigoBarras = vCodigoBarras);
    set TotalVenda = ((select Valor from tbProduto where CodigoBarras = vCodigoBarras) * vQtd);
    
	if exists (select Id from tbCliente where NomeCli = vCliente) and exists (select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras) then
		
            insert into tbVenda(NumeroVenda, DataVenda, TotalVenda, Id_Cli)
				values(vNumeroVenda, current_date() , TotalVenda, ClienteId);
                
			insert into tbItemVenda (NumeroVenda, CodigoBarras, ValorItem, Qtd)
				values(vNumeroVenda, vCodigoBarras, ValorItem, vQtd);
        end if;
        
END $$

call sp_Insert_Venda(1, 'Pimpão', 12345678910111, 1);
call sp_Insert_Venda(2, 'Lança Perfume', 12345678910112, 2);
call sp_Insert_Venda(3, 'Pimpão', 12345678910113, 1);

-- EXE11 - Inserindo as notas Fiscais
create procedure sp_Insert_NF(vNotaFiscal int, vCliente varchar(200))
BEGIN
	declare ClienteId int;
    declare vTotalNota decimal(8,2);
    
	set ClienteId = (select Id from tbCliente where NomeCli = vCliente);
     set vTotalNota = (select sum(TotalVenda) from tbVenda where Id_Cli = ClienteId);

	if exists (select Id_Cli from tbVenda where Id_Cli = ClienteId) then
		insert into tbNota_Fiscal(NF, DataEmissao, TotalNota)
				values(vNotaFiscal, current_date(), vTotalNota);
	end if;
END $$

call sp_Insert_NF(359, 'Pimpão');

-- EXE12 - Inserindo mais produtos
call sp_Insert_Produto(12345678910130, 'Camisa de Poliéster', 35.61, 100);
call sp_Insert_Produto(12345678910131, 'Blusa Frio Moletom', 200.00, 100);
call sp_Insert_Produto(12345678910132, 'Vestido Decote Redondo', 144.00, 50);

-- EXE13 = Deletando produtos por meio de uma Proc
create procedure sp_Delete_Produto(vCodigoBarras decimal(14,0))
BEGIN
	delete from tbProduto where CodigoBarras = vCodigoBarras;
END $$

call sp_Delete_Produto(12345678910116);
call sp_Delete_Produto(12345678910117);

-- EXE14 - fazendo update na tbProduto com a proc

create procedure sp_Update_Produto(vCodigoBarras decimal(14,0), vNomeNovo varchar(200), vValorNovo decimal(8,2))
BEGIN
	update tbProduto set Nome = vNomeNovo, Valor = vValorNovo where CodigoBarras = vCodigoBarras;
END $$

call sp_Update_Produto(12345678910111, 'Rei de Papel Mache', 64.50);
call sp_Update_Produto(12345678910112, 'Bolinha de Sabão', 120.00);
call sp_Update_Produto(12345678910113, 'Carro Bate Bate', 64.00);

-- EXE15 - Mostrando a tbProduto por meio da proc
create procedure sp_Show_Produto()
BEGIN
	select * from tbProduto;
END $$

call sp_Show_Produto();

-- EXE16 - criando a tabela para armazenar o histórico	
create table tbProduto_Historico like tbProduto;

-- EXE17 adicionando os campos na tabela
alter table tbProduto_Historico add column Ocorrencia varchar(20) null;
alter table tbProduto_Historico add column  Atualizacao datetime null;

-- EXE18 - modificando a chave primária da tabela tbProduto_Historico
alter table tbProduto_Historico drop primary key, add primary key (CodigoBarras, Ocorrencia, Atualizacao);

-- EXE19 - Executando o insert para verificar o Gatilho
create trigger Insert_ProdutoHistorico after insert on tbProduto for each row
BEGIN
	insert into tbProduto_Historico(CodigoBarras, Nome, Valor, Qtd, Ocorrencia, Atualizacao) 
				values(new.CodigoBarras, new.Nome, new.Valor, new.Qtd, 'Novo', now());
END $$

call sp_Insert_Produto(12345678910119, 'Água Mineral', 1.99, 500);

-- EXE20 - Executando o update para verificar o gatilho
create trigger Update_ProdutoHistorico after update on tbProduto for each row
BEGIN
	insert into tbProduto_Historico(CodigoBarras, Nome, Valor, Qtd, Ocorrencia, Atualizacao)
				values (new.CodigoBarras, new.Nome, new.Valor, new.Qtd, 'Atualização', now());
END $$

call sp_Update_Produto(12345678910119, 'Água Mineral', 2.99);

-- EXE21 - selecionando todos os registros da tabela produto
select * from tbProduto;

-- EXE22 - 
call sp_Insert_Venda(4, 'Disney Chaplin', 12345678910111, 1);

-- EXE23 - realizando consulta na tabela venda
select * from tbVenda order by DataVenda desc limit 1;

-- order by: ordena em ordem decrescente e crescente
-- limit: limita a uma quantidade x de linhas

-- EXE24 - realizando consulta na tabela itemVenda
select * from tbItemVenda order by NumeroVenda desc limit 1;

-- EXE25 - proc de selecionar clientes
create procedure sp_Select_Cliente(vNomeCli varchar(200))
BEGIN 
	select * from tbCliente where NomeCli = vNomeCli;
END $$

call sp_Select_Cliente('Disney Chaplin');

-- EXE26 - Trigger do exe 26
-- drop trigger Update_Qtd_Venda;
create trigger Update_Qtd_Venda after insert on tbItemVenda for each row
BEGIN
	set @QtdTotal = (select Qtd from tbProduto where CodigoBarras = new.CodigoBarras);
	set @QtdVenda = (select Qtd from tbItemVenda where NumeroVenda = new.NumeroVenda and CodigoBarras = new.CodigoBarras);
    
    set sql_safe_updates=0;
    update tbProduto set Qtd = (@QtdTotal - @QtdVenda) where CodigoBarras = new.CodigoBarras;
	set sql_safe_updates=1;
END $$

-- EXE27 - adicionando venda para o paganada
call sp_Insert_Venda(5, 'Paganada', 12345678910114, 15);

-- EXE28 - selecionando a tabela produto
call sp_Show_Produto();

-- EXE29 - criando trigger de insert na tbCompra para adicionar a quantidade de produtos
-- drop trigger Update_Qtd_Compra;
create trigger Update_Qtd_Compra after insert on tbItemCompra for each row
BEGIN
	set @QtdProduto = (select Qtd from tbProduto where CodigoBarras = new.CodigoBarras);
	set @QtdCompra = (select Qtd from tbItemCompra where CodigoBarras = new.CodigoBarras and NotaFiscal = new.NotaFiscal);
    
    set sql_safe_updates=0;
    update tbProduto set Qtd = (@QtdProduto + @QtdCompra) where CodigoBarras = new.CodigoBarras;
	set sql_safe_updates=1;
END $$

-- EXE30 - inserindo registro para testar o gatilho Update_Qtd_Compra
call sp_Insert_Compra(10548, 'Amoroso e Doce', '10/09/2022', 12345678910111, 40.00, 100, 100, 4000.00);

-- EXE31 - Consultando tabela de produtos para verificar o gatilho
call sp_Show_Produto();

-- EXE32 - selecionando os dados das tbCliente_pf e tbCliente por meio do Inner Join
select * from tbCliente inner join tbCliente_pf on tbCliente.Id = tbCliente_pf.Id;

-- EXE33 - Mostrando todos os dados da ClientePj com o inner join
select * from tbCliente inner join tbCliente_pj on tbCliente.Id = tbCliente_pj.Id;

-- EXE34 - Mostrando os dados solicitados de cada tabela
select tbCliente.Id, NomeCli, CNPJ, IE, tbCliente_pj.Id from tbCliente inner join tbCliente_pj on tbCliente.Id = tbCliente_pj.Id;

-- EXE35 - Mostrando e alterando o nome dos dados com o inner join
select tbCliente.Id as 'Código', NomeCli as 'Nome', CPF, RG, Nasc as 'Data de Nascimento' from tbCliente inner join tbCLiente_pf on tbCliente.Id = tbCliente_pf.Id;

-- EXE36 - Mostrando com Inner Join
select tbCliente.Id, NomeCli, NumEnd, CompEnd, CEP, CNPJ, IE, tbCliente_pj.Id, Logradouro, BairroId as Bairro, CidadeId as Cidade, UFId as UF, CEP from tbCliente inner join tbCliente_pj on tbCliente.id = tbCliente_pj.Id inner join tbEndereco on tbCliente.CEPCli = tbEndereco.CEP;

-- EXE37 - Selecionando atributos e mostrando eles
select tbCliente_pj.Id, NomeCli, tbCliente.CEPCli, Logradouro, NumEnd, CompEnd,
(select Bairro from tbBairro where BairroId = tbEndereco.BairroId) as Bairro,
(select Cidade from tbCidade where CidadeId = tbEndereco.CidadeId) as Cidade,
(select UF from tbEstado where UFId = tbEndereco.UFId) as UF from tbCliente inner join tbCliente_pj on tbCliente.Id = tbCliente_pj.Id
 inner join tbEndereco on tbCliente.CepCli = tbEndereco.CEP;
 
 -- EXE38 - Proc selectPessoaId
 create procedure sp_Select_PessoaPfId(vId int)
 BEGIN 

select tbCliente_pf.Id as Código, NomeCli as Nome, CPF, RG, Rg_dig as "Digíto", Nasc as 'Data de Nascimento', tbCliente.CEPCli, Logradouro, NumEnd, CompEnd, (select Bairro from tbBairro where BairroId = tbEndereco.BairroId) as 'Bairro',(select Cidade from tbCidade where CidadeId = tbEndereco.CidadeId) as 'Cidade', (select UF from tbEstado where UFId = tbEndereco.UFId) as 'UF'from tbCliente inner join tbCliente_pf on tbCliente.Id = tbCliente_pf.Id inner join tbEndereco on tbCliente.CepCli = tbEndereco.CEP where tbCliente.Id = vId;
 END $$
 
 -- testando a Proc
call sp_Select_PessoaPfId(2);
call sp_Select_PessoaPfId(5);

-- EXE39 - Selecionando os itens vendidos e os produtos
select tbProduto.*, tbItemVenda.Qtd, tbItemVenda.ValorItem, tbItemVenda.CodigoBarras, NumeroVenda from tbProduto left join tbitemVenda on tbProduto.CodigoBarras = tbItemVenda.CodigoBarras or tbItemVenda.CodigoBarras = null;
-- Left Join = Retorna todos os registros da tabela esquerda e os registros correspondentes da tabela direita.

-- EXE40 - Fazendo a seleção das Compras com Fornecedores 
select tbCompra.*, tbFornecedor.* from tbCompra right join tbFornecedor on tbCompra.Codigo = tbFornecedor.Codigo;

-- EXE41 - selecionando os fornecedore que não nos venderam nada
select tbFornecedor.* from tbCompra right join tbFornecedor on tbCompra.Codigo = tbFornecedor.Codigo where tbCompra.Codigo is null;

-- EXE42 - select para descobrir os clientes que nunca compraram nada
select tbCliente.Id, tbCliente.NomeCli, tbVenda.DataVenda, tbItemVenda.CodigoBarras,(Select Nome from tbProduto where CodigoBarras = tbItemVenda.CodigoBarras) as Nome, ValorItem from tbCliente inner join tbVenda on tbCliente.Id = tbVenda.Id_Cli inner join tbItemVenda on tbVenda.NumeroVenda = tbItemVenda.NumeroVenda order by NomeCli asc;

-- EXE43
select tbBairro.Bairro from tbBairro left join tbEndereco on tbBairro.BairroId = tbEndereco.BairroId left join tbCliente on tbEndereco.Cep = tbCliente.CepCli left join tbVenda on tbCliente.Id = tbVenda.Id_Cli where tbVenda.NumeroVenda = tbCliente.Id;


-- EXE44 = 
create view vw_Fornecedor as select Codigo, Nome, Telefone from tbFornecedor;

select * from vw_Fornecedor;

-- EXE45 - 
create view vw_NomeTel_Fornecedor as select Nome, Telefone from tbFornecedor;
select * from vw_NomeTel_Fornecedor;

-- EXE46 - 