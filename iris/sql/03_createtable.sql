CREATE TABLE Person_Movie (Movie INTEGER, Person INTEGER, roles VARCHAR(50), 
	CONSTRAINT nFK FOREIGN KEY (Person) REFERENCES Person (PID), 
	CONSTRAINT tFK FOREIGN KEY (Movie) REFERENCES Movie (MID))
GO
INSERT INTO Person_Movie VALUES (1,1,'neo')
GO
INSERT INTO Person_Movie VALUES (1,2,'Trinity')
GO
INSERT INTO Person_Movie VALUES (1,3,'Morpheus')
GO
INSERT INTO Person_Movie VALUES (1,4,'Agent Smith')
GO
INSERT INTO Person_Movie VALUES (2,1,'neo')
GO
INSERT INTO Person_Movie VALUES (2,2,'Trinity')
GO
INSERT INTO Person_Movie VALUES (2,3,'Morpheus')
GO
INSERT INTO Person_Movie VALUES (2,4,'Agent Smith')
GO
INSERT INTO Person_Movie VALUES (3,1,'neo')
GO
INSERT INTO Person_Movie VALUES (3,2,'Trinity')
GO
INSERT INTO Person_Movie VALUES (3,3,'Morpheus')
GO
INSERT INTO Person_Movie VALUES (3,4,'Agent Smith')
GO
INSERT INTO Person_Movie VALUES (4,1,'Kevin Lomax')
GO
INSERT INTO Person_Movie VALUES (5,1,'Shane Falco')
GO
INSERT INTO Person_Movie VALUES (6,1,'Johnny Mnemonic')
GO
INSERT INTO Person_Movie VALUES (7,1,'Julian Mercer')
GO
