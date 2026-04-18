# 🍕 Pizza Sales SQL Analysis Project

## 📌 Project Overview  
This project focuses on analyzing a pizza store's sales data using **SQL**. The goal is to extract meaningful insights such as revenue trends, customer behavior, and product performance.

---

## 🎯 Objectives  
- Analyze overall sales performance  
- Identify top-selling pizzas  
- Understand customer ordering patterns  
- Calculate revenue contribution by each pizza  
- Track daily and monthly trends  

---

## 🗂️ Dataset Description  
The dataset contains the following tables:

- **orders** → Order date and time  
- **order_details** → Quantity of pizzas per order  
- **pizzas** → Price and size of pizzas  
- **pizza_types** → Pizza names and categories  

---

## 🛠️ Tools & Technologies  
- SQL (MySQL / PostgreSQL)  
- Database Management System  

---

## 📊 Key Analysis Performed  

### 🔹 Basic Queries  
- Total number of orders  
- Total revenue generated  
- Highest priced pizza  

### 🔹 Intermediate Queries  
- Most common pizza size  
- Top 5 most ordered pizzas  
- Total quantity ordered per category  

### 🔹 Advanced Queries  
- Revenue contribution (%) of each pizza  
- Cumulative revenue over time  
- Peak order hours analysis  

---

## 📈 Sample Insights  
- 🍕 Peak order time is between **5 PM to 7 PM**  
- 💰 Certain pizzas contribute the majority of revenue  
- 📦 Medium size pizzas are ordered the most  

---

## 💡 Example SQL Query  

```sql
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;
```

---

## 🚀 How to Use  

1. Import the dataset into your SQL database  
2. Run the SQL queries provided in the project  
3. Analyze the results to gain insights  

---

## 📌 Project Highlights  
✔ Real-world dataset  
✔ Beginner to advanced SQL queries  
✔ Business-focused insights  
✔ Ready for portfolio showcase  

---
## 👨‍💻 Author

**Rajeshwar Jadhav**  
  

📧 Email: rajeshwarjadhav06@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/rajeshwar-jadhav-54241625a/)  
💻 [GitHub](https://github.com/rajeshwarjadhav06 )
