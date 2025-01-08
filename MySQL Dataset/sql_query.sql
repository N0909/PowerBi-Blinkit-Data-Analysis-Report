CREATE VIEW master_table AS 
SELECT 
    orders.order_id AS order_id,
    customer.customer_id AS customer_id,
    orders.delivery_partner_id AS delivery_partner_id,
    order_item.product_id AS product_id,
    customer_feedbacks.feedback_id AS feedback_id,
    orders.order_date AS order_datetime,
    customer.area AS area,
    customer.customer_name AS customer_name,
    customer.customer_segment AS customer_segment,
    products.product_name AS product_name,
    products.category AS category,
    products.price AS price,
    order_item.quantity AS quantity,
    ROUND((products.price * order_item.quantity), 2) AS Sales,
    orders.payment_method AS payment_method,
    delivery.promised_time AS promised_time,
    delivery.actual_time AS actual_time,
    delivery.delivery_time_minutes AS delivery_time_minutes,
    delivery.reasons_if_delayed AS reasons_if_delayed,
    customer_feedbacks.rating AS rating,
    customer_feedbacks.feedback_category AS feedback_category,
    customer_feedbacks.feedback_text AS feedback_text,
    customer_feedbacks.sentiment AS feedback_segment,
    rating.Emoji AS Emoji,
    rating.Star AS star,
    category.Img AS img,
    CAST(orders.order_date AS DATE) AS Date
FROM
    orders
    JOIN customer ON orders.customer_id = customer.customer_id
    JOIN order_item ON ROUND(order_item.order_id, 0) = orders.order_id
    JOIN products ON order_item.product_id = ROUND(products.product_id, 0)
    JOIN customer_feedbacks ON customer_feedbacks.customer_id = orders.customer_id
                            AND customer_feedbacks.order_id = orders.order_id
    JOIN delivery ON delivery.delivery_partner_id = orders.delivery_partner_id
                  AND delivery.order_id = orders.order_id
    JOIN rating ON customer_feedbacks.rating = rating.Rating
    JOIN category ON products.category = category.category;
