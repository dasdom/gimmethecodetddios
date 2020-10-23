---
date: 2020-10-16 00:57
description:  Test wheather rows are reordered.
tags: UITableViewDataSource
---

# Reorder Rows

Test wheather rows are reordered

## Step 1: Table View Mock

```swift
class TableViewMock: UITableView {
  
  var fromIndexPath: IndexPath? = nil
  var toIndexPath: IndexPath? = nil
  
  override func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
    fromIndexPath = indexPath
    toIndexPath = newIndexPath
  }
}
```

## Step 2: Test

```swift
func test_movingRows() {
  // given
  let mockTableView = TableViewMock()
  
  // when
  tableView.dataSource?.tableView?(mockTableView, moveRowAt: IndexPath(row: 1, section: 0), to: IndexPath(row: 2, section: 0))
  
  // then
  let expectedFromIndexPath = IndexPath(row: 1, section: 0)
  let expectedToIndexPath = IndexPath(row: 2, section: 0)
  XCTAssertEqual(mockTableView.fromIndexPath, expectedFromIndexPath)
  XCTAssertEqual(mockTableView.toIndexPath, expectedToIndexPath)
}
```

## Step 3: Example code that makes the test pass

```swift
class TableViewDataSource: NSObject, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
  }
}
```

