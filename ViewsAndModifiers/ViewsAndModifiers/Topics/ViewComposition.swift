//
//  ViewComposition.swift
//  ViewsAndModifiers
//
//  Created by Rolando Garcia on 30/03/22.
//

import SwiftUI

struct CapsuleText : View {
    var text : String
    
    var body : some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct ViewComposition: View {
    var body: some View {
        VStack {
            CapsuleText(text:"One")
            CapsuleText(text: "Second")
        }
    }
}

struct ViewComposition_Previews: PreviewProvider {
    static var previews: some View {
        ViewComposition()
    }
}
