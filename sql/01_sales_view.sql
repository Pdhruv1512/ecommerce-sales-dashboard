-- One flat table for the dashboard: each row is one product in one order.
-- Only real rows are kept (order_item_id <= 4183); higher IDs are test data from the DBA project.

CREATE OR REPLACE VIEW sales AS
SELECT
    oi.order_item_id,
    o.order_id,
    o.order_date,
    o.payment_method,
    o.is_returned,
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.region,
    p.product_name,
    p.category,
    p.unit_price,
    oi.quantity,
    oi.quantity * p.unit_price AS revenue
FROM order_items oi
JOIN orders    o ON o.order_id    = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
JOIN products  p ON p.product_id  = oi.product_id
WHERE oi.order_item_id <= 4183;