# Задача 2-4

colors = ['black', 'blue', 'green', 'rose', 'red']

# Создаём пыстые списки для названий цветов:
r = []
g = []
b = []

# Цикл, который распределяет слова из списка 'colors' по соотвествующим пустым спискам
for element in colors:
  if element[0] == 'r':
    r.append(element)
  elif element[0] == 'g':
    g.append(element)
  else:
    b.append(element)

# Сортируем списки по алфавиту
r.sort()
g.sort()
b.sort()

# Объединяем спсики в один
RGB = r + g + b
