USE coffee;
-- From Customers : Customer name, Email, Country, 
-- From Products : Coffee type, Roast type, Size, Unit Price & Sales
CREATE TABLE order_details_summary AS
SELECT
o.Order_ID,
o.Order_Date,
o.Customer_ID,
o.Product_ID,
o.Quantity,
c.Customer_Name,
c.Email,
c.Country,
p.Coffee_Type,
p.Roast_Type,
CONCAT(p.size, ' KG') as Size,
p.Unit_Price,
ROUND(o.Quantity * p.Unit_Price,2) AS Sales,
CASE p.Coffee_Type
WHEN 'Rob' THEN 'Robusta'
WHEN 'Ara' THEN 'Arabica'
WHEN 'Lib' THEN 'Liberica'
WHEN 'Exc' THEN 'Excelsa'
ELSE p.Coffee_Type
END AS Coffee_Type_Name,
CASE p.Roast_Type
WHEN 'M' THEN 'Medium'
WHEN 'D' THEN 'Dark'
WHEN 'L' THEN 'Light'
ELSE p.Roast_Type
END AS Roast_Type_Name,
c.Loyalty_Card
FROM orders o
JOIN customers c
ON o.Customer_ID =c.Customer_ID 
JOIN products p
ON o.Product_ID = p.Product_ID