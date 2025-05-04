-- Achieving first Normal Form
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);
INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- the normalized table
CREATE TABLE NormalizedProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);
CREATE TEMPORARY TABLE numbers (n INT);
INSERT INTO numbers (n)
VALUES (1), (2), (3), (4), (5);

INSERT INTO NormalizedProductDetail (OrderID, CustomerName, Product)
SELECT
  pd.OrderID,
  pd.CustomerName,
  TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pd.Products, ',', numbers.n), ',', -1)) AS Product
FROM ProductDetail pd
JOIN numbers ON CHAR_LENGTH(pd.Products) - CHAR_LENGTH(REPLACE(pd.Products, ',', '')) >= numbers.n - 1;

-- Achieving 2nd Normal Form
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

