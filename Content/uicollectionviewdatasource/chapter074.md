---
date: 2020-10-16 01:14
description:  Test wheather a setup method of a cell is called.
tags: UICollectionViewDataSource
---

# Setup Cell

Test wheather a setup method of a cell is called

## Step 1: Protocol

```swift
protocol CollectionViewCellProtocol {
  func setup(with: User)
}
```

## Step 2: Collection View Cell Mock

```swift
class MockCollectionViewCell: UICollectionViewCell, CollectionViewCellProtocol {
  
  var lastSetupUser: User?
  
  func setup(with user: User) {
    lastSetupUser = user
  }
}
```

## Step 3: Test

```swift
func test_cellForItem_setsUpTheCell() {
  // given
  collectionView.register(MockCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
  let user = User(name: "Foo")
  sut.users = [user]
  
  // when
  let indexPath = IndexPath(item: 0, section: 0)
  let cell = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) as! MockCollectionViewCell
  
  // then
  XCTAssertEqual(cell.lastSetupUser, user)
}
```

## Step 4: Example code that makes the test pass

```swift
class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
  
  var users: [User] = []
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    
    if let setupCell = cell as? CollectionViewCellProtocol {
      setupCell.setup(with: users[indexPath.item])
    }
    
    return cell
  }
}

struct User : Equatable {
  let name: String
}
```

