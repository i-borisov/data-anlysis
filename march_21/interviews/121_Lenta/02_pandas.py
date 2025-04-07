# Задача 3

import pandas as pd

df = pd.read_csv('lenta_data_2.csv', sep=';')

df_19 = df[df['order_dates'].dt.year == 2019]

df_19['month'] = df_19['order_dates'].dt.month

aov = df_19.groupby('month').order_values.mean()

print(aov)
