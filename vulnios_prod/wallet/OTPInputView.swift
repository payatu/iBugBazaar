//
//  OTPInputView.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 22/08/23.
//

import SwiftUI

struct OTPInputView: View {
    @Binding var isVisible: Bool
    @Binding var enteredOTP: String
    let expectedOTP: String
    var onVerification: (Bool) -> Void // Callback to handle OTP verification

    @State private var isIncorrectOTP = false // This is Tracking incorrect OTP

    var body: some View {
        VStack {
            Text("Enter OTP")
                .font(.title)
                .padding()

            TextField("OTP", text: $enteredOTP)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad) // Restrict input to numeric keyboard
                .padding()
                .onReceive(enteredOTP.publisher.collect()) { // Limit to 6 digits
                    let newValue = String($0.prefix(6))
                    if newValue != enteredOTP {
                        enteredOTP = newValue
                    }
                }

            if isIncorrectOTP { // Display error message for incorrect OTP
                Text("Entered wrong OTP")
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding()
            }

            Button(action: {
                // Verify OTP
                let isVerified = enteredOTP == expectedOTP
                if !isVerified {
                    isIncorrectOTP = true // Set error flag for incorrect OTP
                    return
                }
                onVerification(isVerified)
                isVisible = false
            }) {
                Text("Verify OTP")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
            .padding()
        }
    }
}


struct OTPInputView_Previews: PreviewProvider {
    @State static var isVisible = true // Example value
    @State static var enteredOTP = ""
    static let expectedOTP = "010101" // Example value

    static var previews: some View {
        OTPInputView(isVisible: $isVisible, enteredOTP: $enteredOTP, expectedOTP: expectedOTP) { isVerified in
            // Handle verification in your preview if needed
        }
    }
}
