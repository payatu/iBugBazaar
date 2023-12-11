//
//  Product page.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 18/05/23.
//

import SwiftUI

struct Product_page: View {
    @EnvironmentObject var CartManager: CartManager
    
    var Product: Product

    @ViewBuilder
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                Image(Product.image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 180)
                    .scaledToFit()
                
                VStack(alignment: .leading) {
                    Text(Product.name)
                        .bold()
                    
                    Text("\(Product.price)$")
                        .font(.caption)
                }
                .padding()
                .frame(width: 180, height: 50)
                .background(Color(.white)) // Use a standard color here
                .cornerRadius(20)
            }
            .frame(width: 180, height: 200)
            .shadow(radius: 10)
            
            Button {
                CartManager.addToCart(product: Product)
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.black) // Use a standard color here
                    .cornerRadius(40)
                    .padding()
            }
        }
    }
}

struct Product_page_Previews: PreviewProvider {
    static var previews: some View {
        Product_page(Product: Productlist[0])
            .environmentObject(CartManager())
    }
}
