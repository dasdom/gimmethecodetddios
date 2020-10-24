---
date: 2020-10-16 01:19
description:  Test the value of minimumLineSpacing of a flow layout.
tags: UICollectionViewDelegate
---

# Flow Layout Minimum Line Spacing

Test the value of minimumLineSpacing of a flow layout

## Step 1: Test

```swift
func test_layout_hasMinimalLineSpacing() {
  // when
  let minimumLineSpacing = sut.minimumLineSpacing
  
  // then
  XCTAssertEqual(minimumLineSpacing, 23)
}
```

## Step 2: Example code that makes the test pass

```swift
class CollectionCoordinator : NSObject {
  
  let navController : UINavigationController
  
  init(navController: UINavigationController) {
    self.navController = navController
    super.init()
  }
  
  func start() {
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 23
    let collectionViewController = UICollectionViewController(collectionViewLayout: layout)
    
    self.navController.pushViewController(collectionViewController, animated: false)
  }
}
```

 > In the same way you can test the properties `minimumInteritemSpacing`, `itemSize`, `estimatedItemSize`, `sectionInset`, `sectionInsetReference`, `headerReferenceSize`, `footerReferenceSize`, `sectionHeadersPinToVisibleBounds` and `sectionFootersPinToVisibleBounds`.
