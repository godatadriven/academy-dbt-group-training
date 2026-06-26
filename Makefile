# Handy commands for the dbt DuckDB training.
# These work no matter which directory you run them from — paths are resolved
# relative to this Makefile, not your current directory.
#
#   make show-tables   List every schema + table in your DuckDB database.

# Absolute path to the directory containing this Makefile (the repo root).
ROOT_DIR := $(patsubst %/,%,$(dir $(realpath $(firstword $(MAKEFILE_LIST)))))

.PHONY: show-tables

show-tables:
	cd $(ROOT_DIR)/jaffle_shop && uv run dbt show --limit -1 --inline \
		"select table_schema, table_name \
		 from information_schema.tables \
		 order by table_schema, table_name"
