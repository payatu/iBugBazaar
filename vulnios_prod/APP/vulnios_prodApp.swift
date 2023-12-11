//
//  Profile_and_listApp.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 04/05/23.
//


import SwiftUI
@main
struct Profile_and_listApp: App {
    @StateObject var cartManager = CartManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cartManager)
        }
    }
}

