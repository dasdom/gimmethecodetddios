---
date: 2020-10-16 00:26
description: Set expectation that a predicate is fulfilled.
tags: expectation
---

# XCTNSPredicateExpectation

Set expectation that a predicate is fulfilled

## Step 1: Test

```swift
func test_predicate() {
  // Arrage
  let predicate = NSPredicate(format: "name = %@", "Foo Bar")
  let predicateExp = expectation(for: predicate, evaluatedWith: sut) { () -> Bool in
    return true
  }
  
  // when
  sut.firstname = "Foo"
  sut.lastname = "Bar"
  
  // then
  wait(for: [predicateExp], timeout: 1)
}
```

## Step 2: Example code that makes the test pass

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

