---
date: 2020-10-16 00:54
description:  Test wheather a setup method of a cell is called.
tags: UITableViewDataSource
---

# Setup Cell

Test wheather a setup method of a cell is called

## Step 1: Protocol

```swift
protocol TableViewCellProtocol {
  func setup(with: User)
}
```

## Step 2: Table View Cell Mock

```swift
class MockTableViewCell: UITableViewCell, TableViewCellProtocol {
  
  var lastSetupUser: User?
  
  func setup(with user: User) {
    lastSetupUser = user
  }
}
```

## Step 3: Test

```swift
func test_cellForRow_setsUpTheCell() {
  // given
  tableView.register(MockTableViewCell.self, forCellReuseIdentifier: "Cell")
  let user = User(name: "Foo")
  sut.users = [user]
  
  // when
  let indexPath = IndexPath(row: 0, section: 0)
  let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as! MockTableViewCell
  
  // then
  XCTAssertEqual(cell.lastSetupUser, user)
}
```

## Step 4: Example code that makes the test pass

```swift
class TableViewDataSource: NSObject, UITableViewDataSource {
  
  var users: [User] = []
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    if let setupCell = cell as? TableViewCellProtocol {
      setupCell.setup(with: users[indexPath.row])
    }
    
    return cell
  }
}

struct User: Equatable {
  let name: String
}
```

