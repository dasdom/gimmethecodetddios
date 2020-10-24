---
date: 2020-10-16 01:18
description:  Test whether selection of a cell results in a controller being pushed onto the navigation stack.
tags: UICollectionViewDelegate
---

# Selection Of Cells

Test whether selection of a cell results in a controller being pushed onto the navigation stack

## Step 1: Navigation Controller Mock

```swift
class NavigationControllerMock: UINavigationController {
  
  var lastPushedVC: UIViewController?
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    lastPushedVC = viewController
    super.pushViewController(viewController, animated: animated)
  }
}
```

## Step 2: Test

```swift
func test_selectingCell_pushesController() {
  // given
  let user = User(name: "Foo")
  sut.users = [user]
  let navController = NavigationControllerMock(rootViewController: sut)
  
  // when
  let indexPath = IndexPath(row: 0, section: 0)
  sut.collectionView(sut.collectionView, didSelectItemAt: indexPath)
  
  // then
  let pushedVC = navController.lastPushedVC as? DetailViewController
  XCTAssertNotNil(pushedVC)
  XCTAssertEqual(pushedVC?.user, user)
}
```

## Step 3: Example code that makes the test pass

```swift
class CollectionViewController: UICollectionViewController {
  
  var users : [User] = []
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let user = users[indexPath.item]
    let detailViewController = DetailViewController(user: user)
    
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}

class DetailViewController: UIViewController {
  
  let user: User
  
  init(user: User) {
    
    self.user = user
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("not been implemented")
  }
}

struct User: Equatable {
  let name: String
}
```

