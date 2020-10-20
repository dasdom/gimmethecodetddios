---
date: 2020-10-16 00:08
description: You can define your own custom assertions. Let's say we have a test that compares two dictionaries.
tags: general
---

# Custom Test Assertions
 
You can define your own custom assertions. Let's say we have a test that compares two dictionaries.

```swift
  func test_dictsAreQual() {
    let dict1 = ["id": "2", "name": "foo"]
    let dict2 = ["id": "2", "name": "fo"]
    
    XCTAssertEqual(dict1, dict2)
  }
```

In this case, the test output is this:
 
```swift
XCTAssertEqual failed: ("["id": "2", "name": "foo"]") is not equal to ("["id": "2", "name": "fo"]") -
```
 
In this case it's easy see, what is different in the two dictionaries but what if you try to compare two dictionaries with hundreds of entries? Won't work.
 
To improve the output, we can define a custom assertion method.

```swift
extension Dictionary where Key: Hashable, Value: Equatable {
  
  func assertEqual(to otherDict: [Key : Value], file: StaticString = file, line: UInt = #line) {
    
    for key in keys {
      
      let value1 = String(describing: self[key])
      let value2 = String(describing: otherDict[key])
      let keyValue1 = "\"\(key)\": \(value1)"
      let keyValue2 = "\"\(key)\": \(value2)"
      let message = """
      \(keyValue1) is not equal to \(keyValue2)
      """
      
      XCTAssertTrue(self[key] == otherDict[key], message, file: file, line: line)
    }
  }
}
```

With this extension, the test becomes:

```swift
  func test_dictsAreQual2() {
    let dict1 = ["id": "2", "name": "foo"]
    let dict2 = ["id": "2", "name": "fo"]
    
    dict1.assertEqual(to: dict2)
  }
```

And the output becomes:
 
```swift
XCTAssertTrue failed - "name": Optional("foo") is not equal to "name": Optional("fo")
```
 
### `#file` and `#line`
 
With the help of the parameter `file` and `line` in the custom assertions and the default values `#file` and `#line`, Xcode prints the assertion at the line where the assertion method is called. When we ommit those parameter the failure is reported in the line where the actual XCTAssert... call is located. That would not be helpful.
