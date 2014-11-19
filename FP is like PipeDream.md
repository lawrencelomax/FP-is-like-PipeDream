## Function Composition is like Playing PipeDream
### Lawrence Lomax 
### @insertjokehere
### lawrencelomax.github.io

---
# PipeDream
![](pipe_0.png)
![](pipe_1.jpg)

^ The Game PipeDream has these multi-sided tiles that you lay down, they join up and connect to the solution. 

^ Programming is a lot like this, we have a start and end and a bunch of tiles. Also the problem is in multiple dimensions and there is a line of people who will shout at you if you don’t get the water into the exit before the time is up.

^ Now imagine a game of PipeDream where there are some tiles that are angled just the way you expect.

^ Then there are a number of tiles that can stab you in the foot and spew a yard of sick over the rest of the other tiles, and its hard to know which is which.

^ I feel like functional programming gives you ways of creating tiles that face in the directions you want and don’t make you sad. A common analogy for this is a jig. 

---
# Why Now
I want more code that is reliable and easy to reason about:
- **Objective-C**: Assertive Programming in Objective-C; Every ```id``` is a 😫
-  **Haskell**: Somewhat Comprehensible, but I can’t really use it to write Apps*
- **Swift**: I get many of the Strengths of a Strongly Typed Functional Language, with the quality of the Apple Dev ecosystem*

^ I want less tiles that spew a lot less yards of sick all over the place. So we try and do what we can with what we are using. 

^ Asterisks are there 1) There are ways of embedding ghci inside iOS Apps. 2) Quality of Development is dubious as of late.

---
## Functors, Applicatives, And Monads In Pictures
## *by Aditya Y. Bhargava*
![](fam_in_pictures.png)

^ He has a book on algorithms coming out and it has all these pictures to make things make sense. Stuff going in and out of boxes

^ This is really good for seeing where data is going

^ Garbage Collection algorithms, sorts shown as gifs.

---
## Shapes (1)
A Function that postfixes a String `a` with String `b`:

```swift
func postfixer(a: String, b: String) -> String
(String, String) -> String
func postfixer(a: String)(b: String) -> String
String -> String -> String
```

A Function that prefixes a String `a` with String `b`:

```swift
func prefixer(a: String, b: String) -> String
(String, String) -> String
func prefixer(a: String)(b: String) -> String
String -> String -> String
```

^ What you can infer about the behaviour of a function based upon the inputs and outputs.

^ Great Paper called theorems for free that talks exactly about this.

^ Shape is identical to #1 even if the behaviour is different. The shape informs what to expect from the function without using any existing documentation.

---
## Shapes (2)
A Function that takes a String `b` and Repeats it `a` times:

```swift
func repeater(a: Int, b: String) -> [String]
(Int, String) -> [String]
func repeater(a: Int)(b: String) -> [String]
Int -> String -> [String]
```

^ A tuple as an argument of a function isn't the same (unfortunately)

---
## Shapes (3)

A Function that takes a list of Strings `b` and implodes it into a String separated by `b`:

```swift
func imploder(a: String, b: String) -> String
(String, [String]) -> String
func imploder(a: String)(b: [String]) -> String
String -> [String] -> String
```

^ This looks really strange as the arguments are reversed. The reason that you do this is so you can Specialise the functions, gradually or all at once

^ We can't commonicate that the function doesn't do a lot of work, its nice to keep the side effects at bay.

---
## Specialised Functions (1)
A Function that prefixes a String `a` with 😃:

```swift
let happyPrefix = prefixer("😃") // String -> String
print(happyPrefix("Hello")) // "😃Hello"
```

A Function that postfixes a String `a` with 😞:

```swift
let sadPostfix = postfixer("😞") // String -> String
print(sadPostfix("Hello")) // "Hello😞"
```

^ Fixing arguments, we've already seen why you might want to do this. A mapping function an array for example.

^ Using the curried functions to fix arguments, Haskell doesn't make the distinction

---
## Specialised Functions (2)
A Function that repeats a String 3 times:

```swift
let repeater3 = repeater(3) // String -> [String]
print(repeater3("Hello")) // ["Hello", "Hello", "Hello"]
```

A Function that separates an Array of Strings by " 🌽🏄 ":

```swift
let cornSurfer = imploder(" 🌽🏄 ")
// [String] -> String
print(cornSurfer(["I AM", "WENDY THE", "CORNSURFER"])
// "I AM 🌽🏄 WENDY THE 🌽🏄 CORNSURFER"
```

^ Swift doesn’t treat multiple arguments as a tuple, this is why we have the strange double bracket syntax.

---
## Joining Functions (1)
With Statements:

```swift
let infixed = happyPrefix(sadPosfix("Good Morning"))
print(infixed) // "😃Good Morning😞"

let weekdays = repeated(5)(infixed)
print(weekdays) // ["😃Good Morning😞”, x 5]

let result = imploder(" ")(weekdays)
print(result) 
// "😃Good Morning😞 😃Good Morning😞 ..." etc.
```

^ Using intermediate state here, its good that we have the keywords of let to ensure immutability, but we create all of these bits in the midde that we then use to produce a product.

---
## Joining Functions (2)
With the Magic of Function Composition:

```swift
public func •<A, B, C>(f: B -> C, g: A -> B) -> A -> C

let infixer = happyPrefix • sadPostfix // String -> String
print(infixer("Good Morning") // "😃Good Morning😞"

let weekdays = imploder(" ") • repeater(5) • infixer 
// String -> String
print(weekdays("Good Morning"))
// "😃Good Morning😞 😃Good Morning😞 ...” etc.
```

^ Using the Compose operator from Swiftz. I'm not suggesting that this should be the implementation that you use.

^ We have small multi purpose functions that have input and output, that's the essence of function composition

^ We thinking or should think about object composition all of the time, so its just composition on different primitive, using the type system.

---
# Boxes
![](box_0.jpg)

^ Seen the trivial stuff before, we’ve just performed some gymnastic with a type system that treats functions as types with a distinct shape.

^ To start with it is good to think of boxes as containers for something else. Generics make this vastly more efficient.

^ What this gives is a liberation from the imperative nature of code. The What, rather than the How. Notice how we haven’t been concerned with the implementation of these functions

---
# Some Boxes
![](box_1.jpg)

## `Optional<T> / T?` 
## `Either<A, B>`
## `Result<T>`
## `[A]`
## `Function<A, B>`

^ Optional is so common it has this sugar.

^ Either allows multiple types that you should duck-type in OO. Result is a specialisation of Either to cover errors.

^ The List is also a kind of box, we’ve seen already and is so fundamental. I like to consider an Array in Swift to be a Sequence by default and ignore its indelibility.

---
# Pipes
![](pipe_2.jpg)

^ Time for the analogy to completely break down, I talked about Pipe Dream at the start 

^ We will use our Pattern Matching ability to identify the Shape of functions to deduce what they may do.

^ My analogy has broken down because of unix pipes. Thinking of them in terms of the flow of data.

---
# Some Pipes

Bad Pipes:

```swift
var error: NSErrorPointer = nil
let output: AThing = Object.doSomeThing(foo, withError: error);
// (String, NSErrorPointer) -> AThing
```

Good Pipes:

```swift
let output: Result<AThing> = Object.doSomeThing(foo)
// String -> Result<AThing>
```

^ Time for the analogy to completely break down, I talked about Pipe Dream at the start 

^ Look at the Shapes again, I thought we were done with pointers. If you’re making ‘Swift APIs’ whatever that means, take a look at tuples and associated types with unions.

^ We will use our Pattern Matching ability to identify the Shape of functions to deduce what they may do.

---
# Jigs
![](jig_0.jpg)

^ Time for the analogy to completely break down, I talked about Pipe Dream at the start.

^ Jigs are a way of performing repitious tasks without needing so much of the repetition.

^ They are the what rather than the how of programming. How much of programming is shuttling stuff between different forms, so error prone.

^ Benefits, massively reduced branching. Accidental negation. What to do when you get elements in the list, not how to enumerate the list.

^ We will use our Pattern Matching ability to identify the Shape of functions to deduce what they may do.

---
# Some Jigs
```•``` or ‘Function Composition’ 

```swift
public func •<A, B, C>(f: B -> C, g: A -> B) -> A -> C
```

```>>-``` or ```bind``` 

```swift
public func >>-<A,B>(a: F<A>, f: A -> F<B>) -> F<B>
```

```<^>``` or ```fmap```

```swift
public func <^><A, B>(f: A -> B, a: F<A>) -> F<B> 
```

^ These don’t need to be curried. you are joining functions that you have composed and conform to the shapes of the input

^ You might see the friction inherent in Strong Typing in the branching and constant checking in Swift, we can use Higher Order functions to do legwork.

^ Now I’m going to teach you how to write a full XML and JSON parser using Generics, Monads, Applicative Functors, Composition, Type Constraints & Curried Functions.

---
# Piping some Boxes using a Jig
## Drawing the Rest of the Damn Owl

![right fit](draw_owl_1.jpg)

^ Just Kidding.

^ Graham Lee came up with this.

---
# Piping some Boxes using a Jig
## *(In Swift)*

- Rob Napier: `robnapier.net`
- Tony DiPasquale: `robots.thoughtbot.com`
- Airspeed Velocity: `airspeedvelocity.net`
- Functional Programming in Swift: `objc.io/books`
- `Optional<Me>` : `lawrencelomax.github.io`

---
# 🔥 INFIX 🔥

^ C++ is an often cited reason for wanting to hate on infix operators to make code ‘more dense’.

^ Objective-C developers we are comfortable with the idea of meaningful names for things.

^ The Amazing thing about the pipes defined in the functions and convenient infix operators is the applicability across a range of these boxes. Same with the concept of ‘addition’ of vectors and strings etc.

---
## Thanks & Questions

### Lawrence Lomax 
### @insertjokehere
### lawrencelomax.github.io