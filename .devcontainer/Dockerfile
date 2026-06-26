FROM mcr.microsoft.com/devcontainers/python:3.12

# This training runs entirely on a local DuckDB database, so there is no cloud
# SDK or warehouse driver to install.

# uv: fast Python package/environment manager (used to install project deps).
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
