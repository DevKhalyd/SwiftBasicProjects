//
//  ModifiersOrderMatters.swift
//  ViewsAndModifiers
//
//  Created by Rolando Garcia on 30/03/22.
//

import SwiftUI

// Basically the way u call the modifiers
// affects the way of render in the screen as in shown below

struct ModifiersOrderMatters: View {
    var body: some View {
        
        // The render its step by step on the screen...
        
        Button("Hello,World!!"){
            // Do something
        }
        .background(.green)
        .frame(width: 200, height: 200)
        // Not the same
       /*
        Button("Hello,World!!"){
            // Do something
        }
        .frame(width: 200, height: 200)
        .background(.red)
        */
        
    }
}

struct ModifiersOrderMatters_Previews: PreviewProvider {
    static var previews: some View {
        ModifiersOrderMatters()
    }
}
