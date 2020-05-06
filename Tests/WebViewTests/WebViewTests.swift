@testable import WebView
import XCTest

final class WebViewTests: XCTestCase {
    func testExample() {
        XCTAssertNotNil(WebView().webView)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
