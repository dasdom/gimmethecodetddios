---
date: 2020-10-16 00:17
tags: general
---

# Interface Injection

Inject dependency via interface

## Step 1: Protocols

```swift
import Foundation

protocol DefaultsProtocol {
  func bool(forKey: String) -> Bool
}

extension UserDefaults : DefaultsProtocol {}

protocol InjectDependencyProtocol {
  mutating func inject(defaults: DefaultsProtocol)
}
```

## Step 2: Injection Point

```swift
struct User : InjectDependencyProtocol {
  private lazy var defaults: DefaultsProtocol = UserDefaults.standard
  
  mutating func inject(defaults: DefaultsProtocol) {
    self.defaults = defaults
  }
}
```

## Step 3: Fake Object

```swift
struct DefaultsMock : DefaultsProtocol {
  let boolToReturn: Bool
  
  func bool(forKey: String) -> Bool {
    return boolToReturn
  }
}
```

## Step 4: Injection

```swift
let defaultsMock = DefaultsMock(boolToReturn: false)
var user = User()
user.inject(defaults: defaultsMock)
```

