---
date: 2020-10-16 00:16
tags: general
---

#  Setter Injection

Inject dependency via setter

## Step 1: Protocol

```swift
import Foundation

protocol DefaultsProtocol {
  func bool(forKey: String) -> Bool
}

extension UserDefaults : DefaultsProtocol {}
```

## Step 2: Injection Point

```swift
struct User {
  lazy var defaults: DefaultsProtocol = UserDefaults.standard
}
```

## Step 3: Fake Object

```swift
struct DefaultsStub : DefaultsProtocol {
  let boolToReturn: Bool
  
  func bool(forKey: String) -> Bool {
    return boolToReturn
  }
}
```

## Step 4: Injection

```swift
let defaultsStub = DefaultsStub(boolToReturn: false)
var user = User()
user.defaults = defaultsStub
```

