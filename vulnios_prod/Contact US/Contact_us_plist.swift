//
//  Contact_us_plist.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 04/07/23.
//

// @State private var showMessage: Bool = false is added to keep track of whether to show the success message or not.
// The .alert modifier is applied to the VStack, which presents an alert when showMessage is true. The alert displays the "Data Saved" title and "Data sent successfully!" message.
// After saving the data, showMessage is set to true to show the success message.
// DispatchQueue.main.asyncAfter is used to set showMessage back to false after a 2-second delay.

import SwiftUI

struct ContactUsplistView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var showMessage: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Here you can contact easily and communicate with the support team, ensuring that their questions, concerns, or feedback regarding the food application are addressed promptly")
                    .padding()
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                TextField("Message", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Button("Submit Request", action: saveUserData)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .navigationBarTitle("Contact to support")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .alert(isPresented: $showMessage) {
                Alert(title: Text("Data Saved"), message: Text("Request sent successfully!"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func saveUserData() {
        let userData: [String: Any] = [
            "name": name,
            "email": email,
            "message": message
        ]

        guard let plistURL = Bundle.main.url(forResource: "userdata", withExtension: "plist") else {
            return
        }

        do {
            let plistData = try PropertyListSerialization.data(fromPropertyList: userData, format: .xml, options: 0)

            try plistData.write(to: plistURL)

            name = ""
            email = ""
            message = ""

            showMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showMessage = false
            }
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    struct ContactUsplistView_Previews: PreviewProvider {
        static var previews: some View {
            ContactUsplistView()
        }
    }
}
