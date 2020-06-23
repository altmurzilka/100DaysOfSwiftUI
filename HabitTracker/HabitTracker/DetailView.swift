//
//  DetailView.swift
//  HabitTracker
//
//  Created by алтынпончик on 6/24/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var habits: Habbits
    
    @State var habit: OneHabit
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(habit.name)
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.center)
                    Text(habit.description)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                }
                Spacer()
                HStack (spacing: 15) {
                    Text("\(habit.cnts)")
                        .font(.system(size: 25))
                    Stepper("Logged", onIncrement: {
                        self.habit.cnts += 1
                        self.saveHabit()
                    }, onDecrement: {
                        self.habit.cnts -= 1
                        self.saveHabit()
                    })
                        .labelsHidden()
                }
            }
            .padding()
            Spacer()
        }
    }
    
    func saveHabit() {
        guard let index = habits.items.firstIndex(where: {$0.id == habit.id }) else { return }
        habits.items[index].cnts = habit.cnts
    }
}
