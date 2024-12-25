# Задача 23-3

s = 'aabbbccddddaaaaaaaaaaaaa'

def max_sequence(string):
  # переменная для хранения максимального значения счётчика
  max_count = 1
  # переменная для хранения символа, встречающего максимальное количество раз
  max_symbol = string[0]

  # счётчик для проверяемого символа
  count = 1
  # переменная для хранения проверяемого символа
  symbol = string[0]

  for i in range(1, len(string)):
    # если символ равен предыдущему символу, увеличиваем счтёчик на 1
    if string[i] == string[i-1]:
      count += 1
    else:
      # если символ не равен предыдущему, то в случае если текцщий счётчик больше макимального - обновляем максимальный...
      if count > max_count:
        max_count = count
        max_symbol = symbol
      # ... а затем, сбрасываем текущий счётчик и задаём значение для проверяемого следующего символа
      count = 1
      symbol = string[i]

# Делаем проверки и обновления счётчиков для последней проверки
  if count > max_count:
    max_count = count
    max_symbol = symbol

  # Возвращаем результат
  return max_symbol, max_count
