---
date: 2020-10-16 01:29
description: Test whether start() pushes a View Controller onto the navigation stack.
tags: Presentation
---

# start() Pushes View Controller

Test whether start() pushes a View Controller onto the navigation stack.

## Step 1: Protocol

```swift
protocol Coordinator {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  func start()
}
```

## Step 2: Test

```swift
func test_start_pushesViewController() {
  // when
  sut.start()
  
  // then
  let pushedViewController = navController.viewControllers.last
  XCTAssertTrue(pushedViewController is RootViewController)
}
```

## Step 3: Example code that makes the test pass

```swift
class MainCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    navigationController.pushViewController(RootViewController(), animated: false)
  }
}

class RootViewController: UIViewController {}
```

