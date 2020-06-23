//
//  Habit.swift
//  HabitTracker
//
//  Created by алтынпончик on 6/23/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import Foundation

struct Habbits: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
}
