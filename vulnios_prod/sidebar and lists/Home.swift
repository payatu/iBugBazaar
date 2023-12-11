
//
//  Home.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 08/05/23.
//

import SwiftUI

struct Home: View {
    @State private var isShowingSideMenu = false
    
    var body: some View {
        ZStack(alignment: .top) {
            if isShowingSideMenu {
                sidemenuview(isshowing: $isShowingSideMenu)
                    .transition(.move(edge: .leading))
                    .zIndex(1) // Ensure the side menu is above other views
            }
            
            HomeView()
                .cornerRadius(isShowingSideMenu ? 20 : 10)
                .scaleEffect(isShowingSideMenu ? 0.8 : 1)
                .offset(x: isShowingSideMenu ? 230 : 0, y: isShowingSideMenu ? 40 : 0)
                .ignoresSafeArea(edges: .top) // Ignore the safe area at the top
                
            HStack {
                Button(action: {
                    withAnimation(.spring()) {
                        isShowingSideMenu.toggle()
                    }
                }) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.black)
                        .padding()
                }
                
                Spacer() // Add a spacer to push the button to the left
            }
            .padding(.top, -40)
            .padding(.leading, 16)
        }
        .onAppear {
            isShowingSideMenu = false
        }
        .onChange(of: isShowingSideMenu) { newValue in
            if !newValue {
                isShowingSideMenu = false
            }
        }
        .navigationBarHidden(true)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .previewDevice(PreviewDevice(rawValue: "iPhone X"))
    }
}

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("BugBazaar Project")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Greetings from BugBazaar! We appreciate your choice of BugBazaar, the Swift adaptation of the original BugBazaar iOS app. It is designed to pinpoint security vulnerabilities and offer effective solutions. The exercises are crafted to provide hands-on learning experiences for iOS developers and mobile penetration testers.")
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

            
            Link("Project Code - GitHub Link", destination: URL(string: "https://github.com/payatu/iBugBazaar")!)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 0) {
                Text("Acknowledgments: ")
                    .font(.body)

                HStack {
                    Image("twitter-icon") // Replace with your custom Twitter icon
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                    Link("Kapil Gurav", destination: URL(string: "https://twitter.com/hackersden_")!)
                        .font(.body)
                        .foregroundColor(.blue)
                }
            }
            .padding()

            HStack(spacing: 0) {
                Text("To actively contribute to the BugBazaar iOS project, connect with ")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)
                    Link("kapil@payatu.io", destination: URL(string: "mailto:kapil@payatu.io")!)
                        .font(.body)
                        .foregroundColor(.blue)
                }
            }
            .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("For further details, explore ")
                    .font(.body)

                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.blue)
                    Link("Payatu's official website.", destination: URL(string: "https://payatu.com")!)
                        .font(.body)
                        .foregroundColor(.blue)
                }

                Text("Check the latest updates by following ")
                    .font(.body)

                HStack {
                    Image("twitter-icon") // Replace with your custom Twitter icon
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                    Link("Payatu on Twitter.", destination: URL(string: "https://twitter.com/payatulabs")!)
                        .font(.body)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground)) // Use a light gray system background color
            .cornerRadius(10)
        }
        .background(Color(UIColor.systemBackground)) // Use a light gray system background color
        .cornerRadius(10)
        .padding()
    }
}
