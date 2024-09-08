# Write a Python function that takes a string as an argument and prints whether it is upper- or lowercase.
def case(x):
    if x.isupper():
        print("All characters of string are in UPPER CASE")
    elif not x.isupper() and not x.islower():
        print("Some characters of string are in UPPER CASE and some in lower case")
    else:
        print("All characters of string are in lower case")


ip = input("Enter to check case: ")
case(ip)
