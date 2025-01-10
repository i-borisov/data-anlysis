# Задача 47-3

import pandas as pd

pd = pd.DataFrame({
    'category': ['Цифровая техника', 'Цифровая техника', 'Цифровая техника', 
                 'Цифровая техника', 'Бытовая техника', 'Бытовая техника',
                 'Бытовая техника','Бытовая техника'],
    'subcategory': ['Телевизоры', 'Телевизоры', 'Мобильные телефоны', 'Мобильные телефоны',
                    'Холодильники', 'Холодильники', 'Пылесосы', 'Пылесосы'],
    'stock': [1000, 1100, 2400, 2650, 1500, 1100, 900, 920],
    'year': [2022, 2023, 2022, 2023, 2022, 2023, 2022, 2023]
})

stock_2023 = pd[pd['year'] == 2023].groupby(['category', 'subcategory']).agg('sum')
stock_2022 = pd[pd['year'] == 2022].groupby(['category', 'subcategory']).agg('sum')

new_pd = stock_2022.merge(stock_2023, on=['category', 'subcategory'])

result = new_pd.rename(columns={'stock_x': 'stock_2022', 'stock_y': 'stock_2023'}).drop(['year_x', 'year_y'], axis=1).reset_index()
print(result)
