---
date: 2020-10-16 01:42
description: Test wheather the handler of an action does what is expeced.
tags: Alerts
---

# Alerts (Using A Factory)

Test wheather the handler of an action does what is expeced

## Step 1: Protocol

```swift
protocol AlertActionCreator {
  func alertAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction
}
```

## Step 2: Factory

```swift
struct AlertActionFactory: AlertActionCreator {
  
  func alertAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
    return UIAlertAction(title: title, style: style, handler: handler)
  }
}
```

## Step 3: Mock

```swift
class AlertActionFactoryMock: AlertActionCreator {
  
  typealias ActionHandler = (UIAlertAction) -> Void
  var handlers: [String:ActionHandler] = [:]
  var actions: [String:UIAlertAction] = [:]
  
  func alertAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
      
    let action = UIAlertAction(title: title, style: style, handler: handler)
      
    if let unwrappedTitle = title {
      handlers[unwrappedTitle] = handler
      actions[unwrappedTitle] = action
    }
    return action
  }
  
  func executeHandler(for title: String) {
    guard let handler = handlers[title] else {
      return
    }
    guard let action = actions[title] else {
      return
    }
    handler(action)
  }
}
```

## Step 4: Test

```swift
func test_alertHasProceedAction() {
  let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
  window.rootViewController = sut
  window.makeKeyAndVisible()
  let alertFactoryMock = AlertActionFactoryMock()
  sut.actionFactory = alertFactoryMock
  
  sut.showAlert()
  alertFactoryMock.executeHandler(for: "Proceed")
  
  XCTAssertTrue(sut.presentedViewController is UIAlertController)
  XCTAssertEqual(sut.proceed, true)
}
```

## Step 5: Example code that makes the test pass

```swift
class ViewController: UIViewController {
  
  lazy var actionFactory: AlertActionCreator = AlertActionFactory()
  var proceed = false
  
  func showAlert() {
    
    let alert = UIAlertController(title: "Foo", message: "Bar", preferredStyle: .alert)
    
    alert.addAction(actionFactory.alertAction(title: "Proceed", style: .default, handler: { action in
      self.proceed = true
    }))
    
    alert.addAction(actionFactory.alertAction(title: "Cancel", style: .cancel, handler: nil))
    
    present(alert, animated: true, completion: nil)
  }
}
```

