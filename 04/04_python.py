# Задача 4-4

numbers = [1, 2, 1, 2, 1, 1, 5, 5]

def func(lst):
  # Создание словаря для подсчёта количества элементов списка
  pair = {}
  # Создания счётчика для учёта количества пар элементов
  pair_count = 0

  # Цикл считатющий количество элементов и добавляющий их в словарь 'pair'
  for number in lst:
    if number in pair:
      pair[number] += 1
    else:
      pair[number] = 1

  # Цикл определяющий количество возможных пар элементов (через целочисленное деление) и прибавляющий его к счётчику
  for elements in pair:
    pair_count += pair[elements] // 2

  return pair_count
