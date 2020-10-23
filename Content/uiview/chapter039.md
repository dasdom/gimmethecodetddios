---
date: 2020-10-16 00:39
description:  Test wheather a view is in the view hierachy.
tags: UIViewController
---

# Existence Of Subviews

Test wheather a view is in the view hierachy

## Step 1: Test

```swift
func test_labelIsSubview() {
  // then
  XCTAssertTrue(sut.label.isDescendant(of: sut))
}
```

## Step 2: Example code that makes the test pass

```swift
class View: UIView {
  
  let label: UILabel
  let stackView: UIStackView
  
  override init(frame: CGRect) {
    label = UILabel()
    
    stackView = UIStackView(arrangedSubviews:[label])
    
    super.init(frame: frame)
    
    addSubview(stackView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("has not been implemented")
  }
}
```

