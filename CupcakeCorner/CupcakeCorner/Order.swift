//
//  Order.swift
//  CupcakeCorner
//
//  Created by алтынпончик on 6/25/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import Foundation

/*
 For a more challenging task, see if you can convert our data model from a class to a struct,
 then create an ObservableObject class wrapper around it that gets passed around.
 This will result in your class having one @Published property,
 which is the data struct inside it, and should make supporting Codable on the struct much easier.
 */


// challenge 3
struct ClassToStruct: Codable {
    
    // transfer data from Order class to the new struct
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    
    // Get rid of all @Published properties that we used in class
    // @Published is only available on properties of classes
    
    var type = 0            // instead of @Published var type = 0
    var quantity = 3
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var hasValidAddress: Bool {
        // challenge 1
        
        /*
            Our address fields are currently considered valid if they contain anything,
            even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
        */
        
        // check fiels in AddressView for emptyness
        // https://www.hackingwithswift.com/example-code/strings/how-to-trim-whitespace-in-a-string
        // Note: read something about trimmung and build-in methods
        if name.isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
}

class Order: ObservableObject {         // deleting Codable from class
    
    @Published var orderAsStruct: ClassToStruct
    
    enum CodingKeys: CodingKey {
        case orderAsStruct  // adding cases only for @Published variables
    }
    
    init() {
        self.orderAsStruct = ClassToStruct()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(orderAsStruct, forKey: .orderAsStruct)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        orderAsStruct = try container.decode(ClassToStruct.self, forKey: .orderAsStruct)
    }
}
