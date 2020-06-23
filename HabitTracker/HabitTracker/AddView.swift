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
    @ObservedObject var expenses: Expenses
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
                
                let item = Habbits(name: self.name, description: self.description)
                self.expenses.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
