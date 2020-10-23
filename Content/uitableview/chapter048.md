---
date: 2020-10-16 00:48
description:  Test wheather a row is moved.
tags: UITableView
---

# Move Row

Test wheather a row is moved

## Step 1: Table View Mock

```swift
class TableViewMock: UITableView {
  
  var movedFrom: IndexPath? = nil
  var movedTo: IndexPath? = nil
  
  override func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
    movedFrom = indexPath
    movedTo = newIndexPath
  }
}
```

## Step 2: Test

```swift
func test_addUser_deletesRow() {
  // given
  let mockTableView = TableViewMock()
  sut.tableView = mockTableView
  
  // when
  sut.moveUser(at: 2, to: 4)
  
  // then
  XCTAssertEqual(mockTableView.movedFrom, IndexPath(row: 2, section: 0))
  XCTAssertEqual(mockTableView.movedTo, IndexPath(row: 4, section: 0))
}
```

## Step 3: Example code that makes the test pass

```swift
class TableViewController: UITableViewController {
  
  func moveUser(at index: Int, to newIndex: Int) {
    
    let fromIndexPath = IndexPath(row: index, section: 0)
    let toIndexPath = IndexPath(row: newIndex, section: 0)
    
    tableView.moveRow(at: fromIndexPath, to: toIndexPath)
  }
}
```

