----1. Trigger to delete from stock table if the product is deleted from the Product table inventory.---

Create trigger TR_DEL_PRO
ON Product
FOR DELETE
AS
BEGIN
     SET NOCOUNT ON;
	 DELETE FROM STOCK
	 WHERE PID= (SELECT PID FROM DELETED)

END;

delete from Product
where PID= 'P1005';

----2. Trigger to Update stock table if an order is placed on order table. 

Create trigger TR_INS_ORD
ON ORDERS
FOR INSERT
AS
BEGIN
     SET NOCOUNT ON;
	 UPDATE STOCK SET SQTY = SQTY- (SELECT QTY FROM INSERTED)
	 WHERE PID= (SELECT PID FROM INSERTED)

END;

----3. Trigger of there are any changes in order (any update), stock table should get automatically updated

Create trigger TR_UPD_ORD
ON ORDERS
FOR UPDATE 
AS
BEGIN
     Declare @OQ AS INT; ---OLD Qty---
	 Declare @NQ AS INT; ---New QTY---
	 set @OQ= (SELECT QTY FROM DELETED)
	 SET @NQ = (SELECT QTY FROM INSERTED)
	 UPDATE STOCK SET SQTY= SQTY + OQ - NQ
	 WHERE PID =( SELECT PID FROM INSERTED)
	 
END;

---- 4. Trigger to Automatically Add a New Product to the Stock Table,if a new product is added to the Product table. Insert a record into the Stock table with an initial quantity.

CREATE TRIGGER Add_to_STOCK 
ON PRODUCT 
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO STOCK (PID, SQTY, ROL, MOQ)
    SELECT PID, 0, 0, 0 
    FROM INSERTED;
END;									