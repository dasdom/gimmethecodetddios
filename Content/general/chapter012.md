---
date: 2020-10-16 00:12
tags: general
---

# `func setUpWithError()` and `func tearDownWithError()`
 
 > **Apple docs:**
 >
 > Before each test begins, XCTest calls setUpWithError(), followed by setUp(). If state preparation might throw errors, override setUpWithError(). XCTest marks the test failed when when it catches errors, or skipped when it catches XCTSkip.
 >
 > ...
 >
 > After each test completes, XCTest calls tearDown(), followed by tearDownWithError(). If state cleanup might throw errors, override tearDownWithError(). XCTest marks the test failed when when it catches errors, or skipped when it catches XCTSkip.

```swift
class ViewTests : XCTestCase {
  
  var sut: View!
  
  override func setUpWithError() throws {
    sut = View()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_labelIsSubview() {
    // then
    XCTAssertTrue(sut.label.isDescendant(of: sut))
  }
}
```

## Example code that makes the test pass

```swift
class View : UIView {
  
  let label: UILabel
  
  override init(frame: CGRect) {
    label = UILabel()
    
    super.init(frame: frame)
    
    addSubview(label)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
}
```

