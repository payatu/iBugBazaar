//
//  models.swift
//  hackersden_ios_Vuln
//
//  Created by Kapil Gurav on 18/05/23.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Int
    var disciption: String
    var quantity: Int
}

var Productlist = [
    Product(name: "Pizza", image: "pizza", price: 79, disciption: "Vegetable Pizza is a delicious and healthy option for anyone who loves pizza. This pizza is made with a fresh, hand-tossed crust and is topped with a variety of vegetables, including tomatoes, onions, peppers, mushrooms, and spinach", quantity: 0),

    Product(name: "Cake", image: "Cake", price: 109, disciption: "Vegetable Cake is a delicious and healthy option for anyone who loves cake. This cake is made with a fresh, vegetable-based batter and is topped with a variety of vegetables, including tomatoes, onions, peppers, mushrooms, and spinach.", quantity: 0),

    Product(name: "Fried Chicken", image: "Chiken", price: 150, disciption: "Fried chicken is a dish consisting of chicken pieces that have been coated in seasoned flour or batter and pan-fried, deep fried, pressure fried, or air fried. ", quantity: 0),

    Product(name: "Special Egg", image: "egg", price: 50, disciption: "A special egg is an egg that is larger and more nutritious than a regular egg. They are often laid by chickens that are fed a special diet, or that are raised in a specific environment.", quantity: 0),

    Product(name: "Mix Veg Pizza", image: "Mix pizza", price: 99, disciption: "Mix veg pizza is a delicious and healthy option for anyone who loves pizza. It is made with a fresh, hand-tossed crust and is topped with a variety of vegetables, including tomatoes, onions, peppers, mushrooms, and spinach", quantity: 0),

    Product(name: "Mix Salad", image: "Mixsalad", price: 109, disciption: "A mix salad is a salad made with a variety of different ingredients. It can be a great way to get a variety of nutrients in one meal. Some common ingredients in mix salads include lettuce, tomatoes, cucumbers, carrots, onions, and peppers", quantity: 0),

    Product(name: "Nachos", image: "nachos", price: 99, disciption: "Nachos are a delicious and versatile Mexican dish that can be enjoyed by people of all ages. They are made with tortilla chips, cheese, and a variety of toppings, such as beans, meat, vegetables, and salsa. Nachos can be served as a snack, appetizer, or main course", quantity: 0),

    Product(name: "Sweet Banana", image: "sweet banana", price: 89, disciption: "Bananas are a sweet fruit that is a good source of potassium, vitamin B6, and fiber. They are also a good source of carbohydrates, which provide the body with energy.", quantity: 0),

    Product(name: "Mix Veg", image: "Veg mix", price: 109, disciption: "Mix veg is a popular Indian dish made with a variety of vegetables. It is a delicious and healthy dish that can be enjoyed by people of all ages.", quantity: 0),

    Product(name: "Chicken Salad", image: "Salad", price: 129, disciption: "Chicken salad is a delicious and versatile dish that can be enjoyed for lunch, dinner, or a snack. It is made with cooked chicken, mayonnaise, celery, and other ingredients, such as grapes, apples, or nuts.", quantity: 0)
]

