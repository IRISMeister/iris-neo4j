CREATE TABLE Person (PID INTEGER PRIMARY KEY, name VARCHAR(50), born INTEGER)
GO
CREATE INDEX idxName ON Person(name)
GO
INSERT INTO Person VALUES (1,'Keanu Reeves',1964)
GO
INSERT INTO Person VALUES (2,'Carrie-Anne Moss',1967)
GO
INSERT INTO Person VALUES (3,'Laurence Fishburne', 1961)
GO
INSERT INTO Person VALUES (4,'Hugo Weaving', 1960)
GO
INSERT INTO Person VALUES (5,'Lilly Wachowski', 1967)
GO
INSERT INTO Person VALUES (6,'Lana Wachowski', 1965)
GO
INSERT INTO Person VALUES (7,'Joel Silver', 1952)
GO
