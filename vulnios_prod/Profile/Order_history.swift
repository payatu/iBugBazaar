
//
//  Order_history.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 21/11/23.
//
// OrderHistory.swift

import Foundation
import SwiftUI

class Order: NSObject, NSCoding, NSSecureCoding, Identifiable {
    var id: UUID
    var username: String
    var amount: Double
    var isSuccess: Bool

    init(id: UUID = UUID(), username: String, amount: Double, isSuccess: Bool) {
        self.id = id
        self.username = username
        self.amount = amount
        self.isSuccess = isSuccess
    }

    required init?(coder aDecoder: NSCoder) {
        guard
            let id = aDecoder.decodeObject(forKey: "id") as? UUID,
            let username = aDecoder.decodeObject(forKey: "username") as? String,
            let amount = aDecoder.decodeDouble(forKey: "amount") as? Double
        else {
            return nil
        }

        self.id = id
        self.username = username
        self.amount = amount
        self.isSuccess = aDecoder.decodeBool(forKey: "isSuccess")
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(amount, forKey: "amount")
        aCoder.encode(isSuccess, forKey: "isSuccess")
    }

    static var supportsSecureCoding: Bool {
        return true
    }
}

class OrderHistoryManager: ObservableObject {
    @Published var orders: [Order] = []

    init() {
        self.loadOrders()
    }

    func addOrder(username: String, amount: Double, isSuccess: Bool) {
        let order = Order(username: username, amount: amount, isSuccess: isSuccess)
        orders.append(order)

        // Save orders after appending the new order
        saveOrders()
    }

    func saveOrders() {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: orders, requiringSecureCoding: true)
            UserDefaults.standard.set(encodedData, forKey: "savedOrders")
        } catch {
            print("Error saving orders: \(error.localizedDescription)")
        }
    }

    internal func loadOrders() {
        if let encodedData = UserDefaults.standard.data(forKey: "savedOrders"),
           let decodedOrders = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData) as? [Order] {
            orders = decodedOrders
        }
    }
}



class OrderHistoryViewModel: ObservableObject {
    static let shared = OrderHistoryViewModel()

    var orderHistoryManager: OrderHistoryManager

    private init() {
        self.orderHistoryManager = OrderHistoryManager()
    }
}


