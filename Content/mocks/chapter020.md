---
date: 2020-10-16 00:20
description: Stubs are used when you need to test whether the system under test reacts to data it gets from another class or module in an expected way. Common examples are UserDefaults and network requests.
tags: general
---

# Stubs

Stubs are used when you need to test whether the system under test reacts to data it gets from another class or module in an expected way. Common examples are UserDefaults and network requests.

## Example Stub

```swift
class UserDefaultsStub : UserDefaults {
  
  private let boolToReturn: Bool
  var defaultName: String? = nil
  
  init(boolToReturn: Bool) {
    self.boolToReturn = boolToReturn
    
    super.init(suiteName: nil)!
  }
  
  override func bool(forKey defaultName: String) -> Bool {
    self.defaultName = defaultName
    return boolToReturn
  }
}
```

## Usage

```swift
  func test_appearance_whenFirstStart_showsOnboarding() {
    // given
    let stubUserDefaults = UserDefaultsStub(boolToReturn: false)
    sut.userDefaults = stubUserDefaults
    
    // when
    sut.beginAppearanceTransition(true, animated: false)
    sut.endAppearanceTransition()
    
    // then
    XCTAssertTrue(sut.presentedViewController is OnboardingViewController)
    XCTAssertEqual(stubUserDefaults.defaultName, "AlreadyStartedKey")
  }
```

