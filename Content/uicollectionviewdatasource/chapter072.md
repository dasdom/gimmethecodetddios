---
date: 2020-10-16 01:12
description:  Test number of sections and rows.
tags: UICollectionViewDataSource
---

# Number Of Sections And Items

Test number of sections and rows

## Step 1: Test

```swift
func test_loadingView_numberOfSections() {
  // given
  sut.users = [[User(name: "dasdom"),
                User(name: "foo")],
                [User(name: "bar")]]
  
  // then
  let sections = collectionView.numberOfSections
  XCTAssertEqual(sections, 2)
}

func test_loadingView_numberOfItems() {
  // given
  sut.users = [[User(name: "dasdom"),
                User(name: "foo")],
                [User(name: "bar")]]
  
  // then
  let sections = collectionView.numberOfItems(inSection: 0)
  XCTAssertEqual(sections, 2)
}
```

## Step 2: Example code that makes the test pass

```swift
class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
  
  var users: [[User]] = []

  func numberOfSections(in collectionView: UICollectionView)-> Int {
    return users.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}

struct User {
  let name: String
}
```

