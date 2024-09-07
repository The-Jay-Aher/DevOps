# Basic Strings

print(str())
print("Some new Strings!")
print("and with double quotes")

my_list = ["This", "is", "Wednesday"]
print(str(my_list))

multi_line = """This is a multi
line string,
which includes linebreaks."""
print(multi_line)

input = "   I want        more      "
print(input.strip())
print(input.lstrip())
print(input.rstrip())

output = "Barry"
print(output.ljust(10, "#"))
print(output.rjust(9, "^"))

text = "Mary had a little lamb"
print(text.split())

url = "file:///C:/Users/jayah/Downloads/Python%20for%20DevOps%20Learn%20Ruthlessly%20Effective%20Automation%20(Noah%20Gift,%20Kennedy%20Behrman,%20Alfredo%20Deza%20etc.)%20(Z-Library).pdf"
print(url.split("/"))

items = ["cow", "milk", "bread", "butter"]
print(" and ".join(items))

print("%s + %s = %s" % (1, 2, "Three"))
print("%.4f" % 12.23423424)

print("{} comes before {}".format("First", "Second"))
print("{1} comes before {0}, and {0} comes after {1}".format("First", "Second"))

print(
    """{country} is an island,
{country} is off the cost of
{continent} in the {ocean}""".format(
        ocean="Indian Ocean", continent="Africa", country="Madagascar"
    )
)


a = 1
b = 3
print(f"{a} is a, {b} is b. Adding them results in {a+b}")

from string import Template

greeting = Template("$hello, Jay Aher")
greeting.substitute(hello="Hola")
print(greeting)

map = dict()
print(map)

kv_list = [["key-1", "value-1"], ["key-2", "value-2"]]
print(dict(kv_list))

map = {"key-1": "value-1", "key-2": "value-2"}
print(map["key-1"])
print(map["key-2"])
map["key-3"] = "value-3"
print(map)

if "key-4" in map:
    print(f"The value of key-4 is {map['key-4']}")
else:
    print("Key-4 is not present")

print(map.keys())
print(map.values())

for key, value in map.items():
    print(f"{key} : {value}")
