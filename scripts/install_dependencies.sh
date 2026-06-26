#!/bin/bash
set -e

# Install Python dependencies into the project virtual environment with uv.
# `uv sync` reads pyproject.toml + uv.lock and provisions .venv reproducibly.
# The venv is activated automatically in terminals: remoteEnv puts .venv/bin on
# PATH, and the Python extension activates the selected interpreter — so `dbt`
# runs directly with no `uv run` needed.
uv sync

# Pre-load the raw jaffle data into DuckDB so the project works immediately.
echo "Seeding raw jaffle data into DuckDB..."
(cd jaffle_shop && uv run dbt seed)
echo "✓ Codespace ready — try: cd jaffle_shop && dbt run"
