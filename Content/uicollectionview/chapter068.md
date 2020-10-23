---
date: 2020-10-16 01:08
description:  Test wheather a supplementary view is dequeued.
tags: UICollectionView
---

# Dequeue A Supplementary View

Test wheather a supplementary view is dequeued

## Step 1: Collection View Mock

```swift
class CollectionViewMock: UICollectionView {
  
  var dequeueReusableSupplementaryCalls = 0
  
  override func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionReusableView {
    dequeueReusableSupplementaryCalls += 1
    
    return SupplementaryView()
  }
}
```

## Step 2: Test

```swift
func test_cellForItem_dequeuesCell() {
  // given
  let mockCollView = CollectionViewMock(frame: .zero, collectionViewLayout: layout)
  
  // when
  _ = sut.collectionView(mockCollView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
  
  // then
  XCTAssertEqual(mockCollView.dequeueReusableSupplementaryCalls, 1)
}
```

## Step 3: Example code that makes the test pass

```swift
class CollectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
    
    return view
  }
}

class SupplementaryView: UICollectionReusableView {}
```

