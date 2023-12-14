//
//  jailbreakdetection.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 09/12/23.
//
import SwiftUI

struct JailbreakCheckView  {
    @State private var isJailbroken: Bool = false
    @State private var showAlert: Bool = false
    
   
    
    static public   func checkForJailbreak() -> Bool {
        // Check for common jailbreak signs
        if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") {
            print("Jailbreak check: Cydia.app found")
            return true // Device is jailbroken
        }
        if FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") {
            print("Jailbreak check: MobileSubstrate.dylib found")
            return true // Device is jailbroken
        }
        if FileManager.default.fileExists(atPath: "/bin/bash") {
            print("Jailbreak check: bin/bash found")
            return true // Device is jailbroken
        }
        if FileManager.default.fileExists(atPath: "/usr/sbin/sshd") {
            print("Jailbreak check: usr/sbin/sshd found")
            return true // Device is jailbroken
        }
        if FileManager.default.fileExists(atPath: "/etc/apt") {
            print("Jailbreak check: etc/apt found")
            return true // Device is jailbroken
        }
        
         return false
    }
}

//struct JailbreakCheckView_Previews: PreviewProvider {
//    static var previews: some View {
//        JailbreakCheckView()
//    }
//}
