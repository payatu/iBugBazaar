//
//  Hidden lebel.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 22/11/23.
//

import SwiftUI

struct HiddenLabelView: View {
    @State private var isLabelHidden = false

    var body: some View {
        VStack {
            // Your other views...

            Text("This is a hidden label.")
                .opacity(isLabelHidden ? 0 : 1)
                .padding()
                .background(Color.gray) // Optional background color for visibility

            // Your other views...

            Button("Toggle Label Visibility") {
                withAnimation {
                    isLabelHidden.toggle()
                }
            }
        }
    }
}

struct HiddenLabelView_Previews: PreviewProvider {
    static var previews: some View {
        HiddenLabelView()
    }
}
