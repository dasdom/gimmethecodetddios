---
date: 2020-10-16 00:49
description:  Test wheather batch updates are performed.
tags: UITableView
---

# Perform Batch Updates

Test wheather batch updates are performed

## Step 1: Table View Mock

```swift
class TableViewMock: UITableView {
  
  var performBatchUpdatesCalled = false
  
  override func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
    performBatchUpdatesCalled = true
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
  sut.remove(selected: [IndexPath(row: 23, section: 0)])
  
  // then
  XCTAssertTrue(mockTableView.performBatchUpdatesCalled)
}
```

## Step 3: Example code that makes the test pass

```swift
class TableViewController: UITableViewController {
  
  func remove(selected: [IndexPath]) {
    tableView.performBatchUpdates({
      // delete model data
      // remove rows
    })
  }
}
```

