//
//  Profile information.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 21/11/23.
//

// ProfileInformationView.swift
import SwiftUI

struct ProfileInformationView: View {
    @ObservedObject private var userProfileViewModel = UserProfileViewModel.shared

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Username", text: $userProfileViewModel.username)
                    TextField("Email", text: $userProfileViewModel.email)
                    TextField("Address", text: $userProfileViewModel.address)
                        .lineLimit(3)
                    TextField("Mobile Number", text: $userProfileViewModel.mobileNumber)
                        .keyboardType(.phonePad)
                }

                Section {
                    Button(action: {
                        updateProfile()
                    }) {
                        Text("Update Profile")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationBarTitle("Profile Information")
        }
        .padding()
    }

    private func updateProfile() {
        // Save the updated values to UserDefaults
        UserDefaults.standard.set(userProfileViewModel.username, forKey: "username")
        UserDefaults.standard.set(userProfileViewModel.email, forKey: "email")
        UserDefaults.standard.set(userProfileViewModel.address, forKey: "address")
        UserDefaults.standard.set(userProfileViewModel.mobileNumber, forKey: "mobileNumber")

        // Print for demonstration purposes
        print("Updated Profile:")
        print("Username: \(userProfileViewModel.username)")
        print("Email: \(userProfileViewModel.email)")
        print("Address: \(userProfileViewModel.address)")
        print("Mobile Number: \(userProfileViewModel.mobileNumber)")
    }
}


struct ProfileInformationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInformationView()
    }
}
