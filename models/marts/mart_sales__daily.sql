with order_items as (
    select * from {{ ref('int_retail__order_items') }}
),

daily_sales as (
    select
        invoice_day,
        invoice_year,
        invoice_month,
        country,
        count(distinct invoice_id) as total_orders,
        count(distinct customer_id) as unique_customers,
        sum(quantity) as total_items_sold,
        sum(line_revenue) as total_revenue,
        avg(line_revenue) as avg_order_value
    from order_items
    group by
        invoice_day,
        invoice_year,
        invoice_month,
        country
)

select * from daily_sales
