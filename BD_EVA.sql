/* MER_LOG_BD1_normalizado_Daniel_Pittaro: */

Create database if not exists BD_EVA;
USE BD_EVA;

CREATE TABLE if not exists Artista (
    PK_Artista BIGINT auto_increment NOT NULL PRIMARY KEY,
    NOM_Artista VARCHAR(60) NOT NULL,
    CPF_Artista CHAR(14) not null,
    EML_Artista VARCHAR(255) not null,
    NOM_Artisitico VARCHAR(60),
    TEL_Artista SMALLINT(11) not null,
    UNIQUE (CPF_Artista,EML_Artista)
);

CREATE TABLE if not exists Comprador (
    PK_Comprador BIGINT auto_increment not null PRIMARY KEY,
    NOM_Comprador VARCHAR(60) not null,
    CPF_Comprador CHAR(14) not null,
    EML_Comprador VARCHAR(255) not null, 
    TEL_Comprador SMALLINT(11),
    UNIQUE (CPF_Comprador,EML_Comprador)
);

CREATE TABLE IF NOT EXISTS Usuario (
	ID_Usuario BIGINT auto_increment not null,
    FK_Artista BIGINT not null,
    FK_Comprador BIGINT not null,
    EML_Usuario varchar(255) not null,
    SEN_Usuario varchar(60) not null,
    primary key (ID_Usuario),
    unique(EML_Usuario)
);

CREATE TABLE IF NOT EXISTS Permissao (
	ID_Permissao smallint auto_increment not null,
    DESC_permissao varchar(100) not null, 
    primary key (ID_Permissao)
);

CREATE TABLE IF NOT EXISTS usuario_permissao (
    ID_Usuario BIGINT not null,
    ID_Permissao SMALLINT not null,
    primary key (ID_Usuario, ID_Permissao)
);

CREATE TABLE if not exists Associativa_Arte (
    PK_ArteArtrista BIGINT auto_increment not null PRIMARY KEY,
    FK_Artista BIGINT not null,
    FK_Arte BIGINT not null
);

CREATE TABLE if not exists Arte (
    ID_Arte BIGINT auto_increment not null PRIMARY KEY,
    FK_TipoArte TINYINT not null,
    NOM_Arte VARCHAR(60) UNIQUE not null ,
    DAT_Arte DATE not null,
    VAL_VendaArte DECIMAL(10,3) not null,
    EndArte varchar (1000) not null,
    TipoArte char(30)
);

CREATE TABLE if not exists CarrinhoVenda (
    PK_Venda BIGINT auto_increment not null PRIMARY KEY,
    FK_Comprador BIGINT not null,
    FK_TipoMoeda TINYINT not null,
    VAL_VendaArte decimal(10,3) not null,
    DAT_Venda DATE not null,
    Tipo_bandeiraCartao TINYINT not null,
    PAG_Boleto BOOLEAN not null,
    PAG_Cartao BOOLEAN not null
);

CREATE TABLE if not exists Endereco (
    PK_Endereco BIGINT auto_increment not null PRIMARY KEY,
    FK_Comprador BIGINT not null,
    FK_Artista BIGINT not null,
    FK_TipoEndereco TINYINT not null,
    Logradouro VARCHAR(100) not null,
    Complemento VARCHAR(10),
    LOC_Cidade VARCHAR(60) not null,
    UF CHAR(2) not null,
    Bairro VARCHAR(60) not null,
    CEP INT(8) not null 
);

CREATE TABLE if not exists Tipo_Endereco (
    PK_TipoEndereco TINYINT(2) not null PRIMARY KEY,
    DESC_Endereco VARCHAR(20) not null
);

CREATE TABLE if not exists Tipo_Moeda (
    PK_TipoMoeda TINYINT PRIMARY KEY,
    DESC_TipoMoeda VARCHAR(30)
);

CREATE TABLE if not exists Bandeira_cartao (
    PK_BandeiraCartao TINYINT PRIMARY KEY,
    NOM_BandeiraCartao VARCHAR(20)
);
 
ALTER TABLE Associativa_Arte ADD CONSTRAINT FK_Associativa_Arte_0
    FOREIGN KEY (FK_Artista)
    REFERENCES Artista (PK_Artista)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
 
ALTER TABLE Associativa_Arte ADD CONSTRAINT FK_Associativa_Arte_1
    FOREIGN KEY (FK_Arte)
    REFERENCES Arte (ID_Arte)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
 
ALTER TABLE CarrinhoVenda ADD CONSTRAINT FK_CarrinhoVenda_1
    FOREIGN KEY (FK_Comprador)
    REFERENCES Comprador (PK_Comprador)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
 
ALTER TABLE CarrinhoVenda ADD CONSTRAINT FK_CarrinhoVenda_3
    FOREIGN KEY (FK_TipoMoeda)
    REFERENCES Tipo_Moeda (PK_TipoMoeda)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
 
ALTER TABLE CarrinhoVenda ADD CONSTRAINT FK_CarrinhoVenda_4
    FOREIGN KEY (Tipo_bandeiraCartao)
    REFERENCES Bandeira_cartao (PK_BandeiraCartao)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
 
ALTER TABLE Endereco ADD CONSTRAINT FK_Endereco_0
    FOREIGN KEY (FK_Artista)
    REFERENCES Artista (PK_Artista)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
 
ALTER TABLE Endereco ADD CONSTRAINT FK_Endereco_1
    FOREIGN KEY (FK_Comprador)
    REFERENCES Comprador (PK_Comprador)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
 
ALTER TABLE Endereco ADD CONSTRAINT FK_Endereco_3
    FOREIGN KEY (FK_TipoEndereco)
    REFERENCES Tipo_Endereco (PK_TipoEndereco)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE Usuario 
	ADD	FOREIGN KEY (FK_Artista)
    references Artista (PK_Artista)
    on update restrict
    on delete restrict;
    
ALTER TABLE Usuario
	ADD FOREIGN KEY (FK_Comprador)
    references Comprador (PK_Comprador)
    on update restrict
    on delete restrict;

ALTER TABLE usuario_permissao
    ADD foreign key (ID_Usuario)
    references Usuario (ID_Usuario)
    on update restrict
    on delete restrict,
    ADD foreign key (ID_Permissao)
    references Permissao (ID_Permissao)
    on update restrict
    on delete restrict;

insert into permissao values (1,"ROLE_CADASTRAR_ARTE");
insert into permissao values (2,"ROLE_PESQUISAR_ARTE");
insert into permissao values (3,"ROLE_EXCLUIR_ARTE");