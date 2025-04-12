import pandas as pd

def to_json(name):
  path = f'/content/drive/MyDrive/{name}'
  df = pd.read_csv(path)
  df_json = df.to_dict(orient="records")

  return df_json

file_name = 'data.csv'

to_json(file_name)
