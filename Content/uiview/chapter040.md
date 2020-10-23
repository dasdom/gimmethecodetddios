---
date: 2020-10-16 00:40
description:  Test wheather subviews are updated.
tags: UIViewController
---

# Update Of Subviews

Test wheather subviews are updated

## Step 1: Test

```swift
func test_updateWith_setsString() {
  // when
  sut.update(with: "Foo")
  
  // then
  XCTAssertEqual(sut.label.text, "Foo")
}
```

## Step 2: Example code that makes the test pass

```swift
class View: UIView {
  
  let label: UILabel
  
  override init(frame: CGRect) {
    label = UILabel()
    
    super.init(frame: frame)
    
    addSubview(label)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("has not been implemented")
  }
  
  func update(with input: String) {
    label.text = input
  }
}
```

