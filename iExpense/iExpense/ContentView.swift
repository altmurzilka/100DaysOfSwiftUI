//
//  ContentView.swift
//  iExpense
//
//  Created by алтынпончик on 5/20/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @Environment(\.presentationMode) var presentation // Add button doesn't clikking 2nd time error fixation
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        
                        Text("$\(item.amount)")
                            .foregroundColor(self.color(forAmount: item.amount)) // d37 ch2
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading:
                HStack {  // d 38 challenge 1
                    EditButton()
                }, trailing:
                HStack {
                    Button(action: { self.showingAddExpense = true }) {
                        Image(systemName: "plus")
                    }
                }
            ).sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func color(forAmount amount: Int) -> Color {
        switch amount {
        case Int.zero..<10:
            return .gray
        case 10..<100:
            return .green
        default:
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
