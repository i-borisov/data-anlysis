# Задача 2

import pandas as pd
import datetime as dt
import dateutil

last_month = df[df['datetime_purchase'] >= dt.datetime.now() - dateutil.relativedelta(months=1)]

last_month.groupby('city').cost_purchase.sum()
