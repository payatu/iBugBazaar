//  SwiftUIView.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 04/05/23.
//

// SwiftUIView.swift


import SwiftUI

struct SwiftUIView: View {
    var user: User
    var profileImage: UIImage?

    var body: some View {
        HStack {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 5))
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 5))
            }

            VStack(alignment: .leading) {
                Text("\(user.username)")
                    .bold()
                Text("From till 1999")
                    .foregroundColor(.gray)
            }
            .padding(.leading, 5)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User.demoUser
        let profileImage = UIImage(named: "sample_profile_image")
        SwiftUIView(user: user, profileImage: profileImage)
    }
}




