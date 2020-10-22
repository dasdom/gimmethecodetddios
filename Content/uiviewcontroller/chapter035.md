---
date: 2020-10-16 00:35
description: Trigger view loading.
tags: UIViewController
---

# Trigger loadView and viewDidLoad

Trigger view loading

## Step 1: Test

Call `loadViewIfNeeded`

```swift
func test_triggerViewLoading() {
  // when
  sut.loadViewIfNeeded()

  // then
  XCTAssertTrue(sut.loadViewGotCalled)
  XCTAssertTrue(sut.viewDidLoadGotCalled)
}
```

## Step 2: Example code that makes the test green

```swift
class ViewController: UIViewController {
  
  var loadViewGotCalled = false
  var viewDidLoadGotCalled = false
  
  override func loadView() {
    loadViewGotCalled = true
    view = UIView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewDidLoadGotCalled = true
  }
}
```

