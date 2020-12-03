---
date: 2020-10-16 01:34
description: Test wheather an object can receive a notification.
tags: Notification
---

# Notification Receiving

Test wheather an object can receive a notification

## Step 1: Test

```swift
func test_sendingNotification_changesName() {
  // given
  let notificationCenter = NotificationCenter()
  let sut = User(name: "Foobar", notificationCenter: notificationCenter)
  
  // when
  notificationCenter.post(name: notificationName, object: self, userInfo: ["name" : "bla blub"])
  
  // then
  XCTAssertEqual(sut.name, "bla blub")
}
```

## Step 2: Example code that makes the test pass

```swift
class User {
  var name: String
  
  init(name: String, notificationCenter: NotificationCenter = .default) {
    
    self.name = name
    
    notificationCenter.addObserver(self, selector: #selector(changeName(notification:)), name: notificationName, object: nil)
  }
  
  @objc func changeName(notification: Notification) {
    if let newName = notification.userInfo?["name"] as? String {
      name = newName
    }
  }
}
let notificationName = NSNotification.Name("DDHChangeName")
```

