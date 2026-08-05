class User {

  String firstName
  String lastName

  public String UserName() {
    return getUserName(this.firstName, this.lastName)
  }

  private String getUserName (String firstName, String lastName) {
    return firstName.substring(0, 1).toLowerCase() + lastName.toLowerCase()
  }

}

// String[] firstNames = ['Bob', 'George', 'Jeff', 'Boy', 'Tom']
// String[] lastNames = ['Dylan', 'Lynee', 'Orbision', 'Harrison', 'Petty']

User[] users = [
  new User(firstName: 'Bob', lastName:'Dylan'),
  new User(firstName: 'George', lastName:'Lynee'),
  new User(firstName: 'Jeff', lastName:'Orbision'),
  new User(firstName: 'Boy', lastName:'Harrison'),
  new User(firstName: 'Tom', lastName:'Petty')
]

// for (i = 0; i < firstName.size(); i++) {
//   User u = new User(firstName: firstNames[i], lastName: lastNames[i])
//   println("UserName is ${u.UserName()}")
// }

users.each(x-> println("Username is ${ x.UserName() }"))
