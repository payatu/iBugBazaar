//
//  html_injection.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 12/10/23.
//

import SwiftUI
import WebKit

struct WebView3: UIViewRepresentable {
    let htmlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

struct html_injection: View {
    @State var message: String?

    var body: some View {
        NavigationView {
            VStack {
                if let message = message {
                    WebView3(htmlString: message)
                } else {
                    Text("No deep link detected.")
                }
            }
            .navigationBarTitle("Hidden Deep Link")
        }
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let urlContext = URLContexts.first {
            handleDeepLink(urlContext.url)
        }
    }

    func handleDeepLink(_ url: URL) {
        if url.scheme == "payatu" && url.host == "deeplink" {
            let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
            let message = queryItems?.first(where: { $0.name == "message" })?.value

            if let message = message {
                let view = html_injection(message: message)
                window?.rootViewController?.present(UIHostingController(rootView: view), animated: true)
            }
        }
    }
}

struct html_injection_Previews: PreviewProvider {
    static var previews: some View {
        html_injection()
    }
}

//Regarding your code, it appears that you're handling a deep link with the payatu://deeplink/alert?message=... scheme. When a URL with this scheme is opened, it triggers the handleDeepLink function in your SceneDelegate. If the URL matches the expected scheme and host, it extracts the message parameter and presents a view with the html_injection view, which contains a WKWebView displaying the HTML content.
