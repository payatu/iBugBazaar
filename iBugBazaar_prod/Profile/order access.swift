//
//  order access.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 03/12/23.
//
// AllOrdersView.swift

import SwiftUI

struct AllOrdersView: View {
    @ObservedObject var orderHistoryManager: OrderHistoryManager = OrderHistoryViewModel.shared.orderHistoryManager

    var body: some View {
        NavigationView {
            List(orderHistoryManager.orders) { order in
                HStack {
                    Image(systemName: order.isSuccess ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(order.isSuccess ? .green : .red)
                        .font(.title)
                        .frame(width: 30, height: 30) // Adjust icon size

                    VStack(alignment: .leading, spacing: 8) {
                        Text(order.isSuccess ? "Order Successful" : "Order Failed")
                            .font(.headline)
                            .foregroundColor(order.isSuccess ? .green : .red)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4) // Adjust vertical padding
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
                .padding(.vertical, 8) // Increase vertical padding
                .padding(.horizontal, UIScreen.main.bounds.width * 0.03) // Adjust horizontal padding
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Order History")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, UIScreen.main.bounds.width * 0.03) // Adjust horizontal padding
            .navigationBarItems(trailing:
                NavigationLink(destination: CouponsView()) {
                    Image(systemName: "tag")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding(.trailing, 16)
                }
            )
            .onAppear {
                // Reload orders when the view appears
                orderHistoryManager.loadOrders()
            }
        }
    }
}

struct AllOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        AllOrdersView()
    }
}
