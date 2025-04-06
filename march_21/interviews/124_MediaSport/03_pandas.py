import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random
import matplotlib.pyplot as plt
import seaborn as sns

# Задача 1

click_mean = df.groupby('payment_provider_number').agg(click2deposit_mean=('click2deposit', 'mean')).reset_index()
result = pd.merge(df, click_mean, on='payment_provider_number')


# Задача 2

def id_transform(s):
  digits = '1234567890'
  symbols = []
  numbers = []
  
  for element in s:
    if element not in digits:
      symbols.append(element)
    else:
      numbers.append(element)
  
  if numbers:
    a = int(''.join(numbers)) ** 2
    return ''.join(symbols) + str(a)
  
  return ''.join(symbols)


# Задача 3

result['transformed_id'] = result['user_id'].apply(id_transform)


# Задача 4-2

plt.figure(figsize=(15, 5))
plt.subplot(1, 3, 1)
sns.histplot(df['click2deposit'])
plt.title('click2deposit')
plt.subplot(1, 3, 2)
sns.histplot(df['retention'])
plt.title('retention')
plt.subplot(1, 3, 3)
sns.histplot(df['deposit_amount'])
plt.title('deposit_amount')

plt.show()


# Задача 5

sns.boxplot(x=df['payment_provider_number'], y=df['click2deposit'])

# Выбрал boxplot, потому что он сразу показывает выбросы, медиану, квартили.
# Можно сразу сравнить все эти значения по каждой платёжной системе.
