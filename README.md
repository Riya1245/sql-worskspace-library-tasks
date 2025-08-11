# 📚 SQL Task 4: Aggregate Functions and Grouping – LibraryDB

## 🎯 Objective

This task demonstrates how to apply SQL aggregate functions and grouping techniques using a custom `LibraryDB` database. The goal is to analyze borrowing data, book categorization, and author contributions using SQL features like:

- `COUNT()`
- `AVG()`
- `SUM()`
- `GROUP BY`
- `HAVING`
- `DISTINCT`
- `ORDER BY`

---

## 🗃️ Database Schema

The project uses the following tables:

- `Authors` – stores author details
- `Categories` – stores book categories
- `Books` – stores book titles with references to authors and categories
- `Members` – stores library member info
- `Borrow` – records when a member borrows a book

---

## 🧠 Key SQL Queries & Concepts

### 1. 📊 Count of books by each author
```sql
SELECT a.Name AS Author, COUNT(b.BookID) AS TotalBooks
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
GROUP BY a.Name;
# 📚 LibraryDB – SQL Joins Practice

## 🎯 Task 5: SQL Joins (Inner, Left, Right, Full)

This project is part of the SQL Developer Internship. The objective is to demonstrate proficiency in using various types of SQL JOINs by building and querying a Library Management System database.

---

## 🗃️ Database Schema

The database `LibraryDB` consists of the following tables:

| Table      | Description                          |
|------------|--------------------------------------|
| `Authors`  | Stores author information            |
| `Categories` | Stores book category details       |
| `Books`    | Stores book records, linked to Authors and Categories |
| `Members`  | Stores library member information    |
| `Borrow`   | Stores borrow transactions (which member borrowed which book, and when) |

---

## 📦 Files Included

| File                | Description                          |
|---------------------|--------------------------------------|
| `create_tables.sql` | SQL code to create all tables        |
| `insert_data.sql`   | Sample data insertion for testing    |
| `join_queries.sql`  | All required JOIN queries            |
| `README.md`         | This documentation file              |

---

## 🛠️ Tools Used

- MySQL Workbench (or any SQL client)
- SQL (Structured Query Language)

---

## 🔗 SQL Join Types Demonstrated

### 🔹 INNER JOIN
Returns rows with matching values in both tables.
```sql
SELECT b.Title, a.Name AS Author
FROM Books b
INNER JOIN Authors a ON b.AuthorID = a.AuthorID;
