---
date: 2020-10-16 00:14
tags: general
---

# Dependency Injection
 
 The different components in your code base depend on each other and on other frameworks (Apple and 3rd party). An example:

```swift
import Foundation

func loadBooks() {
  guard let url = URL(string: "http://example.com/books") else {
    fatalError()
  }
  
  URLSession.shared.dataTask(with: url) { data, response, error in
    
    // do stuff
    
    }.resume()
}
```

This code depends on `URLSession` and its implementation of `dataTask(with:completionHandler:)`. In a test you often like to exchange such dependencies to make the tests faster and to make testing different scenarios easier. You'd like to 'inject the dependency'. This is sometimes also called 'inversion of control'.
 
## Advantages of Dependency Injection

1. In unit tests you need to control the behaviour of the dependencies to be able to test all relevant scenarios (error handling, edge cases, happy path).
2. In unit tests you need to replace long running computations (like network calls, data base access, complicated computations) with instant return of fake data.
3. You'd like to decouple the different parts of your code from each other and control how they interact from the outside. This also improves readability of your code.

## How to inject dependencies

There are three main ways to inject dependencies.

1. Constructor injection
2. Setter injection
3. Interface injection
