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

struct ContentView: View {
    
    // The emoji to show before the user choose the icon
    private let randomEmoji = "🍀"
    
    private let options = ["✂️","👊","🧾"]
    
    @State private var currentOption = Int.random(in: 0...2)
    
    
    
    
    var body: some View {
        VStack {
            Spacer()
            TextIcon(icon:randomEmoji)
            Spacer()
            HStack{
                // TODO: Select with a button
                TextIcon(icon:options[0])
                TextIcon(icon:options[1])
                TextIcon(icon:options[2])
            }
            Text("Choose an option")
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
