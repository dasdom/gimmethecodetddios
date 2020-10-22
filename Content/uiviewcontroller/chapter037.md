---
date: 2020-10-16 00:37
description:  Trigger view disappearance.
tags: UIViewController
---

# Trigger viewWillDisappear and viewDidDisappear

Trigger view disappearance

## Step 1: Test

Call `beginAppearanceTransition(_:animated:)` and `endAppearanceTransition()`

```swift
func test_triggerViewDisappearing() {
  // when
  sut.beginAppearanceTransition(false, animated: false)
  sut.endAppearanceTransition()
  
  // then
  XCTAssertTrue(sut.viewWillDisappearGotCalled)
  XCTAssertTrue(sut.viewDidDisappearGotCalled)
}
```

## Step 2: Example code that makes the test pass

```swift
class ViewController: UIViewController {
  
  var viewWillDisappearGotCalled = false
  var viewDidDisappearGotCalled = false
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewWillDisappearGotCalled = true
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    viewDidDisappearGotCalled = true
  }
}
```

