CREATE TABLE Movie (MID INTEGER PRIMARY KEY, title VARCHAR(50), released INTEGER, tagline VARCHAR(200))
GO
CREATE INDEX idxTitle ON Movie(title)
GO
INSERT INTO Movie VALUES (1,'The Matrix', 1999, 'Welcome to the Real World')
GO
INSERT INTO Movie VALUES (2,'The Matrix Reloaded', 2003, 'Free your mind')
GO
INSERT INTO Movie VALUES (3,'The Matrix Revolutions', 2003, 'Everything that has a beginning has an end')
GO
INSERT INTO Movie VALUES (4,'The Devil''s Advocate', 1997, 'Evil has its winning ways')
GO
INSERT INTO Movie VALUES (5,'The Replacements', 2000, 'Pain heals, Chicks dig scars... Glory lasts forever')
GO
INSERT INTO Movie VALUES (6,'Johnny Mnemonic', 1995, 'The hottest data on earth. In the coolest head in town')
GO
INSERT INTO Movie VALUES (7,'Something''s Gotta Give', 2003, null)
GO
