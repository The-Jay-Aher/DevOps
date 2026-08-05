abstract class User {

  String firstName
  String lastName

  public String UserName() {
    return getUserName(this.firstName, this.lastName)
  }

  private String getUserName (String firstName, String lastName) {
    return firstName.substring(0, 1).toLowerCase() + lastName.toLowerCase()
  }

}

class Artist extends User {

  public String [] Songs

}

class Producer extends User {

  public void Produce() { }

}

// String[] firstNames = ['Bob', 'George', 'Jeff', 'Boy', 'Tom']
// String[] lastNames = ['Dylan', 'Lynee', 'Orbision', 'Harrison', 'Petty']

User[] users = [
  new Artist(firstName: 'Bob', lastName:'Dylan'),
  new Artist(firstName: 'George', lastName:'Lynee'),
  new Artist(firstName: 'Jeff', lastName:'Orbision'),
  new Artist(firstName: 'Boy', lastName:'Harrison'),
  new Artist(firstName: 'Tom', lastName:'Petty')
]

// for (i = 0; i < firstName.size(); i++) {
//   User u = new User(firstName: firstNames[i], lastName: lastNames[i])
//   println("UserName is ${u.UserName()}")
// }

users.each { user ->
  if (user instanceOf Artist) {
    println("Username is ${user.UserName() }")
    user.Songs.each {
      println("${it}")
    }
  }
  else {
    user.Produce()
  }
}
