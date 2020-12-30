import XCTest
@testable import CloudCoder

final class CloudCoderTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CloudCoder().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
