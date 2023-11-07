select
    ps_partkey as partkey,
    ps_suppkey as suppkey,
    ps_partkey || '-' || ps_suppkey as partsuppkey,
    ps_availqty as availqty,
    ps_supplycost as supplycost

from {{ source('tpch_sf1', 'partsupp') }}