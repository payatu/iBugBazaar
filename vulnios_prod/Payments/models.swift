//
//  model.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 30/05/23.
//

import Foundation

func formatCurrency(amount: Double, currency: String) -> String {
  let numberFormatter = NumberFormatter()
  numberFormatter.numberStyle = .currency
  numberFormatter.currencySymbol = currency
  numberFormatter.maximumFractionDigits = 2

  return numberFormatter.string(from: amount as NSNumber)!
}
