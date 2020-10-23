---
date: 2020-10-16 01:09
description:  Test wheather a row is inserted.
tags: UICollectionView
---

# Insert Row

Test wheather a row is inserted

## Step 1: Collection View Mock

```swift
class CollectionViewMock: UICollectionView {
  
  var indexPathsOfAddedRows: [IndexPath] = []

  override func insertItems(at indexPaths: [IndexPath]) {
    indexPathsOfAddedRows = indexPaths
  }
}
```

## Step 2: Test

```swift
func test_addUser_insertsItem() {
  // given
  let mockCollView = CollectionViewMock(frame: .zero, collectionViewLayout: layout)
  sut.collectionView = mockCollView
  
  // when
  sut.addUser()
  
  // then
  let expectedIndexPaths = [IndexPath(item: 0, section: 0)]
  XCTAssertEqual(mockCollView.indexPathsOfAddedRows, expectedIndexPaths)
}
```

## Step 3: Example code that makes the test pass

```swift
class CollectionViewController: UICollectionViewController {

  func addUser() {
    collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
  }
}
```

