with order_items as (
    select * from {{ ref('int_retail__order_items') }}
),

product_performance as (
    select
        stock_code,
        description,
        count(distinct invoice_id) as total_orders,
        count(distinct customer_id) as unique_customers,
        sum(quantity) as total_units_sold,
        sum(line_revenue) as total_revenue,
        avg(unit_price) as avg_unit_price,
        avg(line_revenue) as avg_line_revenue,
        -- product ranking
        rank() over (order by sum(line_revenue) desc) as revenue_rank,
        rank() over (order by sum(quantity) desc) as volume_rank
    from order_items
    where
        description is not null
        and stock_code is not null
    group by
        stock_code,
        description
)

select * from product_performance
order by total_revenue desc
