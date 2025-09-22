TEST_DB.TEST_DB_SCHEMA.TESTSTAGETEST_DB.TEST_DB_SCHEMA.TESTSTAGETEST_DB.TEST_DB_SCHEMA.TESTSTAGETEST_DB.TEST_DB_SCHEMA.TESTSTAGETEST_DB.TEST_DB_SCHEMA.TESTSTAGE--create database
create database test_db;

--create schema
create schema test_db_Schema;

--dimension table : DimDate
CREATE TABLE DimDate (
    DateID INT PRIMARY KEY,
    Date DATE,
    DayOfWeek VARCHAR(10),
    Month VARCHAR(10),
    Quarter INT,
    Year INT,
    IsWeekend BOOLEAN
);

--dimension table : DimLoyaltyProgram
CREATE TABLE DimLoyalityProgram (
    LoyaltyProgramID INT PRIMARY KEY,
    ProgramName VARCHAR(100),
    ProgramTier VARCHAR(50),
    PointsAccured INT
)

--dimanesion table : DimCustomer
CREATE OR REPLACE TABLE DimCustomer(
    CustomerID INT PRIMARY KEY autoincrement start 1 increment 1,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Gender VARCHAR(100),
    DateOfBirth DATE,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(1000),
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    ZipCode VARCHAR(100),
    Country VARCHAR(200),
    LoyaltyProgramID INT
);


--dimension table : DimProduct
CREATE TABLE DimProduct(
    ProductID INT PRIMARY KEY autoincrement start 1 increment 1,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    UnitPrice DECIMAL(10,2)
);

--dimension Table : DimStore
CREATE TABLE DimStore(
    StoreID INT PRIMARY KEY autoincrement start 1 increment 1,
    StoreName VARCHAR(100),
    StoreType VARCHAR(100),
    StoreOpeningDate Date,
    Address VARCHAR(255),
    City VARCHAR(200),
    State VARCHAR(200),
    Country VARCHAR(200),
    Region VARCHAR(200),
    ManagerName VARCHAR(100)  
);

--Fact Table : FactOrders
CREATE TABLE FactOrders(
    OrderID INT PRIMARY KEY autoincrement start
    1 increment 1,
    DateID INT,
    CustomerID INT,
    ProductID INT,
    StoreID INT,
    QuantityOrdered INT,
    OrderAmount DECIMAL(10,2),
    DiscountAmount DECIMAL(10,2),
    ShippingCost DECIMAL(10,2),
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    FOREIGN KEY (StoreID) REFERENCES DimStore(StoreID)
);



CREATE OR REPLACE FILE FORMAT CSV_SOURCE_FILE_FORMAT
  TYPE = 'CSV'
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  TRIM_SPACE = TRUE
  NULL_IF = ('', 'NULL', 'null');



CREATE or REPLACE STAGE TESTSTAGE;

COPY INTO DimCustomer (FirstName, LastName, Gender, DateOfBirth, Email, PhoneNumber, Address, City, State, ZipCode, Country, LoyaltyProgramID)
FROM @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimCustomerData/DimCustomerData.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT')
ON_ERROR = 'CONTINUE';

COPY INTO DIMDATE from @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimDate/DimDate.csv FILE_FORMAT= (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT')
ON_ERROR = 'CONTINUE';


COPY INTO DIMPRODUCT (ProductName, Category,Brand,UnitPrice)
FROM @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimProductData/DimProductData.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT')
ON_ERROR = 'CONTINUE';

COPY INTO DIMSTORE (StoreName, StoreType, StoreOPeningDate,Address,City,State,Country,Region,ManagerName)
FROM @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimStoreData/DimStoreData.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT')
ON_ERROR = 'CONTINUE';

COPY INTO FACTORDERS (DateId, CustomerId,ProductId, StoreId, QuantityOrdered, OrderAmount, DiscountAmount,ShippingCost,TotalAmount)
FROM @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/factorders/factorders.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT')
ON_ERROR = 'CONTINUE';

COPY INTO DIMLOYALITYPROGRAM (LoyaltyProgramID, ProgramName, ProgramTier, PointsAccured)
FROM @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/factorders/factorders.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT')
ON_ERROR = 'CONTINUE';


SELECT * FROM FACTORDERS LIMIT 5;


--LIST @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE;
--LIST @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimCustomerData/;

--create a new user
CREATE OR REPLACE USER Test_PowerBI_User
PASSWORD = 'Test_PowerBI_User'
LOGIN_NAME='PowerBI User'
DEFAULT_ROLE='ACCOUNTADMIN'
DEFAULT_WAREHOUSE='COMPUTE_WH'
MUST_CHANGE_PASSWORD=TRUE;

-- grant it accountadmin access
grant role accountadmin to user Test_PowerBI_User;

REMOVE @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimLoyaltyInfo;

TRUNCATE TABLE DIMLOYALITYPROGRAM;

COPY INTO DIMLOYALITYPROGRAM (LoyaltyProgramID, ProgramName, ProgramTier, PointsAccured)
FROM @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimLoyaltyInfo/DimLoyaltyInfo.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT')
ON_ERROR = 'CONTINUE';


select * from DIMSTORE;
select * from factorders;
select * from dimproduct;

