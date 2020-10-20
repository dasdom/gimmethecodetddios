---
date: 2020-10-16 00:07
description: There are many different assert methods to be used in a test. When in doubt always choose the one with the most helpful output. To be able to choose wise, you need to learn what all the assert methods do.
tags: general
---

# XCTAssert Functions
There are many different assert methods to be used in a test. When in doubt always choose the one with the most helpful output. To be able to choose wise, you need to learn what all the assert methods do.

## XCTAssert(\_:)

```swift
  XCTAssert(1==2)
```

Assert that an expression is true.
 
Output:
 
```swift
XCTAssertTrue failed -
```

### Declaration

```swift
public func XCTAssert(_ expression: @autoclosure () throws -> Bool,
                      _ message: @autoclosure () -> String = default,
                      file: StaticString = #file,
                      line: UInt = #line)
```
 
## XCTAssertEqual(\_:\_:)

```swift
  XCTAssertEqual(1, 2)
```

Assert that two expressions are equal. Both expressions need to be of the same type and this type needs to confom to `Equatable`. One or both expressions can return optional values. The method uses the `==` operator to check for equality.
 
You should not use this method to check floating point values (`Float`, `Double`, ...) for equality. For floating point values use [XCTAssertEqual(\_:\_:accuracy:)](#xctassertequal_with_accuracy).
 
Output:
 
```swift
XCTAssertEqual failed: ("1") is not equal to ("2") -
```
 
### Declaration

```swift
public func XCTAssertEqual<T>(_ expression1: @autoclosure () throws -> T,
                              _ expression2: @autoclosure () throws -> T,
                              _ message: @autoclosure () -> String = default,
                              file: StaticString = #file,
                              line: UInt = #line) where T : Equatable
```

## XCTAssertEqual(\_:\_:accuracy:) {#xctassertequal_with_accuracy}

```swift
  XCTAssertEqual(1.01, 1.03, accuracy: 0.01)
```

Assert that two expressions are equal within the accuracy. Both expressions and the value for accuracy need to be of the same type and this type needs to confom to `FloatingPoint`. Use this method to check floating point values (`Float`, `Double`, ...) for equality.
 
Output:
 
```
XCTAssertEqualWithAccuracy failed: ("1.01") is not equal to ("1.03") +/- ("0.01") -
```
 
### Declaration
 
```swift
public func XCTAssertEqual<T>(_ expression1: @autoclosure () throws -> T,
                              _ expression2: @autoclosure () throws -> T,
                              accuracy: T,
                              _ message: @autoclosure () -> String = default,
                              file: StaticString = #file,
                              line: UInt = #line) where T : FloatingPoint
```

## XCTAssertNotEqual(\_:\_:)

```swift
  XCTAssertNotEqual(1, 1)
```

Assert that two expressions are not equal. Both expressions need to be of the same type and this type needs to confom to `Equatable`. One or both expressions can return optional values. The method uses the `==` operator to check for equality.
 
You should not use this method to check floating point values (`Float`, `Double`, ...) for equality. For floating point values use [XCTAssertNotEqual(\_:\_:accuracy:)](#xctassertnotequal_with_accuracy).
 
Output:
 
```swift
XCTAssertNotEqual failed: ("1") is equal to ("1") -
```

### Declaration

```swift
public func XCTAssertNotEqual<T>(_ expression1: @autoclosure () throws -> T,
                                 _ expression2: @autoclosure () throws -> T,
                                 _ message: @autoclosure () -> String = default,
                                 file: StaticString = #file,
                                 line: UInt = #line) where T : Equatable
```
 
## XCTAssertNotEqual(\_:\_:accuracy:) {#xctassertnotequal_with_accuracy}

```swift
  XCTAssertNotEqual(1.01, 1.02, accuracy: 0.02)
```

 Assert that two expressions are not equal within the accuracy. Both expressions and the value for accuracy need to be of the same type and this type needs to confom to `FloatingPoint`. Use this method to check floating point values (`Float`, `Double`, ...) for equality.
 
 Output:
 
 ```swift
 XCTAssertNotEqualWithAccuracy failed: ("1.01") is equal to ("1.02") +/- ("0.02") -
 ```

### Declaration

```swift
public func XCTAssertNotEqual<T>(_ expression1: @autoclosure () throws -> T,
                                 _ expression2: @autoclosure () throws -> T,
                                 accuracy: T,
                                 _ message: @autoclosure () -> String = default,
                                 file: StaticString =#file,
                                 line: UInt =#line) where T : FloatingPoint
```
 
## XCTAssertGreaterThan(\_:\_:)

```swift
  XCTAssertGreaterThan(1, 1)
```

Assert that an expression is greater than an other expression. Both expressions need to be of the same type and this type needs to confom to `Comparable`.
 
Output:
 
```swift
XCTAssertGreaterThan failed: ("1") is not greater than ("1") -
```

### Declaration

```swift
public func XCTAssertGreaterThan<T>(_ expression1: @autoclosure () throws -> T,
                                    _ expression2: @autoclosure () throws -> T,
                                    _ message: @autoclosure () -> String = default,
                                    file: StaticString = #file,
                                    line: UInt = #line) where T : Comparable
```
 
## XCTAssertGreaterThanOrEqual(\_:\_:)

```swift
  XCTAssertGreaterThanOrEqual(1, 1.01)
```

Assert that an expression is greater than or equal to an other expression. Both expressions need to be of the same type and this type needs to confom to `Comparable`.
 
Output:
 
```swift
XCTAssertGreaterThanOrEqual failed: ("1.0") is less than ("1.01") -
```

### Declaration

```swift
public func XCTAssertGreaterThanOrEqual<T>(_ expression1: @autoclosure () throws -> T,
                                           _ expression2: @autoclosure () throws -> T,
                                           _ message: @autoclosure () -> String = default,
                                           file: StaticString = #file,
                                           line: UInt = #line) where T : Comparable
```
 
## XCTAssertLessThan(\_:\_:)

```swift
  XCTAssertLessThan(1,1)
```

Assert that an expression is less than an other expression. Both expressions need to be of the same type and this type needs to confom to `Comparable`.
 
Output:
 
```swift
XCTAssertLessThan failed: ("1") is not less than ("1") -
```

### Declaration

```swift
public func XCTAssertLessThan<T>(_ expression1: @autoclosure () throws -> T,
                                 _ expression2: @autoclosure () throws -> T,
                                 _ message: @autoclosure () -> String = default,
                                 file: StaticString = #file,
                                 line: UInt = #line) where T : Comparable
```
 
## XCTAssertLessThanOrEqual(\_:\_:)

```swift
  XCTAssertLessThanOrEqual(1.01,1)
```

Assert that an expression is less than or equal to an other expression. Both expressions need to be of the same type and this type needs to confom to `Comparable`.
 
Output:
 
```swift
XCTAssertLessThanOrEqual failed: ("1.01") is greater than ("1.0") -
```

### Declaration

```swift
public func XCTAssertLessThanOrEqual<T>(_ expression1: @autoclosure () throws -> T,
                                        _ expression2: @autoclosure () throws -> T,
                                        _ message: @autoclosure () -> String = default,
                                        file: StaticString = #file,
                                        line: UInt = #line) where T : Comparable
```
 
## XCTAssertNil(\_:)

```swift
  XCTAssertNil(1)
```

Assert that an expression is nil.
 
Output:
 
```swift
XCTAssertNil failed: "1" -
```

### Declaration

```swift
public func XCTAssertNil(_ expression: @autoclosure () throws -> Any?,
                         _ message: @autoclosure () -> String = default,
                         file: StaticString = #file,
                         line: UInt = #line)
```
 
## XCTAssertNotNil(\_:)

```swift
  XCTAssertNotNil(nil)
```

Assert that an expression is not nil.
 
Output:
 
```swift
XCTAssertNotNil failed -
```

### Declaration

```swift
public func XCTAssertNotNil(_ expression: @autoclosure () throws -> Any?,
                            _ message: @autoclosure () -> String = default,
                            file: StaticString = #file,
                            line: UInt = #line)
```
 
## XCTAssertThrowsError(\_:)

```swift
  XCTAssertThrowsError(try notThrowing())
```

Assert that an expression does throw an error.
 
Output:
 
```swift
XCTAssertThrowsError failed: did not throw an error -
```

### Declaration

```swift
public func XCTAssertThrowsError<T>(_ expression: @autoclosure () throws -> T,
                                    _ message: @autoclosure () -> String = default,
                                    file: StaticString = #file,
                                    line: UInt = #line,
                                    _ errorHandler: (Error) -> Void = default)
```
 
## XCTAssertNoThrow(\_:)

```swift
  XCTAssertNoThrow(try throwing())
```

Assert that an expression does not throw an error.
 
Output:
 
```swift
XCTAssertNoThrow failed: threw error "Error Domain=Dummy error Code=42 "(null)"" -
```

### Declaration

```swift
public func XCTAssertNoThrow<T>(_ expression: @autoclosure () throws -> T,
                                _ message: @autoclosure () -> String = default,
                                file: StaticString = #file,
                                line: UInt = #line)
```
 
## XCTAssertTrue(\_:)

```swift
  XCTAssertTrue(1==2)
```

Assert that an expression is true.
 
Output:
 
```swift
XCTAssertTrue failed -
```

### Declaration

```swift
public func XCTAssertTrue(_ expression: @autoclosure () throws -> Bool,
                          _ message: @autoclosure () -> String = default,
                          file: StaticString = #file,
                          line: UInt = #line)
```
 
## XCTAssertFalse(\_:)

```swift
  XCTAssertFalse(1==1)
```

Assert that an expression is false.
 
Output:
 
```swift
XCTAssertFalse failed -
```

### Declaration

```swift
public func XCTAssertFalse(_ expression: @autoclosure () throws -> Bool,
                           _ message: @autoclosure () -> String = default,
                           file: StaticString = #file,
                           line: UInt = #line)
```
 
## XCTFail()

```swift
  XCTFail()
```

Fails the test.
 
Output:
 
```swift
failed -
```
 
### Declaration

```swift
public func XCTFail(_ message: String = default,
                   file: StaticString = #file,
                   line: UInt = #line)
```
