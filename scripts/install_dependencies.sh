#!/bin/bash
set -e

# Install Python dependencies (dbt-core + dbt-duckdb)
pip3 install --user -r requirements.txt

# Make sure the freshly installed dbt is on PATH for the seed step below.
export PATH="$HOME/.local/bin:$PATH"

# Set up dbt folder and install the DuckDB connection profile
mkdir -p ~/.dbt/
if [ -f "scripts/example_profiles.yml" ]; then
    cp scripts/example_profiles.yml ~/.dbt/profiles.yml
    echo "✓ dbt profiles.yml copied"
fi

# Pre-load the raw jaffle data into DuckDB so the project works immediately.
# This is idempotent — re-running 'dbt seed' during the lessons is safe.
echo "Seeding raw jaffle data into DuckDB..."
(cd jaffle_shop && dbt seed)
echo "✓ Codespace ready — try: cd jaffle_shop && dbt run"
