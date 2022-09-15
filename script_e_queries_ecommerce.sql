-- criação de bando de dados

create database ecommerce;

use ecommerce;

-- criar tabelas cliente

create table clients(
	IdClient int auto_increment primary key,
    Cname varchar(10),
    CName_middle char (3),
    CName_last varchar (20),
    CIdentification char(11) not null,
    Adress varchar(30),
    Birth_date date,
    constraint unique_CPF_Client unique (CIdentification)
);
alter table Clients auto_increment=1;

desc Clients;
-- criar tabela produto

create table Product(
	IdProduct int auto_increment primary key,
    PDescription varchar(10) not null,
    PValue varchar(5),
    Category varchar(10)
);

-- criar tabela pedido

create table ProductOrder(
	IdProduct_Order int auto_increment primary key,
    IdOrderClient int,
    Order_Status enum('Cancelado','Confirmado','Em Processamento','Em Andamento','Enviado','Entregue') default 'Em Processamento',
    PDescription varchar(255),
    Shipping float default 10,
    PaymentCash boolean default false,
    constraint fk_OrderClient foreign key (IdOrderClient) references Clients(IdClient)
);

desc ProductOrder;
-- criar tabela de pagamento

create table Payments(
	IdClient int,
    IdPayment int,
    TypePayment enum('Boleto','Cartão','Dois Cartões'),
    LimitAvailable float,
    primary key(IdClient, IdPayment)
);

-- criar tabela estoque

create table Inventory(
	IdInventory int auto_increment primary key,
    InventoryLocal varchar(255),
    Amount int default 0
);

-- criar tabela fornecedor

create table Provider(
	IdProvider int auto_increment primary key,
    Social_Reason varchar (255) not null,
    Identification_Company char (14) not null,
    Contact_Provider char (11) not null,
    constraint Unique_Provider unique (Identification_Company)
);

-- criar tabela vendedor

create table ThirdPartySeller(
	IdThird_Party int auto_increment primary key,
    Social_Reason varchar (255) not null,
    ThirdPartySellerLocal varchar(255),
    TIdentification_Company char (14) not null,
    Contact char (11) not null,
    Fantasy_Name varchar (255),
    constraint Unique_Third unique (TIdentification_Company)
);

-- criar tabela produto/fornecedor

create table ProductFromProvider(
	IdPSupplier int,
    Product_IdProduct int,
    Amount int default 1,
    primary key (IdPSupplier, Product_IdProduct),
    constraint fk_Product_Supplier foreign key (IdPSupplier) references Provider(IdProvider),
    constraint fk_Product_Product foreign key (Product_IdProduct) references Product(IdProduct)
);

-- criar tabela produto de terceiro

create table Products_by_third_party_seller(
	ThirdPartySeller_IdThird_Party int,
    Product_IdProduct int,
    Amount int default 1,
    primary key (ThirdPartySeller_IdThird_Party,Product_IdProduct),
    constraint fk_Third foreign key (ThirdPartySeller_IdThird_Party) references ThirdPartySeller(IdThird_Party),
    constraint fk_Product_Product_Third foreign key (Product_IdProduct) references Product(IdProduct)
);

-- criar tabela produto/estoque

create table ProductWithInventory(
	Product_IdProduct int,
    Inventory_IdInventory int,
    Amount int default 1,
    primary key (Product_IdProduct,Inventory_IdInventory),
    constraint fk_Product_Third foreign key (Product_IdProduct) references Product(IdProduct),
    constraint fk_Inventory foreign key (Inventory_IdInventory) references Inventory(IdInventory)
);

-- criar tabela produto e pedido

create table ProductAndOrderRelationship(
	Product_IdProduct int,
    ProductOrder_IdProduct_Order int,
    R_Amount int default 1,
    R_Status enum('Disponível','Sem Estoque') default 'Disponível',
    primary key (Product_IdProduct,ProductOrder_IdProduct_Order),
    constraint fk_Product_Product_Relationship foreign key (Product_IdProduct) references Product(IdProduct),
    constraint fk_Order foreign key (ProductOrder_IdProduct_Order) references ProductOrder(IdProduct_Order)
);

-- Queries criadas

select count(*) from clients;
select * from clients c, ProductOrder p where IdClient=IdProduct_Order;

select Cname,CName_last,IdProduct_Order,Order_Status from clients c, ProductOrder p where IdClient=IdProduct_Order;

select concat(Cname,' ',CName_last) as Cliente,IdProduct_Order as ID_do_Produto,Order_Status as Status_do_Pedido from clients c, ProductOrder p where IdClient=IdProduct_Order;

select concat(Cname,' ',CName_last) as Cliente,IdProduct_Order as ID_do_Produto,Order_Status as Status_do_Pedido from clients c, ProductOrder p 
	where IdClient=IdProduct_Order
    group by Order_Status;

select * from clients left outer join ProductOrder on IdClient=IdProduct_Order;

select * from clients left outer join ProductOrder on IdClient=IdProduct_Order
	inner join Product;