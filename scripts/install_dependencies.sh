#!/bin/bash
set -e 

# Install Python dependencies
pip3 install --user -r requirements.txt

# Set up dbt folder
mkdir -p ~/.dbt/