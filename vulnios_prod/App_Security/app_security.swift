//
//  app_security.swift
//  vulnios_prod
//
//  Created by effortlessdevsec on 12/04/24.
//

import SwiftUI

struct app_security: View {
    @State public var selectedOption = UserDefaults.standard.integer(forKey: "Security level")
    
    
    
    
    init() {
        
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.red
        
    }
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.gray, Color.white, Color.red]), startPoint: .topLeading, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                
                Text("Select App securiy level")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
        
            
                HStack
                
                {
                    Spacer()
                    
                    Picker(selection: $selectedOption, label: Text("Picker")) {
                        Text("None").tag(0)
                        Text("Easy").tag(1)
                        Text("Medium").tag(2)
                        Text("Advanced").tag(3)
                        
                        
                    }
                    
                    
                    .pickerStyle(WheelPickerStyle())
                    .onChange(of: selectedOption, perform: { value in
                        saveAppSecurity(selectedOption: value)
                        print(selectedOption)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                           exit(0)
                                       }
                    })
                    
                    Spacer()
                }
                .padding()
                
            }
        }
      
    }
}

func saveAppSecurity(selectedOption: Int) {
    UserDefaults.standard.set(selectedOption, forKey: "Security level")
    

}

struct AppSecurity_Previews: PreviewProvider {
    static var previews: some View {
        app_security()
    }
}

