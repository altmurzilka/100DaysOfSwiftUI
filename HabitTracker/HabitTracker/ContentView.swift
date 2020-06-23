//
//  ContentView.swift
//  HabitTracker
//
//  Created by алтынпончик on 6/20/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

class Expenses: ObservableObject {
    @Published var items = [Habbits]() {
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
            if let decoded = try? decoder.decode([Habbits].self, from: items) {
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
    @State private var showingAddHabbit = false
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.description)
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading:
                HStack {  
                    EditButton()
                }, trailing:
                HStack {
                    Button(action: { self.showingAddHabbit = true }) {
                        Image(systemName: "plus")
                    }
                }
            ).sheet(isPresented: $showingAddHabbit) {
                AddView(expenses: self.expenses)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
