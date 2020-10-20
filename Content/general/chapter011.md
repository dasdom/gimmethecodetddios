---
date: 2020-10-16 00:11
tags: general
---

# `func setUp()` and `func tearDown()`
 
 > **Apple docs:**
 >
 > Before each test begins, XCTest calls setUpWithError(), followed by setUp(). Override this method to reset state for each test method. If state preparation might throw errors, override setUpWithError().
 >
 > ...
 >
 > After each test completes, XCTest calls tearDown(), followed by tearDownWithError(). Override this method to perform any per-test cleanup.

```swift
class ViewTests : XCTestCase {
  
  var sut: View!
  
  override func setUp() {
    sut = View()
  }
  
  override func tearDown() {
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

