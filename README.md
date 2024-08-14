DataSpark: Illuminating Insights for Global Electronics

Project Overview
The DataSpark project focuses on retail analytics in the electronics industry, utilizing datasets related to customers, sales, products, stores, and currency exchange rates. The objective is to clean the data, load it into a MySQL database, perform SQL queries for insightful analysis, and visualize the results using Power BI.

Project Structure

├── data_cleaning.py         # Script for cleaning and processing datasets
├── generate_sql_inserts.py  # Script for generating SQL insert statements
├── sql_dataspark.sql        # SQL script for creating database and tables
├── datasets/
│   ├── Customers.csv
│   ├── Products.csv
│   ├── Sales.csv
│   ├── Stores.csv
│   └── Exchange_Rates.csv
└── README.md                # Project documentation

Workflow
1. Data Cleaning and Processing
The data_cleaning.py script handles the initial steps of data cleaning and preprocessing.
 Key operations include:

Loading datasets using pandas with the specified encoding to handle special characters.
Checking for and handling missing values.
Adjusting column names and data types.
Converting date columns to the appropriate datetime format.
Merging sales data with product and customer data for further analysis.

Execution:
python data_cleaning.py

2. SQL Database Setup
The sql_dataspark.sql script is used to create the database and tables necessary for storing the cleaned data. The script includes:

Creation of Customers, Products, Sales, Stores, and ExchangeRates tables with appropriate keys and constraints.
SQL queries to perform various analyses such as customer demographics, sales performance, revenue generation, and more.
Execution:
-- Run the following in your MySQL Workbench or preferred SQL environment
source sql_dataspark.sql;

3. Data Insertion and Query Execution
The generate_sql_inserts.py script automates the process of generating SQL INSERT statements from the cleaned datasets. This script ensures that data is correctly formatted and inserted into the database.

Execution:
python generate_sql_inserts.py

4. Data Analysis and Visualization
Once the data is loaded into the database, SQL queries are run to extract insights. The results from these queries are then visualized using Power BI. The Power BI dashboard includes:

Customer demographic distribution by gender and age.
Customer location distribution by country and continent.
Average order value and purchase frequency by customer.
Product sales performance and revenue analysis.
Store revenue and sales by currency.

Requirements
Python 3.x
Pandas library
MySQL database
Power BI for visualization

How to Run
Clone the Repository:
git clone https://github.com/yourusername/DataSpark.git
cd DataSpark
Install Dependencies:
pip install pandas
Run Data Cleaning Script:
python data_cleaning.py
Set Up MySQL Database:
Create the database and tables using the sql_dataspark.sql script.
Insert data into the tables using the generate_sql_inserts.py script.
Visualize Data:
Open the Power BI dashboard and connect it to the MySQL database to visualize the insights.

Power Bi 
Relationship creation between tables
![s1](https://github.com/user-attachments/assets/58e7538f-597a-4926-b226-6e9073cd806c)
Dashboard
![s2](https://github.com/user-attachments/assets/20a69337-be92-4bf6-af81-9a7b126f4010)

Results
The Power BI dashboard provides a comprehensive overview of customer demographics, sales trends, product performance, and revenue distribution, enabling data-driven decision-making for the electronics retail industry.


