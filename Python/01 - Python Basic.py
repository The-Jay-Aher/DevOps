# Basic IF Loop

cat = "spot"
if "s" in cat:
    print("Found an 's' in a cat")
    if cat == "Sheba":
        print("I found Sheba")
    else:
        print("Some other cat")
else:
    print("A cat without an 's")

# Basic FOR Loop

for i in range(30):
    print(i)

for i in range(6):
    if i % 2 == 0:
        continue
    print(i)

# Basic While Loop

count = 0
while count < 5:
    print(f"The count is {count}")
    count += 1

# Advanced While Loop

count = 0
while True:
    if count > 5:
        break
    print(f"The count is {count}")
    count += 1

# Try-Catch Block

thinkers = ["Plato", "Playdo", "Gumby"]
while True:
    try:
        thinker = thinkers.pop()
        print(thinker)
    except IndexError as e:
        print("We tried to pop too many thinkers")
        print(e)
        break

# Classes


class FancyCar:
    # Add a class variable
    wheels = 4

    # Adding a default method
    def __init__(self) -> None:
        print("You have creates a car")

    # Add a method
    def driveFast(self, speed) -> str:
        if speed > 50:
            return "Driving so fast"
        else:
            return "Correct driving speed"


mycar = FancyCar()
print(mycar.wheels)
print(mycar.driveFast(30))

# Sequence

print(2 in [1, 2, 3])
print(10 in range(12))
print("a" in "cat")
print(12 not in range(12))

my_sequence = "Bill Cheatham"
print(my_sequence[0])
print(my_sequence[-2])
print(my_sequence.index("C"))
print(my_sequence.index("a", 9, 12))
print(my_sequence[2:6])
print(my_sequence[-3:])
print(my_sequence[5:-3])
print(len(my_sequence))
print(max(my_sequence))
print(min(my_sequence))
print(my_sequence[:6])

# List

print(list())
print(list(range(10)))
print(list("Herman Miller"))

empty = []
print(empty)

nine = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(nine)

mixed = [0, "a", empty, "Wheel House"]
print(mixed)

pies = ["cherry", "apple"]
print(pies)

pies.append("rhubarb")
print(pies)

pies.insert(1, "cream")
print(pies)

desserts = ["cookies", "paste"]
print(desserts)

desserts.extend(pies)
print(desserts)

pies = ["cherry", "cream", "apple", "rhubarb"]

pies.pop()
print(pies)

pies.pop(1)
print(pies)

# Square of numbers

squares = []

for i in range(10):
    squared = i * i
    squares.append(squared)

print(squares)

# Square of Numbers advanced

squares = [i * i for i in range(10)]
print(squares)

squares = [i * i for i in range(10) if i % 2 == 0]
print(squares)
