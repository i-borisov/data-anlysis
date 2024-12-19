# Задача 2-4

colors = ['black', 'blue', 'green', 'rose', 'red']

r = []
g = []
b = []

for element in colors:
  if element[0] == 'r':
    r.append(element)
  elif element[0] == 'g':
    g.append(element)
  else:
    b.append(element)

r.sort()
g.sort()
b.sort()

RGB = r + g + b


# Задача 4-4

numbers = [1, 2, 1, 2, 1, 1, 5, 5]

def func(lst):
  pair = {}
  pair_count = 0
  for number in lst:
    if number in pair:
      pair[number] += 1
    else:
      pair[number] = 1
  for elements in pair:
    pair_count += pair[elements] // 2
  return pair_count


# Задача 7-2

s = 'aacaaffdddfffrrttggggg'

def func(string):
  times = []
  count = 1
  for i in range(1, len(string)):
    if s[i] == s[i-1]:
      count += 1
    else:
      times.append(count)
      count = 1
  times.append(count)
  return max(times)


# Задача 8-2

fsl = ([1, 2, 3], [3, 4])

def func(lists):
  result = []

  for element in lists[0]:
    if element not in lists[1]:
      result.append(element)

  return result


# Задача 15-2

symbols = 'AAAWWDDDSIOPOKKKKKKKKK'

def rle(string):
  count = 1
  symbol = ''
  array = []

  for i in range(1, len(string)):
    if string[i] == string[i-1]:
      count += 1
      symbol = string[i]
    elif count == 1:
      array.append(symbol)
    else:
      array.append(symbol)
      array.append(str(count))
      count = 1

  if count == 1:
    array.append(symbol)
  else:
    array.append(symbol)
    array.append(str(count))

  return ''.join(array)


# Задача 16-2

def palindrome(word):
  if word == word[::-1]:
    return True
  return False
