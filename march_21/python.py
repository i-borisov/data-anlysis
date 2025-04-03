# 1. Перевернуть строку

def reverse_string(s):
    return s[::-1]

print(reverse_string("hello"))


# 2. Проверить, является ли строка палиндромом

def is_palindrome(s):
    r_s = s[::-1]
    if r_s == s:
        return True
    else:
        return False

print(is_palindrome("madam"))


# 3. Подсчитать количество вхождений символа в строку

def count_char(s, char):
    count = 0

    for symbol in s:
      if symbol == char:
        count += 1

    return count

print(count_char("hellllllo", "l"))


# 4. Удалить все гласные из строки

def remove_vowels(s):
    vowels = ['A', 'a', 'E', 'e', 'I', 'i', 'O', 'o', 'U', 'u']
    result = []

    for symbol in s:
      if symbol not in vowels:
        result.append(symbol)
    return ''.join(result)

print(remove_vowels("hello"))  # "hll"


# 5. Найти самое длинное слово в строке
def longest_word(s):
  words = s.split()
  max_length = 0
  result = []

  for word in words:
    if len(word) >= max_length:
      max_length = len(word)

  for word in words:
    if len(word) == max_length:
      result.append(word)

  return result

print(longest_word("hello world this is a test"))  # ["hello", "world"]


# 6. Заменить все пробелы в строке на подчеркивания
def replace_spaces(s):
    return s.replace(' ', '_')

print(replace_spaces("hello world"))  # "hello_world"

def replace_spaces_v2(s):
  new = []

  for e in s:
    if e != ' ':
      new.append(e)
    else:
      new.append('_')

  return ''.join(new)

print(replace_spaces_v2("hello world"))  # "hello_world"


# 7. Удалить все цифры из строки
def remove_digits(s):
  result = []
  digits = '1234567890'

  for element in s:
    if element not in digits:
      result.append(element)

  return ''.join(result)

print(remove_digits("hello123"))  # "hello"


# 8. Вернуть первые n символов строки
def first_n_chars(s, n):
    return s[:n]

print(first_n_chars("hello", 3))  # "hel"


# 9. Сделать первую букву строки заглавной
def capitalize_first(s):
    return s.capitalize()

print(capitalize_first("hello"))  # "Hello"


# 10. Поменять местами первую и последнюю буквы строки
def swap_first_last(s):
    return s[-1] + s[1:-1] + s[0]

print(swap_first_last("hello"))  # "oellh"


# 11. Найти сумму элементов списка
def sum_list(lst):
    sum = 0

    for element in lst:
      sum += element

    return sum

print(sum_list([1, 2, 3, 4]))  # 10


# 12. Найти максимальный и минимальный элементы списка
def min_max(lst):
    minimum = lst[0]
    maximum = lst[0]

    for element in lst:
      if element < minimum:
        minimum = element

      if element > maximum[0]:
        maximum = element

    return minimum, maximum

print(min_max([1, 2, 3, 4]))  # (1, 4)


# 13. Удалить дубликаты из списка
def remove_duplicates(lst):
    return list(set(lst))

print(remove_duplicates([1, 2, 3, 3, 4]))  # [1, 2, 3, 4]


# 14. Отсортировать список по убыванию
def sort_desc(lst):
    return sorted(lst, reverse=True)

print(sort_desc([1, 4, 2, 3]))  # [4, 3, 2, 1]


# 15. Перевернуть список
def reverse_list(lst):
    return lst[::-1]

print(reverse_list([1, 2, 3, 4]))  # [4, 3, 2, 1]


# 16. Объединить два списка без дубликатов
def merge_lists(lst1, lst2):
    return list(set(lst1 + lst2))

print(merge_lists([1, 2], [2, 3]))  # [1, 2, 3]




# 17. Вернуть список только с четными числами
def even_numbers(lst):
    result = []

    for element in lst:
      if element % 2 == 0:
        result.append(element)

    return result

print(even_numbers([1, 2, 3, 4]))  # [2, 4]


# 18. Посчитать количество положительных чисел в списке
def count_positive(lst):
    count = 0

    for element in lst:
      if element > 0:
        count += 1

    return count

print(count_positive([1, -2, 3, 4]))  # 3


# 19. Создать список квадратов чисел
def square_numbers(lst):
    result = []

    for element in lst:
      result.append(element ** 2)

    return result

print(square_numbers([1, 2, 3]))  # [1, 4, 9]


# 20. Объединить два списка в список кортежей
def pair_lists(lst1, lst2):

  result = zip(lst1, lst2)
  return list(result)


print(pair_lists([1, 2], ["a", "b"]))  # [(1, "a"), (2, "b")]


# 21. Проверить, является ли строка строкой с уникальными символами
def has_unique_chars(s):
    return len(s) == len(set(s))

print(has_unique_chars("abcdef"))  # True
print(has_unique_chars("aabbcc"))  # False


# 22. Найти индекс первого вхождения символа в строке
def first_occurrence(s, char):
  for i in range(len(s)):
    if s[i] == char:
      return i

print(first_occurrence("hello", "l"))  # 2


# 23. Проверить, является ли число простым
def is_prime(n):
  if n == 1:
    return False
  elif n > 1:
    for i in range(2, int(n ** 0.5) + 1):
      if n % i == 0:
        return False

  return True

print(is_prime(7))  # True
print(is_prime(4))  # False


# 24. Найти количество слов в строке
def word_count(s):
    a = s.split()
    return len(a)

print(word_count("hello world"))  # 2


# 25. Найти наибольшее число из двух
def max_of_two(a, b):
    if a > b:
      return a
    return b

print(max_of_two(3, 5))  # 5


# 26. Найти наименьшее число из двух
def min_of_two(a, b):
    if a < b:
      return a

    return b

print(min_of_two(3, 5))  # 3
