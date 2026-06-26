#!/bin/bash
set -e

# Install Python dependencies into the project virtual environment with uv.
# `uv sync` reads pyproject.toml + uv.lock and provisions .venv reproducibly.
uv sync

# Set up dbt folder
mkdir -p ~/.dbt/

# Copy profiles template if it exists
if [ -f "scripts/example_profiles.yml" ]; then
    cp scripts/example_profiles.yml ~/.dbt/profiles.yml
    echo "✓ dbt profiles.yml copied"
fi
