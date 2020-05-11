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
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 20) {
                    HStack {
                        Text("Score: \(score)").fontWeight(.thin)
                        Spacer()
                        Text("Round: \(round)/10").fontWeight(.thin)
                    }
                    .padding(50)
                    VStack(spacing: 20) {
                        Text("Now you need to: ").fontWeight(.thin)
                        Text(winOrLoose ? "WIN" : "LOSE").font(.system(size: 40, design: .monospaced))
                    }
                    .padding()
                    
                    VStack(spacing: 40) {
                        Text("Against:").fontWeight(.thin)
                        Text(moves[randomMove])
                            .font(.system(size: 60))
                    }.padding()
                    Spacer()
                    HStack(spacing: 20.0) {
                        ForEach(0 ..< moves.count) { number in
                            Button(action: {
                                self.buttonTapped(number)
                                self.round += 1
                                self.nextMove()
                            }) {
                                Text(self.moves[number])
                                    .font(.system(size: 60))
                            }.padding()
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text("Game over"),
                                  message: Text("You scored \(score) points!"),
                                  dismissButton: .default(Text("Restart game"), action: restartGame))
                        }
                    }
                    Spacer()
                }
            }
            .font(.system(size: 20, design: .monospaced))
            .font(.title)
            .foregroundColor(.green)
            .padding()
        }
    }
    
    func nextMove() {
        randomMove = Int.random(in: 0 ... 2)
        winOrLoose = Bool.random()
    }
    
    func restartGame() {
        round = 1
        randomMove = Int.random(in: 0 ... 2)
        winOrLoose = Bool.random()
        score = 0
    }
    
    func buttonTapped(_ index: Int) {
        showingAlert = round >= 10
        if (randomMove == 0 && index == 1 && winOrLoose == true) ||
            (randomMove == 1 && index == 2 && winOrLoose == true) ||
            (randomMove == 2 && index == 0 && winOrLoose == true) ||
            (randomMove == 0 && index == 2 && winOrLoose == false) ||
            (randomMove == 1 && index == 0 && winOrLoose == false) ||
            (randomMove == 2 && index == 1 && winOrLoose == false)
        {
            score += 1
        }
        else { score -= 1 }
        
        if round == 10 {
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
