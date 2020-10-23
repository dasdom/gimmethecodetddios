---
date: 2020-10-16 01:10
description:  Test whether a row is deleted.
tags: UICollectionView
---

# Delete Items

Test whether a row is deleted

## Step 1: Collection View Hock

```swift
class CollectionViewMock: UICollectionView {
  
  var indexPathsOfDeletedRows: [IndexPath] = []

  override func deleteItems(at indexPaths: [IndexPath]) {
    indexPathsOfDeletedRows = indexPaths
  }
}
```

## Step 2: Test

```swift
func test_deleteUser_deletesItem() {
  // given
  let mockCollView = CollectionViewMock(frame: .zero, collectionViewLayout: layout)
  sut.collectionView = mockCollView
  
  // when
  sut.deleteUser(at: 1)
  
  // then
  let expectedIndexPaths = [IndexPath(row: 1, section: 0)]
  XCTAssertEqual(mockCollView.indexPathsOfDeletedRows, expectedIndexPaths)
}
```

## Step 3: Example code that makes the test pass

```swift
class CollectionViewController: UICollectionViewController {

  func deleteUser(at index: Int) {
    let indexPath = IndexPath(row: 1, section: 0)
    
    collectionView.deleteItems(at: [indexPath])
  }
}
```

