//
//  CouponsView.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 05/12/23.
//

import SwiftUI

struct CouponsView: View {
    @State private var isLabelHidden = false
       @State private var showCoupons = false

       var body: some View {
           VStack {
               // Your other views...

               Text("This is a hidden label.")
                   .opacity(isLabelHidden ? 0 : 1)
                   .padding()
                   .background(Color.gray) // Optional background color for visibility

               // Hidden section for coupons
               if showCoupons {
                   Text("Coupons: XYZ123, ABC456, DEF789")
                       .opacity(0)
                       .padding()
                       .background(Color.gray)
               }

               // Your other views...

               Button("Toggle Label Visibility") {
                   withAnimation {
                       isLabelHidden.toggle()
                   }
               }

               Button("Show Coupons") {
                   withAnimation {
                       showCoupons.toggle()
                   }
               }
           }
       }
   }

struct CouponsView_Previews: PreviewProvider {
    static var previews: some View {
        CouponsView()
    }
}
