//
//  Habit.swift
//  HabitTracker
//
//  Created by алтынпончик on 6/23/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import Foundation

struct OneHabit: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
    var cnts: Int
}

class Habbits: ObservableObject {
    
    @Published var items = [OneHabit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([OneHabit].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
