//
//  FingerprintAuthToggle.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 16/10/23.
//

import SwiftUI

struct FingerprintAuthToggle: View {
    @AppStorage("isFingerprintEnabled") var isFingerprintEnabled = false
    
    var body: some View {
        Toggle("Enable Fingerprint Authentication", isOn: $isFingerprintEnabled)
            .padding()
    }
}

struct ContentView3: View {
    var body: some View {
        VStack {
            FingerprintAuthToggle()
        }
        .padding()
    }
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}
