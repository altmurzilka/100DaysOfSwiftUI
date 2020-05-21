//
//  ContentView.swift
//  Edutainment
//
//  Created by алтынпончик on 5/22/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tipPercentage = 2
    
    @State private var number1 : Int = 0
    @State private var number2 : Int = 0
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("How many qustions do you want")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Edutainment", displayMode: .inline)
            
            .navigationBarItems(trailing: Button("Restart") {  // 2
                self.startGame()
            })
        }
    }
    
    func startGame() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
