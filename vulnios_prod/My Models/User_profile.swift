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
    
    var body: some View {
        NavigationStack(path: $path){
            
            VStack{
                
                SwiftUIView(user: vm.currentuser)

                page2()
                
                Follow_container(Follwers: User.proUsers, Follwing: User.proUsers)
                
                EditProfile()
                
                list_postview()
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Route.self){
                
                route in switch route{
                    
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
            // the recent screen is created for the iphone14
            // Wanted to creat the screen for other devices like iphone6, 6+, 7, 8, iphone X
            // and Iphone SE and other IOS devices also
        }
    }
}
