---
date: 2020-10-16 01:07
description:  Test wheather a cell is dequeued.
tags: UICollectionView
---

# Dequeue A Cell

Test wheather a cell is dequeued

## Step 1: Collection View Mock

```swift
class CollectionViewMock: UICollectionView {
  
  var dequeueReusableCellCalls = 0
  
  override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
    dequeueReusableCellCalls += 1
    
    return UICollectionViewCell()
  }
}
```

## Step 2: Test

```swift
func test_cellForItem_dequeuesCell() {
  // given
  let mockCollView = CollectionViewMock(frame: .zero, collectionViewLayout: layout)
  
  // when
  _ = sut.collectionView(mockCollView, cellForItemAt: IndexPath(item: 0, section: 0))
  
  // then
  XCTAssertEqual(mockCollView.dequeueReusableCellCalls, 1)
}
```

## Step 3: Example code that makes the test pass

```swift
class CollectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: IndexPath(item: 0, section: 0))
    
    return cell
  }
}

class Cell: UICollectionViewCell {}
```

