WITH CustomerOrderCounts AS (
    SELECT 
        customers.customer_unique_id,
        COUNT(orders.order_id) AS total_purchases
    FROM 
        olist_orders_dataset AS orders
    JOIN 
        olist_customers_dataset AS customers 
        ON orders.customer_id = customers.customer_id
    WHERE 
        orders.order_status = 'delivered'
    GROUP BY 
        customers.customer_unique_id
)
SELECT 
    total_purchases,
    COUNT(customer_unique_id) AS number_of_customers
FROM 
    CustomerOrderCounts
GROUP BY 
    total_purchases
ORDER BY 
    total_purchases DESC;
