//
//  webview.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 09/06/23.
//
import SwiftUI
import WebKit

struct WebView1: UIViewRepresentable {
    let baseURL: URL
    @Binding var jsCode: String

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        configuration.preferences = preferences

        let userContentController = WKUserContentController()
        userContentController.add(context.coordinator, name: "jsBridge")
        configuration.userContentController = userContentController

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Load empty HTML string initially
        uiView.loadHTMLString("", baseURL: nil)

        // Update the JavaScript code in the WebView
        let script = WKUserScript(source: jsCode, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        uiView.configuration.userContentController.removeAllUserScripts()
        uiView.configuration.userContentController.addUserScript(script)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
        var parent: WebView1

        init(_ parent: WebView1) {
            self.parent = parent
        }

        // Handle messages sent from JavaScript
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            // Handle JavaScript messages here
        }
    }
}

struct ContentView1: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var contactNumber: String = ""
    @State private var subject: String = ""
    @State private var jsCode: String = ""

    var body: some View {
        VStack {
            TextField("Your Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Your Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Contact Number", text: $contactNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Subject", text: $subject)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("JavaScript Code", text: $jsCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // Dismiss the keyboard
            }) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            WebView1(baseURL: Bundle.main.bundleURL, jsCode: $jsCode) // Display the WebView with the user-provided JavaScript code
        }
        .padding()
    }
}

struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
