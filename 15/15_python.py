# Задача 15-2

symbols = 'AAAWWDDDSIOPOKKKKKKKKK'

def rle(string):
  # Счётчик для подсчёта количества символов
  count = 1
  # Переменная для хранения подсчитываемого символа
  symbol = ''
  # Список для хранения результатов подсчёта
  array = []

  for i in range(1, len(string)):
    # Если элемент равен предыдущему, увеличиваем счётчик на 1 и сохраняем символ в 'symbol'
    if string[i] == string[i-1]:
      count += 1
      symbol = string[i]
    # Если элемент не равен предыдущему и счётчик равен 1 - добавлем символ в список
    elif count == 1:
      array.append(symbol)
    # Во всех других случаях - добавлем символ в список, добавляем значение счётчика в список и сбрасываем счётчик на 1
    else:
      array.append(symbol)
      array.append(str(count))
      count = 1

  # Добавляем символ и значение счётчика в список (для последней проверки)
  if count == 1:
    array.append(symbol)
  else:
    array.append(symbol)
    array.append(str(count))

  # Объединяем список в строку и возвращаем полученное значение
  return ''.join(array)
