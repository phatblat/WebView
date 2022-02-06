import WebKit
import Combine

/// Provides access to webview data.
public class WebViewStore: ObservableObject {
    private var observers = Set<NSKeyValueObservation>()

    @Published
    public var webView: WKWebView {
        didSet {
            setupObservers()
        }
    }

    /// Initializes a new WebView.
    /// - Parameter webView: Optional custom webview. Default WKWebView will be constructed if not provided.
    public init(webView: WKWebView = .init()) {
        self.webView = webView

        #if DEBUG
        self.webView
            .configuration
            .preferences
            .setValue(true, forKey: "developerExtrasEnabled")
        #endif

        setupObservers()
    }

    /// Enables KeyPath access to wrapped WKWebView properties.
    public subscript<T>(keyPath: KeyPath<WKWebView, T>) -> T {
        webView[keyPath: keyPath]
    }

    deinit {
        observers.forEach {
            // Not even sure if this is required?
            // Probably wont be needed in future betas?
            $0.invalidate()
        }
    }
}

/// Private methods
fileprivate extension WebViewStore {
    /// Description
    private func setupObservers() {
        func subscriber<Value>(for keyPath: KeyPath<WKWebView, Value>) -> NSKeyValueObservation {
            return webView.observe(keyPath, options: [.prior]) { _, change in
                if change.isPrior {
                    self.objectWillChange.send()
                }
            }
        }

        // Observers for all KVO compliant properties
        observers = [
            subscriber(for: \.title),
            subscriber(for: \.url),
            subscriber(for: \.isLoading),
            subscriber(for: \.estimatedProgress),
            subscriber(for: \.hasOnlySecureContent),
            subscriber(for: \.serverTrust),
            subscriber(for: \.canGoBack),
            subscriber(for: \.canGoForward)
        ]
    }
}

/// DOM manipulation and scrolling.
extension WebViewStore {
    /// Loads a new document and scrolls to the same Y offset.
    /// - Parameters:
    ///   - html: HTML string of the new document.
    ///   - baseURL: Optional base URL.
    func update(_ html: String, baseURL: URL? = nil) {
        webView.evaluateJavaScript("window.pageYOffset") { [weak self] object, error in
            guard let strongSelf = self else { return }

            strongSelf.webView.loadHTMLString(html, baseURL: baseURL)

            if let offset = object as? Int {
                strongSelf.scrollTo(offset)
            }
        }
    }

    /// Instructs the webview to scroll the viewport.
    /// - Parameter yOffset: Vertical offset to scroll to.
    private func scrollTo(_ yOffset: Int) {
        let script = "window.scrollTo(0, \(yOffset));"
        let scrollScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        webView.configuration.userContentController.addUserScript(scrollScript)
    }
}
