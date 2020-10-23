---
date: 2020-10-16 00:45
description:  Test wheather a header is dequeued.
tags: UITableView
---

# Dequeue A Header

Test wheather a header is dequeued

## Step 1: Table View Mock

```swift
class TableViewMock: UITableView {
  
  var dequeueReusableHeaderCalls: [String:Int] = [:]
  
  override func dequeueReusableHeaderFooterView(withIdentifier identifier: String) -> UITableViewHeaderFooterView? {
    
    var numberOfCalls = dequeueReusableHeaderCalls[identifier] ?? 0
    numberOfCalls += 1
    dequeueReusableHeaderCalls[identifier] = numberOfCalls
    
    return UITableViewHeaderFooterView()
  }
}
```

## Step 2: Test

```swift
func test_cellForRow_dequeuesHeader() {
  // given
  let mockTableView = TableViewMock()
  
  // when
  _ = sut.tableView(mockTableView, viewForHeaderInSection: 0)
  
  // then
  XCTAssertEqual(mockTableView.dequeueReusableHeaderCalls["Header"], 1)
}
```

## Step 3: Example code that makes the test pass

```swift
class TableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewHeaderFooterView.self, forCellReuseIdentifier: "Header")
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header")
    
    return header
  }
}
```

