# ЗАДАЧА 1

row_count = len(df)

print(row_count)


# ЗАДАЧА 2

df = pd.read_csv('/file.csv')

# ЗАДАЧА 3

df.groupby('id').agg({'volume': ['sum']})
