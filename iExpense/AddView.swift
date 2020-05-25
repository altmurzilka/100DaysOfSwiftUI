//
//  AddView.swift
//  iExpense
//
//  Created by алтынпончик on 5/24/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showAlert = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount)
                {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else if self.amount.isInt != true {
                    self.showAlert = true
                }
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Error!"), message: Text("Amount field need to contain numbers only!"), dismissButton: .default(Text("OK"))) // challenge 3 day 37
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
