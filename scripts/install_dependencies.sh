#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Install Python dependencies
pip3 install --user -r requirements.txt

# Set up dbt folder
mkdir -p ~/.dbt/
