//
//  logout.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 31/05/23.
//

import SwiftUI

struct LogoutView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            Text("You are logged in!")
                .font(.largeTitle)
                .padding()
            
            Button("Logout") {
                print("Logging out...")
                isLoggedIn = false
                UserDefaults.standard.removeObject(forKey: "AuthToken") // Remove token
                print("AuthToken removed")
            }

            .foregroundColor(.black)
            .frame(width: 200, height: 50)
            .background(Color.red)
            .cornerRadius(10)
            .onTapGesture {
                // Navigate back to the login screen
                isLoggedIn = false
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}



struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView(isLoggedIn: .constant(true))
    }
}
