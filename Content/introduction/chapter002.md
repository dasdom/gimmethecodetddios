---
date: 2020-10-16 00:02
description: This website is a Gimme-The-Code website for iOS developers about Test-Driven Development. You cannot learn Test-Driven Development from this website. Use it to look up how to implement many test cases encountered in iOS development.
tags: introduction
---

# Introduction

This website is a Gimme-The-Code website for iOS developers about Test-Driven Development. You cannot learn Test-Driven Development from this website. Use it to look up how to implement many test cases encountered in iOS development.

To make this as quick as possible, this website mainly contains the code you need to write the tests. You won't find any explanations why it is done this way on this website. If you want to know the why behind tests, search for books, search the internet, and read blog posts.

# This Website Is For You

This website is for you if you

- already have a little bit experience with Test-Driven iOS Development
- are the kind of person who skips the text in blog posts when searching for a solution of a problem
- are looking for code examples for the most common testing scenarios in iOS development
- know how to search the internet in case you need to know why the code in this website makes sense (or why it doesn't)

# This Website Is Not For You

This website is **not** for you if you are looking for

- an introduction to Unit-Tests
- an introduction to Test-Driven iOS  Development
- an in depth discussion **why** tests are written like this

# Storyboards vs Code

It doesn't matter if you use Storyboards for you user interface or if you type it all in code. But user interfaces defined in code are a bit easier to test. The main difference is how you get an instance of the view controller you'd like to run your tests on. This section describes theses differences.

## Storyboards

If your user interface is defined in a Storyboard, you first need to set a storyboard id for the scene you want to write tests for. Then in the test case you setup the system under test (which is the view controller connected to the scene) like this:

```swift
import UIKit
import XCTest

class ProfileViewControllerTests : XCTestCase {

  var sut: ProfileViewController!

  override func setUpWithError() throws {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    sut = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
  }

  override func tearDownWithError() throws {
    sut = nil
  }
}
```

## User Interface In Code

In case you've defined you user interface in code. You just need to call the initialiser of the view controller unter test.

```swift
import UIKit
import XCTest

class ProfileViewControllerTests : XCTestCase {

  var sut: ProfileViewController!

  override func setUpWithError() throws {
    sut = ProfileViewController()
  }

  override func tearDownWithError() throws {
    sut = nil
  }
}
```

# Thank You

This book would have not been possible without the awesome iOS community. I have the privilege to be part of this community since 2009. Thank you all for sharing your knowledge and help each other to grow.

I'd like to thank especially a few people who helped me to do my first steps in Test Driven iOS Development:

- [Graham Lee](https://twitter.com/iwasleeg) for his awesome book about Test Driven iOS Development
- [Jon Reid](https://twitter.com/qcoding) for helping me understand key concepts and giving me new input through his awesome blog
- [Joe Masilotti](https://twitter.com/joemasilotti) for his UI Testing Cheat Sheet that helped me getting into UI Testing
 
I hope this website helps some (or better many) people to get into TDD for iOS apps. I'd love to hear from you if you find this book helpful.
