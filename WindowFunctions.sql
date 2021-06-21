WITH CTE
AS
(
SELECT
 Sales_Id
 , SUM(Line_Total) AS Total
FROM Sales_Details
GROUP BY Sales_Id
)

SELECT * FROM CTE AS A
INNER JOIN Sales_Details AS B
 ON A.Sales_Id = B.Sales_Id

SELECT
 Sales_Id
 , Sales_Date
 , Item
 , Price
 , Quantity
 , Line_Total
 , COUNT(Line_Total) OVER(PARTITION BY Sales_Id) AS Line_Count
 , SUM(Line_Total) OVER(PARTITION BY Sales_Id) AS Sales_Total
 , SUM(Line_Total) OVER(PARTITION BY Sales_Date) AS Daily_Total
 , SUM(Line_Total) OVER() AS Total
 FROM Sales_Details
 ORDER BY Sales_Total
 
===================================================================
 
 Window Functions can only be included within SELECT or ORDER BY clauses.

Functions Available:
Aggregate - COUNT, SUM, MIN, MAX, AVG
Ranking - ROW_NUMBER, RANK, DENSE_RANK, NTILE
Offset - FIRST_VALUE, LAST_VALUE, LEAD, LAG
Statistical - PERCENT_RANK, CUME_DIST, PERCENTILE_CONT, PERCENTILE_DIST

Windows Functions also have FRAMES
ROWS
RANGE

Window Functions are a powerful tool within SQL Server and I am excited to bring more videos and tutorials working with Window Functions in the future.

ROW_NUMBER - unique incrementing integers
RANK - same rank for same values
DENSE_RANK - same rank for same values
NTILE - assigns tile numbers based on number of tiles requested

SQL:
SELECT
 Sales_Id
 , Sales_Total
 , ROW_NUMBER() OVER(ORDER BY Sales_Total DESC) AS rownum
 , RANK() OVER(ORDER BY Sales_Total DESC) AS rnk
 , DENSE_RANK() OVER(ORDER BY Sales_Total DESC) AS dense
 , NTILE(3) OVER(ORDER BY Sales_Total DESC) AS ntle
FROM dbo.Sales_2

SELECT
 Sales_Id
 , NTILE(10) OVER(ORDER BY Sales_Total DESC) AS ntle
FROM dbo.Sales_2

===================================================================
 
SQL
SELECT
 Sales_Cust_Id
 , SUM(Sales_Total) AS Total
FROM dbo.Sales_2
GROUP BY Sales_Cust_Id
ORDER BY Total DESC

SELECT
 Sales_Cust_Id
 , SUM(Sales_Total) AS Total
 , RANK() OVER(ORDER BY SUM(Sales_Total) DESC) AS rnk
 , DENSE_RANK() OVER(ORDER BY SUM(Sales_Total) DESC) AS dnse
FROM dbo.Sales_2
GROUP BY Sales_Cust_Id
ORDER BY rnk

===================================================================

Window Functions can only be included within SELECT or ORDER BY clauses.

Functions Available:
Aggregate - COUNT, SUM, MIN, MAX, AVG
Ranking - ROW_NUMBER, RANK, DENSE_RANK, NTILE
Offset - FIRST_VALUE, LAST_VALUE, LEAD, LAG
Statistical - PERCENT_RANK, CUME_DIST, PERCENTILE_CONT, PERCENTILE_DIST

Windows Functions also have FRAMES
ROWS
RANGE

Window Functions are a powerful tool within SQL Server and I am excited to bring more videos and tutorials working with Window Functions in the future.

SQL:
SELECT
 Sales_Id
 , Sales_Date
 , Sales_Total
 , SUM(Sales_Total) OVER(ORDER BY Sales_Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Running Total]
FROM dbo.Sales_2
WHERE Sales_Cust_Id = 3
ORDER BY Sales_Date

SELECT
 Sales_Id
 , Sales_Date
 , Sales_Total
 , SUM(Sales_Total) OVER(ORDER BY Sales_Date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS [Running Total]
FROM dbo.Sales_2
WHERE Sales_Cust_Id = 3
ORDER BY Sales_Date

SELECT
 Sales_Id
 , Sales_Date
 , Sales_Total
 , SUM(Sales_Total) OVER(ORDER BY Sales_Date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS [Running Total]
FROM dbo.Sales_2
WHERE Sales_Cust_Id = 3
ORDER BY Sales_Date

SELECT
 Sales_Id
 , Sales_Date
 , Sales_Total
 , SUM(Sales_Total) OVER(ORDER BY Sales_Date ROWS UNBOUNDED PRECEDING) AS [Running Total]
FROM dbo.Sales_2
WHERE Sales_Cust_Id = 3
ORDER BY Sales_Date

SELECT
 Sales_Id
 , Sales_Date
 , Sales_Total
 , SUM(Sales_Total) OVER(ORDER BY Sales_Date ROWS UNBOUNDED PRECEDING) AS [Running Total]
 , CAST(AVG(Sales_Total) OVER(ORDER BY Sales_Date ROWS UNBOUNDED PRECEDING) AS DECIMAL(8, 2)) AS [Running Average]
FROM dbo.Sales_2
WHERE Sales_Cust_Id = 3
ORDER BY Sales_Date

===================================================================

IF OBJECT_ID(N'dbo.Sales', N'U') IS NOT NULL
 DROP TABLE dbo.Sales;

GO

CREATE TABLE dbo.Sales
(
 Sales_Id INT NOT NULL IDENTITY(1, 1)
  CONSTRAINT PK_Sales_Sales_Id PRIMARY KEY
 , Sales_Customer_Id INT NOT NULL
 , Sales_Date DATETIME2 NOT NULL
 , Sales_Amount DECIMAL (16, 2) NOT NULL
)

INSERT INTO dbo.Sales (Sales_Customer_Id, Sales_Date, Sales_Amount)
VALUES
 (1, '20180102', 54.99)
 , (1, '20180103', 72.99)
 , (1, '20180104', 34.99)
 , (1, '20180115', 29.99)
 , (1, '20180121', 67.00)

Lag and Lead are useful for performing trend analysis, in the example I show how we can display a customer spending trend.

Lag will show the previous value.
Lead will show the next value.

Lag and Lead accept multiple parameters as demonstrated in the video:

LAG([Column], [Offset], [Value if NULL])

The example of LAG and LEAD in the video can be shown by executing the below SQL query:

SELECT 
 Sales_Customer_Id
 , Sales_Date
 , LAG(Sales_Amount, 2, 0) OVER(PARTITION BY Sales_Customer_Id ORDER BY Sales_Date) AS PrevValue
 , Sales_Amount
 , LEAD(Sales_Amount, 2, 0) OVER(PARTITION BY Sales_Customer_Id ORDER BY Sales_Date) AS NextValue
FROM dbo.Sales

===================================================================

WITH Number
AS
(
SELECT
 CustomerId
 , NTILE(1000) OVER(ORDER BY CustomerId) AS N
FROM dbo.Customers
)
,
TopCustomer
AS
(
SELECT  
 MAX(CustomerId) AS CustId
FROM Number
GROUP BY N
)

SELECT 
 C2.*
INTO dbo.CustomersSample 
FROM TopCustomer AS C1
INNER JOIN dbo.Customers AS C2
 ON C1.CustId = C2.CustomerId

SELECT * FROM dbo.CustomersSample

===================================================================

CTE - Common Table Expressions
Aggregate Functions - Average

WITH CTE
AS
(
SELECT 
 Sales_Customer_Id
 , Sales_Date
 , Sales_Amount
 , LAG(Sales_Amount) OVER(PARTITION BY Sales_Customer_Id ORDER BY Sales_Date) AS PrevValue
 , Sales_Amount - LAG(Sales_Amount) OVER(PARTITION BY Sales_Customer_Id ORDER BY Sales_Date) AS RunningDifference
FROM dbo.Sales
)

SELECT
 Sales_Customer_Id
 , AVG(RunningDifference) AS AverageDifference
FROM CTE
GROUP BY Sales_Customer_Id
ORDER BY AverageDifference DESC;

===================================================================

SELECT
 Sales_Customer_Id
 , SUM(Sales_Amount) AS Cust_Total
 , SUM(SUM(Sales_Amount)) OVER(ORDER BY (SELECT NULL)) AS Grand_Total
 , AVG(SUM(Sales_Amount)) OVER(ORDER BY (SELECT NULL)) AS Average_Cust_Total
 , CAST((SUM(Sales_Amount) / SUM(SUM(Sales_Amount)) OVER(ORDER BY (SELECT NULL))) * 100 AS DECIMAL(6,2)) AS Pct
FROM dbo.Sales
GROUP BY Sales_Customer_Id

===================================================================

SELECT 
 *
 , SUM(SalesAmount) OVER(ORDER BY [Date] ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS Total
 , SUM(SalesAmount) OVER(ORDER BY [Date] ROWS BETWEEN CURRENT ROW AND 9 FOLLOWING) AS Forward
FROM #TempSales
ORDER BY [Date]

===================================================================

IF OBJECT_ID(N'dbo.Sale', N'U') IS NOT NULL
 DROP TABLE dbo.Sale

IF OBJECT_ID(N'dbo.SaleChannel', N'U') IS NOT NULL
 DROP TABLE dbo.SaleChannel

CREATE TABLE SaleChannel
(
 SaleChannelId INT NOT NULL IDENTITY(1, 1)
  CONSTRAINT PK_SalesChannel_SaleChannelId PRIMARY KEY (SaleChannelId)
 , SaleChannel VARCHAR(10) NOT NULL
)

INSERT INTO dbo.SaleChannel (SaleChannel)
VALUES ('In-Store'), ('Online')

CREATE TABLE Sale
(
 SaleId INT NOT NULL IDENTITY(1, 1)
  CONSTRAINT PK_Sales_SaleId PRIMARY KEY (SaleId)
 , SaleChannelId INT NOT NULL
  CONSTRAINT FK_Sales_SaleChannelId FOREIGN KEY (SaleChannelId) REFERENCES SaleChannel (SaleChannelId)
 , SaleDate DATE NOT NULL
 , SaleAmount DECIMAL(6, 2) NOT NULL
)

INSERT INTO dbo.Sale (SaleChannelId, SaleDate, SaleAmount)
VALUES (1, '20180101', 15.99)
  , (1, '20180201', 7.49)
  , (1, '20180301', 14.99)
  , (1, '20180401', 6.49)
  , (1, '20180501', 13.99)
  , (1, '20180601', 5.49)
  , (1, '20180701', 19.99)
  , (1, '20180801', 10.49)
  , (1, '20180901', 18.99)
  , (1, '20181001', 11.49)
  , (1, '20181101', 17.99)
  , (1, '20181201', 12.49)
  , (2, '20180101', 16.99)
  , (2, '20180201', 13.49)
  , (2, '20180301', 15.99)
  , (2, '20180401', 14.49)
  , (2, '20180501', 19.99)
  , (2, '20180601', 7.49)
  
===================================================================

DROP TABLE IF EXISTS dbo.SalesDetails;

GO

CREATE TABLE dbo.SalesDetails
(
 SalesDetailsId INT NOT NULL IDENTITY(1, 1)
  CONSTRAINT PK_SalesDetails_SalesDetailsId PRIMARY KEY (SalesDetailsId),
 SalesId INT NOT NULL,
 SalesDate DATE NOT NULL,
 ProductId INT NOT NULL,
 Price MONEY NOT NULL,
 Quantity INT NOT NULL,
 LineTotal AS Price * Quantity
);

INSERT INTO dbo.SalesDetails (SalesId, SalesDate, ProductId, Price, Quantity)
VALUES
 (1, '20200105', 6, 5.99, 2),
 (1, '20200105', 5, 4.50, 1),
 (1, '20200105', 4, 17.99, 4),
 (2, '20200107', 2, 2.99, 2),
 (2, '20200107', 3, 11.40, 1),
 (3, '20200107', 6, 5.99, 4),
 (3, '20200107', 2, 2.99, 2),
 (3, '20200107', 3, 11.40, 1),
 (3, '20200107', 9, 6.29, 4),
 (4, '20200108', 9, 6.29, 2),
 (4, '20200108', 8, 23.10, 1),
 (4, '20200108', 1, 13.25, 4),
 (4, '20200108', 2, 2.99, 2),
 (4, '20200108', 3, 11.40, 1),
 (5, '20200110', 4, 17.99, 4),
 (6, '20200110', 7, 19.00, 2),
 (6, '20200110', 9, 6.29, 10);

WITH CTE AS
(
 SELECT
  SalesId,
  SUM(LineTotal) AS SalesTotal
 FROM dbo.SalesDetails
 GROUP BY
  SalesId
)

SELECT
 SalesDetailsId,
 A.SalesId,
 SalesDate,
 ProductId,
 Price,
 Quantity,
 LineTotal,
 SalesTotal
FROM dbo.SalesDetails AS A
INNER JOIN CTE AS B
 ON A.SalesId = B.SalesId;

SELECT
 SalesDetailsId,
 SalesId,
 SalesDate,
 ProductId,
 Price,
 Quantity,
 LineTotal,
 SUM(LineTotal) OVER(PARTITION BY SalesId) AS SalesTotal,
 COUNT(SalesDetailsId) OVER(PARTITION BY SalesId) AS SalesCount,
 SUM(LineTotal) OVER(PARTITION BY SalesDate) AS DailyTotal,
 SUM(LineTotal) OVER(PARTITION BY SalesDate, ProductId) AS DailyProductSales,
 SUM(LineTotal) OVER() AS SalesGrandTotal,
 100 * SUM(LineTotal) OVER(PARTITION BY SalesId) / SUM(LineTotal) OVER() AS pcttotal
FROM dbo.SalesDetails
ORDER BY SalesId

