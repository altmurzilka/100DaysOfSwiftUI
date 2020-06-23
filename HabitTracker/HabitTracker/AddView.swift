//
//  AddView.swift
//  HabitTracker
//
//  Created by алтынпончик on 6/24/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var habits: Habbits
    
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                
                let item = OneHabit(name: self.name, description: self.description, cnts: 0)
                self.habits.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
