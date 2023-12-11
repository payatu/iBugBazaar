//
//  Billing information.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 21/11/23.
//
// BillingInformation.swift

import SwiftUI

struct BillingInformation: View {
    @ObservedObject var orderHistoryManager: OrderHistoryManager = OrderHistoryViewModel.shared.orderHistoryManager

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                List(orderHistoryManager.orders) { order in
                    HStack {
                        Image(systemName: order.isSuccess ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(order.isSuccess ? .green : .red)
                            .font(.title)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(order.isSuccess ? "Order Successful" : "Order Failed")
                                .font(.headline)
                                .foregroundColor(order.isSuccess ? .green : .red)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(order.isSuccess ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                                .cornerRadius(8)

                            Text("Username: \(order.username)")
                                .font(.subheadline)
                                .foregroundColor(.black)

                            Text("Amount: $\(order.amount)")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                        .padding(8)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.vertical, 4)
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Order History")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: EmptyView(), trailing: EmptyView())
            .padding(.horizontal, geometry.size.width * 0.15) // Adjust as needed
            .onDisappear {
                orderHistoryManager.saveOrders() // Save orders when the view disappears
                print("Orders saved locally:", orderHistoryManager.orders)
            }
        }
    }
}

struct BillingInformation_Previews: PreviewProvider {
    static var previews: some View {
        BillingInformation(orderHistoryManager: OrderHistoryManager())
    }
}


