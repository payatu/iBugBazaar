//
//  memory.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 21/10/23.
//

import SwiftUI

class MemoryManagementViewModel: ObservableObject {
    @Published var cardNumberString = ""
    @Published var ccvString = ""
    
    func payItemPressed() {
        if cardNumberString.isEmpty {
            showAlert(title: "iGoat", message: "Enter card number")
        } else if ccvString.isEmpty {
            showAlert(title: "iGoat", message: "Enter cvv number")
        } else {
            showAlert(title: "iGoat", message: "Thanks for purchase!! Do you think card details are safe. Check out memory :)")
        }
    }
    
    private func showAlert(title: String, message: String) {
        // Implement your alert presentation logic here
    }
}

struct MemoryManagementView: View {
    @StateObject private var viewModel = MemoryManagementViewModel()
    
    var body: some View {
        VStack {
            TextField("Card Number", text: $viewModel.cardNumberString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("CCV", text: $viewModel.ccvString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Pay Item") {
                viewModel.payItemPressed()
            }
            .padding()
        }
        .padding()
    }
}

struct MemoryManagementView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryManagementView()
    }
}

