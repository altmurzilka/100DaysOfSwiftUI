//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by алтынпончик on 6/25/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderAsStruct.name)
                TextField("Street Address", text: $order.orderAsStruct.streetAddress) // adding in-between orderAsStruct
                TextField("City", text: $order.orderAsStruct.city)
                TextField("Zip", text: $order.orderAsStruct.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }.disabled(order.orderAsStruct.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
