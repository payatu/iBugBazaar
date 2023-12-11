//
//  User_profile.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 04/05/23.
//

//
//  User_profile.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 04/05/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct User_profile: View {
    @State var path = NavigationPath()
    @StateObject var vm = viewModel()
    @State var currentUser: User = User.demoUser
    @State var profileImage: UIImage? = UIImage(named: "profile_image")

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                SwiftUIView(user: currentUser)
                    .offset(x: true ? 100 : 0, y: true ? -10 : 0)
// Pass username and profile image here
                page2()
                    .offset(x: true ? 10 : 0, y: true ? -0 : 0)

                Follow_container(Follwers: User.proUsers, Follwing: User.proUsers)
                    .offset(x: true ? 0 : 0, y: true ? 10 : 0)

                EditProfile()
                    .offset(x: true ? 0 : 0, y: true ? 20 : 0)

                ChangePasswordView()
                    .offset(x: true ? 0 : 0, y: true ? 30 : 0)

                FingerprintAuthToggle()
                    .offset(x: true ? 0 : 0, y: true ? -150 : 0)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Route.self){
                route in switch route {
                case .followers:
                    Follwers_list_view(follwers: User.proUsers)
                case .following:
                    Follwing_list_view(Follwing: User.proUsers)
                }
            }
        }
    }
}

struct User_profile_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            User_profile()
        } else {
            // Fallback on earlier versions
            // the recent screen is created for the iPhone 14
            // Wanted to create the screen for other devices like iPhone 6, 6+, 7, 8, iPhone X
            // and iPhone SE and other iOS devices also
        }
    }
}
