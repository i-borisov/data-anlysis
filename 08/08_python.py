# Задача 8-2

fsl = ([1, 2, 3], [3, 4])

def func(lists):
  result = []

  for element in lists[0]:
    if element not in lists[1]:
      result.append(element)

  return result
  
