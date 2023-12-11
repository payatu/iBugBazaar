//
//  list_postview.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 05/05/23.
//

import SwiftUI

struct list_postview: View {
    @State private var showingformscreen = false
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(0 ... 0, id: \.self) { _ in PostView() }
            }
            .background(
                NavigationLink("", destination: Text("You are logged in"), isActive: $showingformscreen)
            )
        }
    }
}

struct list_postview_Previews: PreviewProvider {
    static var previews: some View {
        list_postview()
    }
}

