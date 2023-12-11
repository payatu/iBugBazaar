//
//  page2.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 04/05/23.
//

import SwiftUI

struct page2: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Label("last Status", systemImage: "clock")
                    .foregroundColor(.black)
                Label("last Status", systemImage: "map")
                    .foregroundColor(.black)
                
                
            }
            Spacer()
            
        }
        .padding(.horizontal)
    }
    
    struct page2_Previews: PreviewProvider {
        static var previews: some View {
            page2()
        }
    }
}
