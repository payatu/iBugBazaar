//
//  Uploaded.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 06/11/23.
//
import SwiftUI

struct ProfileView1: View {
    @ObservedObject var vm: viewModel// Assuming you have a viewModel for user data

    var body: some View {
        VStack {
            if let image = vm.currentuser.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }

            Text(vm.currentuser.username)
                .font(.headline)
        }
        .padding()
        .navigationBarTitle("Profile")
        
    }

}


struct ProfileView1_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView1(vm: viewModel()) // Assuming you have a viewModel for user data
    }
}
