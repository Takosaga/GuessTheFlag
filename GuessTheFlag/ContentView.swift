//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Gonzalo Gamez on 2/21/20.
//  Copyright © 2020 Gamez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "UK", "US"].shuffled()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flaggedTapped(number)
                        //flag was tapped
                    }) {
                        
                        Image(self.countries[number])
                            .renderingMode(.original)
                        .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth:  1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                    Text("Your score is \(score)")
                        .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("OK")) {
                self.askQuestion()
            } )
        }
    }

    
    func flaggedTapped( _ number: Int){
        
        if number == correctAnswer {
            scoreTitle = "Correct! That is the flag of \(countries[correctAnswer]) "
            score = score + 1
        } else {
            scoreTitle = "Wrong! That is the flag of \(countries[number])"
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
