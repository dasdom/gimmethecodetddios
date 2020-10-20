---
date: 2020-10-16 00:19
description: Mocks are used when you need to verify that your system under test interacts with another class in an expeced way. It's often a good idea to define the interaction of the system under test and the class to be mocked with a protocol.
tags: general
---

# Mocks
 
Mocks are used when you need to verify that your system under test interacts with another class in an expeced way. It's often a good idea to define the interaction of the system under test and the class to be mocked with a protocol.
 
## Protocol

```swift
protocol UserUpdateable {
  func update(with: User)
}
```

## Example Mock

```swift
class ViewMock : UIView, UserUpdateable {

  var updateUser: User? = nil
  
  func update(with user: User) {
    updateUser = user
  }
}
```

## Usage

```swift
  func test_settingUser_callsUpdate() {
    // given
    let viewMock = ViewMock()
    sut.view = viewMock
    let user = User(name: "Foo", lastname: "Bar")
    
    // when
    sut.user = user
    
    // then
    XCTAssertEqual(viewMock.updateUser, user)
  }
```

