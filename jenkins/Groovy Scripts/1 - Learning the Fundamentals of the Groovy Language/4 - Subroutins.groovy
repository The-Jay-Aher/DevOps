String getUserName (String firstName, String lastName) {
  return firstName.substring(0, 1).toLowerCase() + lastName.toLowerCase()
}

assert getUserName('Jay', 'Aher') == 'jaher' : "getUserName isn't working"

println(getUserName('Jay', 'Aher'))

void printCredential (cred) {
  println("UserName is ${cred}")
}

String[] firstName = ['Bob', 'George', 'Jeff', 'Boy', 'Tom']
String[] lastName = ['Dylan', 'Lynee', 'Orbision', 'Harrison', 'Petty']

for (i = 0; i < firstName.size(); i++) {
  printCredential(getUserName(firstName[i], lastName[i]))
}
