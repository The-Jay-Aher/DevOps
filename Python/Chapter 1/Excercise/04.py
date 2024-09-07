# Write a generator that alternates between returning Even and Odd.


def eveodd():
    even = 0
    odd = 1
    while True:
        yield even
        even += 2

        yield odd
        odd += 2


f = eveodd()

for x in f:
    if x > 20:
        break
    print(x)
