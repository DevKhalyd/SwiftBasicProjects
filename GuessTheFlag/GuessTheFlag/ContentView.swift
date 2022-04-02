//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rolando Garcia on 26/03/22.

import SwiftUI


struct FlagImage : View {
    var image : String
    
    init(_ image : String) {
        self.image = image
    }
    
    var body : some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
    
}


struct ContentView: View {
    
    // When those properties have to change we need to mark with @State because will rebuild the UI
    // Otherwise we can use mutating to allow to change the variables with new data.
    // But in this specific case we are using SwiftUI
    @State private var showingScoreAlert = false
    @State private var showingScoreWinning = false
    @State private var scoreTitle = ""
    @State private var scoreDescription = ""
    @State private var score = 0
    
    
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"]
        // Random sort of this list
        .shuffled()
    
   @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {

            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .bottom, startRadius: 200, endRadius: 700).ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.green)
                
                Spacer()
                
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    // Why this forEach needs the n variable intead of use $0
                    // $0, $1, $2
                    // ShortHand Argument names
                    ForEach (0..<3) { n in
                        Button {
                            flagTapped(n)
                        } label: {
                            FlagImage(countries[n])
                        }.alert(scoreTitle,isPresented: $showingScoreAlert){
                            Button("Continue", action: askQuestion)
                        } message: {
                            Text(scoreDescription)
                        }
                    }
                }
                // set a specified width for this stack
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
                
            Spacer()
            
            Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
            Spacer()
                
            }
            
        }.alert("You win", isPresented: $showingScoreWinning) {
            Button("Start again",action: reset)
        }
    }
    
    func reset(){
        score = 0
        askQuestion()
    }
    
    // When the button that contains the flag is tapped
    func flagTapped(_ number : Int){
        // Swift is smart because I dont have to specify when should rebuild the UI like other frameworks
        // It's use assign a new value.
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreDescription = "Nice one. You score is updated"
            score += 1
        }else {
            scoreTitle = "Wrong"
            scoreDescription = "Good luck for the next time. It was \(countries[number]) flag"
        }
        
        if score < 8 {
            showingScoreAlert = true
            return
        }
        
        
        showingScoreWinning = true
        
        
    }
    
    // What to do after a the person press Continue
    func askQuestion(){
        // Reorder randomly the elements of an array
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
