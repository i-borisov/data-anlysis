def managers(dataframe):
  df_with_managers_name = dataframe.merge(dataframe[['id', 'name']], left_on='managerId', right_on='id', how='left')
  employee_count = df_with_managers_name.groupby(['managerId', 'name_y']).id_x.count().reset_index()
  employee_count = employee_count.rename(columns={'name_y': 'name'})
  employee_count['name'] = employee_count['name'].str.lower()

  result = employee_count[employee_count['id_x'] >= 5]

  return result['name']
