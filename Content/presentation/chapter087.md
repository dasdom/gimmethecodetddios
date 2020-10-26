---
date: 2020-10-16 01:27
description: Test whether a view controller is presented.
tags: Presentation
---

# Presentation Of A View Controller

Test whether a view controller is presented

## Step 1: Test

```swift
func test_presentationOfViewController() {
  // given
  let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
  window.rootViewController = sut
  window.makeKeyAndVisible()
  
  // when
  sut.showNext()
  
  // then
  XCTAssertTrue(sut.presentedViewController is DetailViewController)
}
```

## Step 2: Example code that makes the test pass

```swift
class ViewController: UIViewController {
  
  func showNext() {
    let nextController = DetailViewController()
    present(nextController, animated: true, completion: nil)
  }
}

class DetailViewController: UIViewController {}
```

