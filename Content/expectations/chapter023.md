---
date: 2020-10-16 00:23
description: Set an expectation that an expected value is set to a given key path.
tags: expectation
---

# XCTKVOExpectation With Expected Value

Set an expectation that an expected value is set to a given key path

## Step 1: Test

```swift
  func test_kvo() {
    // given
    let kvoExpectation = keyValueObservingExpectation(for: sut as Any, keyPath: "name", expectedValue: "Foo Bar")
    
    // when
    sut.firstname = "Foo"
    sut.lastname = "Bar"
    
    // then
    wait(for: [kvoExpectation], timeout: 1)
  }
```

## Step 2: Example code that makes the test green

```swift
class User: NSObject {
  var firstname: String = "" {
    didSet {
      updateName(firstname: firstname, lastname: lastname)
    }
  }
  var lastname: String = "" {
    didSet {
      updateName(firstname: firstname, lastname: lastname)
    }
  }
  @objc dynamic var name: String = ""
  
  private func updateName(firstname: String, lastname: String) {
    if firstname.count > 0 && lastname.count > 0 {
      name = "\(firstname) \(lastname)"
    }
  }
}
```

