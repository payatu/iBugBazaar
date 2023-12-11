//
//  Users_row.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 05/05/23.
//

import SwiftUI

struct Users_row: View {
    var user: User
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
                .shadow(radius: 5)
            
            HStack(spacing: 20){
                Image(systemName: "person")
                    .font(.system(size: 25))
                    .frame(width: 60, height: 60)
                    .foregroundColor(.red)
                    .overlay(RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth: 2))
                            
                VStack(alignment: .leading)
                {
                    Text("\(user.displayName)")
                        .bold()
                    Text("\(user.username)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

    
                }
                Spacer()
                
            }
            .padding(.horizontal)
        
        }
        .frame(height: 99)
    }
}

struct Users_row_Previews: PreviewProvider {
    static var previews: some View {
        Users_row(user: User.demoUser)
    }
}
