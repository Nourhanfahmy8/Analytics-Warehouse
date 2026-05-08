
CREATE DATABASE BikeStore_DWH;
GO

USE BikeStore_DWH;
GO

 -- DIMENSION TABLES


-- Date Dimension
CREATE TABLE Dim_Date ( 
    DateKey INT IDENTITY(1,1) PRIMARY KEY, 
    FullDate DATE NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] INT NOT NULL,
    [Month] INT NOT NULL,
    [MonthName] NVARCHAR(20) NOT NULL,
    [Day] INT NOT NULL,
    [DayOfWeekName] NVARCHAR(20) NOT NULL,
    [IsWeekend] BIT NOT NULL
);
GO


-- Customer Dimension
CREATE TABLE Dim_Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    Customer_Source_ID INT,
    First_Name NVARCHAR(100),
    Last_Name NVARCHAR(100),
    Email NVARCHAR(150),
    Phone NVARCHAR(50)
);
GO


-- Product Dimension
CREATE TABLE Dim_Product (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    Product_Source_ID INT,
    Product_Name NVARCHAR(255),
    Category_Name NVARCHAR(100),
    Brand_Name NVARCHAR(100),
    Model_Year INT,

    -- SCD Type 2 Columns
    StartDate DATE NOT NULL DEFAULT GETDATE(),
    EndDate DATE NULL,
    IsCurrent BIT NOT NULL DEFAULT 1
);
GO


-- Geography Dimension
CREATE TABLE Dim_Geography (
    LocationKey INT IDENTITY(1,1) PRIMARY KEY,
    Store_Source_ID INT,
    Store_Name NVARCHAR(100),
    City NVARCHAR(100),
    State NVARCHAR(50),
    Zip_Code NVARCHAR(20)
);
GO


-- Staff Dimension
CREATE TABLE Dim_Staff (
    StaffKey INT IDENTITY(1,1) PRIMARY KEY,
    Staff_Source_ID INT,
    Staff_Name NVARCHAR(200),
    Staff_Email NVARCHAR(150),
    Active_Status INT,

    -- SCD Type 2 Columns
    StartDate DATE NOT NULL DEFAULT GETDATE(),
    EndDate DATE NULL,
    IsCurrent BIT NOT NULL DEFAULT 1
);
GO


-- Order Status Dimension
CREATE TABLE Dim_Order_Status (
    StatusKey INT IDENTITY(1,1) PRIMARY KEY,
    Status_ID_Source INT,
    Status_Description NVARCHAR(50)
);
GO


-- FACT TABLES

-- Sales Fact Table
CREATE TABLE Fact_Sales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,

    CustomerKey INT 
        FOREIGN KEY REFERENCES Dim_Customer(CustomerKey),

    ProductKey INT 
        FOREIGN KEY REFERENCES Dim_Product(ProductKey),

    LocationKey INT 
        FOREIGN KEY REFERENCES Dim_Geography(LocationKey),

    DateKey INT 
        FOREIGN KEY REFERENCES Dim_Date(DateKey),

    SalesAmount DECIMAL(18,2),
    Quantity INT,
    DiscountAmount DECIMAL(18,2),

    -- Derived Metric
    Net_Revenue DECIMAL(18,2)
);
GO


-- Shipping Fact Table
CREATE TABLE Fact_Shipping (
    ShipFactKey INT IDENTITY(1,1) PRIMARY KEY,

    ProductKey INT 
        FOREIGN KEY REFERENCES Dim_Product(ProductKey),

    LocationKey INT 
        FOREIGN KEY REFERENCES Dim_Geography(LocationKey),

    DateKey INT 
        FOREIGN KEY REFERENCES Dim_Date(DateKey),

    ActualDays INT,
    ScheduledDays INT,
    LateRiskFlag INT
);
GO


-- Orders Fact Table
CREATE TABLE Fact_Orders (
    OrderFactKey INT IDENTITY(1,1) PRIMARY KEY,

    CustomerKey INT 
        FOREIGN KEY REFERENCES Dim_Customer(CustomerKey),

    StatusKey INT 
        FOREIGN KEY REFERENCES Dim_Order_Status(StatusKey),

    StaffKey INT 
        FOREIGN KEY REFERENCES Dim_Staff(StaffKey),

    DateKey INT 
        FOREIGN KEY REFERENCES Dim_Date(DateKey),

    Order_Total_Value DECIMAL(18,2),
    Item_Count INT
);
GO


-- POPULATE DATE DIMENSION
/*
used inside the date dim package 

DECLARE @StartDate DATE = '2016-01-01';
DECLARE @EndDate DATE = '2018-12-31';

WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO Dim_Date (
        FullDate,
        [Year],
        [Quarter],
        [Month],
        [MonthName],
        [Day],
        [DayOfWeekName],
        [IsWeekend]
    )

    VALUES (
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DAY(@StartDate),
        DATENAME(WEEKDAY, @StartDate),

        CASE
            WHEN DATENAME(WEEKDAY, @StartDate) 
                 IN ('Saturday', 'Sunday')
            THEN 1
            ELSE 0
        END
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);

END;
GO

*/