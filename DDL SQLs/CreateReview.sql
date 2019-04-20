CREATE TABLE [review]
(
	[productId] BIGINT NOT NULL ,
	[userId] VARCHAR(20) NOT NULL ,
	[comment] VARCHAR(300) NULL ,
	[rating] int NULL,
	[time] TIMESTAMP NULL, 
	CONSTRAINT [FK_review_User] FOREIGN KEY ([userId]) REFERENCES [user]([userId]),
	CONSTRAINT [FK_review_Product] FOREIGN KEY ([productId]) REFERENCES [product]([productId]), 
    CONSTRAINT [CK_review_Rating] CHECK (rating < 5 AND rating >0),
	CONSTRAINT [CK_review_Entry] CHECK (rating != NULL OR comment != null ),
	UNIQUE([productId],[userId])
)
