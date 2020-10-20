---
date: 2020-10-16 00:10
tags: general
---

# `class func setUp()` and `class func tearDown()`
 
 > **Apple docs:**
 >
 > The setUp() class method is called exactly once for a test case, before its first test method is called. Override this method to customize the initial state for all tests in the test case.
 >
 > ...
 >
 > The tearDown() class method is called exactly once for a test case, after its final test method completes. Override this method to perform any cleanup after all test methods have ended.

```swift
class FooTests : XCTestCase {
  
  static var dateFormatter: DateFormatter!
  
  override class func setUp() {
    dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
  }
  
  override class func tearDown() {
    dateFormatter = nil
  }
  
  func test_date() {
    // given
    let dateString = "2019-03-01"
    let date = FooTests.dateFormatter.date(from: dateString)!
    
    // when
    let result = Foo(date: date)
    
    // then
    XCTAssertEqual(result.dateString, dateString)
  }
}
```

## Example code that makes the test pass

```swift
struct Foo {
  let dateString: String
  
  init(date: Date) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    dateString = dateFormatter.string(from: date)
  }
}
```

