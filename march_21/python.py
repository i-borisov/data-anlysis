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
