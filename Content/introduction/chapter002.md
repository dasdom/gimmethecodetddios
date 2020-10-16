---
date: 2020-10-16 10:44
description: In Jazz music, Fake Books help performers to learn and perform new songs. They contain the bare minimum needed to play the songs. They are not intended for beginners.
tags: introduction
---

# Introduction

In Jazz music, Fake Books help performers to learn and perform new songs. They contain the bare minimum needed to play the songs. They are not intended for beginners.
 
 This book is a Fake Book for iOS developers about Test-Driven Development. You cannot learn Test-Driven Development from this book. Use it to look up how to implement many test cases encountered in iOS development.
 
 To make this as quick as possible, this book mainly contains the code you need to write the tests. You won't find any explanations why it is done this way in this book. If you want to know the why behind tests, search for other books, search the internet, and read blog posts.
 
# The Structure Of The Book
 
 This book is structured into three parts. The first part, 'Testing in Xcode', contains informations about testing in general and testing in Xcode.
 
 The second part, 'Unit Tests', contains common unit tests in Test-Driven iOS Development.
 
 The third part, 'UI Tests', describes common UI tests.
 
# This Book Is For You
 
 This book is for you if you
 
 - already have a little bit experience with Test-Driven iOS Development
 - are the kind of person who skips the text in blog posts when searching for a solution of a problem
 - are looking for code examples for the most common testing scenarios in iOS development
 - know how to search the internet in case you need to know why the code in this book makes sense (or why it doesn't)
 
# This Book Is Not For You
 
 This book is **not** for you if you are looking for
 
 - an introduction to Unit-Tests
 - an introduction to Test-Driven iOS  Development
 - an in depth discussion **why** tests are written like this
 
# Code Structure
 
 The line breaks in the code snippets in this book might seem to be wrong at some places. The reason is that it’s not easy to get it right for all screen sizes (in EPUB format).
 
 I tried to make it readable even on small screen sizes (iPhone SE). But my guess is that you are reading this on an iPad. This book is not what you read while you wait in a queue. It’s a book that sits on your desk while you are writing tests.
 
 **The line breaks are optimised for the iPad Books-App when scrolling is enabled.**
 
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
     let storyboard = UIStoryboard(name: "Main",
                                   bundle: nil)
     sut = storyboard
       .instantiateViewController(
         withIdentifier: "ProfileViewController")
       as! ProfileViewController
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
 
 I'd like to thank especially a few people who helped me to do my forst steps in Test Driven iOS Development:
 
 - [Graham Lee](https://twitter.com/iwasleeg) for his awesome book about Test Driven iOS Development
 - [Jon Reid](https://twitter.com/qcoding) for helping me understand key concepts and giving me new input through his awesome blog
 - [Joe Masilotti](https://twitter.com/joemasilotti) for his UI Testing Cheat Sheet that helped me getting into UI Testing
 
 I hope this book helps some (or better many) people to get into TDD for iOS apps. I'd love to hear from you if you find this book helpful.
