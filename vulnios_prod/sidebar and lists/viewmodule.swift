//
//  viewmodule .swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 08/05/23.
//

import Foundation

enum viewmodule: Int, CaseIterable {
    
    case profile
    case menu
    case list
    case messages
    case Wallet
    case cart
    case logout
    case Contact
    case Support
    case Orders
    case Info
    case App_Security
    
    var Title: String{
        
        switch self {
            
        case .profile: return ("Profile")
        case .menu: return ("Menu")
        case .cart: return ("cart")
        case .list: return ("List")
        case .messages: return ("Messages")
        case .Wallet: return ("Wallet")
        case .logout: return ("Logout")
        case .Contact: return ("Contact")
        case .Support: return ("Contact")
        case .Orders: return ("My Orders")
        case .Info: return ("More Info")
        case .App_Security: return("App Security Check")
            
            
        }
       
    }
    var imagename: String{
        
        switch self {
        case .profile: return ("person")
        case .menu: return ("menucard.fill")
        case .cart: return ("cart.badge.plus")
        case .list: return ("list.bullet")
        case .messages: return ("bubble.left")
        case .Wallet: return ("creditcard")
        case .logout: return ("arrow.left.square")
        case .Contact: return ("person.crop.circle.dashed")
        case .Support: return ("flag")
        case .Orders: return ("wallet.pass")
        case .Info: return ("info.circle")
        
        
        case .App_Security: return("info.circle")
        }
    }
    
}
