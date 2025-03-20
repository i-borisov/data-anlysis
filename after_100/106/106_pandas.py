# Задача 4

def find_managers(dataframe):
  subs_count = df.groupby('managerId').agg(sub_count=('managerId', 'count')).reset_index()
  df2 = pd.merge(df, subs_count, how='inner', left_on='id', right_on='managerId')
  df3 = df2['name'].loc[df2['sub_count'] == 5]
  return df3
