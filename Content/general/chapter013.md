---
date: 2020-10-16 00:13
tags: general
---

# func addTeardownBlock(_ block:)
 
 > **Apple docs:**
 >
 > Call addTeardownBlock(_:) during a test method's execution to register a block of code to be called when the test method ends.
 
 > Example is from the Apple docs.

```swift
class ReadAndWriteTests: XCTestCase {
  
  func temporaryFileURL() -> URL {
    
    let directory = NSTemporaryDirectory()
    let filename = UUID().uuidString
    let fileURL = URL(fileURLWithPath: directory).appendingPathComponent(filename)
    
    // Add a teardown block to delete any file
    // at `fileURL`.
    addTeardownBlock {
      do {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: fileURL.path) {
          
          try fileManager.removeItem(at: fileURL)
          
          XCTAssertFalse(fileManager.fileExists(atPath: fileURL.path))
        }
      } catch {
        XCTFail("Error: \(error)")
      }
    }
    return fileURL
  }
  
  func testReadAndWriteDataToTemporaryFile() {
    
    let fileURL = temporaryFileURL()
    
    let originalString = "Hello there"
    
    do {
      try originalString.write(to: fileURL, atomically: true, encoding: .utf8)

      let readString = try String(contentsOf: fileURL, encoding: .utf8)

      XCTAssertEqual(readString, originalString)
    } catch {
      XCTFail("Error: \(error)")
    }
  }
}
```

