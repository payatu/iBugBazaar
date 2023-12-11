//
//  Con.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 08/06/23.
//

import SwiftUI

struct PasteboardViewController: View {

    @State private var text = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Pasteboard", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Copy", action: {
                    UIPasteboard.general.string = text
                })
            }
            .navigationTitle("Pasteboard")
        }
    }

}


struct Con_Previews: PreviewProvider {
    static var previews: some View {
        PasteboardViewController()
    }
}


