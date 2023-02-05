//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matheus Müller on 02/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showFinal = false
    @State private var scoreTitle = ""
    @State private var finalTitle = ""
    @State private var totalScore = 0
    @State private var tapCount = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.45), Color(red: 0.76, green: 0.15, blue: 0.26)],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(totalScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(totalScore)")
        }
        
        .alert(finalTitle, isPresented: $showFinal) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score is \(totalScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            totalScore = totalScore + 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            totalScore = totalScore - 1
        }
        
        tapCount = tapCount + 1
        showingScore = true
        
        if tapCount == 8 {
            finalTitle = "Game Over"
            showFinal = true
            tapCount = 0
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        totalScore = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
