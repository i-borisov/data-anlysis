# 1. Вывести 5 первых строк датасета.
print(df.head(5))


# 2. Определить количество уникальных товаров.
print(df['product'].nunique())


# 3. Подсчитать количество заказов по каждому товару.
orders_count =  df.groupby('product').agg(orders_count=('order_id', 'count')).sort_values('orders_count', ascending=False)
print(orders_count)

# ИЛИ...

orders_count = df['product'].values_counts()
