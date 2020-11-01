---
date: 2020-10-16 00:56
description:  Test whether a row is inserted.
tags: UITableViewDataSource
---

# Commit Editing Style (Insert A Row)

Test whether a row is inserted

## Step 1: Table View Mock

```swift
class TableViewMock: UITableView {
  
  var indexPathsOfInsertedRows: [IndexPath] = []
  
  override func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    indexPathsOfInsertedRows = indexPaths
  }
}
```

## Step 2: Test

```swift
func test_insert_addsRow() {
  // given
  let mockTableView = TableViewMock()
  
  // when
  tableView.dataSource?.tableView?(mockTableView, commit: .insert, forRowAt: IndexPath(row: 1, section: 0))
  
  // then
  let expectedIndexPaths = [IndexPath(row: 1, section: 0)]
  XCTAssertEqual(mockTableView.indexPathsOfInsertedRows, expectedIndexPaths)
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
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    tableView.insertRows(at: [indexPath], with: .none)
  }
}
```

