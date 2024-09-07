def position(first, second) -> None:
    print(f"First: {first}")
    print(f"Second: {second}")


# Parameters with default value must come at the end
def position1(second, first=1) -> None:
    print(f"First: {first}")
    print(f"Second: {second}")


# position1(5)


def noreturn():
    """No return defined"""
    pass


def returnOne():
    return 1


# result = noreturn()
# result = returnOne()
# print(result)


def double(x):
    return x * 2


def triple(x):
    return x * 3


# functions = [double, triple]
# for function in functions:
#     print(function(3))

items = [[0, "a", 2], [5, "b", 0], [2, "c", 1]]


def second(item):
    """return the 2nd Element of the item"""
    return item[1]


# print(sorted(items))
# # print(sorted(items, key=second))
# print(sorted(items, key=lambda x: x[1]))


def count():
    n = 0
    while True:
        n += 1
        yield n


counter = count()

# for x in counter:
#     print(x)
#     if x > 20:
#         break


def fib():
    first = 0
    second = 1
    while True:
        first, second = second, first + second
        yield first


f = fib()

# for x in f:
#     print(x)
#     if x > 100:
#         break

list_o_nums = [x for x in range(100)]
gen_o_nums = (x for x in range(100))

# print(list_o_nums)
# print(gen_o_nums)

import sys

print(sys.getsizeof(list_o_nums))
print(sys.getsizeof(gen_o_nums))
