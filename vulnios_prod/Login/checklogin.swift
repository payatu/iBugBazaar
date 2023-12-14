//
//  checklogin.swift
//  vulnios_prod
//
//  Created by effortlessdevsec on 12/04/24.
//

//

//


import Foundation


struct LoginManager {
    
    
    static func checkLogin(username: String, password: String) -> Bool {
            // Perform login validation logic here
            return username == "Admin" && password == "Admin"
        }
    
}

