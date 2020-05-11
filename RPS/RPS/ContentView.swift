//
//  ContentView.swift
//  RPS
//
//  Created by алтынпончик on 5/9/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["✊", "✋", "✌️"]
    @State private var winOrLoose = Bool.random()
    @State private var randomMove = Int.random(in: 0...2)
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var score = 0
    @State private var round = 1
    
    let rounds = 10
    
    var body: some View {
        
        VStack {
            VStack(spacing: 20) {
                HStack {
                    Text("Score \(score)")
                    Spacer()
                    Text("Round \(round)/\(rounds)")
                }.padding(50)
                Text("Now you need to: ")
                Text(winOrLoose ? "⭐️WIN⭐️" : "❗️LOSE❗️")
                Text("Against:")
                Text(moves[randomMove])
                    .font(.system(size: 80))
                HStack(spacing: 10.0) {
                    ForEach(0 ..< moves.count) { number in
                        Button(action: {
                            self.buttonTapped(number)
                            self.round += 1
                        }) {
                            Text(self.moves[number])
                                .font(.system(size: 80))
                        }
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text(round > 10 ? "Restart" : "Continue")) {
                        self.restartGame()
                        })
                }
            }
        }
    }
    
    private func restartGame() {
        round = 1
        randomMove = Int.random(in: 0 ... 2)
        winOrLoose = Bool.random()
        score = 0
    }
    
    
    func buttonTapped(_ number: Int) {
        if randomMove == number {
            alertTitle = "It's a Tie!"
            alertMessage = "You score 0 points."
        } else if (randomMove == 0 && number == 1 && winOrLoose == true) || (randomMove == 1 && number == 2 && winOrLoose == true) || (randomMove == 2 && number == 0 && winOrLoose == true) {
            score += 1
          //  alertTitle = "You Win!"
           // alertMessage = "You score 1 point."
        } else if (randomMove == 0 && number == 2 && winOrLoose == false) || (randomMove == 1 && number == 0 && winOrLoose == false) || (randomMove == 2 && number == 1 && winOrLoose == false) {
            score += 1
            alertTitle = "You Lose, But Obeyed!"
            alertMessage = "You still score 1 point."
        } else {
            score -= 1
            alertTitle = "You disobeyed the command."
            alertMessage = "You get -1 point."
        }
        
        if round > 10 {
            print(round)
            alertTitle = "Game Over! Your score is \(score)"
            alertMessage = "Do you want to play it again?"
            score = 0
            round = 1
        }
        
        showingAlert = true
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
