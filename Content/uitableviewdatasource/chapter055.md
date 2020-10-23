---
date: 2020-10-16 00:55
description:  Test whether a row is deleted.
tags: UITableViewDataSource
---

# Commit Editing Style (Delete A Row)

Test whether a row is deleted

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
func test_delete_deletesRow() {
  // given
  let mockTableView = TableViewMock()
  
  // when
  tableView.dataSource?.tableView?(mockTableView, commit: .delete, forRowAt: IndexPath(row: 1, section: 0))
  
  // then
  let expectedIndexPaths = [IndexPath(row: 1, section: 0)]
  XCTAssertEqual(mockTableView.indexPathsOfDeletedRows, expectedIndexPaths)
}
```

## Step 4: Example code that makes the test pass

```swift
class TableViewDataSource: NSObject, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    tableView.deleteRows(at: [indexPath], with: .none)
  }
}
```

