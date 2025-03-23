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
