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

#if !os(macOS)
// MARK: - UIViewRepresentable
extension WebView: UIViewRepresentable {
    public typealias UIViewType = UIViewContainerView<WKWebView>

    public func makeUIView(context: UIViewRepresentableContext<WebView>) -> WebView.UIViewType {
        return UIViewContainerView()
    }

    public func updateUIView(_ view: WebView.UIViewType, context: UIViewRepresentableContext<WebView>) {
        if view.contentView !== webView {
            view.contentView = webView
        }
    }
}
#endif

#if os(macOS)
// MARK: - NSViewRepresentable
extension WebView: NSViewRepresentable {
    public typealias NSViewType = NSViewContainerView<WKWebView>

    public func makeNSView(context: Context) -> WebView.NSViewType {
        return NSViewContainerView()
    }

    public func updateNSView(_ view: WebView.NSViewType, context: Context) {
        if view.contentView !== webView {
            view.contentView = webView
        }
    }
}
#endif
