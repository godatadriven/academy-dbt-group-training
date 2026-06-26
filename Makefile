# Handy commands for the dbt DuckDB training. Run these from the repo root.
#
#   make show-tables   List every schema + table in your DuckDB database.

.PHONY: show-tables

show-tables:
	cd jaffle_shop && dbt show --limit -1 --inline \
		"select table_schema, table_name \
		 from information_schema.tables \
		 order by table_schema, table_name"
