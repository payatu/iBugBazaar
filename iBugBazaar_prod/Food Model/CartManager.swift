//
//  cartmanager.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 23/05/23.
//
//
import SwiftUI

class CartManager: ObservableObject {
    @Published var products: [Product] = []
    @Published private(set) var total: Double = 0

    func addToCart(product: Product) {
        products.append(product)
        total += Double(product.price)
    }

    func removeFromCart(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            total -= Double(products[index].price)
            products.remove(at: index)
        }
    }

    // Function to update the total amount when the cart is modified
    private func updateTotal() {
        total = products.reduce(0.0) { $0 + Double($1.price) }
    }
}
