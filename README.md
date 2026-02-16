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

Click 'Code', then 'Codespaces, then 'Create codespace on main'.

![Create codespace on main](images/open-codespace.gif)

This will create a new `codespace`, a sandbox with everything you need for the training. 

### Step 2: Connect to BigQuery

1. **Find your project ID**: Go to the [Google Cloud Console](https://console.cloud.google.com/) and note your project ID (For training: `sql-training-422508`)

2. **Authenticate with Google Cloud**: Run the command below, and follow the prompts:
   1. `gcloud auth login`
      - Copy the URL that appears
      - Open it in your browser and authenticate
      - Copy the verification code
      - Paste it back in the terminal
   2. `gcloud auth application-default login`
      - Copy the URL that appears
      - Open it in your browser 
      - Select all the permissions and authenticate
      - Copy the verification code
      - Paste it back in the terminal

3. **Set your project**: Replace `<PROJECT_ID>` with your project ID:
```bash
   gcloud config set project sql-training-422508
   gcloud auth application-default set-quota-project sql-training-422508
```

4. **Set environment variable**: Replacing your_name (!!)
```bash
   export GCP_PROJECT_ID=sql-training-422508
   export BQ_DATASET=dbt_<your_name>
```

5. **Create your working branch**:
```bash
   git checkout -b dbt_<name>
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
