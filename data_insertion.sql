-- Clients Product ProductOrder Payments Inventory Provider ThirdPartySeller ProductFromProvider Products_by_third_party_seller ProductWithInventory ProductAndOrderRelationship

-- Cname CName_middle CName_last CIdentification Adress Birth_date
insert into Clients (Cname, CName_middle, CName_last, CIdentification, Adress, Birth_date) values
	('Cliente1','A','Cliente12','00000000001','Rua 1','20000101'),
	('Cliente2','B','Cliente22','00000000002','Rua 2','20000102'),
	('Cliente3','C','Cliente32','00000000003','Rua 3','20000103');

-- PDescription PValue Category
insert into Product (PDescription, PValue, Category) values
	('Produto1',10,'Categoria1'),
    ('Produto2',20,'Categoria2'),
    ('Produto3',30,'Categoria3');

-- ProductOrder Order_Status PDescription Shipping PaymentCash
insert into ProductOrder(IdOrderClient, Order_Status, PDescription, Shipping, PaymentCash) values
	(1,'Cancelado',null,10,0),
    (2,'Confirmado','Produto 2',10,0),
    (3,default,null,20,0);

-- InventoryLocal Amount
insert into Inventory(InventoryLocal, Amount) values
	('Local1',10),
    ('Local2',20);

-- Social_Reason Identification_Company Contact_Provider
insert into Provider(Social_Reason, Identification_Company, Contact_Provider) values
	('Fornecedor1',00000000000001,00000000001),
    ('Fornecedor2',00000000000002,00000000002);

-- Social_Reason ThirdPartySellerLocal TIdentification_Company Contact Fantasy_Name
insert into ThirdPartySeller(Social_Reason, ThirdPartySellerLocal, TIdentification_Company, Contact, Fantasy_Name) values
	('Vendedor1','LocalVendedor1',00000000000003,00000000003,'FantasiaVendedor1'),
    ('Vendedor2','LocalVendedor2',00000000000004,00000000004,'FantasiaVendedor2');