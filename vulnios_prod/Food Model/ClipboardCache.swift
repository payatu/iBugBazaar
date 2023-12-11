//
//  pasteboard.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 19/05/23.
//

import SwiftUI

struct ClipboardCache: View {
    @State private var clipboardData: String?
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Clipboard Data")
                    .font(.title)
                
                Text(clipboardData ?? "No data")
                    .padding()
                    .onAppear {
                        clipboardData = UIPasteboard.general.string
                    }
                
                Button(action: {
                    UIPasteboard.general.string = "Hello, world!"
                }) {
                    Text("Set Clipboard Data")
                }
            }
            .navigationBarTitle("Clipboard Cache")
        }
    }
}

struct ClipboardCache_Previews: PreviewProvider {
    static var previews: some View {
        ClipboardCache()
    }
}
