# Data Analytics Lab

Repository created to document my learning journey in **Data Analytics**.

This project focuses on developing practical skills in **SQL, PostgreSQL, data modeling and analytical querying** while working with real datasets.

The objective is to progressively build **portfolio-ready data projects** that simulate real data analytics workflows.

---

# 📊 Technologies

Tools and technologies currently used in this repository:

- SQL
- PostgreSQL
- DBeaver
- Python *(learning stage)*
- Data analysis concepts

---

# 📚 Learning Focus

Topics currently being studied and practiced:

- SQL fundamentals
- Data modeling
- Database relationships
- Analytical querying
- Data aggregation
- Exploratory data analysis
- Data visualization *(next step)*

---

# 🚀 Current Projects

## Sprint 1 — SQL Fundamentals

Dataset used:

- Superstore Dataset

Concepts practiced:

- SELECT
- DISTINCT
- ORDER BY
- GROUP BY
- Aggregation functions (SUM, AVG, COUNT)

Example query:

```sql
SELECT order_date, SUM(sales)
FROM superstore
GROUP BY order_date
ORDER BY SUM(sales) DESC;
```
## Sprint 2 — Olist E-commerce Dataset

Dataset used:

- Olist Brazilian E-commerce Dataset

Activities performed:

- Data ingestion into PostgreSQL
- Schema creation and organization
- Table relationship analysis
- Foreign key validation
- Join validation queries
- Analytical SQL queries

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

# 📂 Repository Structure

```
data-analytics-lab
│
├── dashboards
│
├── datasets
│ ├── olist_dataset
│ └── superstore
│
├── docs
│ ├── schema_diagram_olist.png
│ └── schemas_notes.md
│
├── notebooks
│
├── sql
│ ├── analysis
│ │ ├── olist_analysis.sql
│ │ └── superstore_analysis.sql
│ │
│ ├── ingestion
│ │ ├── 01_create_schemas.sql
│ │ ├── 02_ingestion_superstore.sql
│ │ ├── 03_ingestion_olist.sql
│ │ ├── 04_modeling_olist.sql
│ │ └── 05_validation_olist.sql
│ │
│ └── constraint
│
└── README.md
```

---

# 📊 Key Analytical Concepts Practiced

Some important data analytics practices applied in this project:

- metric granularity awareness  
- avoiding duplicated counts caused by joins  
- distinguishing **order-level vs item-level metrics**  
- analytical SQL query structuring  
- use of **CTEs**  
- use of **window functions**

---

# 🎯 Learning Goal

Develop a strong foundation in:

- SQL  
- Data modeling  
- Analytical thinking  
- Data analysis workflows  
- Python for data analysis  
- Data visualization  

while progressively building a **professional data analytics portfolio**.

---

# 👨‍💻 Author

Felipe Mendes

GitHub:  
https://github.com/Felipee-M