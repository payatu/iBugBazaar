//
//  Follwers_list_view.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 05/05/23.
//

import SwiftUI

struct Follwers_list_view: View {
    var follwers: [User]
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(follwers) { user in Users_row(user: user)
                }
                
            }
        }
        .navigationTitle("Follwers")
        .navigationBarTitleDisplayMode(.inline)
    }
}

    struct Follwers_list_view_Previews: PreviewProvider {
        static var previews: some View {
            Follwers_list_view(follwers: User.proUsers)
        }
    }
