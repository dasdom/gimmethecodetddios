---
date: 2020-10-16 00:51
description:  Test number of sections and rows.
tags: UITableViewDataSource
---

# Number Of Sections And Rows

Test number of sections and rows

## Step 1: Test

```swift
func test_numberOfSections() {
  // given
  sut.users = [[User(name: "dasdom"),
                User(name: "foo")],
                [User(name: "bar")]]

  // when
  let sections = tableView.numberOfSections
  
  // then
  XCTAssertEqual(sections, 2)
}

func test_numberOfRows() {
  // given
  sut.users = [[User(name: "dasdom"),
                User(name: "foo")],
                [User(name: "bar")]]
  
  // when
  let rows = tableView.numberOfRows(inSection: 0)
  
  // then
  XCTAssertEqual(rows, 2)
}
```

## Step 2: Example code that makes the test pass

```swift
class TableViewDataSource: NSObject, UITableViewDataSource {
  
  var users: [[User]] = []
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return users[section].count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

struct User {
  let name: String
}
```

