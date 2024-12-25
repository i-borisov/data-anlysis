# Задача 21-3

def even_odd(limit):
  for i in range(limit):
    if i % 2 == 0:
      print(i, '- чётное.')
    else:
      print(i, '- нечётное.')
