import mysql.connector
import pandas as pd

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="shyamkesarwani",
    database="loyalty_program"
)

query = "SELECT * FROM DimLoyaltyProgram"
df = pd.read_sql(query, conn)
# print(df)
conn.close()
df.to_csv("DimLoyaltyInfo.csv", index=False)
print("Data exported successfully")
