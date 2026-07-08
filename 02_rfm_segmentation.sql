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
