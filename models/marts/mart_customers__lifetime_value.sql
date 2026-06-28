with customer_orders as (
    select * from {{ ref('int_retail__customer_orders') }}
),

clv_segmented as (
    select
        customer_id,
        country,
        total_orders,
        total_revenue,
        avg_order_value,
        total_items_purchased,
        first_order_date,
        last_order_date,
        customer_lifespan_days,
        -- CLV segmentation
        case
            when total_revenue >= 1000 then 'High Value'
            when total_revenue >= 300 then 'Medium Value'
            else 'Low Value'
        end as clv_segment,
        -- customer type
        case
            when total_orders = 1 then 'One-Time'
            when total_orders between 2 and 5 then 'Returning'
            else 'Loyal'
        end as customer_type
    from customer_orders
)

select * from clv_segmented
