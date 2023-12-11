//
//  sidemenulistview.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 08/05/23.
//

import SwiftUI

struct sidemenulistview: View {
    
    @Binding var isshowing: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Button(action: {
                withAnimation(.spring())
                {
                    isshowing.toggle()
                }
            }, label: {
        Image(systemName: "xmark")
        
            .frame(width: 35, height: 35)
        
            .padding()
    })
            VStack(alignment: .leading) {
                Image("payatu")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 69, height: 60)
                    .clipShape(Circle())
                    .padding(.bottom, 10)
                
                Text("Payatu Labs")
                    .font((.system(size: 24, weight: .semibold)))
                
                Text("@payatulabs")
                    .font((.system(size: 14)))
            
                
                HStack(spacing: 25){
                    HStack(spacing: 4) {
                        Text("4,036").bold()
                        Text("Followers")
                    }

                    
                    HStack(spacing: 4) {
                        Text("637").bold()
                        Text("Followers")
                    }
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct sidemenulistview_Previews: PreviewProvider {
    static var previews: some View {
        sidemenulistview(isshowing: .constant(true))
    }
}
