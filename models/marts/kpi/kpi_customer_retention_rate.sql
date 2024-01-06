with

orders as (
    select * from {{ref('registry_fct_orders')}}
    {{ apply_partition_date() }}
),

orders_filtered as (
    select *
    from orders
    {{ write_where_by_vars() }}
),

customers_beginning_of_period as (
    select distinct custkey
    from orders_filtered
    where orderdate <= '{{var("startPeriod")}}'
),

customers_end_of_period as (
    select distinct custkey
    from orders_filtered
    where orderdate >= '{{var("startPeriod")}}' and orderdate <= '{{var("endPeriod")}}'
),

acquired_customers as (
    select * from customers_end_of_period
    except
    select * from customers_beginning_of_period
),

customer_retention_rate as (
    select
        {{ write_select_groupByColumns_by_vars() }}
        (((select count(*) from customers_end_of_period) -
        (select count(*) from acquired_customers)) /
        (select count(*) from customers_beginning_of_period)) * 100
        as customer_retention_rate
    from orders_filtered
),

final as (
    select
        {{ write_select_groupByColumns_by_vars() }}
        CAST(avg(customer_retention_rate) AS DECIMAL(10,2)) as customer_retention_rate
    from customer_retention_rate
    {{ write_groupBY_groupByColumns_by_vars() }}
)

select * from final
