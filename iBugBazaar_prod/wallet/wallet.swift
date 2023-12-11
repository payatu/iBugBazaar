//  wallet.swift
//  vulnios_prod
//  Created by Kapil Gurav on 08/08/23.


import SwiftUI

struct WalletView: View {
    @State var cards: [Card] = []
    @Binding var walletBalance: Double
    @State private var selectedCardIndex: Int = 0
    @State private var hasLoadedCards = false // Add this line

    var body: some View {
        NavigationView {
            VStack {
                Text("Wallet Balance")
                    .font(.headline)
                Text("$\(walletBalance, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                List {
                    ForEach(cards) { card in
                        NavigationLink(destination: CardDetailView(card: card)) {
                            WalletCardView(card: card)
                        }
                    }
                }
                .navigationBarTitle("Wallet")
                .navigationBarItems(trailing: NavigationLink(destination: UserDefault(cards: $cards)) {
                    Text("Add Card")
                })

                NavigationLink(destination: UsersMoneyView(walletBalance: $walletBalance, selectedCardIndex: $selectedCardIndex, cards: cards)) {
                    Text("Add Money")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(cards.isEmpty) // Disable the button if cards array is empty
            }
            .onAppear {
                if !hasLoadedCards { // Only load cards once
                    loadCards()
                    hasLoadedCards = true
                }

                if let walletBallenceSaved = UserDefaults.standard.value(forKey: kWalletBalance) as? Double {
                    print(walletBallenceSaved)

                    walletBalance = walletBallenceSaved
                }
            }
        }
    }

    func loadCards() {
        if let name = UserDefaults.standard.string(forKey: "name"),
           let cardNo = UserDefaults.standard.string(forKey: "cardNo"),
           let expiry = UserDefaults.standard.string(forKey: "expiry"),
           let cvv = UserDefaults.standard.string(forKey: "cvv"),
           cardNo.count == 16, // Check if the card number has exactly 16 digits
           cardNo.allSatisfy({ $0.isNumber }) { // Check if all characters are numbers
            let card = Card(name: name, number: cardNo, expiration: expiry, cvv: cvv)

            if !cards.contains(where: { $0.number == cardNo }) { // Check if the card is not already in the list
                cards.append(card)
            }
        }
    }
}

// UsersMoneyView.swift
import SwiftUI

struct UsersMoneyView: View {
    @Binding var walletBalance: Double
    @Binding var selectedCardIndex: Int // Binding for the selected card index
    @State private var amount: Double = 0.0 // State variable to store the amount
    @State private var isPaymentSuccessful = false // Track payment success
    var cards: [Card] // Add cards as a parameter
    @State private var isOTPInputVisible = false // Track whether OTP input is visible
    @State private var enteredOTP = "" // Store the entered OTP
    @State private var otpError = false // Track OTP error
    @State private var isVerified = false // Track OTP verification
    let expectedOTP = "010101" // Expected OTP
    
    var body: some View {
        VStack {
            Text("Add Money to Wallet")
                .font(.title)
                .padding()
            
            Text("Select Payment Card:")
            
            Picker("Card", selection: $selectedCardIndex) {
                ForEach(0..<cards.count, id: \.self) { index in
                    Text("\(cards[index].number) - \(cards[index].name)")
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            TextField("Amount", value: $amount, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
                .onChange(of: amount) {
                    print(amount)
                    print($0)
                }
            
            Button(action: {
                // Show OTP input view
                isOTPInputVisible.toggle()
            }) {
                Text("Add Money")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            if isVerified {
                if isPaymentSuccessful {
                    Text("Payment Successful")
                        .foregroundColor(.green)
                        .font(.headline)
                        .padding()
                } else {
                    Button(action: {
                        // Handle payment logic here using 'selectedCardIndex' and 'amount'
                        if validatePayment() {
                            // Update the wallet balance when payment is successful
                            print(amount)
                            print(walletBalance)
                            
                            walletBalance += amount
                            isPaymentSuccessful = true
                        } else {
                            otpError = true // Set OTP error to true
                        }
                    }) {
                        Text("Add Money")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $isOTPInputVisible) {
            OTPInputView(isVisible: $isOTPInputVisible, enteredOTP: $enteredOTP, expectedOTP: expectedOTP) { isVerified in
                self.isVerified = isVerified // Set isVerified based on OTP verification
                if isVerified {
                    // Handle adding money logic here using 'selectedCardIndex' and 'amount'
                    if validatePayment() {
                        // Update the wallet balance when payment is successful
                        
                        print(amount)
                        print(walletBalance)
                        walletBalance += amount
                        
                        print(walletBalance)
                        
                        UserDefaults.standard.setValue(walletBalance, forKey: kWalletBalance)
                        
                        if let walletBallence = UserDefaults.standard.value(forKey: kWalletBalance) as? Double {
                            print(walletBallence)
                        }
                        
                        isPaymentSuccessful = true
                        
                    } else {
                        otpError = true // Set OTP error to true
                    }
                }
            }
        }
    }

    // Validate the payment (e.g., check the amount and selected card)
    private func validatePayment() -> Bool {
        // Implement your validation logic here
        // Use 'selectedCardIndex' to access the selected card
        if amount > 0 {
            return enteredOTP == expectedOTP // Check if OTP is correct
        } else {
            return false
        }
    }
}

struct WalletCardView: View {
    var card: Card
    
    var body: some View {
        HStack {
            Text(card.name)
            Spacer()
            Text(formatCardNumber(card.number))
            Text(card.expiration)
            Text(card.cvv)
        }
        .padding()
        .background(Color.gray)
    }
    
    func formatCardNumber(_ cardNumber: String) -> String {
        let lastFourDigits = String(cardNumber.suffix(4))
        let maskedDigits = String(repeating: "•", count: cardNumber.count - 4)
        return "\(maskedDigits) \(lastFourDigits)"
    }
}

struct Card: Identifiable {
    var id = UUID()
    var name: String
    var number: String
    var expiration: String
    var cvv: String
}

struct WalletView_Previews: PreviewProvider {
    @State static var walletBalance: Double = 0.0

    static var previews: some View {
        WalletView(cards: [], walletBalance: $walletBalance)
    }
}
