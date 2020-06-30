//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by алтынпончик on 6/24/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

// day 49 2nd video
//class User: ObservableObject, Codable {
//    enum CodingKeys: CodingKey {
//        case name
//    }
//
//    @Published var name = "Paul Hudson"
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//}

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderAsStruct.type) {
                        ForEach(0..<ClassToStruct.types.count) {
                            Text(ClassToStruct.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.orderAsStruct.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderAsStruct.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.orderAsStruct.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.orderAsStruct.specialRequestEnabled {
                        Toggle(isOn: $order.orderAsStruct.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.orderAsStruct.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
