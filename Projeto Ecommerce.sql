show databases;
-- drop database ecommerce;
create database ecommerce;

use ecommerce;


CREATE TABLE PessoaFisica (
idPF INT PRIMARY KEY AUTO_INCREMENT,
CPF char(11)
);

CREATE TABLE PessoaJuridica (
idPJ INT PRIMARY KEY AUTO_INCREMENT,
CNPJ char(15)
);


CREATE TABLE Cliente (
  idCliente INT PRIMARY KEY AUTO_INCREMENT,
  idCPF int,
  idCNPJ int,
  Nome VARCHAR(45) NOT NULL,
  Cep VARCHAR(10) NOT NULL,
  Endereco VARCHAR(45) NOT NULL,
  Fone VARCHAR(12) NULL,
  CONSTRAINT FK_cliente_pessoa_fisica FOREIGN KEY (idCPF) REFERENCES PessoaFisica(idPF),
  CONSTRAINT FK_cliente_pessoa_juridica FOREIGN KEY (idCNPJ) REFERENCES PessoaJuridica(idPJ)
  );

CREATE TABLE CategoriaProduto (
  idCategoriaProduto INT PRIMARY KEY AUTO_INCREMENT,
  Descricao VARCHAR(45) NOT NULL,
  Observacao VARCHAR(100) NOT NULL
  );

CREATE TABLE Produto (
  idProduto INT PRIMARY KEY AUTO_INCREMENT,
  Codigo VARCHAR(45) NOT NULL,
  Descricao VARCHAR(45) NOT NULL,
  Unidade VARCHAR(5) NOT NULL,
  Peso FLOAT NOT NULL,
  Preco FLOAT NOT NULL,
  idCProduto integer NOT NULL,
  CONSTRAINT fk_Produto_CategoriaProduto FOREIGN KEY (idCProduto) REFERENCES CategoriaProduto(idCategoriaProduto)
  );

CREATE TABLE FormaPagamento (
  idFormaPagamento INT PRIMARY KEY AUTO_INCREMENT,
  Descricao VARCHAR(45) NOT NULL
  );

CREATE TABLE ClienteFormaPagamento (
  idClienteFormaPagamento INT PRIMARY KEY AUTO_INCREMENT,
  idCliente integer NOT NULL,
  idFormaPagamento integer NOT NULL,
  Numero VARCHAR(45) NOT NULL,
  Validade DATE NOT NULL,
  Nome VARCHAR(45) NULL,
  CONSTRAINT fk_ClienteFormaPagamento_Cliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
  CONSTRAINT fk_ClienteFormaPagamento_FormaPagamento FOREIGN KEY (idFormaPagamento) REFERENCES FormaPagamento (idFormaPagamento)
  );

CREATE TABLE Pedido (
  idPedido INT PRIMARY KEY AUTO_INCREMENT,
  DataPedido time,
  Descricao VARCHAR(45) NOT NULL,
  idCliente integer NOT NULL,
  CodigoRastreio VARCHAR(45) NOT NULL,
  idClienteFormaPagamento integer NOT NULL,
  CONSTRAINT fk_Pedido_Cliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
  CONSTRAINT fk_Pedido_ClienteFormaPagamento FOREIGN KEY (idClienteFormaPagamento) REFERENCES ClienteFormaPagamento (idClienteFormaPagamento)
  );

CREATE TABLE StatusTipo (
  idStatusTipo INT PRIMARY KEY AUTO_INCREMENT,
  Descricao VARCHAR(45) NOT NULL
  );

CREATE TABLE Fornecedor (
  idFornecedor INT PRIMARY KEY AUTO_INCREMENT,
  Cnpj VARCHAR(20) NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  Cep VARCHAR(10) NOT NULL,
  Endereco VARCHAR(45) NOT NULL,
  Fone VARCHAR(12) NOT NULL,
  Email VARCHAR(45) NOT NULL
  );

CREATE TABLE FornecedorProduto (
  idFornecedor INT NOT NULL,
  idProduto INT NOT NULL,
  PRIMARY KEY (idFornecedor, idProduto),
  CONSTRAINT fk_FornecedorProduto_Fornecedor FOREIGN KEY (idFornecedor) REFERENCES Fornecedor (idFornecedor),
  CONSTRAINT fk_FornecedorProduto_Produto FOREIGN KEY (idProduto) REFERENCES Produto (idProduto)
    );

CREATE TABLE Estoque (
  idEstoque INT PRIMARY KEY AUTO_INCREMENT,
  Localizacao VARCHAR(45) NOT NULL
  );

CREATE TABLE ProdutoEstoque (
  idProduto INT NOT NULL,
  idEstoque INT NOT NULL,
  Quantidade FLOAT NOT NULL,
  PRIMARY KEY (idProduto, idEstoque),
  CONSTRAINT fk_ProdutoEstoque_Produto FOREIGN KEY (idProduto) REFERENCES Produto (idProduto),
  CONSTRAINT fk_ProdutoEstoque_Estoque FOREIGN KEY (idEstoque) REFERENCES Estoque (idEstoque)
    );

CREATE TABLE StatusPedido (
  idStatusTipo integer NOT NULL,
  idPedido integer NOT NULL,
  Data time,
  PRIMARY KEY (idStatusTipo, idPedido, Data), 
  CONSTRAINT fk_StatusPedido_Status FOREIGN KEY (idStatusTipo) REFERENCES StatusTipo (idStatusTipo),
  CONSTRAINT fk_StatusPedido_Pedido FOREIGN KEY (idPedido) REFERENCES Pedido (idPedido)
  );

CREATE TABLE Terceiro (
  idTerceiro INT PRIMARY KEY AUTO_INCREMENT,
  Cnpj VARCHAR(15) NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  Cep VARCHAR(12) NOT NULL,
  Endereco VARCHAR(45) NOT NULL,
  Fone VARCHAR(12) NOT NULL,
  Email VARCHAR(45) NOT NULL
  );

CREATE TABLE TerceiroProduto (
  idTerceiroProduto INT PRIMARY KEY AUTO_INCREMENT,
  idTerceiro INT NOT NULL,
  idProduto INT NOT NULL,
  Quantidade FLOAT NOT NULL,
  idTerceiroEntrega integer NOT NULL,
  CONSTRAINT fk_TerceiroProduto_Terceiro FOREIGN KEY (idTerceiro) REFERENCES Terceiro (idTerceiro),
  CONSTRAINT fk_TerceiroProduto_Produto FOREIGN KEY (idProduto) REFERENCES Produto (idProduto)
    );

CREATE TABLE PedidoTerceiroProduto (
  idPedidoTerceiroProduto INT PRIMARY KEY AUTO_INCREMENT,
  idTerceiroProduto INT NOT NULL,
  idPedido INT NOT NULL,
  Quantidade FLOAT NOT NULL,
  Preco FLOAT NOT NULL,
  Frete FLOAT NOT NULL,
  DataPrevistaEntrega DATE NOT NULL,
  DataEntrega DATE NOT NULL,
  PRIMARY KEY (idPedidoTerceiroProduto),
  CONSTRAINT fk_PedidoTerceiroProduto_TerceiroProduto FOREIGN KEY (idTerceiroProduto) REFERENCES TerceiroProduto(idTerceiroProduto),
  CONSTRAINT fk_PedidoTerceiroProduto_Pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
    );

CREATE TABLE PedidoTerceiroProdutoStatus (
  idPedidoTerceiroProduto INT NOT NULL,
  idStatusTipo INT NOT NULL,
  Data time,
  PRIMARY KEY (idPedidoTerceiroProduto, idStatusTipo, Data),
  CONSTRAINT fk_PedidoTerceiroProdutoStatus_PedidoTerceiroProduto FOREIGN KEY (idPedidoTerceiroProduto) REFERENCES PedidoTerceiroProduto (idPedidoTerceiroProduto),
  CONSTRAINT fk_PedidoTerceiroProdutoStatus_Status FOREIGN KEY (idStatusTipo) REFERENCES StatusTipo (idStatusTipo)
    );
