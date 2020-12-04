---
date: 2020-10-16 01:57
description: Test whether an Interface Builder outlet is connected.
tags: Storyboards
---

# Outlet

Test whether an Interface Builder outlet is connected

## Step 1: Test
 
```swift
class StoryboardTests: XCTestCase {
  
  var sut: ViewController!
  
  override func setUpWithError() throws {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    sut = (storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_viewController_hasButtonOutlet () {
    // when
    sut.loadViewIfNeeded()
    
    // then
    XCTAssertNotNil(sut.button)
  }
}
```

## Step 2: Example Storyboard that makes the test pass

![Storyboard scene with a connected outlet](../../images/storyboards_outlet.png)
