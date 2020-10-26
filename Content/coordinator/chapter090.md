---
date: 2020-10-16 01:30
description: Test whether a new view controller is pushed onto the navigation stack.
tags: Presentation
---

# Navigate To Next View Controller

Test whether a new view controller is pushed onto the navigation stack

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
    sut.showDetail()
    
    // then
    let pushedViewController = navController.viewControllers.last
    XCTAssertTrue(pushedViewController is DetailViewController)
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
    
  }
  
  func showDetail() {
    navigationController.pushViewController(DetailViewController(), animated: false)
  }
}

class DetailViewController: UIViewController {}
```

