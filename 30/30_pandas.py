# Задача 30-5

import pandas as pd

offline = pd.read_excel('/offline.xlsx')
offline = offline.rename(columns={'sale_date': 'date', 'rub': 'rub_offline', 'qty': 'qty_offline'})

online = pd.read_excel('/online.xlsx')
online['date_complete'] = online['date_complete'].dt.date
online = online.rename(columns={'date_complete': 'date', 'rub': 'rub_online', 'qty': 'qty_online'})

offline_group = offline.groupby(['date', 'tag', 'group_id']).agg({'rub_offline': ['sum'], 'qty_offline': ['sum'], 'rub_offline': ['max']})
online_group = online.groupby(['date', 'tag', 'group_id']).agg({'rub_online': ['sum'], 'qty_online': ['sum']})

result = pd.merge(offline_group, online_group, on=['date', 'tag', 'group_id'], how='outer')

result['average_price'] = (result['rub_offline'] / result['qty_offline'] + result['rub_online'] / result['qty_online']) / 2

result['average_price'] = result['average_price'].round(2)
