with source as (
    select * from `neat-responder-426714-d8`.`retailiq`.`raw_retail_2009_2010`
    union all
    select * from `neat-responder-426714-d8`.`retailiq`.`raw_retail_2010_2011`
),

cleaned as (
    select
        Invoice as invoice_id,
        StockCode as stock_code,
        Description as description,
        Quantity as quantity,
        InvoiceDate as invoice_date,
        Price as unit_price,
        `Customer ID` as customer_id,
        Country as country,
        Quantity * Price as line_revenue,
        case when Quantity < 0 then true else false end as is_return,
        case when Invoice like 'C%' then true else false end as is_cancelled
    from source
    where
        Quantity > 0
        and Price > 0
        and `Customer ID` is not null
)

select * from cleaned
