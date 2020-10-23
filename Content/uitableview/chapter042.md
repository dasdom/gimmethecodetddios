---
date: 2020-10-16 00:42
description:  Test wheather cells are registered.
tags: UITableView
---

# Register A Cell

Test wheather cells are registered

## Step 1: Test

```swift
func test_loadingView_registersCell() {
  // when
  sut.loadViewIfNeeded()
  
  // then
  let cell = sut.tableView.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath(row: 0, section: 0))
  XCTAssertNotNil(cell)
  XCTAssertTrue(cell is Cell)
}
```

## Step 2: Example code that makes the test pass

```swift
class TableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
  }
}

class Cell: UITableViewCell {}
```

