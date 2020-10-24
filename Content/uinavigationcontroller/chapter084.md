## Push View Controller
 
 Test wheather a view controller is pushed onto the navigation stack
 
### Step 1: Navigation Controller Mock

```swift
class NavigationControllerMock :
UINavigationController {
  
  var lastPushedVC: UIViewController?
  
  override func pushViewController(
    _ viewController: UIViewController,
    animated: Bool) {
    
    lastPushedVC = viewController
    super.pushViewController(
      viewController,
      animated: animated)
  }
}
```

### Step 2: Test

```swift
  func test_showNext_pushesViewController() {
    // given
    let navControllerMock =
      NavigationControllerMock(
        rootViewController: sut)
    let user = User(name: "Foobar")
    
    // when
    sut.showNext(with: user)
    
    // then
    guard let detailController =
      navControllerMock.lastPushedVC
        as? DetailViewController else {
          return XCTFail()
    }
    XCTAssertEqual(detailController.user, user)
  }
```

### Step 3: Example code that makes the test pass

```swift
class ViewController : UIViewController {
  
  func showNext(with user: User) {
    let detailController =
      DetailViewController(user: user)
    navigationController?.pushViewController(
      detailController,
      animated: true)
  }
}

class DetailViewController : UIViewController {
  
  let user: User
  
  init(user: User) {
    self.user = user
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("has not been implemented")
  }
}

struct User: Equatable {
  let name: String
}
```

