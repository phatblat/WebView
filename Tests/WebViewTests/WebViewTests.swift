@testable import WebView
import XCTest

final class WebViewTests: XCTestCase {
    func testWebViewExists() {
        XCTAssertNotNil(WebView().webView)
    }

    func testWebViewLoading() {
        let url = URL(string: "about:blank")!
        let request = URLRequest(url: url)
        let navigation = WebView().webView.load(request)
        
        XCTAssertNotNil(navigation)
        XCTAssertEqual(navigation!.effectiveContentMode, .recommended)
    }
}
