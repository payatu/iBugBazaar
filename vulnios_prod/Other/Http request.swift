//
//  Http request.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 21/11/23.
//

import SwiftUI

struct httprequest: View {
    @State private var responseText: String = ""

    var body: some View {
        VStack {
            Button("Send Report") {
                // Call a function to send the HTTP request
                sendHTTPRequest()
            }
            .padding()

            Text("Response: \(responseText)")
                .padding()
        }
    }

    func sendHTTPRequest() {
        // Specify the URL you want to send the request to
        if let url = URL(string: "https://payatu.com") {
            // Create a URL session
            let session = URLSession.shared

            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            // Add headers if needed
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            // Add parameters to the request body
            let parameters: [String: String] = ["Secret": "4865795F6368616D705F796F755F666F756E645F74686973"]
            request.httpBody = parameters
                .map { "\($0.key)=\($0.value)" }
                .joined(separator: "&")
                .data(using: .utf8)

            // Log the request data
            if let requestBody = request.httpBody, let requestBodyString = String(data: requestBody, encoding: .utf8) {
                print("Request URL: \(url)")
                print("Request Method: \(request.httpMethod ?? "")")
                print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
                print("Request Body: \(requestBodyString)")
            }

            // Create a data task
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    // Log the response data
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                        
                        // Update the UI on the main thread
                        DispatchQueue.main.async {
                            self.responseText = responseString
                        }
                    }
                }
            }

            // Start the data task
            task.resume()
        }
    }
}

struct httprequest_Previews: PreviewProvider {
    static var previews: some View {
        httprequest()
    }
}
