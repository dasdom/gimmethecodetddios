---
date: 2020-10-16 00:33
description: Test wheather the action is sent to the target.
tags: easy_tests
---

# Target-Action: Action Is Sent To Target

Test wheather the action is sent to the target

## Step 1: Test

```swift
func test_buttonAction_increasesCount() {
  // given
  sut.loadViewIfNeeded()
  XCTAssertEqual(sut.count, 0)
  
  // when
  sut.button?.sendActions(for: .touchUpInside)
  
  // then
  XCTAssertEqual(sut.count, 1)
}
```

## Step 2: Example code that makes the test pass

```swift
class ViewController : UIViewController {
  
  weak var button: UIButton?
  var count = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tempButton = UIButton(type: .system)
    tempButton.addTarget(self, action:#selector(increaseCount), for: .touchUpInside)
    
    view.addSubview(tempButton)
    
    button = tempButton
  }
  
  @objc func increaseCount() {
    count += 1
  }
}
```

