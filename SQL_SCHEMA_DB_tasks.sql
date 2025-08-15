CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(150),
    AuthorID INT,
    CategoryID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

CREATE TABLE Borrow (
    BorrowID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT,
    BookID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


-- Authors
INSERT INTO Authors (Name) VALUES ('Chetan Bhagat'), ('J.K. Rowling');

-- Categories
INSERT INTO Categories (CategoryName) VALUES ('Fiction'), ('Science');

-- Books
INSERT INTO Books (Title, AuthorID, CategoryID) 
VALUES 
('2 States', 1, 1),
('Harry Potter', 2, 1);

-- Members
INSERT INTO Members (Name, Email)
VALUES
('Rahul Sharma', 'rahul@example.com'),
('Anita Verma', 'anita@example.com');

-- Borrow
INSERT INTO Borrow (MemberID, BookID, BorrowDate, ReturnDate)
VALUES 
(1, 1, '2025-08-01', '2025-08-10'),
(2, 2, '2025-08-02', NULL);

SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Borrow;

SET SQL_SAFE_UPDATES = 0;

UPDATE Authors  
SET Name = 'Chetan B.'  
WHERE Name = 'Chetan Bhagat';

UPDATE Authors
SET Name = 'Chetan B.'
WHERE AuthorID = 1;  -- Because 'Chetan Bhagat' has AuthorID = 1


UPDATE Authors
SET Name = 'Chetan B.'
WHERE Name = 'Chetan Bhagat';

UPDATE Books
SET Title = 'Harry Potter and the Philosopher\'s Stone'
WHERE Title = 'Harry Potter';

UPDATE Books
SET Title = 'Harry Potter and the Philosopher\'s Stone'
WHERE BookID = 2;  -- BookID 2 corresponds to 'Harry Potter'

UPDATE Members
SET Email = 'rahul.sharma@library.com'
WHERE Name = 'Rahul Sharma';


UPDATE Members
SET Email = 'rahul.sharma@library.com'
WHERE MemberID = 1;  -- Rahul Sharma's MemberID


UPDATE Borrow
SET ReturnDate = '2025-08-12'
WHERE BorrowID = 2;

DELETE FROM Members
WHERE Name = 'Anita Verma';

-- First delete borrow record
DELETE FROM Borrow
WHERE MemberID = 2;

-- Then delete member
DELETE FROM Members
WHERE MemberID = 2;

-- First delete borrow entry
DELETE FROM Borrow
WHERE BookID = 1;

-- Then delete book
DELETE FROM Books
WHERE BookID = 1;

-- First delete books in that category
DELETE FROM Books
WHERE CategoryID = 1;

-- Then delete category
DELETE FROM Categories
WHERE CategoryID = 1;

SELECT Title, AuthorID FROM Books;

SELECT * FROM Authors WHERE Name = 'Chetan B.';

SELECT * FROM Books 
WHERE AuthorID = 2 AND CategoryID = 1;

SELECT * FROM Members 
WHERE Name = 'Rahul Sharma' OR Name = 'Anita Verma';

SELECT * FROM Books 
WHERE Title LIKE '%Harry%';

SELECT * FROM Borrow 
WHERE BorrowDate BETWEEN '2025-08-01' AND '2025-08-05';

SELECT * FROM Borrow 
ORDER BY BorrowDate;

SELECT * FROM Borrow 
ORDER BY ReturnDate DESC;

SELECT * FROM Books 
LIMIT 1;

SELECT DISTINCT CategoryID FROM Books;

SELECT Name AS AuthorName FROM Authors;

SELECT * FROM Authors 
WHERE Name IN ('Chetan B.', 'J.K. Rowling');

-- Count of books by each author
SELECT a.Name AS Author, COUNT(b.BookID) AS TotalBooks
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
GROUP BY a.Name;

-- Count of books per category
SELECT c.CategoryName, COUNT(b.BookID) AS BookCount
FROM Categories c
JOIN Books b ON c.CategoryID = b.CategoryID
GROUP BY c.CategoryName;

-- Number of books borrowed by each member
SELECT m.Name AS Member, COUNT(br.BorrowID) AS BorrowedBooks
FROM Members m
JOIN Borrow br ON m.MemberID = br.MemberID
GROUP BY m.Name;
 
 -- Average number of days to return a book
 SELECT AVG(DATEDIFF(ReturnDate, BorrowDate)) AS AvgReturnDays
FROM Borrow
WHERE ReturnDate IS NOT NULL;

-- Borrow records grouped by borrow date
SELECT BorrowDate, COUNT(*) AS TotalBorrows
FROM Borrow
GROUP BY BorrowDate;

-- List of authors who have written more than 1 book
SELECT a.Name, COUNT(b.BookID) AS BookCount
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
GROUP BY a.Name
HAVING COUNT(b.BookID) > 1;

-- Total books and average ID of books per category
SELECT c.CategoryName, COUNT(b.BookID) AS TotalBooks, AVG(b.BookID) AS AvgBookID
FROM Categories c
JOIN Books b ON c.CategoryID = b.CategoryID
GROUP BY c.CategoryName;

-- Number of borrows per book

SELECT bk.Title, COUNT(br.BorrowID) AS TimesBorrowed
FROM Books bk
JOIN Borrow br ON bk.BookID = br.BookID
GROUP BY bk.Title;

-- Categories with more than 1 book (HAVING example
SELECT c.CategoryName, COUNT(b.BookID) AS BookCount
FROM Categories c
JOIN Books b ON c.CategoryID = b.CategoryID
GROUP BY c.CategoryName
HAVING COUNT(b.BookID) > 1;

-- List of all distinct authors whose books have been borrowed
SELECT DISTINCT a.Name AS Author
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
JOIN Borrow br ON b.BookID = br.BookID;

-- Find books and their authors
SELECT b.Title, a.Name AS Author
FROM Books b
INNER JOIN Authors a ON b.AuthorID = a.AuthorID;

-- 2. LEFT JOIN
--  List all books, even those without authors (if any)
SELECT b.Title, a.Name AS Author
FROM Books b
LEFT JOIN Authors a ON b.AuthorID = a.AuthorID;

-- 3. RIGHT JOIN
SELECT a.Name AS Author, b.Title
FROM Books b
RIGHT JOIN Authors a ON b.AuthorID = a.AuthorID;

-- 4. FULL OUTER JOIN (Simulated using UNION)
SELECT a.Name AS Author, b.Title
FROM Authors a
LEFT JOIN Books b ON a.AuthorID = b.AuthorID

UNION

SELECT a.Name AS Author, b.Title
FROM Authors a
RIGHT JOIN Books b ON a.AuthorID = b.AuthorID;

-- 5. JOIN with Borrow, Members, Books
SELECT br.BorrowID, m.Name AS Member, b.Title AS Book, br.BorrowDate, br.ReturnDate
FROM Borrow br
INNER JOIN Members m ON br.MemberID = m.MemberID
INNER JOIN Books b ON br.BookID = b.BookID;

-- 6. LEFT JOIN: List all members and their borrow records (even if they borrowed nothing)
SELECT m.Name AS Member, b.Title AS Book, br.BorrowDate
FROM Members m
LEFT JOIN Borrow br ON m.MemberID = br.MemberID
LEFT JOIN Books b ON br.BookID = b.BookID;

--  7. RIGHT JOIN: List all books and who borrowed them (if anyone)
SELECT b.Title, m.Name AS Borrower
FROM Borrow br
RIGHT JOIN Books b ON br.BookID = b.BookID
LEFT JOIN Members m ON br.MemberID = m.MemberID;

-- 8.  FULL JOIN Simulation: Members and their borrows
SELECT m.Name AS Member, b.Title AS Book
FROM Members m
LEFT JOIN Borrow br ON m.MemberID = br.MemberID
LEFT JOIN Books b ON br.BookID = b.BookID

UNION

SELECT m.Name AS Member, b.Title AS Book
FROM Members m
RIGHT JOIN Borrow br ON m.MemberID = br.MemberID
RIGHT JOIN Books b ON br.BookID = b.BookID;
-- 1. Scalar Subquery in SELECT

SELECT Title, 
       (SELECT AVG(BookID) FROM Books) AS AvgBookID
FROM Books;

-- 2. Subquery in WHERE with IN

SELECT Name 
FROM Members 
WHERE MemberID IN (
    SELECT br.MemberID
    FROM Borrow br
    JOIN Books b ON br.BookID = b.BookID
    JOIN Authors a ON b.AuthorID = a.AuthorID
    WHERE a.Name = 'J.K. Rowling'
);

-- 3. Correlated Subquery in WHERE

SELECT Title
FROM Books b1
WHERE BookID > (
    SELECT AVG(b2.BookID)
    FROM Books b2
    WHERE b2.CategoryID = b1.CategoryID
);
 
-- 4. Subquery in FROM Clause (Derived Table) 

SELECT c.CategoryName, avgdata.AvgBookID
FROM (
    SELECT CategoryID, AVG(BookID) AS AvgBookID
    FROM Books
    GROUP BY CategoryID
) avgdata
JOIN Categories c ON c.CategoryID = avgdata.CategoryID;

-- 5. Subquery with EXISTS

SELECT Name 
FROM Authors a
WHERE EXISTS (
    SELECT 1
    FROM Books b
    JOIN Borrow br ON b.BookID = br.BookID
    WHERE b.AuthorID = a.AuthorID
);

-- 6. Subquery with EXISTS

SELECT Name 
FROM Authors a
WHERE EXISTS (
    SELECT 1
    FROM Books b
    JOIN Borrow br ON b.BookID = br.BookID
    WHERE b.AuthorID = a.AuthorID
);

7. Subquery in WHERE with =
-- Find books written by the author with the highest number of books:
SELECT Title
FROM Books
WHERE AuthorID = (
    SELECT AuthorID
    FROM Books
    GROUP BY AuthorID
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
-- . Correlated Subquery with AVG Return Days
 -- List borrow records where the return duration is greater than average return duration:


SELECT *
FROM Borrow br1
WHERE DATEDIFF(br1.ReturnDate, br1.BorrowDate) > (
    SELECT AVG(DATEDIFF(ReturnDate, BorrowDate))
    FROM Borrow
    WHERE ReturnDate IS NOT NULL
);
-- 9. Subquery in WHERE with NOT IN
 -- Find members who haven’t borrowed any book:
SELECT Name
FROM Members
WHERE MemberID NOT IN (
    SELECT DISTINCT MemberID FROM Borrow
);

--  10. Subquery in FROM for Author Book Counts

SELECT Name, BookCount
FROM (
    SELECT a.Name, COUNT(b.BookID) AS BookCount
    FROM Authors a
    JOIN Books b ON a.AuthorID = b.AuthorID
    GROUP BY a.Name
) AS AuthorBookCounts
WHERE BookCount > 1;

-- ✅ Purpose: Show full book details including title, author name, and category.
CREATE VIEW BookDetailsView AS
SELECT 
    b.BookID,
    b.Title,
    a.Name AS Author,
    c.CategoryName
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
JOIN Categories c ON b.CategoryID = c.CategoryID;

SELECT * FROM BookDetailsView WHERE CategoryName = 'Fiction';

-- Show borrow details with member name and book title
CREATE VIEW BorrowedBooksView AS
SELECT 
    br.BorrowID,
    m.Name AS Member,
    b.Title AS Book,
    br.BorrowDate,
    br.ReturnDate
FROM Borrow br
JOIN Members m ON br.MemberID = m.MemberID
JOIN Books b ON br.BookID = b.BookID;
SELECT * FROM BorrowedBooksView WHERE ReturnDate IS NULL;

-- View: MemberBorrowCountView
CREATE VIEW MemberBorrowCountView AS
SELECT 
    m.Name AS Member,
    COUNT(br.BorrowID) AS TotalBorrows
FROM Members m
LEFT JOIN Borrow br ON m.MemberID = br.MemberID
GROUP BY m.Name;
SELECT * FROM MemberBorrowCountView ORDER BY TotalBorrows DESC;

-- Show number of books per author
CREATE VIEW AuthorBookCountView AS
SELECT 
    a.Name AS Author,
    COUNT(b.BookID) AS BookCount
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
GROUP BY a.Name;
SELECT * FROM AuthorBookCountView WHERE BookCount > 1;

-- Track average number of days taken to return books
CREATE VIEW AverageReturnDaysView AS
SELECT 
    AVG(DATEDIFF(ReturnDate, BorrowDate)) AS AvgReturnDays
FROM Borrow
WHERE ReturnDate IS NOT NULL;
SELECT * FROM AverageReturnDaysView;
DROP VIEW IF EXISTS BookDetailsView;
 
 -- View: SafeMembersView
CREATE VIEW SafeMembersView AS
SELECT 
    Name
FROM Members;

-- Purpose: Show all books written by a given author (by name)
DELIMITER //

CREATE PROCEDURE GetBooksByAuthor(
    IN author_name VARCHAR(100)
)
BEGIN
    SELECT b.Title, a.Name AS Author
    FROM Books b
    JOIN Authors a ON b.AuthorID = a.AuthorID
    WHERE a.Name = author_name;
END //

DELIMITER ;
-- 📥 How to call it:
CALL GetBooksByAuthor('J.K. Rowling');

-- 2. Function: TotalBorrowedBooks 📌 Purpose: Return total number of books borrowed by a member (by Member ID)
DELIMITER //

CREATE FUNCTION TotalBorrowedBooks(member_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM Borrow
    WHERE MemberID = member_id;

    RETURN total;
END //

DELIMITER ;
-- How to call it:
SELECT TotalBorrowedBooks(1);  -- Replace with actual MemberID





