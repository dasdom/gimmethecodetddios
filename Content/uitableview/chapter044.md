---
date: 2020-10-16 00:44
description:  Test wheather a cell is dequeued.
tags: UITableView
---

# Dequeue A Cell

Test wheather a cell is dequeued

### Step 1: Table View Mock

```swift
class TableViewMock: UITableView {
  
  var dequeueReusableCellCalls: [String:Int] = [:]
  
  override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
    
    var numberOfCalls = dequeueReusableCellCalls[identifier] ?? 0
    numberOfCalls += 1
    dequeueReusableCellCalls[identifier] = numberOfCalls
    
    return UITableViewCell()
  }
}
```

## Step 2: Test

```swift
func test_cellForRow_dequeuesCell() {
  // given
  let mockTableView = TableViewMock()
  
  // when
  let indexPath = IndexPath(row: 0, section: 0)
  _ = sut.tableView(mockTableView, cellForRowAt: indexPath)

  // then
  XCTAssertEqual(mockTableView.dequeueReusableCellCalls["Cell"], 1)
}
```

## Step 3: Example code that makes the test pass

```swift
class TableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    return cell
  }
}
```

