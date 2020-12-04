---
date: 2020-10-16 01:46
description: Test whether requestWhenInUseAuthorization is called.
tags: CLLocationManager
---

# Request When In Use (Always) Authorization

Test whether requestWhenInUseAuthorization is called

## Step 1: CLLocationManager Mock

```swift
class LocationManagerMock: CLLocationManager {
  
  var requestWhenInUseAuthorizationCallCount = 0
  
  override func requestWhenInUseAuthorization() {
    requestWhenInUseAuthorizationCallCount += 1
  }
}
```

## Step 2: Test

```swift
func test_requestWhenInUseAuthorization() {
  // given
  sut.locationManagerClass = LocationManagerMock.self
  
  // when
  sut.setup()
  
  // then
  let locationManager = sut.locationManager
  XCTAssertEqual(locationManager.requestWhenInUseAuthorizationCallCount, 1)
}
```

## Step 3: Example code that makes the test pass

```swift
class LocationProvider<LocationManager: CLLocationManager>: NSObject {
  
  lazy var locationManagerClass: LocationManager.Type = LocationManager.self
  lazy var locationManager: LocationManager = LocationManager()
  
  func setup() {
    if LocationManager.locationServicesEnabled() {
      locationManager.requestWhenInUseAuthorization()
    }
  }
}
```

> The test for requestAlwaysAuthorization works similar.
