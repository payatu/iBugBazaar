//
//  appsecure.swift
//  vulnios_prod
//
//  Created by effortlessdevsec on 12/04/24.
//

import Foundation
import IOSSecuritySuite


struct appsecure {
    
    
    static private func  jailbreakcheck() -> Bool {
        
        return(IOSSecuritySuite.amIJailbroken())
        
        
    }
}
