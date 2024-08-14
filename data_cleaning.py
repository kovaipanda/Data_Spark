import pandas as pd

# Load datasets with a specified encoding
customers = pd.read_csv('Customers.csv', encoding='ISO-8859-1')
products = pd.read_csv('Products.csv', encoding='ISO-8859-1')
sales = pd.read_csv('Sales.csv', encoding='ISO-8859-1')
stores = pd.read_csv('Stores.csv', encoding='ISO-8859-1')
exchange_rates = pd.read_csv('Exchange_Rates.csv', encoding='ISO-8859-1')

# Check for missing values
print(customers.isnull().sum())
print(products.isnull().sum())
print(sales.isnull().sum())
print(stores.isnull().sum())
print(exchange_rates.isnull().sum())

# Handle missing values
customers['State Code'] = customers['State Code'].fillna('Unknown')
sales['Delivery Date'] = sales['Delivery Date'].fillna(pd.NaT)  # Fill with NaT for missing dates
stores['Square Meters'] = stores['Square Meters'].fillna(stores['Square Meters'].mean())  # Fill with mean value

# Adjust column names based on actual CSV content
products['Unit Cost USD'] = products['Unit Cost USD'].replace(r'[\$,]', '', regex=True).astype(float)
products['Unit Price USD'] = products['Unit Price USD'].replace(r'[\$,]', '', regex=True).astype(float)


# Convert date columns to datetime
sales['Order Date'] = pd.to_datetime(sales['Order Date'])
sales['Delivery Date'] = pd.to_datetime(sales['Delivery Date'])
exchange_rates['Date'] = pd.to_datetime(exchange_rates['Date'])

# Merge sales with products and customers
merged_data = sales.merge(products, left_on='ProductKey', right_on='ProductKey')
merged_data = merged_data.merge(customers, left_on='CustomerKey', right_on='CustomerKey')

# Output to check merged data
print(merged_data.head())
