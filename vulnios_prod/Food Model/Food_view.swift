//
//  Food_view.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 1/11/23.
//
import SwiftUI

struct FoodDetailScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var cartManager = CartManager()
    var product: Product
    @State private var quantity: Int = 1
    @State private var showingAlert = false

    var body: some View {
        ZStack {
            Color("Bg")

            ScrollView {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.top)

                FoodDescriptionView(product: product, quantity: $quantity)
            }
            .edgesIgnoringSafeArea(.top)

            VStack {
                Spacer()

                // HStack {
                // Button(action: {
                //     addToCart()
                //  }) {
                //      Text("Add to Bag")
                //         .font(.title3)
                ////          .fontWeight(.semibold)
                //         .foregroundColor(.red)
                //         .padding()
                //        .frame(width: 190, height: 40)
                //        .background(Color.black)
                //       .cornerRadius(10)
                //       .overlay(
                //         RoundedRectangle(cornerRadius: 10)
                //               .stroke(Color.white, lineWidth: 2)
                //         )
                //   }
                //   .frame(maxHeight: .infinity, alignment: .bottom)
                //   .alert(isPresented: $showingAlert) {
                //       Alert(
                //          title: Text("Product Added"),
                //          message: Text("The product has been added to your cart."),
                //         dismissButton: .default(Text("OK"))
                //     )
                //    }
                //  }
            //   .padding()
                //  .padding(.horizontal)
                //   .background(Color("Primary"))
                //   .cornerRadius(100)
                //  .edgesIgnoringSafeArea(.bottom)

                HStack {
                    Text("$\(product.price)") // Product Price on the left side
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding(.leading)

                    Spacer()

                    //   HStack {
                        //     Stepper(value: $quantity, in: 1...10) {
                            //     Image(systemName: "minus.circle")
                            //       .foregroundColor(.black)
                            //       .font(.title)
                            //    }
                        //    .padding(.horizontal)
                        //    .labelsHidden()

                        //   Text("Quantity: \(quantity)")
                        //  .font(.title3)
                        //  .foregroundColor(.black)
                        //      .padding(.horizontal)
                        //         .labelsHidden()
                        // }
                    // .padding()
                    //   .background(Color("Primary"))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(action: { presentationMode.wrappedValue.dismiss() }), trailing: Image("threeDot"))
            .environmentObject(cartManager)
        }
    }

    func addToCart() {
        let productWithQuantity = Product(
            id: product.id,
            name: product.name,
            image: product.image,
            price: product.price,
            disciption: product.disciption, // Note the correction in property name
            quantity: quantity
        )

        cartManager.addToCart(product: productWithQuantity)
        showingAlert = true

        // Added print statements
        print("Added to cart:")
        print("Product: \(productWithQuantity)")
        print("Cart Total: \(cartManager.total)")
        print("Cart Contents: \(cartManager.products)")
    }
}

struct FoodDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailScreen(product: Productlist[0])
    }
}

struct FoodDescriptionView: View {
    let product: Product
    @Binding var quantity: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.title)
                .fontWeight(.bold)

            HStack(spacing: 4) {
                ForEach(0 ..< 5) { _ in
                    Image("star")
                }
                Text("(4.9)")
                    .opacity(0.5)
                    .padding(.leading, 8)
                Spacer()
            }

            Text("Description")
                .fontWeight(.medium)
                .padding(.vertical, 8)

            Text(product.disciption)
                .lineSpacing(8.0)
                .opacity(0.6)
        }
        .padding()
        .padding(.top)
        .background(Color("Bg"))
        .cornerRadius(30)
        .offset(x: 0, y: -30.0)
    }
}

struct BackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
                .padding(.all, 12)
                .background(Color.white)
                .cornerRadius(8.0)
        }
    }
}

