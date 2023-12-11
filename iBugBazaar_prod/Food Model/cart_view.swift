// cart_view.swift
// hackersden_ios_Vuln
//
// Created by Kapil Gurav on 23/05/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var showPaymentView = false
    @State private(set) var walletBalance: Double = 0.0
    @State private var showAlert = false
    @State private var cartTotal: Double = 0.0
    let maxProductsInCart: Int = 11

    var body: some View {
        NavigationView {
            ScrollView {
                if cartManager.products.count > 0 {
                    ForEach(cartManager.products.prefix(maxProductsInCart), id: \.id) { product in
                        product_row(products: product)
                    }

                    HStack {
                        Text("Your Cart Total Is")
                            .padding()
                        Spacer()
                        Text(String(format: "$%.2f", cartTotal))
                            .bold()
                    }

                    Button(action: {
                        checkBalanceAndProceed()
                    }) {
                        Text("Proceed to Payment")
                            .font(.system(size: 25))
                            .frame(width: 300, height: 50)
                            .foregroundColor(cartManager.products.count > maxProductsInCart ? .red : .green)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 2))
                    }
                    .disabled(cartManager.products.count > maxProductsInCart)
                    .sheet(isPresented: $showPaymentView) {
                        PaymentView(
                            cartTotal: $cartTotal,
                            walletBalance: $walletBalance,
                            paymentResult: .constant(false)
                        )
                    }
                } else {
                    Text("Your cart is empty")
                }
            }
            .onAppear {
                cartTotal = Double(cartManager.total)
            }
            .padding(.top)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("My Cart")
        .navigationBarBackButtonHidden(false)
        .padding(.top, -10)
        .overlay(
            NavigationLink(destination: Text(""), label: { EmptyView() })
                .hidden()
        )
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Insufficient Balance"),
                message: Text("You don't have enough money in your wallet to place this order."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear() {
            print(walletBalance)
        }
    }

    func checkBalanceAndProceed() {
        let orderAmount = cartTotal

        if let walletBallanceSaved = UserDefaults.standard.value(forKey: kWalletBalance) as? Double {
            walletBalance = walletBallanceSaved
        }

        if walletBalance >= orderAmount {
            walletBalance -= orderAmount
            UserDefaults.standard.setValue(walletBalance, forKey: kWalletBalance)
            showPaymentView = true
        } else {
            showAlert = true
        }
    }
}

struct cart_view_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
