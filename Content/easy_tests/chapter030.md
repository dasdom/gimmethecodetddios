---
date: 2020-10-16 00:30
description: Test wheather a property value is changed.
tags: easy_tests
---

# Changes Of Property Values

Test wheather a property value is changed

## Step 1: Test

```swift
func test_name_property() {
  // when
  sut.firstname = "Foo"
  sut.lastname = "Bar"
  
  // then
  XCTAssertEqual(sut.name, "Foo Bar")
}
```

## Step 2: Example code that makes the test pass

```swift
struct User {
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
  var name: String = ""
  
  private mutating func updateName(firstname: String, lastname: String) {
    name = "\(firstname) \(lastname)"
  }
}
```

