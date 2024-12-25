# Задача 16-2

def palindrome(word):
  if word == word[::-1]:
    return True
  return False
