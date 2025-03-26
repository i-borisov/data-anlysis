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
