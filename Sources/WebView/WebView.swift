import WebKit
import SwiftUI
import Combine

/// WKWebView wrapped in a SwiftUI View.
public struct WebView: View {
    /// The WKWebView to display
    public let webView: WKWebView

    public init(webView: WKWebView = .init()) {
        self.webView = webView
    }
}

// MARK: - UIViewRepresentable
#if os(iOS)
extension WebView: UIViewRepresentable {
    public func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        webView
    }

    public func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<WebView>) {}
}
#endif

// MARK: - NSViewRepresentable
#if os(macOS)
extension WebView: NSViewRepresentable {
    public func makeNSView(context: NSViewRepresentableContext<WebView>) -> WKWebView {
        webView
    }

    public func updateNSView(_ view: WKWebView, context: NSViewRepresentableContext<WebView>) {}
}
#endif
