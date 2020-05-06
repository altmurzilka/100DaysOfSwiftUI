////
////  ContentView.swift
////  Temperature_conversion
////
////  Created by алтынпончик on 5/6/20.
////  Copyright © 2020 алтынпончик. All rights reserved.
////
//
//import SwiftUI
//
//struct ContentView: View {
//
//    @State private var startTemp = ""
//    @State private var endTemp = ""
//    @State private var temperature1 = 1
//    @State private var temperature2 = 1
//    @State private var formula = ""
//
//    let temp = ["Celsius", "Fahrenheit", "Kelvin"]
//
//    var result: String {
//        let converter = Converter()
//        let currentList = temp[temperature1]
//
//        guard let amount = Double(startTemp) else {
//            return "Invalid input. Type a number."
//        }
//
//        guard let firstDimension = Converter.dimension(for: startTemp),
//            let secondDimension = Converter.dimension(for: endTemp),
//            [startTemp, endTemp].allSatisfy(currentList.contains) else {
//                return "Unit has not been selected"
//        }
//
//        let measurement = Measurement(value: amount, unit: firstDimension)
//        return converter.conversion(from: measurement, to: secondDimension)
//    }
//
//    func getTemperature(label: String) -> Float {
//        var temperature: Float
//        temperature = Float(startTemp) ?? 0
//        return temperature
//    }
//
//    var body: some View {
//        VStack(alignment: .center){
//            Text("Temperature Conversion")
//                .font(.largeTitle).bold()
//                .padding(.bottom, 30)
//            HStack(alignment: .center) {
//                VStack(alignment: .leading) {
//                    Text("Initial temperature")
//                        .font(.callout)
//                        .bold()
//                    TextField(" ", text: $startTemp)
//                        .keyboardType(.decimalPad)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    Picker("°t", selection: $temperature1) {
//                        ForEach(0 ..< temp.count) {
//                            Text(self.temp[$0])
//                        }
//                    }.pickerStyle(SegmentedPickerStyle())
//                }
//                Text("=").font(.system(size: 45, weight: .bold, design: .default))
//                VStack(alignment: .leading) {
//                    Text("End temperature")
//                        .font(.callout)
//                        .bold()
//                    TextField(" ", text: $endTemp)
//                        .keyboardType(.decimalPad)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    Picker("°t", selection: $temperature2) {
//                        ForEach(0 ..< temp.count) {
//                            Text(self.temp[$0])
//                        }
//                    }.pickerStyle(SegmentedPickerStyle())
//                }
//            }.padding()
//            HStack {
//                Text("Formula: ")
//                    .font(.callout)
//                    .bold()
//                Spacer()
//            }.padding()
//        }.padding(70)
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()//.previewLayout(.fixed(width: 896, height: 414))
//    }
//}

import SwiftUI

struct ContentView: View {
    
    @State private var unitType = 0
    @State private var amount = ""
    @State private var firstUnit = ""
    @State private var secondUnit = ""
    
    private let possibleUnits = ["temperature", "length", "time", "volume"]
    private let unitSelection = [
        ["celsius", "fahrenheit", "kelvin"],
        ["meters", "kilometers", "feet", "yards", "miles"],
        ["seconds", "minutes", "hours", "days"],
        ["milliliters", "liters", "cups", "pints", "gallons"]
    ]
    
    // MARK: - Computed properties
    var result: String {
        let converter = Converter()
        let currentList = unitSelection[unitType]
        
        guard let amount = Double(amount) else {
            return "Invalid input. Type a number."
        }
        
        guard let firstDimension = Converter.dimension(for: firstUnit),
            let secondDimension = Converter.dimension(for: secondUnit),
            [firstUnit, secondUnit].allSatisfy(currentList.contains) else {
                return "Unit has not been selected"
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
                        
                        TextField("Type a temperature", text: $amount)
                            .keyboardType(.numbersAndPunctuation)
                        
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
