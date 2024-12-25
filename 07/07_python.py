# Задача 7-2

s = 'aacaaffdddfffrrttggggg'

def func(string):
  # Список, хранящий количество повторов каждого элемента
  times = []
  # Счётчик считающий кол-во элементов
  count = 1
  # Цикл, проверяющий повтор элементов и добавляющий количество повторов в список 'times'
  for i in range(1, len(string)):
    if s[i] == s[i-1]:
      count += 1
    else:
      times.append(count)
      count = 1
  # Добавление результатов последней проверки в список 'times'
  times.append(count)

  return max(times)
  
