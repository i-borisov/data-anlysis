# Задача 25-3

def anagram(word_1, word_2):
  symbols_1 = list(word_1)
  symbols_2 = list(word_2)

  symbols_1.sort()
  symbols_2.sort()

  return symbols_1 == symbols_2
