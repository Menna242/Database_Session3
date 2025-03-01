CREATE DATABASE OnlineShopping;

CREATE TABLE Customers(
     ID INT IDENTITY PRIMARY KEY,
	 Name NVARCHAR(100) NOT NULL,
	 Email VARCHAR(100) UNIQUE NOT NULL,
	 PhoneNum NVARCHAR(50) NOT NULL,
	 Address NVARCHAR(100) NOT NULL,

);

CREATE TABLE Orders(
     ID INT IDENTITY PRIMARY KEY,
	 OrderDate DateTime default GETUTCDATE(),
	 OrderStatus NVARCHAR(50) CHECK (OrderStatus IN('Pending','Shipped','Delivered'))
	 Default 'Pending',
	 TotalAmount INT NOT NULL,
	 CustomerID INT NOT NULL,
	 FOREIGN KEY (CustomerID) REFERENCES Customers(ID),
);

CREATE TABLE Suppliers(
     ID INT IDENTITY PRIMARY KEY,
	 Name NVARCHAR(100) NOT NULL,
	 ContactInfo NVARCHAR(100) NOT NULL,
);

CREATE TABLE Products(
     ID INT IDENTITY PRIMARY KEY,
	 Name NVARCHAR(100) NOT NULL,
	 Category VARCHAR(50)  NOT NULL,
	 Description NVARCHAR(100) NOT NULL,
	 Price Decimal(8,2) NOT NULL,

	 SupplierID INT NOT NULL,
	 FOREIGN KEY (SupplierID) REFERENCES Suppliers(ID),
	 
);

CREATE TABLE Order_Product(
	 OrderID INT NOT NULL ,
	 ProductID INT NOT NULL,
	 PRIMARY KEY(OrderID,ProductID),

	 FOREIGN KEY (OrderID) REFERENCES Orders(ID),
	 FOREIGN KEY (ProductID) REFERENCES Products(ID),

);

CREATE TABLE OrderDetails(
     ID INT IDENTITY PRIMARY KEY,
	 Quantity INT NOT NULL,
	 Price Decimal(8,2) NOT NULL,
	 
);

CREATE TABLE AssoiationPro_Order_DetailOrder(
	 OrderID INT NOT NULL ,
	 ProductID INT NOT NULL,
	 OrderDetailID INT NOT NULL,
	 PRIMARY KEY(OrderID,ProductID),

	 FOREIGN KEY (OrderID) REFERENCES Orders(ID),
	 FOREIGN KEY (ProductID) REFERENCES Products(ID),
	 FOREIGN KEY (OrderDetailID) REFERENCES OrderDetails(ID),

);
--/////////////////////////////////////////////////////////////////////////////////////////////

INSERT INTO Customers(Name,Email,PhoneNum,Address) VALUES
('Menna','Menna123@gmail.com','01209384948','Cairo'),
('Mohammed','Mohammed123@gmail.com','0127587392899','Giza');
SELECT* FROM Customers;
--////////////////////////////////////////////////////////////////


INSERT INTO Orders(OrderStatus,TotalAmount,CustomerID) VALUES
('Pending',3,1),
('Shipped',5,2);
SELECT* FROM Orders;
--////////////////////////////////////////////////////////////////


INSERT INTO Suppliers(Name,ContactInfo) VALUES
('malak','malak@gmail.com'),
('Anas','Anas123@gmail.com');
SELECT* FROM Suppliers;
--////////////////////////////////////////////////////////////////


INSERT INTO Products(Name,Category,Description,Price,SupplierID) VALUES
('bag','bags','very large',600,1),
('TV','Electronics,','modern',7000,2);
SELECT* FROM Products;
--////////////////////////////////////////////////////////////////

INSERT INTO Order_Product(OrderID,ProductID) VALUES
(1,1),
(1,2);
SELECT* FROM Order_Product;
--////////////////////////////////////////////////////////////////


INSERT INTO OrderDetails(Quantity,Price) VALUES
(3,600),
(4,7000);
SELECT* FROM OrderDetails;
--////////////////////////////////////////////////////////////////


INSERT INTO AssoiationPro_Order_DetailOrder(OrderID,ProductID,OrderDetailID) VALUES
(1,1,1),
(1,2,1);
SELECT* FROM AssoiationPro_Order_DetailOrder;
--/////////////////////////////////////////////////////////////////////////////////////////////
--//DDL
-- 1
Alter table Products
ADD Rating INT DEFAULT 0 ;

--2
ALTER TABLE Products
ADD DEFAULT 'new' FOR Category;


--3
-- To drop COLUMN Rating I should drop AssoiationPro_Order_DetailOrder,Order_Product 

Alter table Products
drop COLUMN Rating;


--//DML
--1
Update Orders
Set OrderDate= GetDate()
Where ID>0;

--2
--// TO delete from Products i should drop AssoiationPro_Order_DetailOrder ,Order_Product
--drop table AssoiationPro_Order_DetailOrder;
--drop table Order_Product;


DELETE FROM  Products
WHERE Name IS NOT NULL 
AND Name <> 'Null';

