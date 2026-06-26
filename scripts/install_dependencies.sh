#!/bin/bash
set -e

# Install Python dependencies into the project virtual environment with uv.
# `uv sync` reads pyproject.toml + uv.lock and provisions .venv reproducibly.
uv sync

# Auto-activate the virtualenv in every new terminal so participants can run
# `dbt ...` directly (no `uv run` needed) and see the (.venv) prompt.
# Idempotent: only added once even if the codespace is rebuilt.
VENV_ACTIVATE="$(pwd)/.venv/bin/activate"
if ! grep -qsF "$VENV_ACTIVATE" ~/.bashrc; then
    echo "source \"$VENV_ACTIVATE\"" >> ~/.bashrc
    echo "✓ virtualenv will auto-activate in new terminals"
fi

# Pre-load the raw jaffle data into DuckDB so the project works immediately.
# dbt reads jaffle_shop/profiles.yml automatically (it sits next to
# dbt_project.yml), so there is no profile to copy or configure.
# This is idempotent — re-running 'dbt seed' during the lessons is safe.
echo "Seeding raw jaffle data into DuckDB..."
(cd jaffle_shop && uv run dbt seed)
echo "✓ Codespace ready — try: cd jaffle_shop && dbt run"
