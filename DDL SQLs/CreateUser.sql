CREATE TABLE [user]
(
	[userId] varchar(20) NOT NULL PRIMARY KEY,
	[pass] varchar(20) NOT NULL,
	[imgid] varchar(20) NOT NULL,
	[firstName] varchar(20) NOT NULL,
	[lastName] varchar(20) NOT NULL,
	[email] varchar(25) NOT NULL, 
    [streetAddress] VARCHAR (60) NULL, 
	[zip] VARCHAR(5) NOT NULL,
    CONSTRAINT [FK_users_To_zip] FOREIGN KEY ([zip]) REFERENCES [zip]([zipCode])
);