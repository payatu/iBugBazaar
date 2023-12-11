//
//  jailbreakdetection.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 09/12/23.
//
import SwiftUI

struct JailbreakCheckView: View {
    @State private var isJailbroken: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Jailbreak Detection")
                .font(.title)
                .padding()
            
            if isJailbroken {
                Text("This app cannot run on jailbroken devices.")
                    .foregroundColor(.red)
                    .padding()
                    .onTapGesture {
                        showAlert = true
                    }
            } else {
                Text("Congratulations! Your device is not jailbroken.")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .onAppear {
            // Perform jailbreak detection when the view appears
            self.isJailbroken = checkForJailbreak()
            
            // Show alert and exit app if the device is jailbroken
            if isJailbroken {
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Device is Jailbroken"),
                message: Text("This app cannot run on jailbroken devices."),
                dismissButton: .default(Text("OK")) {
                    // Close the app when "OK" is tapped
                    exit(0)
                }
            )
        }
    }
    
    private func checkForJailbreak() -> Bool {
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
        
        // Check if the app is running in a simulator
        #if targetEnvironment(simulator)
        print("Jailbreak check: Running in a simulator")
        return true
        #else
        return false
        #endif
    }
}

struct JailbreakCheckView_Previews: PreviewProvider {
    static var previews: some View {
        JailbreakCheckView()
    }
}
