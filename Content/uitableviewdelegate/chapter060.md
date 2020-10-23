---
date: 2020-10-16 01:00
description:  Test whether the indentation level is correct.
tags: UITableViewDelegate
---

# Indentation Level

Test whether the indentation level is correct

## Step 1: Test

```swift
func test_indentationLevel() {
  // when
  let indexPath = IndexPath(row: 0, section: 0)
  let indetationLevel = sut.tableView(UITableView(), indentationLevelForRowAt: indexPath)
  
  // then
  XCTAssertEqual(indetationLevel, 2)
}
```

## Step 2: Example code that makes the test pass

```swift
class TableViewDelegate: NSObject, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
    return 2
  }
}
```

