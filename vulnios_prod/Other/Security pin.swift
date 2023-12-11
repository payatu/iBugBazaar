//
//  Security pin.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 21/11/23.
//

import SwiftUI
import LocalAuthentication

struct BiometricAuthenticationView: View {
    @State private var isUnlocked = false
    @State private var pinEntered: String = ""

    var body: some View {
        VStack {
            if isUnlocked {
                // Your authenticated content goes here
                Text("You're authenticated!")
            } else {
                if pinEntered.isEmpty {
                    // Biometric authentication button
                    Button("Authenticate with Biometrics") {
                        authenticateWithBiometrics()
                    }
                } else {
                    // PIN entry view
                    PINEntryView(pin: $pinEntered, onPinEntered: authenticateWithPIN)
                }
            }
        }
    }

    func authenticateWithBiometrics() {
        let context = LAContext()

        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access the app"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication successful
                        isUnlocked = true
                    } else {
                        // Authentication failed
                        if let error = authenticationError {
                            // Handle the error
                            print("Biometric Authentication error: \(error.localizedDescription)")
                            // Show PIN entry view when biometric authentication fails
                            pinEntered = ""
                        }
                    }
                }
            }
        } else {
            // Device doesn't support biometric authentication or is not enrolled
            if let error = error {
                // Handle the error
                print("Biometric authentication not available: \(error.localizedDescription)")
            }

            // Show PIN entry view when biometric authentication is not available
            pinEntered = ""
        }
    }

    func authenticateWithPIN() {
        // Implement logic to authenticate with PIN
        if pinEntered == "1234" {
            isUnlocked = true
        } else {
            // Handle incorrect PIN
            pinEntered = ""
        }
    }
}

struct BiometricAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        BiometricAuthenticationView()
    }
}

struct PINEntryView: View {
    @Binding var pin: String
    var onPinEntered: () -> Void

    var body: some View {
        VStack {
            SecureField("Enter PIN", text: $pin)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Submit") {
                onPinEntered()
            }
            .padding()
        }
        .padding()
    }
}

