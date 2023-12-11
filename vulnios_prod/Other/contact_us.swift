//
//  contact_us.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 20/10/23.
//

import SwiftUI
import WebKit

struct ContentView5: View {
    @State private var webView: WKWebView?

    var body: some View {
        VStack {
            if let webView = webView {
                WebView(webView: webView)
            }

            Button(action: {
                // Load the contact us form URL.
                if let webView = webView {
                    webView.load(URLRequest(url: URL(string: "https://payatu.com/contact-us")!))
                }
            }) {
                Text("Contact Us")
            
            }
        }
        .padding()
        .onAppear {
            // Initialize WKWebView here.
            self.webView = WKWebView()
        }
    }
}

struct ContentView5_Previews: PreviewProvider {
    static var previews: some View {
        ContentView5()
    }
}

struct WebView: UIViewRepresentable {
    let webView: WKWebView

    init(webView: WKWebView) {
        self.webView = webView
    }

    func makeUIView(context: Context) -> WKWebView {
        webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    //check

    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // Allow all URL redirections.
            decisionHandler(.allow)
        }
    }
}



