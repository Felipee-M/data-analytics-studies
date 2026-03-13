# Data Analytics Studies

Repository created to document my learning journey in **Data Analytics**.

This project contains datasets exploration, database modeling and analytical queries developed while studying **SQL, PostgreSQL and Python for data analysis**.

The goal is to progressively build practical projects while strengthening core concepts used in real data analytics workflows.

---

# 📊 Technologies

Technologies and tools currently used in this repository:

- SQL
- PostgreSQL
- DBeaver
- Python *(learning stage)*
- Data analysis concepts

---

# 📚 Learning Track

This repository is part of my transition and professional development in **Data Analytics**.

Topics currently being studied:

- SQL fundamentals
- Data modeling
- Database relationships
- Data querying
- Data aggregation
- Exploratory data analysis
- Data visualization *(next step)*

---

# 🚀 Current Progress

## Sprint 1 — SQL Fundamentals

Concepts practiced:

- SELECT
- DISTINCT
- ORDER BY
- GROUP BY
- Aggregation functions (SUM)

Dataset used:

- Superstore dataset

Example query:

```sql
SELECT order_date, SUM(sales)
FROM superstore
GROUP BY order_date
ORDER BY SUM(sales) DESC;
```

---

## Sprint 2 — E-commerce Dataset Exploration

Dataset used:

- Olist Brazilian E-commerce Dataset

Activities performed:

- Data ingestion into PostgreSQL
- Schema organization (`olist`)
- Table relationship analysis
- Foreign key creation
- Join validation queries
- Initial analytical exploration

Main tables explored:

- customers
- orders
- order_items
- order_payments
- order_reviews
- products
- sellers
- geolocation
- product_category_name_translation

Example validation query:

```sql
SELECT
    oi.product_id,
    COUNT(*)
FROM olist.products p
JOIN olist.order_items oi
    ON p.product_id = oi.product_id
GROUP BY oi.product_id
LIMIT 10;
```

---

# 📂 Repository Structure

```
data-analytics-studies
│
├── datasets
│   ├── superstore
│   └── olist
│
├── sprint_01_sql
│   └── queries.sql
│
├── sprint_02_olist
│   ├── ingestion
│   ├── relationships
│   ├── validations
│   └── analysis
│
└── README.md
```

---

# 🎯 Project Goals

Develop a solid foundation in:

- SQL
- Data modeling
- Data analysis
- Python for data analysis
- Data visualization

and progressively build **portfolio-ready data projects**.

---

# 👨‍💻 Author

Felipe Mendes

GitHub:  
https://github.com/Felipee-M