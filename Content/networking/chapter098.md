---
date: 2020-10-16 10:42
description: Test wheather the method `loadUser` fetches data and calls completion closure.
tags: networking
---

# Mocking and Stubbing an Upload Task with URLSession
 
 Test wheather the method `loadUser` fetches data and calls completion closure
 
## Step 0: Prerequisites
 
 Possibility to inject the url session as a dependency (see **Dependency Injection**)
 
## Step 0: Protocol

```swift
protocol DDHURLSessionProtocol {
  
  func uploadTask(with request: URLRequest, from bodyData: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
}

extension URLSession: DDHURLSessionProtocol {}
```

## Step 1.1: URLSession Stub

```swift
class StubURLSession: DDHURLSessionProtocol {
  
  private var urlRequest: URLRequest?
  private var uploadData: Data?
  private let uploadTask: StubURLSessionUploadTask
  
  init(data: Data?, urlResponse: URLResponse?, error: Error?, testCase: XCTestCase) {
    
    uploadTask = StubURLSessionUploadTask(data: data, urlResponse: urlResponse, error: error, testCase: testCase)
  }
  
  func waitForAsync() {
    uploadTask.testCase.waitForExpectations(timeout: 5)
  }
  
  var lastURLRequest: URLRequest? {
    uploadTask.testCase.waitForExpectations(timeout: 5)
    
    return urlRequest
  }
  
  func uploadTask(with request: URLRequest, from bodyData: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
    
    self.urlRequest = request
    uploadTask.completionHandler = completionHandler
    return uploadTask
  }
}
```

## Step 1.2: URLSessionUploadTask Stub

```swift
class StubURLSessionUploadTask: URLSessionUploadTask {
  
  private let data: Data?
  private let urlResponse: URLResponse?
  private let responseError: Error?
  let testCase: XCTestCase
  private let expectation: XCTestExpectation
  
  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
  var completionHandler: CompletionHandler?
  
  init(data: Data?, urlResponse: URLResponse?, error: Error?, testCase: XCTestCase) {
    
    self.data = data
    self.urlResponse = urlResponse
    self.responseError = error
    self.testCase = testCase
    self.expectation = testCase.expectation(description: "Async")
  }
  
  override func resume() {
    DispatchQueue.main.async {
      self.completionHandler?(self.data, self.urlResponse, self.responseError)
      
      // Fulfill expectation after a delay
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
        self.expectation.fulfill()
      })
    }
  }
}
```

## Step 2: Test Error Case - URLRequest Returns An Error

```swift
  func test_loadUser_errorInCompletionBlock() {
    // given
    let error = NSError(domain: "FooError", code: 42, userInfo: nil)
    let stubSession = StubURLSession(data: nil, urlResponse: nil, error: error, testCase: self)
    sut.session = stubSession
    
    // when
    var result: NSError? = nil
    sut.upload(
    user: User(name: "Foo")) { error in
      
      result = error as NSError?
    }
    
    // then
    let url = URL(string: "http://example.com/user")!
    XCTAssertEqual(stubSession.lastURLRequest, URLRequest(url: url))
    XCTAssertEqual(result!, error)
  }
```

## Step 3: Test Error Case - Data Returned Is Not JSON

```swift
  func test_loadUser_errorWhenNotJSON() {
    // given
    let data = "1234".data(using: .utf8)
    let stubSession = StubURLSession(data: data, urlResponse: nil, error: nil, testCase: self)
    sut.session = stubSession
    
    // when
    var result: NSError! = nil
    sut.upload(
    user: User(name: "Foo")) { error in
      
      result = error as NSError?
    }
    
    // then
    let url = URL(string: "http://example.com/user")!
    XCTAssertEqual(stubSession.lastURLRequest, URLRequest(url: url))
    XCTAssertEqual(result.localizedDescription,
                   "The data couldn’t be read because it isn’t in the correct format.")
  }
```

## Step 4: Test The Happy Path

```swift
  func test_uploadUser_success() {
    // given
    let data = try! JSONSerialization.data(withJSONObject: ["success":true], options: [])
    let stubSession = StubURLSession(data: data, urlResponse: nil, error: nil, testCase: self)
    sut.session = stubSession
    
    // when
    var result: Error? = NSError(domain: "Foo", code: 1234, userInfo: nil)
    sut.upload(user: User(name: "Foo")) { error in
      result = error
    }
    
    // then
    let url = URL(string: "http://example.com/user")!
    XCTAssertEqual(stubSession.lastURLRequest, URLRequest(url: url))
    XCTAssertNil(result)
  }
```

## Step 5: Example code that makes the test pass

```swift
class APIClient: NSObject {
  
  lazy var session: DDHURLSessionProtocol? = URLSession.shared
  
  func upload(
    user: User,
    completion: @escaping ((Error?) -> Void)) {
    
    guard let url = URL(string: "http://example.com/user") else {
      fatalError()
    }
    
    let request = URLRequest(url: url)
    
    let userData = try? JSONEncoder().encode(user)
    
    session?.uploadTask(with: request, from: userData) { data, response, error in
      
      if let unwrappedError = error {
        completion(unwrappedError)
        return
      }
      
      guard let unwrappedData = data else {
        return
      }
      
      DispatchQueue.main.async {
        
        do {
          let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
          if let responseData = json as? [String:Any],
             let success = responseData["success"] as? Bool, success {
            
            completion(nil)
          }
        } catch {
          completion(error)
        }
      }
    }.resume()  
  }
}

struct User: Equatable, Codable {
  let name: String
}
```

