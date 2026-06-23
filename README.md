# Academy dbt Group Training
Welcome to dbt Group training! 

*This repo can be accessed using the link:*
## **https://xebia.ai/codespace-dbt**

## Overview + Set-up Instructions
This training session is designed to provide a comprehensive understanding 
of dbt, covering its core concepts and functionalities. You will 
learn how to use dbt to build and maintain data models, perform data 
transformations, and ensure data quality through rigorous testing and documentation.

### Step 1: Create a new codespace

Click 'Code', then 'Codespaces, then 'Create codespace on erasmus'.

![Create codespace on main](images/open-codespace.gif)

This will create a new `codespace`, a sandbox with everything you need for the training. 

### Step 2

Make sure you are on the right branch. In the terminal, you should see the name `erasmus` in brackets.

<img src=images/erasmus-branch.png width=400px>

If you see another name, simply run the below command to switch to the right branch.

```bash
git checkout erasmus
```

### Step 3: Connect to the Data

#### Databricks

The connection to the Databricks warehouse is managed by Xebia and the trainer. The only thing you need to update in your schema.

```bash
code .dbt/profiles.yml 
```

Once this file is open, look for the key `schema: ` and add your own schema. It will need to be unique, convention is to use `dbt_` followed by your first initial & last name. Eg.

```
    schema: dbt_kmccallister
```

### Step 4: Verify connection in the project

To run dbt, you will need to use the command line.

Your terminal will open in the root directory, to ensure you are in the project location change directory (`cd`) into the `jaffle_shop/` folder:

```bash
cd jaffle_shop
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
