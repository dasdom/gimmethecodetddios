---
date: 2020-10-16 00:43
description:  Test wheather headers are registered.
tags: UITableView
---

# Register A Header

Test wheather headers are registered

## Step 1: Test

```swift
func test_loadingView_registersHeader() {
  // when
  sut.loadViewIfNeeded()
  
  // then
  let header = sut.tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header")
  XCTAssertNotNil(header)
}
```

### Step 2: Example code that makes the test pass

```swift
class TableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Header")
  }
}
```

