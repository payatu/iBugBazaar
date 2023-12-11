//
//  Chnage_password.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 16/10/23.
//

import SwiftUI
import Security

struct ChangePasswordView: View {
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showAlert = false

    var passwordsMatch: Bool {
        return newPassword == confirmPassword && !newPassword.isEmpty
    }
    
    var isValidPassword: Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: newPassword)
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Change Password")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding()
                
                if showPassword {
                    TextField("New Password", text: $newPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                } else {
                    SecureField("New Password", text: $newPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                HStack {
                    if showPassword {
                        TextField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    } else {
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .padding(.trailing, 8)
                            .foregroundColor(.blue)
                    }
                }
                
                Button(action: {
                    if passwordsMatch && isValidPassword {
                        storePassword(password: newPassword, account: "johndoe", service: Bundle.main.bundleIdentifier!)
                        showAlert = true
                    } else {
                        // Show an error or alert indicating invalid password
                    }
                }) {
                    Text("Change Password")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
                }
                .padding()
                .disabled(!passwordsMatch || !isValidPassword)
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Password changed successfully!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

func storePassword(password: String, account: String, service: String) {
    let passwordData = password.data(using: .utf8)!

    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: account,
        kSecAttrService as String: service,
        kSecValueData as String: passwordData
    ]

    let status = SecItemAdd(query as CFDictionary, nil)
    if status != errSecSuccess {
        print("Error storing password in Keychain: \(status)")
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}

