# Задача 22-4 (Pandas)

import pandas as pd

data = {'product_id': [101, 102, 101, 103, 102, 101, 103],
        'store_id': [1, 1, 2, 1, 2, 2, 1],
        'sales': [5, 3, 9, 7, 2, 4, 8]}

df = pd.DataFrame(data)

df_store = df.groupby(['store_id', 'product_id']).agg({'sales': ['sum', 'mean', 'max']})


# Задача 22-5 (Pandas)

import pandas as pd

data = {'product_id': [101, 102, 101, 103, 102, 101, 103],
        'store_id': [1, 1, 2, 1, 2, 2, 1],
        'sales': [5, 3, 9, 7, 2, 4, 8]}

df = pd.DataFrame(data)

def is_even(number):
  if number % 2 == 0:
    return 'Чётное'
  else:
    return 'Нечётное'

df['even'] = df['store_id'].map(is_even)