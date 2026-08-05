int courseCount = 14
Boolean isProgrammer = true
String[] singers = ['Bob', 'George', 'Jeff', 'Boy', 'Tom']

if (isProgrammer) {
  println "He's a programmer, alright"
} else {
  println 'Not a programmer, tho'
}

for (int i = 0; i < courseCount; i++) {
  println 'jay made course ' + (i + 1) + '!!!'
}

for (String singer: singers) {
  println singer
}

singers.each { x -> println(x) }

singers.each { println(it) }
