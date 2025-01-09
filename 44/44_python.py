# Задача 44-1

list_a = [20, 1, 1, 2, 2, 3, 4, 4, 5]
list_b = [1, 2, 3, 20, 4, 4, 5, 6, 18, 27]

list_a = list(set(list_a))
list_b = list(set(list_b))

result = []

for element in list_a:
  if element in list_b:
    result.append(element)

print(result)


# Задача 44-2

numbers = [1, 1, 2, 2, 3]

result = list(set(numbers))

print(result)
