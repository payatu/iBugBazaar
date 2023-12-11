//
//  Cart.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 23/05/23.
//

import SwiftUI

struct Cart: View {
    var NoofProducts: Int
    var body: some View {
        ZStack(alignment: .topTrailing){
            Image(systemName: "cart.badge.plus")
                .padding(.top, 5)
            
            if NoofProducts > 0 {
                
                Text("\(NoofProducts)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                    .cornerRadius(15)
                
                
            }
        }
    }
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart(NoofProducts: 1)
    }
}


// race Condition
// Value tampering
// cart limit
//

