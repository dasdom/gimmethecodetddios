---
date: 2020-10-16 01:41
description: Testing every aspect of UIAlertController and UIAlertAction.
tags: Alerts
---

# Alerts (With Method Swizzling)

Testing every aspect of UIAlertController and UIAlertAction

> Note: The idea for the API of the AlertMock comes from [https://qualitycoding.org/testing-uialertcontroller/](https://qualitycoding.org/testing-uialertcontroller/).

## Step 1.1: Mock With Class Variables

```swift
typealias ActionHandler = (UIAlertAction) -> Void

class AlertMock {
  
  static var lastPresented: UIViewController?
  static var title: String?
  static var message: String?
  static var handlers: [String:ActionHandler] = [:]
  static var actions: [String:UIAlertAction] = [:]
  
  init() {
    swizzle()
  }
  
  deinit {
    swizzle()
    AlertMock.handlers = [:]
    AlertMock.actions = [:]
  }
}
```

## Step 1.2: Method Swizzling

```swift
extension AlertMock {
  
  func swizzle() {
    swizzleActionConstructor()
    swizzleControllerConstructor()
    swizzleControllerPresentation()
    
    print("swizzzzzzzzz")
  }
  
  func swizzleActionConstructor() {
    let originalSelector = NSSelectorFromString("actionWithTitle:style:handler:")
    
    let swizzledSelector = #selector(UIAlertAction.mock_constructor(title:style:handler:))
    
    guard let originalMethod = class_getClassMethod(UIAlertAction.self, originalSelector) else {
      fatalError("original missing")
    }
    
    guard let swizzledMethod = class_getClassMethod(UIAlertAction.self, swizzledSelector) else {
      fatalError("swizzled missing")
    }
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
  }
  
  func swizzleControllerConstructor() {
    let originalSelector = NSSelectorFromString("alertControllerWithTitle:message:preferredStyle:")
    
    let swizzledSelector = #selector(UIAlertController.mock_constructor(title:message:style:))
    
    guard let originalMethod = class_getClassMethod(UIAlertController.self, originalSelector) else {
      fatalError("original missing")
    }
    
    guard let swizzledMethod = class_getClassMethod(UIAlertController.self, swizzledSelector) else {
      fatalError("swizzled missing")
    }
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
  }
  
  func swizzleControllerPresentation() {
    let originalSelector = #selector(UIViewController.present(_:animated:completion:))
    
    let swizzledSelector = #selector(UIViewController.mock_present(_:animated:completion:))
    
    guard let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector) else {
      fatalError("original missing")
    }
    
    guard let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector) else {
      fatalError("swizzled missing")
    }
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
  }
}
```

## Step 1.3: Getters

```swift
extension AlertMock {
  var title: String? {
    
    if AlertMock.lastPresented is UIAlertController {
      return AlertMock.title
    }
    return nil
  }
  
  var message: String? {
    
    if AlertMock.lastPresented is UIAlertController {
      return AlertMock.message
    }
    return nil
  }
  
  func executeHandler(for title: String) {
    
    if !(AlertMock.lastPresented is UIAlertController) {
      return
    }
    
    guard let action = AlertMock.actions[title] else {
      fatalError()
    }
    guard let handler = AlertMock.handlers[title] else {
      fatalError()
    }
    
    handler(action)
  }
}
```

## Step 2: Swizzled Methods

```swift
extension UIAlertAction {
  
  @objc class func mock_constructor(title: String?, style: UIAlertAction.Style, handler: ActionHandler? = nil) -> UIAlertAction {
    guard let title = title else {
      fatalError()
    }
    AlertMock.handlers[title] = handler
    
    let action = self.mock_constructor(title: title, style: style)
    
    AlertMock.actions[title] = action
    
    return action
  }
}

extension UIAlertController {
  
  @objc class func mock_constructor(title: String?, message: String?, style: UIAlertController.Style) -> UIAlertController {
    
    AlertMock.title = title
    AlertMock.message = message
    return self.mock_constructor(title: title, message: message, style: style)
  }
}

extension UIViewController {
  
  @objc func mock_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    
    AlertMock.lastPresented = viewControllerToPresent
  }
}
```

## Step 3: Test

```swift
  func test_proceedInAlert_setsProperty() {
    let alertMock = AlertMock()
    
    sut.showAlert()
    alertMock.executeHandler(for: "Proceed")
    
    XCTAssertTrue(sut.proceed)
    XCTAssertEqual(alertMock.title, "Foo")
  }
```

## Step 4: Example code that makes the test pass

```swift
class ViewController : UIViewController {
  
  var proceed = false
  
  func showAlert() {
    let alert = UIAlertController(title: "Foo", message: "Bar", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Proceed", style: .default) { action in
      self.proceed = true
    })
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    present(alert, animated: true, completion: nil)
  }
}
```

