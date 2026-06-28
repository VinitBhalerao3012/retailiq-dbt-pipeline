with source as (
    select * from `neat-responder-426714-d8`.`retailiq`.`raw_retail_2009_2010`
    union all
    select * from `neat-responder-426714-d8`.`retailiq`.`raw_retail_2010_2011`
),

customers as (
    select
        `Customer ID` as customer_id,
        Country as country
    from source
    where
        `Customer ID` is not null
        and Quantity > 0
        and Price > 0
),

deduplicated as (
    select
        customer_id,
        max(country) as country
    from customers
    group by customer_id
)

select * from deduplicated
