//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dmytro Akulinin on 01.08.2022.
//

import SwiftUI

struct TitleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.blue)
  }
}

extension View {
  func title() -> some View {
    modifier(TitleModifier())
  }
}



struct ContentView: View {
  @State private var showingScore = false
  @State private var showingResults = false

  @State private var scoreTitle = ""
  @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
  @State var correctAnswer = Int.random(in: 0...2)
  @State var score = 0
  @State private var questionCounter = 1

  
  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
      ], center: .top, startRadius: 200, endRadius: 400)
      .ignoresSafeArea()
      
      VStack {
        Text("Guess the flag")
          .font(.largeTitle.bold())
          .foregroundColor(.white)
      
        
        VStack(spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .font(.subheadline.weight(.heavy))
              .foregroundStyle(.secondary)
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
          }
          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            } label: {
              FlagImage(name: countries[number])
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
        Spacer()
        Spacer()
        
        Text("Score: \(score)")
          .foregroundColor(.white)
          .font(.title.bold())
        
        Spacer()
      }
      .padding()
    }.alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("Your score is \(score)")
    }
    .alert("Game over!", isPresented: $showingResults) {
      Button("Start Again", action: newGame)
    } message: {
      Text("Your final score was \(score).")
    }
    
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      score += 1
    } else {
      scoreTitle = "Wrong"
      
      if score > 0 {
        score -= 1
      }
    }
    
    if questionCounter == 8 {
      showingResults = true
    } else {
      showingScore = true
    }
    
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    questionCounter += 1
  }
  
  func newGame() {
    questionCounter = 0
    score = 0
    askQuestion()
  }
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
        .previewDevice("iPhone 8")
    }
}
