# Задача 1

import pandas as pd

print(len(df))


# Задача 2

import pandas as pd

df = pd.read_csv('file.csv', sep=',')


# Задача 3

import pandas as pd

df.groupby('id').volume.sum()
