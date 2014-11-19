// Playground - noun: a place where people can do things

import Foundation

// Taken from Swiftz https://github.com/typelift/swiftz
infix operator • {
associativity right
}

public func •<A, B, C>(f: B -> C, g: A -> B) -> A -> C {
  return { (a: A) -> C in
    return f(g(a))
  }
}

// Some Curried Functions

func postfixer(a: String)(b: String) -> String {
  return a + b
}

func prefixer(a: String)(b: String) -> String {
  return b + a
}

func repeater(a: Int)(b: String) -> [String] {
  var array: [String] = []
  for index in 0..<a {
    array.append(b)
  }
  return array
}

func imploder(a: String)(b: [String]) -> String {
  var out = ""
  for index in 0..<b.count {
    out += b[index]
    if index < (b.count - 1) {
      out += a
    }
  }
  return out
}

// Statements
let prefixed = prefixer("😃")(b: "Good Morning")
let infixed = postfixer("😞")(b: prefixed)
print(infixed)

let weekdays = repeater(5)(b: infixed)
print(weekdays)

let result = imploder(" ")(b: weekdays)
print(result)

// Function Composition
let happyPrefixer = prefixer("😃") // String -> String
print(happyPrefixer(b: "Hello"))

let sadPostfixer = postfixer("😞") //S
print(sadPostfixer(b: "Hello"))

let infixer = happyPrefixer • sadPostfixer
print(infixer("Good Morning"))

let surrounder = imploder(" ") • repeater(5) • infixer
print(surrounder("Good Morning"))
