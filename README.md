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
