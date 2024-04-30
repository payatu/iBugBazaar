//
//  sidemenuview.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 08/05/23.
//

import SwiftUI

struct sidemenuview: View {
    @Binding var isshowing: Bool
    @EnvironmentObject var cartManager: CartManager // Retrieve CartManager environment object
    @State private var userInput: String = ""
    @State private var isWebViewPresented = false
    @State private var walletBalance: Double = 0.0
    @State private var isLoggedIn = true // or however you manage the login state
    @State private var isLoggedout = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                sidemenulistview(isshowing: $isshowing)
                    .frame(height: 145)
                    .foregroundColor(.black)
                    .cornerRadius(10)

                List {
                    NavigationLink(destination: Product_list()) {
                        sidemenuoptionview(viewmodule: .menu)
                    }
                    NavigationLink(destination: AccountView()) {
                        sidemenuoptionview(viewmodule: .profile)
                    }
                    NavigationLink(destination: CartView()) {
                        sidemenuoptionview(viewmodule: .cart)
                    }
                    NavigationLink(destination: WalletView(walletBalance: $walletBalance)) {
                        sidemenuoptionview(viewmodule: .Wallet)
                    }
                    NavigationLink(destination: ContactUsplistView()) {
                        sidemenuoptionview(viewmodule: .Support)
                    }
                    NavigationLink(destination: ContentView5()) {
                        sidemenuoptionview(viewmodule: .Info)
                    }
                    NavigationLink(destination: AllOrdersView()) {
                        sidemenuoptionview(viewmodule: .Orders)
                    }
                    
                    NavigationLink(destination: LogoutView(isLoggedIn: $isLoggedIn, isLoggedout: isLoggedout)) {
                        sidemenuoptionview(viewmodule: .logout)
                    }
                    
                    NavigationLink(destination: app_security()) {
                        sidemenuoptionview(viewmodule: .App_Security)
                    }
                    

                }
                .listRowInsets(EdgeInsets()) // Apply styling to the entire list
            }
        }
        .navigationBarHidden(true)
    }
}

struct sidemenuview_Previews: PreviewProvider {
    static var previews: some View {
        sidemenuview(isshowing: .constant(true))
            .environmentObject(CartManager())
    }
}


//  For example, if you enter <script>alert("XSS");</script> as the search query, the code will detect the presence of <script> in the query and display the XSS Popup alert on the screen.
