---
date: 2020-10-16 01:40
description: Tests wheather an alert has the correct title, message and actions.
tags: Alerts
---

# Alerts (Without Action Handlers)

Tests wheather an alert has the correct title, message and actions

## Step 1: Test Alert Title

```swift
func test_alertHasTitle() {
  // given
  let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
  window.rootViewController = sut
  window.makeKeyAndVisible()
  
  // when
  sut.showAlert()
  
  // then
  let presentedVC = sut.presentedViewController as? UIAlertController
  XCTAssertNotNil(presentedVC)
  XCTAssertEqual(presentedVC?.title, "Foo")
}
```

## Step 2: Test Alert Message

```swift
func test_alertHasMessage() {
  // given
  let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
  window.rootViewController = sut
  window.makeKeyAndVisible()
  
  // when
  sut.showAlert()
  
  // then
  let presentedVC = sut.presentedViewController as? UIAlertController
  XCTAssertNotNil(presentedVC)
  XCTAssertEqual(presentedVC?.message, "Bar")
}
```

## Step 3: Test Action Title

```swift
func test_alertHasActionWithTitle() {
  // given
  let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
  window.rootViewController = sut
  window.makeKeyAndVisible()
  
  // when
  sut.showAlert()
  
  // then
  let presentedVC = sut.presentedViewController as? UIAlertController
  XCTAssertNotNil(presentedVC)
  let action = presentedVC?.actions.first
  XCTAssertEqual(action?.title, "Proceed")
}
```

## Step 4: Example code that makes the test pass

```swift
class ViewController: UIViewController {
  
  func showAlert() {
    
    let alert = UIAlertController(title: "Foo", message: "Bar", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Proceed", style: .default, handler: nil))
    
    present(alert, animated: true, completion: nil)
  }
}
```

