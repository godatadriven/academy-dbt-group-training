# Academy dbt Group Training (BNG)

Welcome to the dbt Group training!

*This repo can be accessed using the link:*
## **https://xebia.ai/codespace-dbt**

## Overview + Set-up Instructions

This training session is designed to provide a comprehensive understanding
of dbt, covering its core concepts and functionalities. You will
learn how to use dbt to build and maintain data models, perform data
transformations, and ensure data quality through rigorous testing and documentation.

This branch (`bng`) connects to Xebia's training Databricks workspace. The
Databricks host, SQL warehouse and catalog are already configured for you, so the
**only** thing you need to provide is your access **token** which will be provided by your trainer.

### Step 1: Create a codespace on the `bng` branch

> **Important:** create the codespace on the **`bng`** branch, not on `main`.
> This branch contains the dbt project and the Databricks connection settings.
> If you create the codespace on `main` and switch branches afterwards, the
> environment is built from `main` and will not be configured correctly.

1. Open the repository on GitHub.
2. Switch the branch selector to **`bng`**.
3. Click **Code → Codespaces → Create codespace on `bng`**. (The GIF shows main, it should say bng in your case)

![Create codespace](images/open-codespace.gif)

This creates a `codespace`, a sandbox with everything you need for the training.
Wait for it to finish building before continuing.

### Step 2: Connect to Databricks

The connection details (host, SQL warehouse and the `bng_databricks_workspace`
catalog) are already configured in this branch. You only need to add your token
and pick a schema. Both live in a local `.env` file at the **root of the repo**
(next to this README). The `.env` file is git-ignored, so your token is never
committed.

Once your codespace has finished building, create this file in the terminal
(replace the placeholders):

```bash
cat > .env <<'EOF'
export DATABRICKS_TOKEN=<paste the token your trainer gives you>
export DBT_SCHEMA=dbt_<yourname>
EOF
```

`DBT_SCHEMA` is where all the data you create is stored, so make it **unique** to
you (for example `dbt_jdoe`).

Now load it into your terminal. You need to run this **once in every terminal you
open** (it exports the token and schema so dbt can read them):

```bash
source .env
```

**Check it works**

```bash
cd jaffle_shop
dbt debug
```

You should see `All checks passed!`. Now you are ready to run models:

```bash
dbt run
```

## Data Overview

### Jaffle data
The Jaffle data set will be used throughout this training. Jaffle data is a
sample dataset that simulates a simple e-commerce store, including customers,
orders, and payments. This dataset provides a practical context for learning
and applying dbt concepts, making it easier to understand real-world applications of dbt.

## Agenda - dbt Group Training

### 1. dbt Fundamentals
Introduction to the basics of dbt, including its purpose, key components, and
how it integrates into the modern data stack. Concepts such as models, runs, builds and
configurations will be explained.

### 2. Sources
Instructions on how to define and manage data sources in dbt. The session will
cover the importance of sources, how to declare them in a dbt project, and best
practices for managing source freshness.

### 3. Documentation
Exploration of how to document dbt models and projects effectively. The
importance of maintaining documentation and using dbt's built-in documentation
features to keep projects organized and understandable will be discussed.

### 4. Tests
Guidance on writing and running tests in dbt, including schema tests and data tests,
to ensure transformations produce accurate results. Emphasis will be placed on the
importance of testing for data integrity.

### 5. Macros and Jinja
Understanding the power of dbt macros and the Jinja templating language. The
session will cover how to write reusable SQL snippets using macros and leverage
Jinja to make dbt models more dynamic and flexible.

### 6. Materializations
Overview of different types of materializations in dbt, such as views, tables,
and incremental models. Discussion on when and why to use each type, and how to
configure them in a dbt project.

### 7. Incremental Models
Explanation of incremental models and their significance for efficient data processing.
Instructions on how to set up and manage incremental models in dbt to process large
datasets incrementally rather than reprocessing everything from scratch.
