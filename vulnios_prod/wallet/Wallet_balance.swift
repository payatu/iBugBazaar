//
//  Wallet_balance.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 08/08/23.
//

import SwiftUI


struct Wallet_balance: View {
    @State private var amountString = ""
    @Binding var walletBalance: Double // Binding for wallet balance
    
    var body: some View {
        VStack {
            Text("Add Money to Wallet")
                .font(.title)
                .padding()
            
            TextField("Amount", text: $amountString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.decimalPad) // Allow numeric input

            
            Button(action: {
                // Handle adding money logic here
            }) {
                Text("Add Money")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct Wallet_balance_Previews: PreviewProvider {
    static var previews: some View {
        Wallet_balance(walletBalance: .constant(0.0)) // Provided a sample wallet balance for preview
    }
}
