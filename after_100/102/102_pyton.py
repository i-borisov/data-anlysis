# Задача 102 - 2

def get_shipping_cost(quantity):
  first_item = 1000
  next_item = 120
  cost = first_item + 120 * (quantity - 1)

  return cost
