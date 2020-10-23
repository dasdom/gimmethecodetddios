---
date: 2020-10-16 00:47
description:  Test wheather a row is deleted.
tags: UITableView
---

# Delete Rows

Test wheather a row is deleted

## Step 1: Table View Mock

```swift
class TableViewMock: UITableView {
  
  var indexPathsOfDeletedRows: [IndexPath] = []
  
  override func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    indexPathsOfDeletedRows = indexPaths
  }
}
```

## Step 2: Test

```swift
func test_deleteUser_deletesRow() {
  // given
  let mockTableView = TableViewMock()
  sut.tableView = mockTableView
  
  // when
  sut.deleteUser(at: 1)
  
  // then
  let expectedIndexPaths = [IndexPath(row: 1, section: 0)]
  XCTAssertEqual(mockTableView.indexPathsOfDeletedRows, expectedIndexPaths)
}
```

## Step 3: Example code that makes the test pass

```swift
class TableViewController: UITableViewController {
  
  func deleteUser(at index: Int) {
    let indexPath = IndexPath(row: 1, section: 0)
    tableView.deleteRows(at: [indexPath], with: .automatic)
  }
}
```

