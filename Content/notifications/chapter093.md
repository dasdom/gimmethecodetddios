---
date: 2020-10-16 01:33
description: Test wheather a notification for a given name is sent and has the expected user info.
tags: Notification
---

# Notification Sending With Object And User Info

Test wheather a notification for a given name is sent and has the expected user info

## Step 1: Test

```swift
func test_settingScore_sendsNotification() {
  // given
  expectation(forNotification: notificationName, object: sut) { notification -> Bool in
    
    if let score = notification.userInfo?["score"] as? Int {
      return score == 5
    }
    return false
  }
  
  // when
  sut.score = 5
  
  // then
  waitForExpectations(timeout: 1, handler: nil)
}
```

## Step 2: Example code that makes the test pass

```swift
class User {
  var score: Int {
    didSet {
      NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["score": score])
    }
  }
  
  init(score: Int) {
    self.score = score
  }
}

let notificationName = NSNotification.Name("DDHScoreDidChange")
```

