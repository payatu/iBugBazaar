//
//  Payments.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 30/05/23.
//
//  Payments.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 30/05/23.

import SwiftUI

struct PaymentView: View {
    @Binding var cartTotal: Double
    @Binding var walletBalance: Double
    @Binding var paymentResult: Bool
    
    @State private var paymentSuccessfull: Bool = false
    @State private var showBillingInfo: Bool = false
    
    var orderHistoryManager: OrderHistoryManager = OrderHistoryManager()

    var body: some View {
        VStack {
            Text("Your cart total is $\(cartTotal, specifier: "%.2f")")
                .padding()
            
            Button(action: {
                simulatePayment()
            }) {
                Text("Pay Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(paymentSuccessfull)
            
            Spacer() // Add some space between button and result
            
            if paymentSuccessfull {
                Image("Done")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 65)
                    .cornerRadius(10)
                    .padding()
                
                Text("Payment Successful")
                    .font(.title)
                    .foregroundColor(.green)
                    .bold()
                    .padding()
                
                Button("Show Billing Information") {
                                    showBillingInfo.toggle()
                                }
                                .padding()
                                .foregroundColor(.blue)
                                .sheet(isPresented: $showBillingInfo) {
                                    BillingInformation(orderHistoryManager: orderHistoryManager)
                                }

            }
        }
        .navigationBarTitle("Payment Gateway")
        .padding()
        .onAppear() {
            print(cartTotal)
            print(walletBalance)
            print(paymentResult)
        }
    }
    
    func simulatePayment() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            paymentSuccessfull = true

            // Create and add an order to the OrderHistoryManager
            let order = Order(username: "ExampleUser", amount: cartTotal, isSuccess: paymentSuccessfull)
            orderHistoryManager.orders.append(order)

            // Print statements for debugging
            print("Payment simulation successful")
            print("OrderHistoryManager orders: \(orderHistoryManager.orders)")
        }
    }

}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(cartTotal: .constant(50.0), walletBalance: .constant(100.0), paymentResult: .constant(false))
    }
}

