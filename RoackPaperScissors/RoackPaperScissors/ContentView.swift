//
//  ContentView.swift
//  RoackPaperScissors
//
//  Created by Rolando Garcia on 02/04/22.
//

import SwiftUI

/*
 
 Objectives:
 
 - 5 Tries to win
 
 - If the user wins get a point other wise lose it
 
 - Show the final score when the user wins
 
 
 
 Design:
 
 - Split the screen into to parts with a divider
 
 - First section (Up section)
 - Second section (Down section)
 
 - The first section will be handle by the app and the second one will be by the user
 
 - Where the first part first pick a random option but not show its result until the user choose the result.
 
 - The section user (down section) will have 3 buttons to choose its options. 
 */

// Options in the game
enum Options: Int {
    // 0,1,2
    case scissors, rock,paper
}

enum Action {
   case add, subtraction
}

let waitingForResponse = "I already choose and I'm getting older..."

let limit = 3

struct ContentView: View {
    
    // The emoji to show before the user choose the icon
    private let randomEmoji = "🍀"
    
    private let options = ["✂️","👊","🧾"]
    
    @State private var shownAnswer = false
    @State private var answerMessasge = ""
    @State private var currentOption = Int.random(in: Options.scissors.rawValue...Options.paper.rawValue)
    @State private var score = 0
    // Final alet that indicates the game has ended
    @State private var showAlert = false
    
    var body: some View {
        let isLastGame = score == limit-1
        VStack {
            Spacer()
            Text("Score: \(score)")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            TextIcon(icon:shownAnswer ? options[currentOption] : randomEmoji)
            Text(shownAnswer ? answerMessasge : waitingForResponse)
                .multilineTextAlignment(.center)
                .padding()
                
            Spacer()
            VStack {
                if !shownAnswer {
                    HStack{
                          // TODO: Select with a button
                          ButtonIcon(icon:options[Options.scissors.rawValue]){
                              chooseOption(Options.scissors)
                          }
                          ButtonIcon(icon:options[Options.rock.rawValue]){
                              chooseOption(Options.rock)
                          }
                          ButtonIcon(icon:options[Options.paper.rawValue]){
                              chooseOption(Options.paper)
                          }
                      }
                }
                if !shownAnswer { Text("Choose your option") }
                
                if shownAnswer {Button(isLastGame ? "Last Game" : "Next Match") {
                    shownAnswer = false
                    resetGame(resetScore: false)
                }}
            }
            Spacer()
        }.alert("Nice!!!", isPresented: $showAlert){
            Button("Try again!") {
                resetGame()
            }
        } message: {
            Text("You got it. You defeat the computer brag.")
        }
    }
    
    func resetGame(resetScore : Bool = true){
        shownAnswer = false
        if resetScore {
            score = 0
        }
        assignNewRandomOption()
    }
    
    // What happens when a new options is choosed by the user
    func chooseOption(_ option : Options){
        shownAnswer = true
        
        let winsComputer = wonComputer(option)
        
        // IDK why is so brag XD
        
        if winsComputer {
            answerMessasge = "Oh yes I won"
            updateScore(.subtraction)
        } else {
            answerMessasge = "You just got some of luck"
            updateScore(.add)
        }
        
        if score == limit {
            showAlert = true
        }
        
    }
    
    func updateScore(_ a : Action = Action.add){
        switch a {
        case .add:
            score += 1
        case .subtraction:
            if score == 0 {return}
            score -= 1
        }
    }
    
    func wonComputer(_ userOption : Options) -> Bool {
        
        let rawValue = userOption.rawValue
        // Because the computer choose first it won
        if currentOption == rawValue { return true }
        
        
        switch userOption {
            
        case Options.scissors:
            if currentOption == Options.rock.rawValue {
                return true
            }
        case Options.rock:
            if currentOption == Options.paper.rawValue {
                return true
            }
        case Options.paper:
            if currentOption == Options.scissors.rawValue {
                return true
            }
        }
        
        return false
    }
    
    // Assign a new random option for the answer´s application
    func assignNewRandomOption(){
        currentOption = Int.random(in: Options.scissors.rawValue...Options.paper.rawValue)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
