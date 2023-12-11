//
//  Follow_container.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 05/05/23.
//

import SwiftUI

struct Follow_container: View {
    
    var Follwers: [User]
    var Follwing: [User]


    var body: some View {
        HStack{
            Spacer()
            if #available(iOS 16.0, *) {
                NavigationLink(value: Route.followers)
                {
                    VStack{
                        Text("\(Follwers.count)")
                        Text("Follwers")
                            .bold()
                    }
                }
            } else {
                // Fallback on earlier versions
            }
            Spacer()
            
            if #available(iOS 16.0, *) {
                NavigationLink(value: Route.following)
                {
                    
                    VStack{
                        
                        
                        Text("\(Follwing.count)")
                        Text("Follwing")
                        
                    }
                }
            } else {
                // Fallback on earlier versions
            }
           Spacer()
            
        }
    }
}

struct Follow_container_Previews: PreviewProvider {
    static var previews: some View {
        Follow_container(Follwers: User.proUsers, Follwing: User.proUsers)
    }
}
