
//  Userdefault.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 14/05/23.
//

//Here is a breakdown of how the code works:

//The name, cardNo, expiry, and cvv properties are declared as State variables. This means that the values of these properties can be changed by the user.

//The UserDefaults.standard.string(forKey:) method is used to get the user's input from UserDefaults. If the user's input does not exist in UserDefaults, then an empty string is returned.

//The UserDefaults.standard.set(_:forKey:) method is used to save the user's input to UserDefaults.

//The Button is used to save the user's input to UserDefaults. When the button is tapped, the saveData() function is called.

//The saveData() function uses the UserDefaults.standard.set(_:forKey:) method to save the user's input to UserDefaults.

//The print() statement is used to print the user's input to the console.


//This line of code logs the values of name, cardNo, expiry, and cvv to the console, in clear text, after they have been saved to UserDefaults.

// Copy paste buffer cache
// NS UserDefault Data save
//


import SwiftUI

struct UserDefault: View {
    @Binding var cards: [Card]
    @State private var name: String = UserDefaults.standard.string(forKey: "name") ?? ""
    @State private var cardNo: String = UserDefaults.standard.string(forKey: "cardNo") ?? ""
    @State private var expiry: String = UserDefaults.standard.string(forKey: "expiry") ?? ""
    @State private var cvv: String = UserDefaults.standard.string(forKey: "cvv") ?? ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Name:")) {
                TextField("Please Enter Your Name", text: $name)
            }
            
            Section(header: Text("Credit Card No:")) {
                TextField("Add Credit No", text: $cardNo)
                    .keyboardType(.numberPad) // Only allow numbers
                    .textContentType(.creditCardNumber)
                    .onChange(of: cardNo, perform: { value in
                        formatCardNumber()
                    })
            }
            
            Section(header: Text("Expiry:")) {
                TextField("MM/YY", text: $expiry)
                    .keyboardType(.numberPad)
                    .onChange(of: expiry, perform: { value in
                        formatExpiryDate()
                    })
            }
            
            Section(header: Text("Add CVV")) {
                TextField("Add CVV", text: $cvv)
                    .keyboardType(.numberPad)
                    .onChange(of: cvv, perform: { value in
                        cvv = formatCVV(value)
                    })
            }
            
            Section(header: Text("Actions:")) {
                VStack {
                    Spacer()
                    
                    Button("Save Card") {
                        UserDefaults.standard.set(name, forKey: "name")
                        UserDefaults.standard.set(cardNo, forKey: "cardNo")
                        UserDefaults.standard.set(expiry, forKey: "expiry")
                        UserDefaults.standard.set(cvv, forKey: "cvv")
                        
                        print("Saved Values - name: \(name), cardNo: \(cardNo), expiry: \(expiry), cvv: \(cvv)")
                        
                        let card = Card(name: name, number: cardNo, expiration: expiry, cvv: cvv)
                        cards.append(card)
                        
                        presentationMode.wrappedValue.dismiss() // Dismiss the current view and go back to the wallet screen
                    }
                    .foregroundColor(.red)
                    .frame(width: 300, height: 20)
                    
                    Spacer()
                }
            }
        }
    }
    
    private func formatCardNumber() {
        // Remove any non-digit characters from the card number
        let cleanedNumber = cardNo.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Restrict the number to 16 digits
        let maxLength = 16
        let formattedNumber = String(cleanedNumber.prefix(maxLength))
        
        // Format the number with spaces every four digits
        var formattedString = ""
        for i in 0..<formattedNumber.count {
            if i % 4 == 0 && i != 0 {
                formattedString += " "
            }
            let index = formattedNumber.index(formattedNumber.startIndex, offsetBy: i)
            formattedString.append(formattedNumber[index])
        }
        
        // Update the cardNo binding
        cardNo = formattedString
    }
    
    private func formatExpiryDate() {
        // Remove any non-digit characters from the expiry date
        let cleanedExpiry = expiry.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Restrict the date to MM/YY format
        
        let maxLength = 4
        let formattedExpiry = String(cleanedExpiry.prefix(maxLength))
        
        // Format the date with a slash between the month and year
        if formattedExpiry.count >= 2 {
            let index = formattedExpiry.index(formattedExpiry.startIndex, offsetBy: 2)
            let month = formattedExpiry[..<index]
            let year = formattedExpiry[index...]
            
            expiry = "\(month)/\(year)"
        } else {
            expiry = formattedExpiry
        }
    }
    
    private func formatCVV(_ cvv: String) -> String {
        // Remove any non-digit characters from the CVV
        let cleanedCVV = cvv.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Restrict the CVV to 3 digits
        let maxLength = 3
        let formattedCVV = String(cleanedCVV.prefix(maxLength))
        
        return formattedCVV
    }
    
}



struct Userdefault_Previews: PreviewProvider {
    static var previews: some View {
        UserDefault(cards: .constant([]))
    }
}
