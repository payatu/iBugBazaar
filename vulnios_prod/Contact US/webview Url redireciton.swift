//
//  WebviewOPENredirection.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 12/07/23.
//

import SwiftUI
import WebKit

struct WebviewOPENredirection: View {
    @State private var isRedirecting = false
    @State private var customURL = ""

    var body: some View {
        VStack {
            if isRedirecting {
                Webview(urlString: customURL)
            } else {
                Text("Welcome to Vulnweb")
                    .font(.title)
                    .padding()

                TextField("Enter custom URL", text: $customURL)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Open WebView") {
                    handleRedirect(urlString: customURL)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .onOpenURL { url in
            handleRedirect(urlString: url.absoluteString)
        }
    }

    private func handleRedirect(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        if url.scheme == "bandit", let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems {
            for queryItem in queryItems {
                if queryItem.name == "urlredirection" {
                    isRedirecting = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isRedirecting = false
                        openWebview(urlString: queryItem.value ?? "")
                    }
                }
            }
        } else {
            // Handle other cases or show an alert for invalid URLs
        }
    }

    private func openWebview(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        let webview = WKWebView()
        webview.load(URLRequest(url: url))
        let viewController = UIViewController()
        viewController.view = webview
        let window = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

struct Webview: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            uiView.load(URLRequest(url: url))
        }
    }
}

struct WebviewOPENredirection_Previews: PreviewProvider {
    static var previews: some View {
        Webview(urlString: "https://payatu.com")
    }
}

    
//In the provided code, the handleRedirect function //checks whether the URL has the scheme "bandit" //and contains a query item with the name //"urlredirection." If these conditions are met, it //sets the isRedirecting state to true and opens a //WKWebView to load the URL specified in the //"urlredirection" query item.

//So, to load a URL in the application using this code, the user should use a URL with the "bandit" scheme and include a query item with the name "urlredirection" that contains the desired URL.


//bandit://urlredirection?url=https://payatu.com
