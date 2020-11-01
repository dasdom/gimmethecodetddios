---
date: 2020-10-16 01:03
description:  Test wheather the cell has the correct height.
tags: UITableViewDelegate
---

# Cell Height

Test wheather the cell has the correct height

## Step 1: Test

```swift
func test_heightForRow() {
  // when
  let indexPath = IndexPath(row: 0, section: 0)
  let height = sut.tableView(UITableView(), heightForRowAt: indexPath)
  
  // then
  XCTAssertEqual(height, 42)
}
```

## Step 2: Example code that makes the test pass

```swift
class TableViewDelegate: NSObject, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 42
  }
}
```

