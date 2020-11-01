---
date: 2020-10-16 01:17
description:  Test whether shouldSelectItemAt returns expected value.
tags: UICollectionViewDelegate
---

# Should Select Item

Test whether shouldSelectItemAt returns expected value

## Step 1: Test

```swift
func test_shouldSelectItem_even() {
  // when
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  let indexPath = IndexPath(item: 2, section: 0)
  let result = sut.collectionView(collectionView, shouldSelectItemAt: indexPath)
  
  // then
  XCTAssertEqual(result, false)
}
```

## Step 2: Example code that makes the test pass

```swift
class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let itemEven = indexPath.item % 2 == 0
    return itemEven ? false : true
  }
}
```

