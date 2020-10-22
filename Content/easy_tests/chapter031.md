---
date: 2020-10-16 00:31
description: Test wheather a delegate method is called.
tags: easy_tests
---

# Calls Of Delegate Methods

Test wheather a delegate method is called

## Step 0: Delegate

```swift
protocol UserDelegate {
  func score(for user: User) -> Int
}
```

## Step 1: Mock For The Delegate

```swift
class UserDelegateMock : UserDelegate {
  
  var scoreCallUser: User? = nil
  
  func score(for user: User) -> Int {
    scoreCallUser = user
    return 0
  }
}
```

## Step 2: Test

```swift
class UserViewControllerTests : XCTestCase {
  
  var sut: UserViewController!
  var delegate: UserDelegateMock!
  
  override func setUpWithError() throws {
    sut = UserViewController()
    delegate = UserDelegateMock()
    sut.delegate = delegate
  }
  
  override func tearDownWithError() throws {
    sut = nil
    delegate = nil
  }
  
  func test_viewLoading_callsScoreForUser() {
    // when
    sut.loadViewIfNeeded()
    
    // then
    XCTAssertEqual(delegate.scoreCallUser, sut.user)
  }
}
```

## Step 3: Example code that makes the test pass

```swift
class UserViewController : UIViewController {
  var delegate: UserDelegate? = nil
  let user = User(name: "Foobar")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate?.score(for: user)
  }
}

struct User : Equatable {
  let name: String
}
```

