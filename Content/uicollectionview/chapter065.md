---
date: 2020-10-16 01:05
description:  Test wheather cells are registered.
tags: UICollectionView
---

# Register A Cell

Test wheather cells are registered

## Step 1: Test

```swift
func test_loadingView_registersCell() {
  // when
  sut.loadViewIfNeeded()
  
  // then
  let cell = sut.collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: IndexPath(item: 0, section: 0))
  XCTAssertNotNil(cell)
  XCTAssertTrue(cell is Cell)
}
```

## Step 2: Example code that makes the test pass

```swift
class CollectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
  }
}

class Cell: UICollectionViewCell {}
```

