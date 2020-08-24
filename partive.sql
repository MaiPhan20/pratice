CREATE DATABASE MyBlog1
--
CREATE TABLE Users
(
	UserID INT identity
	CONSTRAINT PK_UserID_User PRIMARY KEY(UserID),
	UserName VARCHAR(20),
	Password VARCHAR(30) ,
	Email VARCHAR(30) UNIQUE,
	ADDRESS	NVARCHAR(200)
)
CREATE TABLE Posts
(
	PostID INT Identity
	CONSTRAINT PK_PostID_Posts PRIMARY KEY(PostID),
	Title	NVARCHAR(200),
	Content	NVARCHAR(100),
	Tag	NVARCHAR(100) ,
	Status	bit,
	CreateTime	DATETIME Default Current_timestamp,
	UpdateTime	DATETIME,
	UserID	INT,
	CONSTRAINT FK_Users_Posts FOREIGN KEY (UserID) REFERENCES Users

)
CREATE TABLE Comments
(
	CommentID	INT Identity
	CONSTRAINT PK_CommentID_Commnents PRIMARY KEY(CommentID),
	Content	NVARCHAR(500),
	Status	bit,
	CreateTime	DATETIME Default Current_timestamp ,
	Author	NVARCHAR(30),
	Email	VARCHAR(50) NOT NULL,
	PostID	INT,
	CONSTRAINT FK_Posts_Comments FOREIGN KEY (PostID) REFERENCES Posts
)
--3Create a constraint (CHECK) to ensure value of Email column (on the Users table
--and the Comments table) always contain the ‘@’ character.
ALTER TABLE USERS
ADD CONSTRAINT Users_check CHECK(Emai like '%@')
--4. Create an unique, none-clustered index named IX_UserName on UserName columon table Users.
CREATE UNIQUE CLUSTERED INDEX IX_UserName
ON Users(Username)
--5. Insert into above tables at least 3 records per table.
--Bang Users
INSERT INTO Users Values ('MP100','phan1234','phanvanmai9898@gmail.com',N'Nam Định')
INSERT INTO Users Values ('MP101','huy1234','huyvanpham9898@gmail.com',N'Nam Định')
INSERT INTO Users Values ('MP102','tuan1234','tuanvanle9898@gmail.com',N'hà Nội')
INSERT INTO Users Values ('MP103','hai1234','haihuytruong9898@gmail.com',N'Nam Định')
INSERT INTO Users Values ('MP104','duy234','duyvanle9898@gmail.com',N'Nam Định')


--Bang Posts
INSERT INTO Posts Values(N'Công Nghệ Thông Tin',N'Học Lập trinh','CNTT',1,'1998-2-5','1999-6-7',1)
INSERT INTO Posts Values(N'Toán Học',N'Học Toán','CNTT',2,'1999-2-5','1999-6-7',2)
INSERT INTO Posts Values(N'Xây Dựng',N'Học Lập trinh','Xây Dựng',3,'1998-2-5','1999-6-7',3)
INSERT INTO Posts Values(N'Môi Trường',N'Học Lập trinh','CNTT',4,'1998-2-5','1999-6-7',4)
INSERT INTO Posts Values(N'Quản Trị',N'Học Lập trinh','CNTT',5,'1998-2-5','1999-6-7',5)

--Bang Comment
INSERT INTO Comments Values(N'Công Nghệ',1,'1999-5-2',N'Ok','ronaldo@gmail.com',1)
INSERT INTO Comments Values(N'Xây Dựng',2,'1999-5-2',N'Ok','messi@gmail.com',2)
INSERT INTO Comments Values(N'Môi Trường',3,'1999-5-2',N'Ok','quaresma@gmail.com',3)
INSERT INTO Comments Values(N'toán Học',4,'1999-5-2',N'Ok','hahyuya@gmail.com',4)
INSERT INTO Comments Values(N'Công Nghệ',5,'1999-5-2',N'Ok','ngocgiap@gmail.com',5)
--6 Create a query to select the postings has the ‘Social’ tag.
SELECT Tag
FROM Posts
WHERE Tag = 'Social'
--7 Create a query to select the postings that have author who has ‘abc@gmail.com’
--email.
SELECT  Title,Content,Status,CreateTime,UpdateTime
FROM Posts
WHERE PostID IN (SELECT PostID from Comments
WHERE Email='abc@gmail.com')
--8 Create a query to count the total comments of the posting.
SELECT COUNT(*) AS Total
FROM Comments
Group By PostID
--9Create a view named v_NewPost, this view includes Title, UserName and
--CreateTime of two lastest posting.
CREATE VIEW v_NewPost AS
SELECT Title,Username
FRom Posts as P
join Users AS u
On p.UserID = u.UserID
--1010.Create a stored procedure named sp_GetComment that accepts PostID as given
--input parameter and display all comments of the posting. [3 marks]
CREATE PROCEDURE sp_GetComment 
AS
BEGIN
SELECT CommentID,Status,Author,,CreateTime,Email
FROm Comments
ENd
--1111.Create a trigger nammed tg_UpdateTime to automatic update UpdateTime column
--in the Posts table to current time when the record in this table is updated.




