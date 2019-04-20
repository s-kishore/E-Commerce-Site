CREATE TABLE [follower]
(
	[userId] VARCHAR(20) NOT NULL, 
	[followerId] VARCHAR(20) NOT NULL,
    CONSTRAINT [FK_follower_user1] FOREIGN KEY ([followerId]) REFERENCES [user]([userId]),
	CONSTRAINT [FK_follower_user2] FOREIGN KEY ([userId]) REFERENCES [user]([userId]), 
    UNIQUE (userId, followerId)
)
