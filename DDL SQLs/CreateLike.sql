CREATE TABLE [like]
(
	[productId] BIGINT NOT NULL,
	[userId] varchar(20) NOT NULL, 
    CONSTRAINT [FK_like_Product] FOREIGN KEY ([productId]) REFERENCES [product]([productId]),
	CONSTRAINT [FK_like_User] FOREIGN KEY ([userId]) REFERENCES [user]([userId]),
	UNIQUE (userId, productId)
);
