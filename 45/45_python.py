# Задача 45-1

a = [1, 4, 3]

def func(lst):
  mult = 1
  result = []
  
  for element in lst:
    mult *= element

  for element in lst:
    new_element = mult // element
    result.append(new_element)
  
  return result
