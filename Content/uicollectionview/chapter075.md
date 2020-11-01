---
date: 2020-10-16 01:15
description:  Test wheather a setup method of a supplementary view is called.
tags: UICollectionViewDataSource
---

# Setup Supplementary View

Test wheather a setup method of a supplementary view is called

## Step 1: Protocol

```swift
protocol SupplementaryViewProtocol {
  func setup(with: Group)
}
```

## Step 2: Supplementary View Mock

```swift
class MockSupplementaryView: UICollectionReusableView, SupplementaryViewProtocol {
  
  var lastSetupGroup: Group?
  
  func setup(with group: Group) {
    lastSetupGroup = group
  }
}
```

## Step 3: Test

```swift
func test_viewForSupplementary_setsUpView() {
  // given
  collectionView.register(MockSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
  let group = Group(name: "Friends")
  sut.groups = [group]
  
  // when
  let indexPath = IndexPath(item: 0, section: 0)
  let supplView = collectionView.dataSource?.collectionView?(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath) as! MockSupplementaryView
  
  // then
  XCTAssertEqual(supplView.lastSetupGroup, group)
}
```

## Step 4: Example code that makes the test pass

```swift
class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
  
  var groups: [Group] = []
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}

struct Group : Equatable {
  let name: String
}
```

