//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by алтынпончик on 5/7/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0  // 1
    @State private var scoreMessage = ""
    
    @State private var opacity = 1.0
    
    @State private var popIn = false
    @State private var popOut = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 30) {
                Spacer()
                VStack {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.black)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .padding()
                    }
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        withAnimation {
                            self.opacity -= 0.2
                        }
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.white, lineWidth: 5))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                Spacer()
                VStack (alignment: .center){
                    Text("\(score)") // 2
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.black)
                        .padding()
                    Text("Current score")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.black)
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is: \(score)"
        } else {
            scoreTitle = "Wrong"
            score -= 1
            scoreMessage = "Wrong! That’s the flag of \(countries[number])" // 3
        }
        
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
