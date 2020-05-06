//
//  ContentView.swift
//  Temperature_conversion
//
//  Created by алтынпончик on 5/6/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var startTemp = ""
    @State private var endTemp = ""
    @State private var temperature1 = 1
    @State private var temperature2 = 1
    @State private var formula = ""
    
    let temp = ["Celsius", "Fahrenheit", "Kelvin"]
    
    func getTemperature(label: String) -> Float {
        var temperature: Float
        temperature = Float(startTemp) ?? 0
        return temperature
    }
    
    func convertToCelsius(t:Float, source:String) -> Float? {
        switch source {
        case "Kelvin": return t - 273.15
        case "Celsius": return t
        case "Fahrenheit": return (t - 32) * 5 / 9
        default: return nil
        }
    }

    func convertFromCelsius(t:Float, target:String) -> Float? {
        switch target {
        case "Kelvin": return t + 273.15
        case "Celsius": return t
        case "Fahrenheit": return t * 9 / 5 + 32
        default: return nil
        }
    }
    
    func convertToFahrenheit(t:Float, source:String) -> Float? {
        switch source {
        case "Kelvin": return (t - 273.15) * 9 / 5 + 32
        case "Celsius": return t * 9 / 5 + 32
        case "Fahrenheit": return t
        default: return nil
        }
    }
    
    func convertFromFahrenheit(t:Float, source:String) -> Float? {
        switch source {
        case "Kelvin": return (t - 32) * 5 / 9 + 273.15
        case "Celsius": return (t - 32) * 5 / 9
        case "Fahrenheit": return t
        default: return nil
        }
    }
    
    func convertToKelvin(t:Float, source:String) -> Float? {
        switch source {
        case "Kelvin": return t
        case "Celsius": return t + 273.15
        case "Fahrenheit": return (t - 32) * 5 / 9 + 273.15
        default: return nil
        }
    }
    
    func convertFromKelvin(t:Float, source:String) -> Float? {
        switch source {
        case "Kelvin": return t
        case "Celsius": return t - 273.15
        case "Fahrenheit": return (t - 273.15) * 9 / 5 + 32
        default: return nil
        }
    }
    
//    let cels = "Celsius"
//    let fahr = "Fahrenheit"
//    let kelv = "Kelvin"
    
    var body: some View {
        VStack(alignment: .center){
            Text("Temperature Conversion")
                .font(.largeTitle).bold()
                .padding(.bottom, 30)
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Initial temperature")
                        .font(.callout)
                        .bold()
                    TextField(" ", text: $startTemp)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Picker("°t", selection: $temperature1) {
                        ForEach(0 ..< temp.count) {
                            Text(self.temp[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Text("=").font(.system(size: 45, weight: .bold, design: .default))
                VStack(alignment: .leading) {
                    Text("End temperature")
                        .font(.callout)
                        .bold()
                    TextField(" ", text: $endTemp)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Picker("°t", selection: $temperature2) {
                        ForEach(0 ..< temp.count) {
                            Text(self.temp[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }.padding()
            HStack {
                Text("Formula: ")
                    .font(.callout)
                    .bold()
                Spacer()
            }.padding()
        }.padding(70)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
