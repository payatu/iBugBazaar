//
//  ContentView.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 04/05/23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @StateObject private var cartManager = CartManager()
    @State private var isDeepLinkActivated = false
    @State private var isWebviewRedirecting = false
    @State private var webviewCustomURL = ""

    var body: some View {
        NavigationView {
            if isDeepLinkActivated {
                Link_file_theft()
                    .navigationBarTitle("Deep Link View")
            } else if isWebviewRedirecting {
                WebviewOPENredirection()
                    .navigationBarTitle("Webview Redirect View")
                    .onAppear {
                        // Pass the customURL to WebviewOPENredirection when it appears
                        handleWebviewRedirect(customURL: webviewCustomURL)
                    }
            } else {
                Loginscreen()
                    .navigationBarTitle("")
            }
        }
        .navigationBarHidden(true)
        .onOpenURL { url in
            handleDeepLinkAndRedirect(url)
        }
        .environmentObject(cartManager)
    }

    private func handleWebviewRedirect(customURL: String) {
        guard let url = URL(string: customURL) else {
            return
        }

        DispatchQueue.main.async {
            let webview = WKWebView()
            webview.load(URLRequest(url: url))
            let viewController = UIViewController()
            viewController.view = webview

            // Present the webview using a navigation controller or modal presentation
            UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
        }
    }

    private func handleDeepLinkAndRedirect(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return
        }

        if let scheme = components.scheme, let host = components.host {
            if scheme == "bandit" && host == "urlredirection" {
                // Handle the URL redirection for "bandit" scheme
                if let queryItems = components.queryItems {
                    for queryItem in queryItems {
                        if queryItem.name == "url" {
                            handleWebviewRedirect(customURL: queryItem.value ?? "")
                            isDeepLinkActivated = false
                            isWebviewRedirecting = true
                            return
                        }
                    }
                }
            } else if scheme == "payatu" && host == "secret" {
                // Handle the deep link here for "payatu" scheme
                print("Handling deep link: \(url)")
                isDeepLinkActivated = true
                isWebviewRedirecting = false
            } else {
                // Reset states if the URL scheme is not recognized
                isDeepLinkActivated = false
                isWebviewRedirecting = false
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


