---
date: 2020-10-16 01:06
description:  Test wheather supplementary views are registered.
tags: UICollectionView
---

# Register A Supplementary View

Test wheather supplementary views are registered

## Step 1: Test

```swift
func test_loadingView_registersCell() {
  // when
  sut.loadViewIfNeeded()
  
  // then
  let header = sut.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: IndexPath(item: 0, section: 0))
  XCTAssertNotNil(header)
  XCTAssertTrue(header is SupplementaryView)
}
```

### Step 2: Example code that makes the test pass

```swift
class CollectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
  }
}

class SupplementaryView: UICollectionReusableView {}
```

