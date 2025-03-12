# ЗАДАЧА 1

new_df = df['timestamp', 'user_id', 'event_name']


# ЗАДАЧА 2

df = pd.read_csv('data.csv' index_col='id')


# ЗАДАЧА 3

new_df = df[(df['events_count'] > 1000) & (df['event_type']=='ecom')]


# ЗАДАЧА 4

df_1 = pd.DataFrame(data1)
df_2 = pd.DataFrame(data2)

df_3 = pd.merge(df_1, df_2, how='outer', left_key='key_1', right_key='key_2')


# ЗАДАЧА 5

result = p1[~p1.isin(p2)]
