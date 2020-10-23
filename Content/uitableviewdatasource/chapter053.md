---
date: 2020-10-16 00:53
description:  Test wheather the content of a cell (labels, image views, ...) is populated with data.
tags: UITableViewDataSource
---

# Populating A Cell

Test wheather the content of a cell (labels, image views, ...) is populated with data

## Step 1: Test

```swift
func test_cellForRow_populatesCell() {
  // given
  sut.names = ["foo"]
  
  // when
  let indexPath = IndexPath(row: 0, section: 0)
  let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)
  
  // then
  XCTAssertEqual(cell?.textLabel?.text, sut.names.first)
}
```

## Step 2: Example code that makes the test pass

```swift
class TableViewDataSource: NSObject, UITableViewDataSource {
  
  var names: [String] = []
  
  func registerCell(for tableView: UITableView) {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return names.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let name = names[indexPath.row]
    cell.textLabel?.text = name
    
    return cell
  }
}
```

