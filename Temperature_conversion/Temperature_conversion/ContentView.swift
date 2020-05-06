//
//  ContentView.swift
//  Temperature_conversion
//
//  Created by алтынпончик on 5/6/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var unitType = 0
    @State private var amount = ""
    @State private var firstUnit = ""
    @State private var secondUnit = ""
    
    private let possibleUnits = ["temperature"]
    private let unitSelection = [
        ["celsius", "fahrenheit", "kelvin"]
    ]
    
    // MARK: - Computed properties
    var result: String {
        let converter = Converter()
        let currentList = unitSelection[unitType]
        
        guard let amount = Double(amount) else {
            return "0"
        }
        
        guard let firstDimension = Converter.dimension(for: firstUnit),
            let secondDimension = Converter.dimension(for: secondUnit),
            [firstUnit, secondUnit].allSatisfy(currentList.contains) else {
                return "Please, select a unit"
        }
        
        let measurement = Measurement(value: amount, unit: firstDimension)
        return converter.conversion(from: measurement, to: secondDimension)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Temperature Conversion")
                .font(.largeTitle).bold()
            HStack(alignment: .center) {
                Form {
                    Section(header: Text("From: ")) {
                        
                        Picker("First unit", selection: $firstUnit) {
                            ForEach(self.unitSelection[unitType], id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        TextField("Input", text: $amount)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section(header: Text("To: ")) {
                        Picker("Second unit", selection: $secondUnit) {
                            ForEach(self.unitSelection[unitType], id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        Text(result)
                    }
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
