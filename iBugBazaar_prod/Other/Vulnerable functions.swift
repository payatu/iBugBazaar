//
//  Vulnerable functions.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 21/11/23.
//

import SwiftUI
import CommonCrypto

struct FunctionDemoView: View {
    var body: some View {
        VStack {
            Text("Function Demo")
                .font(.title)
                .padding()

            Text("MD5 Hash of 'Hello World': \(md5Hash("Hello World"))")
                .padding()

            Text("SHA1 Hash of 'Hello World': \(sha1Hash("Hello World"))")
                .padding()

            Text("Random Number: \(randomNumber())")
                .padding()

            Text("Malloc Example: \(mallocExample())")
                .padding()

            Text("Alloca Example: \(allocaExample())")
                .padding()

            Text("Strncpy Example: \(strncpyExample())")
                .padding()
        }
    }

    // MD5 Hashing
    func md5Hash(_ input: String) -> String {
        let data = Data(input.utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = data.withUnsafeBytes {
            CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }

    // SHA1 Hashing
    func sha1Hash(_ input: String) -> String {
        let data = Data(input.utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        _ = data.withUnsafeBytes {
            CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }

    // Random Number Generation
    func randomNumber() -> Int {
        return Int.random(in: 1...100)
    }

    // Malloc Example
    func mallocExample() -> String {
        let buffer = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        buffer.pointee = 42
        let result = buffer.pointee
        buffer.deallocate()
        return "\(result)"
    }

    // Alloca Example
    func allocaExample() -> Int {
        let buffer = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        buffer.pointee = 42
        let result = buffer.pointee
        return result
    }

    // Strncpy Example
    func strncpyExample() -> String {
        let source = "Hello"
        var destination = [CChar](repeating: 0, count: source.utf8.count + 1)
        _ = source.utf8CString.withUnsafeBufferPointer {
            strncpy(&destination, $0.baseAddress!, source.utf8.count)
        }
        return String(cString: destination)
    }
}

struct FunctionDemoView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionDemoView()
    }
}
