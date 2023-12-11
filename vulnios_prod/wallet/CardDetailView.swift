//
//  CardDetailView.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 09/06/23.
//

import SwiftUI

struct CardDetailView: View {
    var card: Card

    @State private var isMasked = true

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "creditcard")
                .resizable()
                .scaledToFit()
                .frame(height: 100)

            Text("Bank Name")
                .font(.headline)

            HStack {
                Text(isMasked ? maskData(card.number) : card.number)
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
                    .frame(width: 100)
                    .foregroundColor(.black) // Text color
                    .padding(5)
                    .background(Color.white.opacity(0.7)) // Background color
                    .cornerRadius(5)

                Text(card.expiration)
                    .font(.system(size: 15, weight: .medium))
                    .frame(width: 100)

                Text("MONTH/YEAR")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .frame(width: 100)
            }

            Text("VALID")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black)

            Text("CARDHOLDER")
                .font(.headline)

            Text(isMasked ? maskData(card.name) : card.name)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.black)

            HStack {
                Text("Expiry (MM/YY)")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .frame(width: 150)

                Text(isMasked ? maskData(card.cvv) : card.cvv)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.gray)
                    .frame(width: 100)
            }

            Toggle("Mask sensitive data", isOn: $isMasked)
                .padding(.top, 20)
        }
        .padding(.bottom, 0)
        .padding(.leading, 0)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    private func maskData(_ data: String) -> String {
        return String(repeating: "•", count: data.count)
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(name: "kapil Gurav", number: "1234 5678 9012 3456", expiration: "12/24", cvv: "123")
        return CardDetailView(card: card)
    }
}

