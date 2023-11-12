with

lineitem as (
    select * from {{ref('stg_lineitem')}}
),

orders as (
    select * from {{ref('fct_orders')}}
),

supplier as (
    select * from {{ref('dim_supplier')}}
),

final as (
    select
        *,
        {{ compute_discounted_extended_price('extendedprice', 'discount') }} as discounted_extended_price,
        {{ compute_discounted_extended_price_plus_tax('extendedprice', 'discount', 'tax') }} as discounted_extended_price_plus_tax
    from lineitem
    join orders using(orderkey)
    join supplier using(suppkey)
    order by orders.orderdate
)

select * from final