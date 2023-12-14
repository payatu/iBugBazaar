//
//  appprotect.swift
//  vulnios_prod
//
//  Created by effortlessdevsec on 12/04/24.
//

import Foundation
import IOSSecuritySuite
import SwiftUI


struct appprotect {
   
    @Binding public var jailbreakalert: Bool
    
    static func isJailbreak() -> Bool {
        print("Checking for jailbreak or emulator")
        let jailbreak = IOSSecuritySuite.amIJailbroken()
        let jailbreakStatus1 = IOSSecuritySuite.amIJailbrokenWithFailMessage()
        let jailbreakStatus = IOSSecuritySuite.amIJailbrokenWithFailedChecks()
        let isRunningInEmulator = IOSSecuritySuite.amIRunInEmulator()
        print("hello",jailbreak)
        return (jailbreakStatus.jailbroken || jailbreakStatus1.jailbroken || isRunningInEmulator || jailbreak)
    }
    
    static func isAppdebug() -> Bool {
        
        print("cheking App debug")
        _ =  IOSSecuritySuite.amIDebugged()
        return true
    }
    
    static func  Appruntimecheck() -> Bool{
        
        print("chcking run time instrumentation ")

        return true
        
    }
    
    static func isAppsecureOthers() -> Bool{
        
        return(IOSSecuritySuite.amIReverseEngineered() || IOSSecuritySuite.amIProxied() || IOSSecuritySuite.isParentPidUnexpected())
        
    }
    
    
    
    static func isfridapresent() -> Bool {
             let fileManager = FileManager.default
             let fridaPaths = ["/usr/local/bin/frida-server", "/usr/bin/frida-server", "/usr/sbin/frida-server"]

             for path in fridaPaths {
                 if fileManager.fileExists(atPath: path) {
                     return true
                 }
             }

             return false
         }
    
    
   static func isFridaInjected() -> Bool {
       print("hello hello")
        // Get the list of loaded libraries (dylibs) using dladdr
        var info = Dl_info()
        print(info)
        if dladdr(UnsafeRawPointer(bitPattern: 1), &info) != 0 {
            // Get the path of  ddthe executable
            let executablePath = String(cString: info.dli_fname)
            
            // Check if the executable path contains a known Frida-related library name
            // Adjust the library name as needed based on your knowledge of Frida's library naming conventions
            if executablePath.contains("frida") {
                return true
            }
        }
        
        return false
    }
    
    
    
    
    
}
