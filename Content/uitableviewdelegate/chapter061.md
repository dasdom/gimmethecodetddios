---
date: 2020-10-16 01:01
description:  Test whether will select row returns the correct index path.
tags: UITableViewDelegate
---

# Will Select Row

Test whether will select row returns the correct index path

## Step 1: Test

```swift
func test_willSelectRow_returnsIndexPath() {
  // when
  let indexPath = IndexPath(row: 0, section: 0)
  let result = sut.tableView(UITableView(), willSelectRowAt: indexPath)
  
  // then
  let expectedIndexPath = IndexPath(row: 1, section: 0)
  XCTAssertEqual(result, expectedIndexPath)
}
```

## Step 2: Example code that makes the test pass

```swift
class TableViewDelegate: NSObject, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return IndexPath(row: indexPath.row + 1, section: 0)
  }
}
```

