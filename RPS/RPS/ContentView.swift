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
    
    var body: some View {
        
        VStack {
            VStack(spacing: 20) {
                HStack {
                    Text("Score: \(score)")
                    Spacer()
                    Text("Round \(round)/10)")
                }.padding(50)
                Text("Now you need to: ")
                Text(winOrLoose ? "WIN" : "LOSE")
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
                    Alert(title: Text("Game over"),
                          message: Text("You scored \(score) points!"),
                          dismissButton: .default(Text("Restart game"), action: restartGame))
                }
            }
        }
    }
    
    func restartGame() {
        round = 1
        randomMove = Int.random(in: 0 ... 2)
        winOrLoose = Bool.random()
        score = 0
    }
    
    
    func selectMove(at index: Int) {
        showingAlert = round >= 10
        let userSelection = moves[index]
        let gameSelection = moves[randomMove]
        switch (userSelection.wins(against: gameSelection), winOrLoose) {
        case (true, true), (false, false):
            score += 1
        default:
            score -= 1
        }
        
        randomMove = Int.random(in: 0 ... 2)
        winOrLoose = Bool.random()
        round += 1
    }
    
    func buttonTapped(at index: Int) {
        if randomMove == index {
        } else if (randomMove == 0 && number == 1 && playerShouldWin == true) || (randomMove == 1 && number == 2 && playerShouldWin == true) || (randomMove == 2 && number == 0 && playerShouldWin == true) {
            score += 1
        } else if (randomMove == 0 && number == 2 && playerShouldWin == false) || (randomMove == 1 && number == 0 && playerShouldWin == false) || (randomMove == 2 && number == 1 && playerShouldWin == false) {
            score += 1
        } else {
            score -= 1
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
