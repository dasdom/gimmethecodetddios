---
date: 2020-10-16 00:52
tags: UITableViewDataSource
---

# Header Title

## Step 1: Test

```swift
func test_titleForHeader() {
  // when
  let title = tableView.dataSource?.tableView?(tableView, titleForHeaderInSection: 0)
  
  // then
  XCTAssertEqual(title, "foobar")
}
```

## Step 2: Example code that makes the test pass

```swift
class TableViewDataSource: NSObject, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "foobar"
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
```

