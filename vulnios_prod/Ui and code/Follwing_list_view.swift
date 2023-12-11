//
//  Follwing_list_view.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 05/05/23.
//

import SwiftUI

struct Follwing_list_view: View {
    var Follwing: [User]
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(Follwing) { user in Users_row(user: user)
                }
                
            }
        }
        .navigationTitle("Follwing")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    struct Follwing_list_view_Previews: PreviewProvider {
        static var previews: some View {
            Follwing_list_view(Follwing: User.proUsers)
        
        }
    }
}
