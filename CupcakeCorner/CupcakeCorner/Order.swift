//
//  Order.swift
//  CupcakeCorner
//
//  Created by алтынпончик on 6/25/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var type = 0
    @Published var quantity = 3

    @Published var specialRequestEnabled = false
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
