//  Product_list.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 22/05/23.

//  If a user has the ability to reverse engineer or modify the code, they can potentially bypass the limit you've implemented in several ways. Here are a few possible approaches:

//  Modifying the code directly: Since the code is running on the client-side, a determined user can modify the code locally to remove or bypass the limit entirely. They can simply remove the code that enforces the limit and rebuild the app.

//  Using a debugger: Users with reverse engineering skills can use tools like Frida or Objection to attach a debugger to the running application and modify the variables or memory values directly. They can change the value of maxProductsInCart to a higher number or disable the condition that checks the cart's product count.

//  Patching the app binary: Advanced users can disassemble the app binary, identify the code responsible for enforcing the cart limit, and patch it to remove or bypass the limit. This requires a deeper understanding of assembly language and binary patching techniques.
import SwiftUI
import WebKit

struct Product_list: View {
    @StateObject var cartManager = CartManager()
    @State private var searchFood = ""
    @State private var showAlert = false
    @State private var javaScriptResponse = ""
    @State private var webView: WKWebView?

    // This one for the search bar to filter the product
    var filteredProducts: [Product] {
        if searchFood.isEmpty {
            return Productlist
        } else {
            return Productlist.filter { product in
                product.name.lowercased().contains(searchFood.lowercased())
            }
        }
    }

    var columns = [GridItem(.adaptive(minimum: 150), spacing: 0)]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Search bar
                HStack {
                    TextField("Search Food Menu", text: $searchFood)
                        .padding(7)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.leading, 10)

                    Button(action: {
                        executeJavaScript(with: searchFood)
                    }) {
                        Text("Search")
                            .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // Food products
                ScrollView {
                    LazyVGrid(columns: columns, spacing: -10) {
                        ForEach(filteredProducts, id: \.id) { product in
                            NavigationLink(destination: FoodDetailScreen(product: product)
                                .environmentObject(cartManager)
                                .navigationBarHidden(true)) { // Hide back button for FoodDetailScreen
                                Product_page(Product: product)
                                    .environmentObject(cartManager)
                            }
                            .padding()
                        }
                    }
                }
                .padding(.top, 0) // Adjust the value based on your preference
            }
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                        .navigationBarHidden(true) // Hide back button for CartView
                } label: {
                    Cart(NoofProducts: cartManager.products.count)
                }
            }
            .accentColor(.black) // Set the accent color to black
            .padding(.bottom, 0)
            .environmentObject(cartManager)
            .navigationBarTitle("Food Menu", displayMode: .inline)
            .padding(.top, 0)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("XSS Triggered"),
                    message: Text("The result of JavaScript execution is: \(javaScriptResponse)"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func executeJavaScript(with code: String) {
        if code.localizedCaseInsensitiveContains("<script>") {
            showAlert = true
        } else {
            showAlert = false

            // Create a WKWebView
            let webView = WKWebView()

            // Load a dummy HTML content with the provided JavaScript code
            let html = """
            <html>
                <head>
                    <title>JavaScript Execution</title>
                    <script type="text/javascript">
                        \(code)
                    </script>
                </head>
                <body></body>
            </html>
            """
            webView.loadHTMLString(html, baseURL: nil)

            // Wait for the JavaScript to finish executing
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // Extract the result (you may customize this based on your needs)
                let result = webView.evaluateJavaScript("document.body.innerHTML") { result, error in
                    if let error = error {
                        print("JavaScript error: \(error)")
                    } else if let result = result as? String {
                        javaScriptResponse = result
                        showAlert = true
                    }
                }

                // Clean up the WebView
                webView.removeFromSuperview()
            }
        }
    }
}


struct Product_list_Previews: PreviewProvider {
    static var previews: some View {
        Product_list()
    }
}

// For example, if you enter <script>alert("XSS");</script> as the search query, the code will detect the presence of <script> in the query and display the XSS Popup alert on the screen.
