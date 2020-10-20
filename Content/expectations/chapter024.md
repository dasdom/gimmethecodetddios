---
date: 2020-10-16 00:24
description: Set an expectation that a value is set to a given key path. With completion handler.
tags: expectation
---

# XCTKVOExpectation With Handler

Set an expectation that a value is set to a given key path. With completion handler.

## Step 1: Test

```swift
func test_kvo() {
  // given
  let kvoExpectation = keyValueObservingExpectation(for: sut as Any, keyPath: "name") { observed, changes -> Bool in
    
    guard let new = changes["new"] as? String else {
      return false
    }
    
    return new == "Foo Bar"
  }
  
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

