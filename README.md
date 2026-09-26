# 📊 Sales Analytics & Business Intelligence — MySQL

## 📌 Project Overview

This project is an end-to-end **Sales Analytics and Business Intelligence project using MySQL**. It analyzes sales data across customers, products, orders, stores, regions, categories, suppliers, and employees to answer real-world business questions.

The project contains **130 SQL business-analysis questions**, progressing from basic SQL concepts to advanced analytical techniques.

---

## 🎯 Project Objectives

* Analyze sales and revenue performance.
* Understand customer purchasing behavior.
* Identify top-performing products and categories.
* Analyze store, region, and employee performance.
* Calculate business KPIs such as revenue and Average Order Value (AOV).
* Apply advanced SQL techniques to solve business problems.

---

## 🗂️ Database Structure

The project uses the following tables:

| Table           | Purpose                               |
| --------------- | ------------------------------------- |
| `customers`     | Customer information                  |
| `products`      | Product and pricing information       |
| `orders`        | Order transactions                    |
| `order_details` | Products and quantities within orders |
| `categories`    | Product categories                    |
| `suppliers`     | Supplier information                  |
| `stores`        | Store information                     |
| `regions`       | Regional information                  |
| `employees`     | Employee information                  |

### 🔗 Main Relationships

```text
customers
    ↓
orders
    ↓
order_details
    ↓
products
    ↓
categories
    ↓
suppliers

orders → stores → regions
orders → employees → regions
```

---

## 🧠 SQL Concepts Covered

### Basic SQL

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* Aggregate Functions

### Joins

* INNER JOIN
* LEFT JOIN
* Multi-table Joins

### Advanced SQL

* Subqueries
* CTEs
* CASE statements
* RANK()
* DENSE_RANK()
* ROW_NUMBER()
* LAG()
* LEAD()
* Window Functions

### Business Analysis

* Revenue Analysis
* Customer Analysis
* Product Performance
* Store Performance
* Regional Analysis
* Employee Performance
* Monthly Sales Analysis
* Customer Lifetime Revenue
* Repeat Customers
* Average Order Value

---

## 📈 Key Business Questions

Examples of questions answered in this project:

* Who are the top customers by revenue?
* Which products generate the highest revenue?
* Which categories perform best?
* Which regions generate the most sales?
* Which stores have the highest revenue?
* Which employees generate the most revenue?
* What is the monthly revenue trend?
* Which customers make repeat purchases?
* What is the Average Order Value?
* Which products perform best within each category?
* How does revenue vary across regions and stores?

---

## 🛠️ Tools & Technologies

* **Database:** MySQL
* **Language:** SQL
* **Version Control:** Git & GitHub

---

## 📂 Project Structure

```text
sales-analytics-sql-project/
│
├── sales_sql_db.sql
├── README.md
└── screenshots/
```

---

## 🚀 How to Run

### 1. Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/sales-analytics-sql-project.git
```

### 2. Open MySQL Workbench

### 3. Run the SQL script

Open:

```text
sales_sql_db.sql
```

Execute the script to create the database, tables, and analytical queries.

---

## 💡 Key Learning

This project helped me move beyond writing basic SQL queries toward using SQL to solve **real-world business problems**, perform analytical investigations, and generate actionable business insights.

---

## 👨‍💻 Author

**Deepak Malviya**

Data Analyst | SQL | Power BI | Python | Advanced Excel | DAX

📍 Hyderabad, India
