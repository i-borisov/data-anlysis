import random

def random2():
  return random.randint(0, 1)

def random3():
  a = random2()
  b = random2()

  if a == 0 and b == 1:
    return random3()

  return a + b
