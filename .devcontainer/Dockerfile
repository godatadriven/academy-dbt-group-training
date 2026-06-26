FROM mcr.microsoft.com/devcontainers/python:3.12

# This training runs entirely on a local DuckDB database, so there is no cloud
# SDK or warehouse driver to install — just Python and the dbt-duckdb adapter
# (installed from requirements.txt in the postCreateCommand).

# Install the DuckDB CLI so students can easily inspect what they have built:
#   duckdb jaffle_shop.duckdb   ->   SHOW ALL TABLES;  SELECT * FROM customers;
# Pinned to match the duckdb engine version in requirements.txt.
ARG DUCKDB_VERSION=1.5.4
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl unzip ca-certificates \
    && curl -sL -o /tmp/duckdb.zip \
        "https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip" \
    && unzip -o /tmp/duckdb.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/duckdb \
    && rm /tmp/duckdb.zip \
    && rm -rf /var/lib/apt/lists/*
