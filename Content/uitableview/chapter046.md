---
date: 2020-10-16 00:46
description:  Test wheather a row is inserted.
tags: UITableView
---

# Insert Rows

Test wheather a row is inserted

## Step 1: Table View Mock

```swift
class TableViewMock: UITableView {
  
  var indexPathsOfAddedRows: [IndexPath] = []
  
  override func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    indexPathsOfAddedRows = indexPaths
  }
}
```

## Step 2: Test

```swift
func test_addUser_insertsRow() {
  // given
  let mockTableView = TableViewMock()
  sut.tableView = mockTableView

  // when
  sut.addUser()
  
  // then
  let expectedIndexPaths = [IndexPath(row: 0, section: 0)]
  XCTAssertEqual(mockTableView.indexPathsOfAddedRows, expectedIndexPaths)
}
```

## Step 3: Example code that makes the test pass

```swift
class TableViewController: UITableViewController {
  
  func addUser() {
    
    tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
  }
}
```

