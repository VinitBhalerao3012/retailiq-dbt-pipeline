with order_items as (
    select * from {{ ref('int_retail__order_items') }}
),

customer_orders as (
    select
        customer_id,
        country,
        count(distinct invoice_id) as total_orders,
        sum(line_revenue) as total_revenue,
        avg(line_revenue) as avg_order_value,
        min(invoice_day) as first_order_date,
        max(invoice_day) as last_order_date,
        date_diff(max(invoice_day), min(invoice_day), day) as customer_lifespan_days,
        sum(quantity) as total_items_purchased
    from order_items
    group by
        customer_id,
        country
)

select * from customer_orders
