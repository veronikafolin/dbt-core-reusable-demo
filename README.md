# Demo on DBT Core + Snowflake

The database used is made available on Snowflake (Snowsight), after registering an account.

Dataset documentation: https://docs.snowflake.com/en/user-guide/sample-data-tpch

## Setup
* Clone the repository
* Create a [Trial Account](https://signup.snowflake.com/) in Snowflake
* [Setup](https://docs.getdbt.com/docs/core/connect-data-platform/snowflake-setup) the connection with the data platform
  with the method you prefer
* `dbt deps` to install packages specified in `packages.yml`

## Usage

Try running the following commands:
- `dbt run`
- `dbt run --m volume_orders --vars {"groupBy": ["cust_mktsegment", "cust_nation_name"], "filters": ["cust_region_name = 'AMERICA'"]}`
- `dbt test`
- `dbt build`
- `dbt build -m <model_name>`
- `dbt docs generate`