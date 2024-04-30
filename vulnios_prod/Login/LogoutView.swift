//
//  logout.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 31/05/23.
//

import SwiftUI

struct LogoutView: View {
    @Binding var isLoggedIn: Bool
    @State var isLoggedout: Bool

    
    var body: some View {
        NavigationView
        {
            VStack {
                Text("Logging out !")
                    .font(.largeTitle)
                    .padding()
                
                .foregroundColor(.black)
                .frame(width: 200, height: 50)
                .background(Color.red)
                .cornerRadius(10)
            }
        }
        .navigationBarBackButtonHidden(true)

        
        .onAppear(){
            isLoggedIn = false
            isLoggedout = true
            UserDefaults.standard.removeObject(forKey: "AuthToken")
            
        }
        NavigationLink("", destination: Loginscreen(), isActive: $isLoggedout)
 
    }

}



struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView(isLoggedIn: .constant(true), isLoggedout: false)
    }
}
