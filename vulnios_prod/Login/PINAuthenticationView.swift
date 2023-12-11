//
//  PINAuthenticationView.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 21/11/23.
//


import SwiftUI

struct PINAuthenticationView: View {
    @Binding var isLoggedIn: Bool
    @State private var enteredPIN = ""

    var body: some View {
        VStack(spacing: 20) {
            // PIN authentication UI
            TextField("Enter PIN", text: $enteredPIN)
                .padding(15)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .keyboardType(.numberPad) // Ensure numeric keyboard
                .onChange(of: enteredPIN) { newValue in
                    // Limit the PIN to 4 digits
                    if newValue.count > 4 {
                        enteredPIN = String(newValue.prefix(4))
                    }
                }

            Button("Authenticate") {
                // Retrieve the stored PIN from Keychain
                guard let storedPIN = retrievePINFromKeychain() else {
                    // Handle PIN retrieval failure
                    print("Error retrieving PIN from Keychain.")
                    return
                }

                // Verify the entered PIN
                if enteredPIN == storedPIN {
                    // PIN is correct, set isLoggedIn to true
                    isLoggedIn = true
                } else {
                    // PIN is incorrect, display an error message
                    print("Invalid PIN. Please try again.")
                }
            }

            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }

    // Function to retrieve PIN from Keychain
    func retrievePINFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "UserPIN",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var resultRef: CFTypeRef?

        let status = SecItemCopyMatching(query as CFDictionary, &resultRef)

        if status == errSecSuccess {
            if let retrievedData = resultRef as? Data {
                return String(decoding: retrievedData, as: UTF8.self)
            }
        }

        return nil
    }
}

struct PINAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        PINAuthenticationView(isLoggedIn: .constant(false))
    }
}
//Flow of login and pin

//Login with Credentials:
// The user initially logs in with their username and password credentials.
//  Upon successful login, a token is generated and saved locally.

//PIN-Based Authentication Setup:
//  If the user has enabled PIN-based authentication in the application, the system checks whether a PIN is set for the user.
//If a PIN is set, the application will prompt the user to enter their PIN during subsequent logins.

//Closing and Reopening the App:
// When the user closes the application and opens it again, the application checks for the presence of a token.

//Biometric Authentication (Optional):
//If a token is found, the application may attempt biometric authentication (if available) for seamless login.
// If biometric authentication is successful, the user is logged in automatically.

//PIN Authentication Prompt:
// If biometric authentication fails or is unavailable, or if the user has not set up biometrics, the application prompts the user to enter their PIN.

//PIN Verification:
//  The user enters the PIN they previously set up.
//  The application verifies the entered PIN against the stored PIN.

//Redirection or Incorrect PIN Display:
//// If the entered PIN is correct, the user is redirected to the home screen.
//   If the entered PIN is incorrect, the application displays a message indicating that the PIN is incorrect.

//PIN Setup and Changes:
// If the user has not set up a PIN, they may be prompted to set one up initially.
// There might be an option in the settings (AccountView) to change or update the PIN.
