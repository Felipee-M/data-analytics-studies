# Data Analytics Lab

Repository created to document my journey into **Data Analytics**, focusing on building strong foundations in **SQL, data modeling, and analytical thinking** through hands-on projects using real-world datasets.

The goal of this repository is to simulate real data workflows and progressively build **portfolio-ready projects** that demonstrate both technical and analytical skills.

---

# 📊 Technologies

Tools and technologies used in this project:

- SQL
- PostgreSQL
- DBeaver
- Python *(learning stage)*
- Git & GitHub

---

# 📚 Learning Focus

Core topics currently being developed:

- SQL fundamentals and advanced querying
- Data modeling and relational databases
- Data aggregation and metric design
- Analytical problem solving
- Exploratory data analysis (EDA)
- Data storytelling *(in progress)*
- Data visualization *(next step)*

---

# 🚀 Projects

## 🟢 Sprint 1 — SQL Fundamentals

**Dataset used:**

- Superstore Dataset

**Concepts practiced:**

- SELECT, DISTINCT
- ORDER BY
- GROUP BY
- Aggregations (SUM, AVG, COUNT)

**Example query:**

```sql
SELECT order_date, SUM(sales)
FROM superstore
GROUP BY order_date
ORDER BY SUM(sales) DESC;
```

---

## 🟡 Sprint 2 — Olist E-commerce Dataset

**Dataset used:**

- Olist Brazilian E-commerce Dataset

**Activities performed:**

- Data ingestion into PostgreSQL
- Schema creation and organization
- Table relationship analysis
- Foreign key validation
- Join validation queries
- Analytical SQL queries

**Main tables explored:**

- customers
- orders
- order_items
- order_payments
- order_reviews
- products
- sellers
- geolocation
- product_category_name_translation

**Example validation query:**

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

## 🔵 Sprint 3 — Advanced Analytical Queries

**Dataset used:**

- Olist Brazilian E-commerce Dataset

**Activities performed:**

- Development of analytical queries using CTEs
- Development of analytical queries using subqueries
- Revenue analysis by customer, order, and month
- Identification of recurring customers
- Comparison of metrics against average values
- Practice with business-oriented SQL logic

**Concepts practiced:**

- Common Table Expressions (CTEs)
- Subqueries
- EXISTS
- HAVING
- Aggregation over aggregation
- Metric comparison with averages

**Key analyses implemented:**

- Top 10 customers by total revenue
- Most sold products by quantity
- Monthly revenue
- Recurring customers
- Average ticket per order
- Customers with above-average spending
- Products with above-average average price
- Orders with above-average value
- Customers with at least 1 delivered order
- Months with above-average revenue

**Example query:**

```sql
WITH total_per_order AS (
    SELECT
        order_id,
        SUM(price + freight_value) AS total_revenue
    FROM order_items
    GROUP BY order_id
),
valid_orders AS (
    SELECT
        o.order_id
    FROM orders o
    WHERE o.order_approved_at IS NOT NULL
) total_per_order tpo
JOIN valid_orders vo
    ON tpo.order_id = vo.order_id;
```

---

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
│ │ └── olist_advanced_queries.sql
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

This project applies important real-world data analysis principles:

- metric granularity awareness  
- avoiding duplication caused by joins  
- distinction between **order-level vs item-level metrics**  
- structured analytical SQL development  
- use of **CTEs and subqueries** for complex logic  
- performance vs readability trade-offs  

---

# 🎯 Learning Goals

Build a strong foundation in:

- SQL (advanced level)
- Data modeling
- Analytical thinking
- Data workflows
- Python for data analysis
- Data visualization (Power BI / future dashboards)

---

# 📌 Next Steps

- Implement exploratory data analysis (EDA) in Python  
- Build dashboards (Power BI)  
- Create end-to-end data projects (SQL + Python + Visualization)  
- Improve storytelling and business insights  

---

# 👨‍💻 Author

Felipe Mendes  

GitHub:  
https://github.com/Felipee-M
