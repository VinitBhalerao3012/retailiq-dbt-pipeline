with invoices as (
    select * from {{ ref('stg_retail__invoices') }}
),

order_items as (
    select
        invoice_id,
        stock_code,
        description,
        quantity,
        unit_price,
        line_revenue,
        invoice_date,
        customer_id,
        country,
        is_return,
        is_cancelled,
        -- date dimensions
        date(invoice_date) as invoice_day,
        extract(year from invoice_date) as invoice_year,
        extract(month from invoice_date) as invoice_month,
        extract(dayofweek from invoice_date) as day_of_week
    from invoices
)

select * from order_items
