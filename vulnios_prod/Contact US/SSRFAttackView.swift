//
//  SSRFAttackView.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 11/10/23.

import SwiftUI

struct SSRFAttackView: View {

    @State private var fileName = ""
    @State private var fileData: Data?
    @State private var applicationPath = "" // Changed to non-optional String
    @State private var localFileContent: String?

    var body: some View {
        Form {
            Section(header: Text("Upload file")) {
                TextField("File name", text: $fileName)
                Button("Upload") {
                    if !fileName.isEmpty {
                        uploadTextFile(fileName: fileName, fileData: fileData)
                    }
                }
            }

            Section(header: Text("Find application path")) {
                TextField("Application path", text: $applicationPath)
                Button("Find") {
                    if !fileName.isEmpty {
                        applicationPath = getApplicationPath(fileName: fileName) ?? ""
                    }
                }
            }
            

            Section(header: Text("View local file")) {
                Text(localFileContent ?? "")
                Button("View") {
                    if !fileName.isEmpty && !applicationPath.isEmpty {
                        localFileContent = viewLocalFile(applicationPath: applicationPath, fileName: fileName)
                    }
                }
            }
        }
    }

    func uploadTextFile(fileName: String, fileData: Data?) {
        guard let fileData = fileData else {
            print("File data is nil")
            return
        }
        
        // Create a URL to the upload endpoint.
        guard let url = URL(string: "https://hackersden.in/upload") else {
            print("Invalid URL")
            return
        }
        
        // Create a URL request.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the request headers.
        request.setValue("multipart/form-data; boundary=Boundary-\(UUID().uuidString)", forHTTPHeaderField: "Content-Type")
        
        // Create the request body.
        var body = Data()
        
        // Add file data to the request body.
        body.append("\r\n--Boundary-\(UUID().uuidString)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n--Boundary-\(UUID().uuidString)--\r\n".data(using: .utf8)!)
        
        // Set the request body.
        request.httpBody = body
        
        // Execute the request.
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                // The file was uploaded successfully.
                print(String(data: data, encoding: .utf8) ?? "Response is not a valid UTF-8 string")
            }
        }.resume()
    }
    

    func getApplicationPath(fileName: String) -> String? {
        // Simulate finding the application path using a regular expression.
        let regex = #"document\.write\(document\.location\)"#
        let sampleHtml = "<svg/onload=document.write(document.location)>"
        let matches = sampleHtml.matches(for: regex)
        if let match = matches.first {
            return sampleHtml.replacingOccurrences(of: match, with: "")
        }
        return nil
    }

    func viewLocalFile(applicationPath: String, fileName: String) -> String? {
        // Simulate fetching local file content.
        let localFileContent = "Content of the local file."
        return localFileContent
    }

    struct SSRFAttackView_Previews: PreviewProvider {
        static var previews: some View {
            SSRFAttackView()
        }
    }
}

// Extension to perform regular expression matches.
extension String {
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

    
    struct SSRFAttackView_Previews: PreviewProvider {
        static var previews: some View {
            SSRFAttackView()
        }
    }


//In your provided code, there are areas that can potentially lead to SSRF vulnerabilities:

//User-Controlled URLs: The applicationPath variable is taken directly from user input without proper validation or sanitization. This allows users to potentially specify any URL, including internal or sensitive resources.

//Sending Requests to User-Provided URLs: In the uploadTextFile function, you are directly creating a URL request using the applicationPath provided by the user. This means the application will send requests to the URL specified by the user, which is a significant SSRF risk.

//No URL Validation or Sanitization: There is no validation or sanitization being performed on the applicationPath input, making it vulnerable to SSRF attacks.

//Based on the steps you've outlined, it's clear that an attacker can exploit this vulnerability to upload files, find the application path, and even view local files. This is a serious security concern.

// https://hackerone.com/reports/746541
