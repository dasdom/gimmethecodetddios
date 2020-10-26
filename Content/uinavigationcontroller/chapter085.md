---
date: 2020-10-16 01:25
description: Test whether a view controller is poped from the navigaton stack.
tags: UINavigationController
---

# Pop View Controller

Test whether a view controller is poped from the navigaton stack

## Step 1: Navigation Controller Mock

```swift
class NavigationControllerMock: UINavigationController {
  
  var lastPopedVC: UIViewController? = nil
  
  override func popViewController(animated: Bool) -> UIViewController? {
    
    lastPopedVC = super.popViewController(animated: false)
    return lastPopedVC
  }
}
```

## Step 2: Test

```swift
  func test_done_popsViewController() {
    // given
    let navControllerMock = NavigationControllerMock(rootViewController: UIViewController())
    navControllerMock.pushViewController(sut, animated: false)
    
    // when
    sut.done()
    
    // then
    XCTAssertEqual(navControllerMock.lastPopedVC, sut)
  }
```

## Step 3: Example code that makes the test pass

```swift
class ViewController: UIViewController {
  
  func done() {
    navigationController?.popViewController(animated: true)
  }
}
```

