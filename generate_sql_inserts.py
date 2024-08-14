import pandas as pd
from datetime import datetime

def convert_date(date_str):
    if isinstance(date_str, str):
        try:
            # Convert mm/dd/yyyy to YYYY-MM-DD
            return datetime.strptime(date_str, '%m/%d/%Y').strftime('%Y-%m-%d')
        except ValueError:
            # Log incorrect date formats for debugging
            print(f"Incorrect date format: {date_str}")
            return None  
    else:
        # Handle non-string cases (e.g., NaN or float)
        return None  

def clean_decimal(value):
    """Remove dollar signs and spaces, and convert to float."""
    if isinstance(value, str):
        value = value.replace('$', '').replace(' ', '')  # Remove dollar signs and spaces
        try:
            return float(value)  # Convert to float
        except ValueError:
            return None  # Return None if conversion fails
    return value

def generate_sql_insert_statements(csv_file, table_name):
    try:
        df = pd.read_csv(csv_file, encoding='ISO-8859-1')  
    except UnicodeDecodeError:
        print(f"Failed to decode {csv_file} with encoding ISO-8859-1.")
        return
    except Exception as e:
        print(f"An error occurred while reading {csv_file}: {e}")
        return

    # Apply cleaning to decimal columns
    if 'Unit Cost USD' in df.columns:
        df['Unit Cost USD'] = df['Unit Cost USD'].apply(clean_decimal)
    if 'Unit Price USD' in df.columns:
        df['Unit Price USD'] = df['Unit Price USD'].apply(clean_decimal)
    
    # Convert dates for relevant columns
    date_columns = ['Order Date', 'Delivery Date', 'Open Date', 'Birthday', 'Date']  # Add other date columns as needed
    for date_column in date_columns:
        if date_column in df.columns:
            df[date_column] = df[date_column].apply(convert_date)
    
    try:
        with open(f'{table_name}_insert_statements.sql', 'w', encoding='utf-8') as f:
            for _, row in df.iterrows():
                values = []
                for col, value in row.items():
                    if pd.isna(value) or value is None:  # Check for NaN or None values
                        values.append('NULL')
                    else:
                        values.append(f"'{str(value).replace('\'', '\'\'')}'")
                
                columns = ', '.join([f'`{col}`' if ' ' in col or not col.isalnum() else col for col in df.columns])
                values_str = ', '.join(values)
                stmt = f"INSERT INTO {table_name} ({columns}) VALUES ({values_str});"
                f.write(stmt + '\n')
    except Exception as e:
        print(f"An error occurred while writing to {table_name}_insert_statements.sql: {e}")

# Define file paths and table names
files_and_tables = [
    ('C:/Users/DELL/Downloads/DataSpark Illuminating Insights for Global Electronics/Customers.csv', 'Customers'),
    ('C:/Users/DELL/Downloads/DataSpark Illuminating Insights for Global Electronics/Products.csv', 'Products'),
    ('C:/Users/DELL/Downloads/DataSpark Illuminating Insights for Global Electronics/Sales.csv', 'Sales'),
    ('C:/Users/DELL/Downloads/DataSpark Illuminating Insights for Global Electronics/Stores.csv', 'Stores'),
    ('C:/Users/DELL/Downloads/DataSpark Illuminating Insights for Global Electronics/Exchange_Rates.csv', 'ExchangeRates')
]

# Generate and save insert statements for each file
for csv_file, table_name in files_and_tables:
    generate_sql_insert_statements(csv_file, table_name)

print("SQL insert statements generated successfully.")
