//
//  CustomModifiers.swift
//  ViewsAndModifiers
//
//  Created by Rolando Garcia on 30/03/22.
//

import SwiftUI


// Let's say some new Title modifier

struct Title : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            // And so on...
    }
}

// Over the View protocol
extension View {
    // Name the propierty...
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct CustomModifiers: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .titleStyle()
    }
}

struct CustomModifiers_Previews: PreviewProvider {
    static var previews: some View {
        CustomModifiers()
    }
}
