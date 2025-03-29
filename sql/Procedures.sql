-- Creating procedures with Auto generating Alpha numeric IDS using seqqunces and user-defined functions.--- 
 
 --- Created a function for generating ID (COMMON FOR ALL PROCEDURE)--CREATE AUTO_ID
 
CREATE FUNCTION CID ( @C AS CHAR(1),@I AS INT)
RETURNS CHAR(5)
AS BEGIN
   DECLARE @ID CHAR(5);
   SELECT @ID=CASE
                 WHEN @I<10 THEN CONCAT(@C,'000',@I)
		         WHEN @I<100 THEN CONCAT(@C,'00',@I)
		         WHEN @I<1000 THEN CONCAT(@C,'0',@I)
		         WHEN @I<10000 THEN CONCAT(@C,@I)
		         ELSE 'NA'
    END 
    RETURN @ID;
END;

  ---- FOR ADDING SUPPLIER- created Sequence Supp_SEQ and Procedure ADDSUPPLIER

Create Sequence SUPP_SEQ
AS INT
START WITH 6
INCREMENT BY 1;

Create procedure ADDSUPPLIER @SNAME as varchar(30), @SADD as Varchar(30), @SCITY as Varchar(5), @SPHONE as char(15), @EMAIL as Varchar(50)
AS
BEGIN
       SET NOCOUNT ON; 
	   DECLARE @I AS INT
	   DECLARE @ID AS CHAR(5)

	   SET @I=(NEXT VALUE FOR SUPP_SEQ) 
	   SET @ID=DBO.CID('S',@I) 

	   INSERT INTO Supplier 
       values (@ID, @SNAME, @SADD, @SCITY, @SPHONE, @EMAIL)
       select * from supplier where sid = @ID
END;

ADDSUPPLIER 'VERMA TECH', ' 27B Bhawarkuan','DELHI','874658923','Supplier4@example.com'
ADDSUPPLIER 'Rai TECH', ' 278B Bhawarkuan','DELHI','874658893','Supplier5@example.com'
ADDSUPPLIER 'Fancy TECH', ' 30 Bhawarkuan','DELHI','8747432923','Supplier6@example.com'

select * from Supplier
select * from Product

---- FOR ADDING PRODUCT- created Sequence PRO_SEQ and Procedure ADDPROD--

Create Sequence PRO_SEQ
AS INT
START WITH 6
INCREMENT BY 1;

drop sequence PRO_SEQ


Create procedure ADDPRO @PDESC as varchar(50), @PRICE as INT, @CATEGORY as Varchar(2), @SID as char(5)
AS
BEGIN
       SET NOCOUNT ON;
	   DECLARE @I AS INT
	   DECLARE @ID AS CHAR(5)

	   SET @I=(NEXT VALUE FOR PRO_SEQ)
	   SET @ID=DBO.CID('P',@I)

	   INSERT INTO Product 
       values (@ID, @PDESC, @PRICE, @CATEGORY, @SID)
       select * from Product where pid = @ID
END;

drop procedure ADDPRO
ADDPRO 'MICROWAVE', 15000,'HA','S0002'
ADDPRO 'MOUSE', 1000,'IT','S0002'
ADDPRO 'WIRE', 2000,'IT','S0002' 

SELECT * FROM PRODUCT

---- FOR ADDING CUSTOMER- created Sequence CUST_SEQ and Procedure ADDCUST--

Create Sequence CUST_SEQ
AS INT
START WITH 8
INCREMENT BY 1;

DROP SEQUENCE CUST_SEQ

Create procedure ADDCUST @CNAME as varchar(50), @CADDRESS as varchar(50), @CITY as varchar(50), @PHONE as CHAR(10), @EMAIL as varchar(50), @DOB AS DATE
AS
BEGIN
       SET NOCOUNT ON;
	   DECLARE @I AS INT
	   DECLARE @ID AS CHAR(5)

	   SET @I=(NEXT VALUE FOR CUST_SEQ)
	   SET @ID=DBO.CID('C',@I)

	   INSERT INTO CUST 
       values (@ID, @CNAME, @CADDRESS, @CITY, @PHONE, @EMAIL, @DOB)
       select * from CUST where Cid = @ID
END;

DROP PROCEDURE ADDCUST

ADDCUST 'PAVAN', '24 PIPARIYA','DELHI','7415508798','Pavan@gmail.com','1993-11-20'
ADDCUST 'PAVANi', '278 PIPARIYA','DELHI','7416708798','Pavani@gmail.com','1990-11-20'
ADDCUST 'Sonu', '278 khandwa road','DELHI','741676512','sonu@gmail.com','1991-11-20'
select * from Cust

---- FOR ADDING ORDERS- created Sequence ORD_SEQ and Procedure ADDORDER--

Create Sequence ORD_SEQ
AS INT
START WITH 6 --- check the table record to check start from--
INCREMENT BY 1;

Create procedure ADDORDER @CID AS CHAR(5), @PID AS CHAR(5), @OQTY INT
AS
BEGIN
       SET NOCOUNT ON;  
	   DECLARE @I AS INT
	   DECLARE @ID AS CHAR(5)

	   SET @I=(NEXT VALUE FOR ORD_SEQ) 
	   SET @ID=DBO.CID('O',@I)   

	   INSERT INTO Orders 
       values (@ID, GETDATE(), @CID, @PID, @OQTY)
       select * from ORDERS where Oid = @ID
END;
 DROP PROCEDURE  ADDORDER
ADDORDER 'P0005','C0001',10
ADDORDER 'P0006','C0001',11
select * from Orders
