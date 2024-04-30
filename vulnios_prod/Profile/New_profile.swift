//
//  New_profile.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 20/11/23.
//

// UserProfileViewModel.swift

import SwiftUI
import CoreLocation

class UserProfileViewModel: ObservableObject {
    @Published var username: String = "Kapil Gurav"
    @Published var email: String = ""
    @Published var address: String = ""
    @Published var mobileNumber: String = ""
    
    // Flag to track whether PIN is set
    @Published var isPinSet: Bool {
        didSet {
            UserDefaults.standard.set(isPinSet, forKey: "isPinSet")
            UserDefaults.standard.synchronize() // Add this line
        }
    }
    
    static let shared = UserProfileViewModel()
    
    private init() {
        // Only initialize isPinSet based on UserDefaults if it's the first app launch
        if UserDefaults.standard.object(forKey: "isPinSet") == nil {
            self.isPinSet = false
        } else {
            self.isPinSet = UserDefaults.standard.bool(forKey: "isPinSet")
        }
    }
}

import SwiftUI

class LocationDelegate: NSObject, CLLocationManagerDelegate {
    var locationUsage: Binding<Bool>
    
    init(locationUsage: Binding<Bool>) {
        self.locationUsage = locationUsage
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // Location permission granted
            locationUsage.wrappedValue = true
        case .denied, .restricted, .notDetermined:
            // Location permission denied or not determined
            locationUsage.wrappedValue = false
        @unknown default:
            locationUsage.wrappedValue = false
        }
    }
}

struct AccountView: View {
    @ObservedObject private var userProfileViewModel = UserProfileViewModel.shared
    @State private var selectedCurrency = 0
    @State private var currencyArray = ["$ US Dollar", "£ GBP", "€ Euro", "₹ Rupee"]
    @State private var selectedPaymentMethod = 1
    @State private var paymentMethodArray = ["Paypal", "Credit/Debit Card", "Bitcoin"]
    @State private var locationUsage = false
    @State private var notificationToggle = false
    @State private var isPINSetup = false // Track PIN setup state
    @State var cards: [Card] = []

    
    // Create an instance of CLLocationManager
    private var locationManager = CLLocationManager()
    private var locationDelegate: LocationDelegate?
    
    init() {
        // Initialize locationDelegate only once
        locationDelegate = LocationDelegate(locationUsage: $locationUsage)
        locationManager.delegate = locationDelegate
        locationManager.requestWhenInUseAuthorization()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Image("payatu")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .padding(.bottom, 10)
                Text(userProfileViewModel.username)
                    .font(.system(size: 20))
                
                Form {
                    Section(header: Text("Payment Settings")) {
                        Picker(selection: $selectedCurrency, label: Text("Currency")) {
                            ForEach(0 ..< currencyArray.count) {
                                Text(currencyArray[$0]).tag($0)
                            }
                        }
                        
                        Picker(selection: $selectedPaymentMethod, label: Text("Payment Method")) {
                            ForEach(0 ..< paymentMethodArray.count) {
                                Text(paymentMethodArray[$0]).tag($0)
                            }
                        }
                        NavigationLink(destination: UserDefault(cards: $cards)) {
                            Text("Add a Credit/Debit Card to your account")
                        }
                    }
                    
                    Section(header: Text("Personal Information")) {
                        NavigationLink(destination: ProfileInformationView()) {
                            Text("Profile Information")
                        }
                        
//                        NavigationLink(destination:JailbreakCheckView()) {
//                            Text("Extra Setting")
//                        }
                        
                        NavigationLink(destination:httprequest()) {
                            Text("Send Crash Report")
                        }
                    }
                    
                    Section(footer: Text("Allow push notifications to get latest food and coupon deals")) {
                        Toggle(isOn: $locationUsage) {
                            Text("Location Usage")
                        }
                        
                        // Display Set PIN button only if Biometric/PIN toggle is enabled
                        Toggle(isOn: $userProfileViewModel.isPinSet) {
                            Text("Biometric/PIN")
                        }
                        
                        // Display Set PIN button only if Biometric/PIN toggle is enabled
                        if userProfileViewModel.isPinSet {
                            Button("Set PIN") {
                                isPINSetup = true
                            }
                        }
                    }
                }
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
            }
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline) // Set title display mode to inline
            .padding(.top, -1) // Adjust padding to push the content under the navigation bar
            .onAppear {
                // Refresh the view when it appears to reflect changes in isPinSet
                notificationToggle = userProfileViewModel.isPinSet
            }
            .onDisappear {
                // Save the PIN setting when leaving the view
                UserDefaults.standard.synchronize()
            }
            .sheet(isPresented: $isPINSetup) {
                // Show PIN setup screen as a sheet
                PINSetupView(isPINSet: $userProfileViewModel.isPinSet)
            }
        }
    }
}


struct PINSetupView: View {
    @Binding var isPINSet: Bool
    @State private var pin: String = ""
    @State private var pinSetSuccess = false
    
    var body: some View {
        VStack {
            // PIN setup UI
            TextField("Enter PIN", text: $pin)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .keyboardType(.numberPad) // Ensure numeric keyboard
                .onChange(of: pin) { newValue in
                    // Limit the PIN to 4 digits
                    if newValue.count > 4 {
                        pin = String(newValue.prefix(4))
                    }
                }
            
            Button("Set PIN") {
                // Ensure the PIN is exactly 4 digits before saving
                if pin.count == 4 {
                    print("PIN set successfully!")
                    // Store the PIN
                    storePINInCookies(pin: pin)
                    UserProfileViewModel.shared.isPinSet = true
                    isPINSet = false
                    pinSetSuccess = true
                } else {
                    // Optionally show an alert or handle invalid PIN length
                    pinSetSuccess = false
                }
            }
            .padding()
            
            if pinSetSuccess {
                Text("PIN set successfully!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
        .onDisappear {
            // Save the PIN setting when leaving the view
            UserDefaults.standard.synchronize()
        }
    }
}

// Function to store the PIN in binary cookies
func storePINInCookies(pin: String) {
    // Store PIN in UserDefaults
    storePINInUserDefaults(pin: pin)
    
    // Store PIN in cookies
    if let url = URL(string: "https://example.com") {
        let cookieProperties: [HTTPCookiePropertyKey: Any] = [
            .name: "PIN_Cookie",
            .value: pin,
            .domain: url.host!,
            .path: "/",
            .expires: NSDate(timeIntervalSinceNow: 31536000) // Expires in one year
        ]
        
        if let cookie = HTTPCookie(properties: cookieProperties) {
            HTTPCookieStorage.shared.setCookie(cookie)
        }
    }
}

func storePINInUserDefaults(pin: String) {
    UserDefaults.standard.set(pin, forKey: "UserPIN")
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

