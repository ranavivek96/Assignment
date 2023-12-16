USE adventureworks;

-- 1. Write a query to display employee numbers and employee name (first name, last name) 
	-- of all the sales employees who received an amount of 2000 in bonus. 

select firstname, lastname, ContactID, bonus from contact join salesperson on 
contact.contactid =salesperson.salespersonid
having bonus in(select bonus from salesperson where bonus = 2000);

-- 2. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A.

select Addressline1, IFNULL(Addressline2,'N/A'), CountryRegionCode from address 
join stateprovince
on address.StateProvinceID = stateprovince.StateProvinceID
where CountryRegionCode = 'CA';
 
-- 3. Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product. ------
 
select Name , salesorderdetailiD from product
join salesorderdetail
on product.productid = salesorderdetail.productid;

-- 4. Find the subcategories that have at least two different prices less than $15. 

select name, listprice from product where listprice < 15
order by listprice desc limit 2;

-- 5.  A. Write a query to display employees and their manager details. Fetch employee id, employee first name, and manager id, manager name.
	-- B. Display the employee id and employee name of employees who do not have manager. 

select employeeID, firstName, managerid  from contact
join employee 
on contact.contactid = employee.contactid 
where managerid is null;

-- 6. A. Display the names of all products of a particular subcategory 15 and the names of their vendors.
-- B. Find the products that have more than one vendor. 

select product.productsubcategoryid,productvendor.productid,productvendor.vendorid,vendor.Name from vendor 
join productvendor on productvendor.VendorID=vendor.VendorID
join product on productvendor.productid = product.productid 
where product.ProductSubcategoryID=15;

-- 7. Find all the customers who do not belong to any store. 

select customer.customerid from customer 
left join store 
on customer.customerid = store.customerid 
where store.customerid is null 
group by customer.Customerid;

-- 8. Find sales prices of product 718 that are less than the list price recommended for that product. 

select product.productid, salesorderdetail.unitprice 
from salesorderdetail join product on salesorderdetail.productid= product.productid
where salesorderdetail.unitprice < product.listprice  and product.productid=718;

-- 9. Display product number, description and sales of each product in the year 2001. 

select productid, description , linetotal, year(salesorderdetail.modifieddate) from productdescription
join salesorderdetail
on productdescription.productdescriptionid = salesorderdetail.productid
where year(salesorderdetail.modifieddate) = 2001;

-- 10. Build the logic on the above question to extract sales for each category by year. Fetch Product Name, Sales_2001, Sales_2002, Sales_2003. 
--  Hint: For questions 9 & 10 (From Sales.SalesOrderHeader, sales. SalesOrderDetail, 
-- Production. Product. Use ShipDate of SalesOrderHeader to extract shipped year.
-- Calculate sales using QTY and unitprice from Sales OrderDetail.)

select product.productid, product.name ,  year(salesorderdetail.modifieddate) as year from product
join salesorderdetail
on product.productid = salesorderdetail.productid
where year(salesorderdetail.modifieddate) in (2001, 2002, 2003);
