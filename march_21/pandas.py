# 1. Вывести 5 первых строк датасета.
print(df.head(5))


# 2. Определить количество уникальных товаров.
print(df['product'].nunique())


# 3. Подсчитать количество заказов по каждому товару.
orders_count =  df.groupby('product').agg(orders_count=('order_id', 'count')).sort_values('orders_count', ascending=False)
print(orders_count)

# ИЛИ...

orders_count = df['product'].values_counts()


# 4. Найти товар с наибольшим количеством заказов.
print(orders_count['count'].idxmax())


# 5. Найти среднюю цену каждого товара.
avg_prices = df.groupby('product').agg(avg=('price', 'mean'))
print(avg_prices)


# 6. Вывести топ-5 самых дорогих товаров по средней цене.
print(avg_prices.sort_values('avg', ascending=False).head(5))


