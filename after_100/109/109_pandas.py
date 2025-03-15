import pandas as pd
import datetime

df['date'] = df['datetime_purchase'].dt.to_period('M')

last_month = df[df['date'] == df['date'].max()]

last_month.groupby('city').agg({'cost_purchase': ['sum']})
