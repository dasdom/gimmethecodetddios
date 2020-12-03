---
date: 2020-10-16 02:00
tags: UITests
---

# UI Tests Basics

This chapter was inspired by [joemasilotti/UI-Testing-Cheat-Sheet](https://github.com/joemasilotti/UI-Testing-Cheat-Sheet).

## Existence Of A Label

Test whether a label with the text 'Please log in' exists in the user interface.

```swift
func test_label_exists() {

  let app = XCUIApplication()

  let label = app.staticTexts["Please log in"]
  XCTAssertTrue(label.exists)
}
```

## Text Input

Insert text into a text field

```swift
func test_textField_insertText() {

  let app = XCUIApplication()

  let usernameTextField = app.textFields["Username"]
  usernameTextField.tap()
  usernameTextField.typeText("foobar")
}
```

## Button Tap

Tap a button

```swift
func test_buttonTouch_showsNextViewController() {

  let app = XCUIApplication()

  let button = app.buttons["Login"]
  button.tap()

  let titleExtists = app
    .navigationBars["All Items"].exists
  XCTAssertTrue(titleExtists)
}
```

## Scrolling

Scroll a table view

```swift
func test_scrolling() {

  let app = XCUIApplication()

  let cell9 = app.cells.element(boundBy: 9)
  let cell0 = app.cells.element(boundBy: 0)
  let from = cell9.coordinate(
    withNormalizedOffset:
    CGVector(dx: 0, dy: 0))
  let to = cell0.coordinate(
    withNormalizedOffset:
    CGVector(dx: 0, dy: 0))
  from.press(forDuration: 0, thenDragTo: to)
}
```

## Selection Of A Table View Cell

Test whether the selection of a table view cell pushes a view controller onto the navigation stack

```swift
func test_selectionOfCell_showsDetails() {

  let app = XCUIApplication()

  let cell =
    app.staticTexts["Section: 5, Row: 23"]
  cell.tap()
  let titleExtists =
    app.navigationBars["Detail"].exists
  XCTAssertTrue(titleExtists)
}
```

## Push And Pop Of ViewControllers

```swift
let cell =
  app.staticTexts["Section: 5, Row: 23"]
cell.tap()

XCTAssertTrue(
  app.navigationBars["Detail"].exists)

```

```swift
app.navigationBars.buttons.element(
  boundBy: 0).tap()

XCTAssertTrue(
  app.navigationBars["All Items"].exists)
```

## Pull To Refresh

Pull down to refresh

```swift
func test_pullToRefresh() {

  let app = XCUIApplication()

  let cell0 = app.cells.element(boundBy: 0)
  let from = cell0.coordinate(
    withNormalizedOffset:
    CGVector(dx: 0, dy: 0))
  let to = cell0.coordinate(
    withNormalizedOffset:
    CGVector(dx: 0, dy: 6))
  from.press(forDuration: 0, thenDragTo: to)
}
```

## Alerts

React on alerts

```swift
func test_alert() {

  let app = XCUIApplication()

  app.buttons["Show Alert"].tap()

  app.alerts.buttons["OK"].tap()
}
```

## Change Orientation

```swift
XCUIDevice.shared.orientation = .landscapeLeft
```

## Screenshot

```swift
func test_takeScreenshot() {

  let app = XCUIApplication()

  let screenshot =
    app.windows.firstMatch.screenshot()
  let attachment =
    XCTAttachment(screenshot: screenshot,
                  quality: .original)
  attachment.lifetime = .keepAlways
  add(attachment)
}
```

## Delete App

Delete the app in a tear down block to get a clean state for the next tests

```swift
func test_something() {

  addTeardownBlock {
    self.app.delete()
  }

  // ... test ...
}

extension XCUIApplication {
  func delete() {

    delete(app: self.label)
  }

  func delete(app: String) {

    self.terminate()

    let springboard = XCUIApplication(
      bundleIdentifier: "com.apple.springboard")

    let appIcon = springboard.icons[app]
    if appIcon.exists {

      appIcon.press(forDuration: 1.3)

      springboard.buttons["Delete App"].tap()

      Thread.sleep(forTimeInterval: 0.8)

      springboard.alerts.buttons["Delete"].tap()

      Thread.sleep(forTimeInterval: 0.8)

      XCUIDevice.shared.press(.home)
    }
  }
}
```

## System Alerts (like Location Services)

React on system alerts like authorisation for location services

```swift
func test_auth() {

  var didAskForAuth = false

  // add monitor
  let monitor = addUIInterruptionMonitor(
  withDescription: "Location Services") {
    alert -> Bool in

    didAskForAuth = true

    alert.buttons["Don’t Allow"].tap()
    return true
  }

  addTeardownBlock {
    // remove monitor
    self.removeUIInterruptionMonitor(monitor)
    self.app.delete()
  }

  app.buttons["Auth"].tap()

  // this is needed to trigger the handler
  app.tap()

  XCTAssertTrue(didAskForAuth)
}
```
