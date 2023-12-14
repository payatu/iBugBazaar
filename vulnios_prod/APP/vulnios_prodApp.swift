//
//  Profile_and_listApp.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 04/05/23.
//


import SwiftUI
@main
struct Profile_and_listApp: App {
    @ObservedObject var cartManager = CartManager()
    @State private var jailbreakAlert: Bool = false
    @State private var Appdebug: Bool = false
    @State private var Appruntime: Bool = false
    @State private var selectedOption = UserDefaults.standard.integer(forKey: "Security level")
    @State private var advance: Bool = false
    var body: some Scene {
        WindowGroup {
            switch selectedOption {
            case 0: // None
                
                ContentView()
                    .environmentObject(cartManager)
                
                
            case 1: // Easy
                if JailbreakCheckView.checkForJailbreak()  {
                    ContentView()
                        .environmentObject(cartManager)
                        .opacity(0.1)
                        . onAppear{
                            
                            jailbreakAlert = true
                            
                        }
                        .alert(isPresented: $jailbreakAlert) {
                            Alert(title: Text(""), message: Text("Your device is jailbroken. The app will now exit "), dismissButton: .default(Text("OK"))
                                  {
                                exit(0)
                            }
                            )
                        }
                }
                else {
                    ContentView().environmentObject(cartManager)
                }
            case 2: // Medium
                // Perform medium-level security action
                if appprotect.isJailbreak() {
                    ContentView()
                        .environmentObject(cartManager)
                        .opacity(0.1)
                        . onAppear{
                            
                            jailbreakAlert = true
                            
                        }
                        .alert(isPresented: $jailbreakAlert) {
                            Alert(title: Text(""), message: Text("You r device is jailbroken or running on an emulator. The app will now exit "), dismissButton: .default(Text("OK"))
                                  {
                                exit(0)
                            }
                            )
                        }
                }
                
                if (appprotect.isFridaInjected() || appprotect.isfridapresent()) {
                    ContentView()
                        .environmentObject(cartManager)
                        .opacity(0.1)
                        . onAppear{
                            
                            jailbreakAlert = true
                            
                        }
                        .alert(isPresented: $jailbreakAlert) {
                            Alert(title: Text(""), message: Text("App hooked. The app will now exit "), dismissButton: .default(Text("OK"))
                                  {
                                exit(0)
                            }
                            )
                        }
                }
                
                if (appprotect.isAppsecureOthers()) {
                    ContentView()
                        .environmentObject(cartManager)
                        .opacity(0.1)
                        . onAppear{
                            
                            jailbreakAlert = true
                            
                        }
                        .alert(isPresented: $jailbreakAlert) {
                            Alert(title: Text(""), message: Text("Something wrong happened. The app will now exit "), dismissButton: .default(Text("OK"))
                                  {
                                exit(0)
                            }
                            )
                        }
                }
                
                
                else {
                    ContentView().environmentObject(cartManager)
                }
                
                
                
            case 3: // Advanced
                // Show the JailbreakCheckView for advanced security
                
                
                
                ContentView()
                    .environmentObject(cartManager)
                    . onAppear{
                        
                        advance = true
                        
                    }
                    .alert(isPresented: $advance) {
                        Alert(title: Text(""), message: Text("feature coming soon "), dismissButton: .default(Text("OK"))
                              {
                            exit(0)
                        }
                        )
                    }
                
            default:
                ContentView()
                    .environmentObject(cartManager)
            }
        }

    }
    
    init() {
            Thread.sleep(forTimeInterval: 1) // Sleep for 2 seconds
        }
}
