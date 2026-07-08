# 🛒 E-Commerce Customer Retention & Sales Analytics

## 📌 Executive Summary
An end-to-end SQL analysis of a Brazilian e-commerce platform to uncover customer purchasing behaviors, geographic sales trends, and retention bottlenecks. The project utilizes advanced SQL to transform raw transaction data into actionable business intelligence, culminating in an RFM (Recency, Frequency, Monetary) segmentation model to identify high-value customers at risk of churn.

## 🛠️ Technical Skills Showcased
* **Advanced SQL:** Common Table Expressions (CTEs), Window Functions, Multiple `JOIN`s, Aggregations.
* **Data Wrangling:** Date/Time manipulation (`strftime`, `julianday`), data type casting, and handling NULLs.
* **Tools Used:** SQLite, DB Browser, GitHub.

## 💡 Key Business Insights
1. **The "One-and-Done" Bottleneck:** Out of ~93,000 unique users, **90,557 (97%)** purchased exactly once. 
   * *Recommendation:* Implement a targeted post-purchase email sequence and first-time buyer discount to drive repeat purchases.
2. **Geographic Dominance:** São Paulo (SP) is the platform's undisputed core market, accounting for over 40,000 delivered orders—more than the next three states combined.
   * *Recommendation:* Optimize logistics and warehouse placement heavily around the SP region to reduce delivery times and costs.
3. **High-Value Churn Risk:** The platform's highest lifetime-value customer (>$13,600 spent) has not made a purchase in 336 days. 
   * *Recommendation:* Deploy an automated RFM-triggered VIP retention campaign to re-engage top spenders before they permanently churn.

## 💻 Featured Code: RFM Analysis
This query segments customers based on their last purchase date, total orders, and total money spent. 

```sql
SELECT 
    c.customer_unique_id,
    CAST(julianday('2018-09-01') - julianday(MAX(o.order_purchase_timestamp)) AS INTEGER) AS recency_days,
    COUNT(DISTINCT o.order_id) AS frequency,
    ROUND(SUM(p.payment_value), 2) AS monetary_value
FROM 
    olist_orders_dataset o
JOIN 
    olist_customers_dataset c 
    ON o.customer_id = c.customer_id
JOIN 
    olist_order_payments_dataset p 
    ON o.order_id = p.order_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
    c.customer_unique_id
ORDER BY 
    monetary_value DESC
LIMIT 10;
