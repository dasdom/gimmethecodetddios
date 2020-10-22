---
date: 2020-10-16 00:36
description:  Trigger view appearance.
tags: UIViewController
---

# Trigger viewWillAppear and viewDidAppear

Trigger view appearance

## Step 1: Test

Call `beginAppearanceTransition(_:animated:)` and `endAppearanceTransition()`

```swift
func test_triggerViewAppearing() {
  // when
  sut.beginAppearanceTransition(
    true,
    animated: false)
  sut.endAppearanceTransition()
  
  // then
  XCTAssertTrue(sut.viewWillAppearGotCalled)
  XCTAssertTrue(sut.viewDidAppearGotCalled)
}
```

## Step 2: Example code that makes the test pass

```swift
class ViewController: UIViewController {
  
  var viewWillAppearGotCalled = false
  var viewDidAppearGotCalled = false
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    viewWillAppearGotCalled = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    viewDidAppearGotCalled = true
  }
}
```

