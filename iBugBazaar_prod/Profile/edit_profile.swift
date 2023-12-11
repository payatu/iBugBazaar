//
//  edit_profile.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 18/05/23.
//

import SwiftUI

struct EditProfile: View {
    @State private var isEditingProfile = false // State variable to control navigation
    
    var body: some View {
        NavigationLink(destination: Profile_edit(), isActive: $isEditingProfile) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 24, style: .circular)
                        .fill(Color.white)
                        .shadow(radius: 5)
                    
                    Text("Edit Profile")
                        .bold()
                        .frame(width: 140, height: 32)
                }
                .border(Color.red, width: 2)
                .frame(width: 140, height: 23)
            }
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
