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

---

## 🔵 Sprint 3 — Advanced Analytical Queries

**Dataset used:**

- Olist Brazilian E-commerce Dataset

**Activities performed:**

- Development of analytical queries using CTEs and subqueries
- Revenue analysis by customer, order, and month
- Identification of recurring customers
- Comparison of metrics against average values

**Concepts practiced:**

- Common Table Expressions (CTEs)
- Subqueries
- EXISTS
- HAVING
- Aggregation over aggregation
- Metric comparison with averages

**Key analyses implemented:**

- Top customers by revenue
- Most sold products
- Monthly revenue
- Recurring customers
- Average ticket
- Above-average performance analysis

---

## 🟣 Sprint 4 — Window Functions & Advanced Analytics

**Dataset used:**

- Olist Brazilian E-commerce Dataset

**Activities performed:**

- Ranking of products and customers
- Revenue share and cumulative contribution analysis
- Monthly performance analysis (MoM)
- Customer purchase history construction

**Concepts practiced:**

- Window Functions
- RANK()
- ROW_NUMBER()
- FIRST_VALUE()
- LAG()
- Cumulative metrics (running totals)
- Analytical partitioning

**Key analyses implemented:**

- Product ranking by revenue and volume
- Customer ranking by total spend
- Revenue share and cumulative contribution (Pareto logic)
- Monthly variation of orders and revenue (MoM)
- Customer purchase journey tracking

---

# 📂 Repository Structure

```
data-analytics-lab
│
├── dashboards
│
├── data_env
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
├── projects
│
├── sql
│ ├── analysis
│ │ ├── olist_analysis.sql
│ │ ├── olist_advanced_queries.sql
│ │ ├── olist_window_analysis.sql
│ │ └── superstore_analysis.sql
│ │
│ ├── constraint
│ │
│ ├── ingestion
│ │ ├── 01_create_schemas.sql
│ │ ├── 02_ingestion_superstore.sql
│ │ ├── 03_ingestion_olist.sql
│ │ ├── 04_modeling_olist.sql
│ │ └── 05_validation_olist.sql
│ │
│ └── validation
│
├── .gitignore
└── README.md
```







---

# 📊 Key Analytical Concepts Practiced

This project applies important real-world data analysis principles:

- metric granularity awareness  
- avoiding duplication caused by joins  
- distinction between **order-level vs item-level metrics**  
- structured analytical SQL development  
- use of **CTEs and window functions**  
- cumulative analysis (running totals and contribution %)  
- ranking and segmentation logic  
- analytical ordering and partitioning  
- performance vs readability trade-offs  

---

# 🎯 Learning Goals

Build a strong foundation in:

- SQL (advanced level)
- Data modeling
- Analytical thinking
- Data workflows
- Python for data analysis
- Data visualization (Power BI / dashboards)

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
