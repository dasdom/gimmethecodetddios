---
date: 2020-10-16 00:15
tags: general
---

# Constructor Injection
 
Inject dependency in constructor

## Step 1: Protocol

```swift
import Foundation

protocol DefaultsProtocol {
  func bool(forKey: String) -> Bool
}

extension UserDefaults : DefaultsProtocol {}
```

## Step 2: The Injection Point

```swift
struct User {
  let defaults: DefaultsProtocol
  
  init(defaults: DefaultsProtocol = UserDefaults.standard) {
    self.defaults = defaults
  }
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
let user = User(defaults: defaultsStub)
```

