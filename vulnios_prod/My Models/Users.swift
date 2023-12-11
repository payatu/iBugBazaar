//
//  user.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 04/05/23.
//

import Foundation
import UIKit

struct User: Identifiable {
    var id: String
    var displayName: String
    var username: String
    var profileImage: UIImage?
    var profileImageURL: URL?
    var followers: [User] = []
    var following: [User] = []

    static var emptyUser = User(id: "", displayName: "", username: "", profileImageURL: nil)
    static var demoUser = User(id: "Bandit@payatu.io", displayName: "Bandit", username: "@Hackersden", profileImageURL: URL(string: "https://example.com/bandit_profile.jpg"))
    static var proUsers = [
        User(id: "Bandit@payatu.io", displayName: "Bandit", username: "@Hackersden", profileImageURL: nil),
        User(id: "Amit@payatu.io", displayName: "Amit Kumar", username: "@Effotless", profileImageURL: nil),
        User(id: "vedant@payatu.io", displayName: "vedant Wayal", username: "@spider", profileImageURL: nil),
        User(id: "ali@payatu.io", displayName: "ali Jujara", username: "@alex", profileImageURL: nil),
        User(id: "Test@payatu.io", displayName: "Anubhav Singh", username: "@Dominator", profileImageURL: nil)
    ]
}
