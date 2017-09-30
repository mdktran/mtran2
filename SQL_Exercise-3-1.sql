use AdventureWorksDW2012;


/*1, Display number of orders and total sales amount(sum of SalesAmount) of Internet Sales in 1st 
quarter each year in each country. Note: your result set should produce a total of 18 rows. */


select b.salesterritorycountry Country, count(a.OrderDateKey) as TotalOrders, round(sum(a.salesamount),2) as TotalSales, 
c.CalendarQuarter as Quarter, c.calendaryear as Year
from DimDate c, FactInternetSales a 
join DimSalesTerritory b
on a.salesterritorykey = b.salesterritorykey
where c.DateKey=a.OrderDateKey
and c.CalendarQuarter = '1'
group by b.salesterritorycountry, c.CalendarQuarter, c.calendaryear



/*2, Show total reseller sales amount (sum of SalesAmount), calendar quarter of order date, product category 
name and reseller’s business type by quarter by category and by business type in 2006. Note: your result set should produce a total of 44 rows. */

select round(sum(a.SalesAmount),2) TotalSales, c.CalendarQuarter, f.EnglishProductcategoryName, b.BusinessType
from FactResellerSales a 
join dimreseller b
on b.ResellerKey = a.resellerkey
join Dimdate c
on a.orderdatekey=c.datekey
join dimproduct d
on a.ProductKey=d.ProductKey
join DimProductsubcategory e
on d.ProductSubcategoryKey=e.ProductSubcategoryKey
join DimProductcategory f
on  f.ProductCategoryKey= e.ProductCategoryKey
where c.Calendaryear = '2006'
group by b.BusinessType, c.CalendarQuarter,f.EnglishProductcategoryName


/*3, Based on 2, perform an OLAP operation: slice. In comment, describe how you perform the slicing, 
i.e. what do you do to what dimension(s)? Why is it a operation of slicing?*/

Based on 2, I could slice by a single value/column, such as BusinessType, creating a dimension for BusinessType, each slice would contain rolled up information for each Businesstype, eg, Warehouse, Value added Reseller , and Specialty Bike Shop. I could also slice and create a dimension based on time , in this case Calendar quarters, 1-4. this is an operation of slicing, because slicing is based on a specific singular category. The slice will contain rolled up information about the applicable dimension. Essentially slicing a multidimensional cube to a one dimension view. 


/*4, Based on 2, perform an OLAP operation: drill-down. In comment, describe how you perform the drill-down,
 i.e. what do you do to what dimension(s)? Why is it a operation of drilling-down?*/

Based on 2, to perform a drill down I could drill down to a more detailed view of a cube dimension such as Calendar Quarter down to the month, day or week of the order date. Another example would be to drill down on the dimension of Business Type down to the type of product that is specific to the category. 

09/30/2017
Matt Tran
mtran2@babson.com
