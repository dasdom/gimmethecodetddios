---
date: 2020-10-16 01:13
description:  Test wheather a cell is populated with the expected data.
tags: UICollectionViewDataSource
---

# Populate A Cell

Test wheather a cell is populated with the expected data

## Step 1: Test

```swift
func test_cellForItem_populatesCell() {
  // given
  sut.names = ["foo"]
  
  // when
  let indexPath = IndexPath(item: 0, section: 0)
  let cell = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) as! NameCell
  
  // then
  XCTAssertEqual(cell.label.text, sut.names.first)
}
```

## Step 2: Example code that makes the test pass

```swift
class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
  
  var names: [String] = []
  
  func registerCell(for collectionView: UICollectionView) {
    collectionView.register(NameCell.self, forCellWithReuseIdentifier: "Cell")
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return names.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NameCell
    
    let name = names[indexPath.row]
    cell.label.text = name
    
    return cell
  }
}

class NameCell: UICollectionViewCell {
  
  let label = UILabel()
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    contentView.addSubview(label)
  }
  
  required init?(coder: NSCoder) { fatalError() }
}
```

