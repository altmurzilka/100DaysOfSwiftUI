//
//  ContentView.swift
//  HabitTracker
//
//  Created by алтынпончик on 6/20/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentation // Add button doesn't clikking 2nd time error fixation
    
    @ObservedObject var habits = Habbits()
    
    @State private var showingAddHabbit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                    NavigationLink(destination: DetailView(habits: self.habits, habit: item )) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("\(item.cnts)")
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Habit Tracker")
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
                AddView(habits: self.habits)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}
