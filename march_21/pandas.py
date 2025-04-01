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


# 7. Найти суммарную выручку по каждому товару.
df['amount'] = df['price'] * df['quantity']
df_amount = df.groupby('product').amount.sum()
print(df_amount)


# 8. Найти самый прибыльный товар.
df_amount.idxmax()


# 9. Определить, сколько заказов сделал каждый клиент.
orders_count = df.groupby('customer_name').order_id.count().sort_values(ascending=False)
orders_count


# 10. Найти клиента, совершившего больше всего заказов.
orders_count.idxmax()


# 11. Определить, какой клиент потратил больше всего денег.
df['amount'] = df['price'] * df['quantity']
best_client = df.groupby('customer_name').amount.sum().idxmax()
print(best_client)


# 12. Определить средний чек заказа.
aov = df['amount'].mean()
print(aov)


# 13. Найти общее количество проданных товаров.
print(df.quantity.sum())


# 14. Определить товар с наибольшим общим количеством продаж.
top_product = df.groupby('product').quantity.sum().idxmax()
print(top_product)


# 15. Найти средний рейтинг товаров.
print(df.rating.mean())


# 16. Определить, какой товар имеет самый высокий средний рейтинг.
print(df.groupby('product').rating.mean().idxmax())


# 17. Определить, какой товар имеет самый низкий средний рейтинг.
print(df.groupby('product').rating.mean().idxmin())


# 18. Найти процент товаров с рейтингом ниже 3.
percent = 100 * len(df[df['rating'] < 3]) / len(df)

print(percent)


# 19. Определить день недели с наибольшим количеством заказов.
df['day_of_week'] = df['order_date'].dt.day_name()
df['order_date_trunc'] = df['order_date'].dt.floor('D')

new_df = df.groupby(['order_date_trunc', 'day_of_week']).order_id.count().reset_index()

max_orders = new_df.order_id.max()

result = new_df['day_of_week'].loc[new_df.order_id == max_orders]

print(result.unique())


# 20. Определить, в каком месяце было больше всего заказов.
df['month'] = df['order_date'].dt.month

print(df.groupby('month').order_id.count().idxmax())


# 21. Подсчитать количество заказов по дням недели.
print(df['day_of_week'].value_counts())


# 22. Найти количество заказов по месяцам.
df['month'].value_counts()


# 23. Определить средний рейтинг товаров по категориям.
df.groupby('category').rating.mean()


# 24. Найти топ-3 клиентов с наибольшей суммой заказов.
df['amount'] = df['price'] * df['quantity']
df.groupby('customer_name').amount.sum().nlargest(3)


# 25. Определить среднее количество товаров в заказе.
df.quantity.mean()


# 26. Найти процент заказов с более чем 3 товарами.
print(df[df['quantity'] > 3].order_id.count() / df.order_id.count() * 100)


# 27. Определить, сколько заказов было сделано за последние 30 дней.
df[df['order_date'] >= pd.Timestamp.today() - pd.Timedelta(days=30)].order_id.count()


# 28. Найти день с наибольшей выручкой.
df['amount'] = df['price'] * df['quantity']
df['day'] = df.order_date.dt.floor('D')
df.groupby('day').amount.sum().idxmax()


# 29. Определить месяц с наибольшей выручкой.
df['amount'] = df['price'] * df['quantity']
df['month'] = df['order_date'].dt.month
df.groupby('month').amount.sum().idxmax()


# 30. Найти самый популярный товар в каждом месяце.
most_popular = df.groupby(['month', 'product']).quantity.sum()
most_popular.groupby(level=0).idxmax()
