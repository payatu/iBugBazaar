//
//  app_intigrity.swift
//  vulnios_prod
//
//  Created by effortlessdevsec on 12/04/24.
//

import Foundation
import IOSSecuritySuite
import SwiftUI

struct app_intigrity: View {
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isjailbrokendevice: Bool = false
    let completion: (Bool) -> Void

    var body: some View {
        Text("")
            .onAppear {
                checkSecurityControls()
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage),
               dismissButton: .default(Text("OK")) {
                // Close the app when "OK" is tapped
                exit(0)
                }
            )
        }
        
    }
    
    func checkSecurityControls() {
        if isJailbreak() {
            alertTitle = "Jailbreak Detected"
            alertMessage = "Your device is jailbroken or running on an emulator. The app will now exit."
            showingAlert = true
            completion(isJailbreak())
        } else {
        
            completion(isJailbreak())
        }
    }
    
    func isJailbreak() -> Bool {
        print("Checking for jailbreak or emulator")
        let jailbreakStatus = IOSSecuritySuite.amIJailbrokenWithFailMessage()
        let jailbreakStatus1 = IOSSecuritySuite.amIJailbrokenWithFailedChecks()
        let isRunningInEmulator = IOSSecuritySuite.amIRunInEmulator()
        
        return jailbreakStatus.jailbroken || jailbreakStatus1.jailbroken || isRunningInEmulator
    }
}

//struct app_intigrity_Previews: PreviewProvider {
//    static var previews: some View {
//        app_intigrity(completion: (false)
//    }
//}
