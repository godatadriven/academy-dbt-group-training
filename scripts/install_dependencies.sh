#!/bin/bash
set -e

# Install Python dependencies (dbt-core + dbt-duckdb)
pip3 install --user -r requirements.txt

# Make sure the freshly installed dbt is on PATH for the seed step below.
export PATH="$HOME/.local/bin:$PATH"

# Pre-load the raw jaffle data into DuckDB so the project works immediately.
# dbt reads jaffle_shop/profiles.yml automatically (it sits next to
# dbt_project.yml), so there is no profile to copy or configure.
# This is idempotent — re-running 'dbt seed' during the lessons is safe.
echo "Seeding raw jaffle data into DuckDB..."
(cd jaffle_shop && dbt seed)
echo "✓ Codespace ready — try: cd jaffle_shop && dbt run"
