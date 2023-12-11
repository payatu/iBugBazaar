//
//  Couchbase.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 20/11/23.
//
import SwiftUI
import WebKit

struct CookieDemoView: View {
    var body: some View {
        VStack {
            CustomWebView(url: "https://payatu.com", cookieName: "This_is_secret_Cookie", cookieValue: "Bandits_token")
        }
    }
}

struct CookieDemoView_Previews: PreviewProvider {
    static var previews: some View {
        CookieDemoView()
    }
}

struct CustomWebView: UIViewRepresentable {
    let url: String
    let cookieName: String
    let cookieValue: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        if let url = URL(string: self.url) {
            let cookieProperties: [HTTPCookiePropertyKey: Any] = [
                .name: self.cookieName,
                .value: self.cookieValue,
                .domain: url.host!,
                .path: "/",
                .expires: NSDate(timeIntervalSinceNow: 31536000) // Expires in one year
            ]

            if let cookie = HTTPCookie(properties: cookieProperties) {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update view if needed
    }
}


//here we stored the persistance cookies value


