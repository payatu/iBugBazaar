//
//  logout.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 31/05/23.
//

import SwiftUI

struct LogoutView: View {
    @Binding var isLoggedIn: Bool
    @StateObject var vm = viewModel()

    
    var body: some View {
        VStack {
            Text("You are logged in!")
                .font(.largeTitle)
                .padding()
            
            Button("Logout") {
                isLoggedIn = false
            }
            .foregroundColor(.black)
            .frame(width: 200, height: 50)
            .background(Color.red)
            .cornerRadius(10)
            
            NavigationLink(destination: Loginscreen(), isActive: $isLoggedIn) {
                EmptyView()
            }
            .hidden()
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView(isLoggedIn: .constant(true))
    }
}
