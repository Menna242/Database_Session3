CREATE DATABASE SocialMedia;

CREATE TABLE Users(
     ID INT IDENTITY PRIMARY KEY,
	 Name NVARCHAR(100) NOT NULL,
	 Email VARCHAR(100) UNIQUE NOT NULL,
	 DateOfBirth DATE ,
	 Gender NVARCHAR(50) NOT NULL,
	 JoinDate DateTime default GETUTCDATE()

);


CREATE TABLE Posts(
     ID INT IDENTITY PRIMARY KEY,
	 Content NVARCHAR(100) NOT NULL,
	 Visibility VARCHAR(100) CHECK (Visibility IN('Public','Private'))
	 DEFAULT 'Public',
	 PostDate DateTime default GETUTCDATE(),
	 UserID INT NOT NULL,
	 FOREIGN KEY (UserID) REFERENCES Users(ID),

);

CREATE TABLE Interaction(
     ID INT IDENTITY PRIMARY KEY,
	 InterDate DateTime default GETUTCDATE(),
	 InterType NVARCHAR(50) CHECK (InterType IN('Comment','Like','Share')),

);

CREATE TABLE Comment(
     ID INT IDENTITY PRIMARY KEY,
	 Content NVARCHAR(100) NOT NULL,
	 CommentDate DateTime default GETUTCDATE(),
	 UserID INT NOT NULL,
	 PostID INT NOT NULL,
	 FOREIGN KEY (UserID) REFERENCES Users(ID),
	 FOREIGN KEY (PostID) REFERENCES Posts(ID),

);

CREATE TABLE AssoiateInteraction(
	 UserID INT NOT NULL ,
	 InterTD INT NOT NULL,
	 PostID INT NOT NULL,
	 PRIMARY KEY(UserID,InterTD),

	 FOREIGN KEY (UserID) REFERENCES Users(ID),
	 FOREIGN KEY (InterTD) REFERENCES Interaction(ID),
	 FOREIGN KEY (PostID) REFERENCES Posts(ID),

);
--/////////////////////////////////////////////////////////////////////////////////////////////

INSERT INTO Users(Name,Email,DateOfBirth,Gender) VALUES
('Menna','Menna123@gmail.com','2004-11-11','Female'),
('Mohammed','Mohammed123@gmail.com','2003-11-11','male');
SELECT* FROM Users;
--////////////////////////////////////////////////////////////////
	 
INSERT INTO Posts(Content,Visibility,UserID) VALUES
('excellent','Public','1'),
('veyy good for you ','Private','2');
SELECT* FROM Posts;
--////////////////////////////////////////////////////////////////

INSERT INTO Interaction(InterType) VALUES
('Comment'),
('Like');
SELECT* FROM Interaction;
--////////////////////////////////////////////////////////////////

INSERT INTO Comment(Content,UserID,PostID) VALUES
('congratulation',1,1),
('I study now ',1,2);
SELECT* FROM Comment;
--////////////////////////////////////////////////////////////////

INSERT INTO AssoiateInteraction(UserID,InterTD,PostID) VALUES
(1,1,1),
(1,2,1);
SELECT* FROM AssoiateInteraction;
--////////////////////////////////////////////////////////////////

--4
-- To drop Users I should drop table Posts,AssoiateInteraction,Comment
drop table Users;

--5
drop database SocialMedia;