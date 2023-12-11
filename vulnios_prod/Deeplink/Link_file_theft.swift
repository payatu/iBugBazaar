//
//  Link_file_theft.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 11/10/23.
//
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Register the deeplink scheme.
        URLProtocol.registerClass(DeeplinkProtocol1.self)

        return true
    }
}

class DeeplinkProtocol1: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        // Check if the request is for a deeplink.
        return request.url?.scheme == "payatu" && request.url?.host == "secret"
    }

    override func startLoading() {
        guard let url = request.url else { return }

        let fileName = url.queryParameters?["name"]
        let fileData = url.queryParameters?["data"]?.data(using: .utf8)

        guard let filePath = fileName, let data = fileData else {
            client?.urlProtocol(self, didFailWithError: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil))
            return
        }

        // Get the application's documents directory
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Append the desired file path
            let fileURL = documentsDirectory.appendingPathComponent(filePath)

            do {
                try data.write(to: fileURL, options: .atomic)

                // Log confirmation
                print("Data written to file: \(fileURL.path)")

                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                // Log error
                print("Error writing data to file: \(error)")
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
    }
}

extension URL {
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return nil
        }

        var parameters = [String: String]()
        queryItems.forEach { parameters[$0.name] = $0.value }
        return parameters
    }
}

import SwiftUI

struct ContentView9: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Other Content in the Main View")
                NavigationLink(destination: Link_file_theft()) {
                    Text("Go to Link_file_theft")
                }
            }
            .navigationBarTitle("Main View")
        }
    }
}

import SwiftUI

struct Link_file_theft: View {
    @State private var writtenData: String? = nil

    var body: some View {
        VStack {
            Text("Hey you've found SECRET WAY")
                .font(.title)
                .padding()

            Divider()

            Text("Username: Bandit")
                .font(.headline)
                .padding()

            Text("Password: payatu")
                .font(.headline)
                .padding()

            Text("API_KEY: PROD_USER_SECRET_TOKEN_PAYATU")
                .font(.headline)
                .padding()
            Divider()

                        // Display the written data on the screen
                        if let data = writtenData {
                            Text("Data Written to File:")
                            Text(data)
                                .padding()
                        } else {
                            Text("No data written to file.")
                        }
                    }
                    .onAppear {
                        self.readWrittenData()
                    }
                }

    // Function to read the content of the written file
    private func readWrittenData() {
        let fileName = "bandit.plist"

        // Get the application's documents directory
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Append the desired file path
            let fileURL = documentsDirectory.appendingPathComponent(fileName)

            do {
                let fileContent = try String(contentsOf: fileURL)
                self.writtenData = fileContent
            } catch {
                // Log error
                print("Error reading file content: \(error)")
            }
        }
    }
}

struct Link_file_theft_Previews: PreviewProvider {
    static var previews: some View {
        Link_file_theft()
    }
}




//Here is a breakdown of what the code does:

//It registers a custom URL protocol called DeeplinkProtocol1. This protocol intercepts all requests to the Payatu scheme and deeplink host.

//When a request is intercepted, the protocol checks if the query parameters contain name and data. If they do, it writes the data to a file with the given name in the temporary directory.

//If the write is successful, the protocol responds with a 200 OK status code and the data. Otherwise, it responds with a 500 Internal Server Error status code.

//To use the code, simply add it to your project and register the deeplink scheme in your app's Info.plist file. Then, you can open arbitrary files by sending a deeplink with the following format:

//payatu://deeplink/save?data=...&name=...

//For example, to open a file called myfile.txt containing the text "Hello, world!", you would use the following deeplink:

//payatu://deeplink/save?data=SGVsbG8sIHdvcmxkIQ==&name=myfile.txt

//When the user clicks on the deeplink, the DeeplinkProtocol1 protocol will intercept the request and write the file to the temporary directory. The user can then open the file from the Files app.

//Note: It is important to note that this code can be used to overwrite any file on the device, even if it is protected by the sandbox. It is therefore important to only use this code in trusted applications.
