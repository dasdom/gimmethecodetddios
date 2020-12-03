---
date: 2020-10-16 01:32
description: Test wheather a notification for a given name is sent.
tags: Notification
---

# Notification Sending

Test wheather a notification for a given name is sent

## Step 1: Test

```swift
func test_settingScore_sendsNotification() {
  // Arrage
  let notificationCenter = NotificationCenter()
  sut = User(score: 0, notificationCenter: notificationCenter)
  let expectation = XCTNSNotificationExpectation(name: notificationName, object: nil, notificationCenter: notificationCenter)
  
  // when
  sut.score = 5
  
  // then
  wait(for: [expectation], timeout: 1)
}
```

## Step 2: Example code that makes the test pass

```swift
class User {
  var score: Int {
    didSet {
      notificationCenter.post(name: notificationName, object: self)
    }
  }
  let notificationCenter: NotificationCenter
  
  init(score: Int, notificationCenter: NotificationCenter = NotificationCenter.default) {
    self.score = score
    self.notificationCenter = notificationCenter
  }
}

let notificationName = NSNotification.Name("DDHScoreDidChange")
```

