---
date: 2020-10-16 00:59
description:  Test whether the background color of the cell is set in `willDisplay`.
tags: UITableViewDelegate
---

# Will Display

Test whether the background color of the cell is set in `willDisplay`.

## Step 1: Test

```swift
func test_willDisplay_setsBackgroundColor() {
  // given
  let cell = UITableViewCell()
  
  // when
  let indexPath = IndexPath(row: 0, section: 0)
  sut.tableView(UITableView(), willDisplay: cell, forRowAt: indexPath)
  
  // then
  XCTAssertEqual(cell.backgroundColor, UIColor.yellow)
}
```

## Step 2: Example code that makes the test pass

```swift
class TableViewDelegate: NSObject, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = .yellow
  }
}
```

