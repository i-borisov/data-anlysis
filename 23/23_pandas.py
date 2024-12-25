# Задача 23-2

answer = df[df['Region'] == 'USA'].groupby('Device').agg({'Session Start': ['count'], 'User_id': ['nuniq']})
