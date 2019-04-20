CREATE TABLE [purchase]
(
	[purchaseId] BIGINT IDENTITY(1,1) PRIMARY KEY, 
    [amount] FLOAT NULL, 
    [userId] VARCHAR(20) NOT NULL, 
    [deliveryAddress] VARCHAR(60) NOT NULL, 
    [deliveryZip] VARCHAR(5) NOT NULL,
	CONSTRAINT [FK_purchase_To_zip] FOREIGN KEY ([deliveryZip]) REFERENCES [zip]([zipCode]),
	CONSTRAINT [FK_purchase_To_user] FOREIGN KEY ([userId]) REFERENCES [user]([userId])
);
