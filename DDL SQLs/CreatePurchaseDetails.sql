CREATE TABLE [purchaseDetail]
(
	[purchaseId] BIGINT NOT NULL,
	[productId] BIGINT NOT NULL,
	[quantity] INT NOT NULL,
	[price] FLOAT NOT NULL,
	CONSTRAINT [FK_purchaseDetail_To_purchase] FOREIGN KEY ([purchaseId]) REFERENCES [purchase]([purchaseId]),
	CONSTRAINT [FK_purchaseDetail_To_Product] FOREIGN KEY ([productId]) REFERENCES [product]([productId])
)
