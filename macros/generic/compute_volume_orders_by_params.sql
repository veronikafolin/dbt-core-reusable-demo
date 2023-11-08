{% macro compute_volume_orders_by_params() %}

{% set columns = [] %}

{% for key, value in kwargs.items() %}
{% do columns.append(value) %}
{% endfor %}

{% for value in var("groupBy") %}
{% do columns.append(value) %}
{% endfor %}

select
    {% for value in columns %}
    {{value}},
    {% endfor %}
    min(orderdate) as first_order_date,
    max(orderdate) as most_recent_order_date,
    count(orderkey) as number_of_orders,
    sum(totalprice) as sum_total_price
from
    {{ref('fct_orders')}}
group by
    {% for value in columns %}
    {{value}}{% if not loop.last %},{% endif %}
    {% endfor %}

{% endmacro %}