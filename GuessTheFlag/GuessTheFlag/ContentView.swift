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
    
    @State private var opacities: [Double] = [1, 1, 1]
    
    @State private var wrongRotationAmount: [Double] = [0, 0, 0]
    
    @State private var rotation = 0.0
    @State private var animationAmount = 10.0
    
    struct FlagImage: View { // day 24 
        var text: String
        
        var body: some View {
            Image(text)
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.white, lineWidth: 5))
                .shadow(color: .black, radius: 2)
        }
    }
    
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
                ForEach(0..<3, id: \.self) { number in
                    VStack {
                        Button(action: {
                                self.flagTapped(number)
                        }) {
                            FlagImage(text: self.countries[number])
                        }
                        .rotation3DEffect(.degrees(number == self.correctAnswer ? self.rotation : 0),
                        axis: (x: 0, y: 1, z: 0)) // day 34 challenge 1
                        .opacity(self.opacities[number]) // day 34 challenge 2
                        .rotation3DEffect(.degrees(self.wrongRotationAmount[number]),
                        axis: (x: 0, y: 0, z: 1)) // day 34 challenge 3
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
            for i in 0..<3 where i != correctAnswer {  // day 34 challenge 2
                opacities[i] = 0.3
            }
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is: \(score)"
            rotation = 0.0
            
            withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                self.rotation = 360 // day 34 challenge 1
            }
            
        } else {
            scoreTitle = "Wrong"
            score -= 1
            scoreMessage = "Wrong! That’s the flag of \(countries[number])" // 3
            self.animationAmount = 10
            rotation = 0.0
            withAnimation(Animation.interpolatingSpring(mass: 1, stiffness: 120, damping: 5, initialVelocity: 700)) { // challenge 3 day 34
                self.wrongRotationAmount[number] = 1
            }
        }
        
        showingScore = true
    }
    func askQuestion() {
        rotation = 0.0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.opacities = [1, 1, 1]
        self.wrongRotationAmount = [0, 0, 0]
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
