//
//  product_row.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 24/05/23.


import SwiftUI

struct product_row: View {
        
    @EnvironmentObject var cartManager: CartManager
    
    var products: Product
    
    var body: some View {
        
        HStack(spacing: 20){
            Image(products.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10){
                
                Text(products.name)
                    .bold()
                Text("$\(products.price)")
                
            }
            Spacer()
                
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    cartManager.removeFromCart(product: products)
                }
            
            
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct product_row_Previews: PreviewProvider {
    static var previews: some View {
        
        product_row(products: Productlist[3])
            .environmentObject(CartManager())
        
    }
}
